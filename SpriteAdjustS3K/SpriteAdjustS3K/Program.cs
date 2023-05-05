using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SpriteAdjustS3K {
	class Program {
		// "G:\hacks\current\S3K Battle Race\General\Sprites\Tails\Map - Tails.asm" "G:\hacks\current\S3K Battle Race\General\Sprites\Tails\Map - Tails Fixed.asm" "G:\hacks\current\S3K Battle Race\General\Sprites\Tails\Tails.txt"
		// "G:\hacks\current\S3K Battle Race\General\Sprites\Tails\Map - Tails tails.asm" "G:\hacks\current\S3K Battle Race\General\Sprites\Tails\Map - Tails tails Fixed.asm" "G:\hacks\current\S3K Battle Race\General\Sprites\Tails\Tails_tails.txt"
		public static string temp = "";
		public static Mappings m;

		public static void e(string v) {
			Console.WriteLine(v);
			Console.ReadKey();
			Environment.Exit(-1);
		}

		public static void Main(string[] args) {
			// first, parse file!
			temp = File.ReadAllText(args[0]);
			ParseMaps();

			// convert sprites
			temp = File.ReadAllText(args[2]);

			for(int i = 0;i < m.offsets.Count;i++) {
				if (!m.sprites.ContainsKey(m.offsets[i]))
					e("Missing key for offset:" + m.offsets[i]);

				// newline check
				if (temp.StartsWith("\r")) {
					temp = temp.Substring(1);
				}
				if (temp.Length == 0) continue;
				if (temp.StartsWith("\n")) {
					temp = temp.Substring(1);
					continue;
				}

				Sprite s = m.sprites[m.offsets[i]];

				// convert nums
				string z;
				if (temp.Contains("\n")) {
					z = temp.Substring(0, temp.IndexOf("\n"));
					temp = temp.Substring(temp.IndexOf("\n") + 1);

				} else {
					z = temp;
					temp = "";
				}

				string[] y = z.Split(' ');
				if (y.Length < 2) e("Expected 2 entries, but got " + y.Length + " for line: " + z);

				//convert nums
				if(!Int32.TryParse(y[0], out int xp)) e("Cannot parse: " + y[0]);
				if(!Int32.TryParse(y[1], out int yp)) e("Cannot parse: " + y[1]);

				// offset pos
				for(int w = 0;w < s.pieces.Count;w++) {
					s.pieces[w][0] += (byte)yp;
					
					if(xp > 0) {
						if (s.pieces[w][5] + xp > 0xFF)
							s.pieces[w][4]++;

						s.pieces[w][5] += (byte)xp;

					} else if(xp < 0) {
						if (s.pieces[w][4] + xp < 0)
							s.pieces[w][5]--;

						s.pieces[w][5] += (byte)xp;
					}
				}
			}

			// write out
			Console.WriteLine("Convert data...");
			string data = m.label + ":\n";

			var keys = m.sprites.Keys.ToArray();
			var vals = m.sprites.Values.ToArray();

			int x = 0;
			foreach(string off in m.offsets) {
				data += "\tdc.w " + off + "-" + m.label + "\t ; " + x++ + "\n";
			}

			for (x = 0;x < keys.Length;x++) {
				data += "\n" + keys[x] + ":\tdc.w " + hex(vals[x].pieces.Count, 4) + "\n";

				for (int z = 0;z < vals[x].pieces.Count;z++) {
					data += "\tdc.b ";

					for (int y = 0;y < 6;y++) {
						if (y == 5) data += hex(vals[x].pieces[z][y], 2) + "\n";
						else data += hex(vals[x].pieces[z][y], 2) + ", ";
					}
				}
			}

			Console.WriteLine("Save file...");
			File.WriteAllText(args[1], data);
			e("All done!");
		}

		public static void ParseMaps() {
			ParsedItem? i = ParseItem();
			if (i == null) e("Failed to parse header; No valid line!");
			
			if (i.Value.label) {
				m = new Mappings(i.Value.data);
				i = null;
			}  else m = new Mappings(null);

			// start dealing with offset table
			if(i != null) {
				string s = GetOffset(i);
				if (s != null) {
					if (s == "") goto getsprites;
					Console.WriteLine("Collect label: " + s);

				} else e("Impossible fail with getting labels");
			}

			while (true) {
				string s = GetOffset(ParseItem());
				if (s != null) {
					if (s == "") goto getsprites;
					Console.WriteLine("Collect label: " + s);
				}
			}

			// process sprite shit
			getsprites:
			i = null;
			while (true) {
				// check if we want to load next item
				if(i == null) i = ParseItem();
				if (i == null) return;

				if (i.Value.label) {
					// process label data
					string extra, lable;
					if (i.Value.data.Contains(":")) {
						string[] x = i.Value.data.Split(':');
						lable = x[0];
						if (x.Length != 2) e("Invalid label name or data");
						extra = x[1];

					} else {
						lable = i.Value.data;
						extra = null;
					}

					// check if label exists
					bool used = true;
					if (!m.sprites.ContainsKey(lable)) m.sprites[lable] = new Sprite(false);
					Console.WriteLine("Get lable: " + lable + " (" + (used ? "U" : "Unu") + "sed)");

					// process data
					int len;
					if(extra != null) len = ProcSpriteLen(extra, m.sprites[lable]);
					else {
						// do extra line for len
						i = ParseItem();
						if(i == null) return;
						if (i.Value.label) e("Invalid empty lable!");
						len = ProcSpriteLen(i.Value.data, m.sprites[lable]);
					}

					// loop for all sprites
					while(true) {
						i = ParseItem();
						if (i == null) break;
						if (i.Value.label) break;
						len--;

						// get sprite data
						byte[] spr = ProcSprite(i.Value.data, m.sprites[lable]);
						if (spr == null) e("Failed to process sprite for unknown reason!");
						m.sprites[lable].AddPiece(spr);
					}

					if(len != 0) Console.WriteLine("WWRN: Incorrect num of sprites! "+ m.sprites[lable].pieces.Count + " found.");
					if (i == null) return;

				} else {
					Console.WriteLine("Ignore nonlabel: "+ i.Value.data);
				}
			}
		}

		private static string hex(int val, int zeros) {
			return "$" + val.ToString("X" + zeros);
		}

		private static byte[] ProcSprite(string data, Sprite sprite) {
			int x = 0;
			for (;x < data.Length;x++)
				if (data[x] != '\t' && data[x] != ' ') {
					// clean up str
					data = data.Substring(x);

					if (data.StartsWith("dc.b")) {
						// dc.b format, read it
						data = data.Substring(5);
						string[] z = data.Split(',');
						if (z.Length != 6) e("Invalid data. 6 entries was required, but " + z.Length + " was found: " + data);

						byte[] ret = new byte[6];
						for (int i = 0;i < 6;i++) {
							if (TryParseNum(z[i], out int num))
								ret[i] = (byte)num;
							else e("Cannot parse: " + z[i]);
						}

						return ret;

					} else e("Invalid number format: " + data);
					// no dc.w for now
				}

			e("Unexpected end of line: " + data);
			return null;
		}

		private static int ProcSpriteLen(string data, Sprite sprite) {
			int x = 0;
			for (;x < data.Length;x++)
				if (data[x] != '\t' && data[x] != ' ') {
					// clean up str
					data = data.Substring(x);

					if (data.StartsWith("dc.b")) {
						// dc.b format, read it
						data = data.Substring(5);
						string[] z = data.Split(',');
						if (z.Length != 2) e("Invalid data. 2 entries was required, but "+ z.Length +" was found: " + data);

						// attempt to combine nums
						if (TryParseNum(z[0], out int numhi) && TryParseNum(z[1], out int numlo)) {
							return (numhi << 8) | numlo;

						} else e("Cannot parse: " + z[0] +" or "+ z[1]);

					} else if (data.StartsWith("dc.w")) {
						// dc.w format, read it
						data = data.Substring(5);
						if(TryParseNum(data, out int num)) {
							return num;
						}

						e("Cannot parse: " + data);

					} else e("Invalid number format: "+ data);
				}

			e("Unexpected end of line: " + data);
			return -1;
		}

		private static bool TryParseNum(string data, out int num) {
			NumberStyles radix = NumberStyles.Integer;
			if (data.Contains("$")) {
				data = data.Substring(data.IndexOf("$") + 1);
				radix = NumberStyles.HexNumber;

			} else if (data.StartsWith("%")) {
				num = -1;
				return false;
			}

			return Int32.TryParse(data, NumberStyles.HexNumber, CultureInfo.InvariantCulture, out num);
		}

		private static string GetOffset(ParsedItem? i) {
			if (i == null) return null;
			if (!i.Value.label && i.Value.data.Contains("-") && i.Value.data.StartsWith("dc.w")) {
				
				int x = 4;
				for (;x < i.Value.data.Length;x++)
					if (i.Value.data[x] != '\t' && i.Value.data[x] != ' ') {
						// cleanup str and make sanity checks
						string[] z = i.Value.data.Substring(x).Split('-');

						if (z[1].Length == 0 || (m.label != null && m.label != z[1])) e("Incorrect mappings label found.");
						if (z[0].Length == 0) e("Invalid label found!");

						// if dictionary entry doesnt exist, make one
						if (!m.sprites.ContainsKey(z[0])) m.sprites[z[0]] = new Sprite(false);
						m.offsets.Add(z[0]);
						return z[0];
					}

				e("Impossible error in GetOffset");
				return null;
			} else return "";
		}

		public static ParsedItem? ParseItem() {
			while (temp.Length > 0) {
				// remove all shit chars
				int i = 0;
				string line;
				for (;i < temp.Length;i++)
					if (temp[i] != '\n' && temp[i] != '\r' && temp[i] != '\t' && temp[i] != ' ') {
						if (i != 0) {
							temp = temp.Substring(i);

							// get line only
							if (temp.Contains("\n")) {
								line = temp.Substring(0, temp.IndexOf("\n"));
								temp = temp.Substring(temp.IndexOf("\n") + 1);
							} else {
								line = temp;
								temp = "";
							}

							if (line.Contains(";")) line = line.Substring(0, line.IndexOf(";"));
							if (line.Length <= 0) break;    // oops, wrong line

							return new ParsedItem() { label = false, data = line };

						} else {
							// get line only
							if (temp.Contains("\n")) {
								line = temp.Substring(0, temp.IndexOf("\n"));
								temp = temp.Substring(temp.IndexOf("\n") + 1);
							} else {
								line = temp;
								temp = "";
							}

							if (line.Contains(";")) line = line.Substring(0, line.IndexOf(";"));
							if (line.Length <= 0) break;    // oops, wrong line
							if (line.EndsWith(":")) line = line.Substring(0, line.Length - 1);

							return new ParsedItem() { label = true, data = line };
						}
					}
			}
			return null;
		}
	}

	public struct Sprite {
		public List<byte[]> pieces;
		bool unused;
		bool locked;

		public Sprite(bool unused) {
			pieces = new List<byte[]>();
			this.unused = unused;
			locked = false;
		}

		public void AddPiece(byte[] data) {
			if (data.Length != 6) {
				Program.e("Invalid Sprite piece loaded");
			}

			pieces.Add(data);
		}
	}

	public struct Mappings {
		public string label;
		public Dictionary<string, Sprite> sprites;
		public List<string> offsets;

		public Mappings(string label) {
			this.label = label;
			sprites = new Dictionary<string, Sprite>();
			offsets = new List<string>();
		}
	}

	public struct ParsedItem {
		public bool label;
		public string data;
	}
}
