using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.Ports;
using System.Threading;
using System.Diagnostics;

namespace mega_usb {
	class Program {
		// if true, exit without enter
		public static bool exit = false;

		static void Main(string[] args) {
			SerialPort port;
			string option = null;
			exit = false;

			try {
				Console.Title = "Mega EverDrive USB loader - Natsumi custom";

				// check args and make sure file can be read
				if (args.Length == 0) throw new Exception("Drop ROM into executable to load a file.");
				if (!File.Exists(args[0])) throw new Exception("Input file not found!");

				// find port
				Console.WriteLine("Searching MegaED...");
				port = searchCart();
				Console.WriteLine("MegaED detected on " + port.PortName);

				// open file and pad its length correctly
				FileStream f = File.OpenRead(args[0]);
				if(f.Length < 1) throw new Exception("File is empty");

				int len = (int)f.Length;
				if (len % 65536 != 0) len = len / 65536 * 65536 + 65536;

				// read file into memory
				byte[] buff = new byte[len];
				f.Read(buff, 0, (int)f.Length);
				f.Close();

				// check for special files?
				for (int i = 0;i < args.Length;i++) {
					if (args[i].Contains("MEGA.BIN") || args[i].Contains(".RBF") || args[i].Contains(".rbf")) {
						v2_sysTools(args, port);
						port.Close();
						return;
					}
				}

				// figure out which mode to use for upload
				if (args.Length == 1) {
					option = args[0].Contains("MEGAOS.bin") ? "-o" : args[0].Contains(".sms") | args[0].Contains(".SMS") ? "-sms" : "-smd";
					if (buff[261] == 'S' && buff[262] == 'S' && buff[263] == 'F' && buff[264] == ' ') option = "-ssf";

				} else option = args[1];

				// upload os or game
				if (option.Equals("-o") || option.Equals("-fo")) loadOS(option, buff, port);
				else loadGame(option, buff, port);

			} catch (Exception x) {
				Console.WriteLine("\nError: " + x.Message);
			}

			if(!exit) Console.ReadKey();
			else {
				Thread.Sleep(1000 *2);
			}
		}

		static void loadOS(string arg, byte[] data, SerialPort port) {
			if (data.Length > 0x100000) throw new Exception("OS file is too big!");
			port.ReadTimeout = 1000;
			port.WriteTimeout = 1000;
			byte[] tx = new byte[1];

			if (arg.Equals("-fo")) {
				Console.WriteLine("Firmware loading...");
				tx[0] = (byte)(64 + 32);
				port.Write("*f");
				port.Write(tx, 0, 1);
				int rss = port.ReadByte();
				if (rss != 'k') throw new Exception("Unexpected response code '" + (char)rss + "'");
				sendData(data, port, 0x8400, 0x18000);

				port.ReadTimeout = 200;
				port.WriteTimeout = 200;
				Thread.Sleep(1000);

				for (int i = 0;;i++) {
					if (i > 10) throw new Exception("OS reloading timeout");

					try {
						for (;;) port.ReadByte();
					} catch (Exception) { }

					try {
						port.Write("*T");
						rss = port.ReadByte();
						if (rss != 'k') throw new Exception("Unexpected response code '" + (char)rss + "'");
						break;
					} catch (Exception) { }
				}

				port.ReadTimeout = 1000;
				port.WriteTimeout = 1000;
			}

			Console.WriteLine("OS loading...");
			tx[0] = (byte)(data.Length / 512 / 128);
			port.Write("*o");
			port.Write(tx, 0, 1);

			int rs = port.ReadByte();
			if (rs != 'k') throw new Exception("Unexpected response code '" + (char)rs + "'");
			sendData(data, port, 0, data.Length);

			Console.WriteLine("success!");
			exit = true;
		}

		// load a game into MED
		static void loadGame(string arg, byte[] data, SerialPort port) {
			if (data.Length > 0xf00000) throw new Exception("File size is too big!");

			// write game chunk length
			byte[] tx = new byte[1];
			// Console.WriteLine("Game loading request...");
			port.ReadTimeout = 1000;
			port.WriteTimeout = 1000;
			port.Write("*g");
			tx[0] = (byte)(data.Length / 512 / 128);
			port.Write(tx, 0, 1);
			//System.Console.WriteLine("len: " + data.Length);

			int rs = port.ReadByte();
			if (rs != 'k') throw new Exception("Unexpected response code '" + (char)rs + "'");
			sendData(data, port, 0, (int)data.Length);

			// tell the system what mode to start on
			//Console.WriteLine("start game...");
			string write = null;
			switch (arg) {
				case "-sms":
					write = "*rs";
					break;

				case "-os":
					write = "*ro";
					break;

				case "-cd":
					write = "*rc";
					break;

				case "-m10":
					write = "*rM";
					break;

				case "-ssf":
					write = "*rS";
					break;

				default:
					write = "*rm";
					break;
			}
			
			port.Write(write);
			rs = port.ReadByte();
			if (rs != 'k') throw new Exception("Unexpected response code '" + (char)rs + "'");
			Console.WriteLine("Success!");
			exit = true;
		}

		static void sendData(byte[] data, SerialPort port, int offset, int len) {
			int block_len = 0x8000;// len % 0x10000 == 0 ? 0x10000 : 0x8000;

			// write ROM to MegaED asap
			Console.Write("Loading data");
			Stopwatch sw = new Stopwatch();
			sw.Start();
			for (int i = 0;i < len;i += block_len) {
				port.Write(data, i + offset, block_len);
				if (i % 65536 == 0) Console.Write(".");
			}

			sw.Stop();
			Console.WriteLine("\nUpload time: " + sw.ElapsedMilliseconds + "ms!");
			int rs = port.ReadByte();
			if (rs != 'd') throw new Exception("Unexpected response code '" + (char)rs + "'");
		}

		static SerialPort searchCart() {
			string[] port_list = SerialPort.GetPortNames();
			SerialPort port = null;

			for (int i = 0;i < port_list.Length;i++) {
				try {
					port = new SerialPort(port_list[i]);
					port.ReadTimeout = 200;
					port.WriteTimeout = 200;
					port.Open();
					port.ReadExisting();
					port.Write("    *T");

					if (port.ReadByte() == (byte)'k') return port;
					port.Close();
				} catch (Exception) {
					if (port.IsOpen) port.Close();
				}
			}

			throw new Exception("MegaED not detected!");
		}

		static void v2_sysTools(string[] args, SerialPort port) {
			port.ReadTimeout = 3000;
			port.WriteTimeout = 3000;

			for (int i = 0;i < args.Length;i++) {
				if (args[i].Contains(".RBF") || args[i].Contains(".rbf")) {
					v2_loadFpga(args[i], port);
					//Thread.Sleep(500);
					port.Write("*T");
					int rs = port.ReadByte();
					if (rs != 'k') throw new Exception("Unexpected response code '"+ (char)rs +"'");

				}
			}

			for (int i = 0;i < args.Length;i++) {
				if (args[i].Contains("MEGA.BIN")) {
					v2_loadOS(args[i], port);
					//Thread.Sleep(500);
					port.Write("*T");
					int rs = port.ReadByte();
					if (rs != 'k') throw new Exception("Unexpected response code '" + (char)rs + "'");
				}
			}
		}

		static void v2_loadOS(string filename, SerialPort port) {
			Console.Write("OS loading");
			FileStream f = File.OpenRead(filename);
			byte[] buff = new byte[f.Length];
			f.Read(buff, 0, buff.Length);
			f.Close();

			port.Write("*o");
			port.Write(new byte[] { (byte)(buff.Length / 512 >> 8), (byte)(buff.Length / 512) }, 0, 2);

			int block_len = 2048;
			for (int i = 0;i < buff.Length;i += block_len) {
				port.Write(buff, i, block_len);
				if (i % 8192 == 0) Console.Write(".");
			}

			port.Write("*R");
			Console.WriteLine("Success");
			exit = true;
		}

		static void v2_loadFpga(string filename, SerialPort port) {
			Console.Write("Firmware loading...");
			FileStream f = File.OpenRead(filename);
			byte[] buff = new byte[0x18000];
			for (int i = 0;i < buff.Length;i++) buff[i] = 0xff;
			f.Read(buff, 0, buff.Length);
			f.Close();

			port.Write("*f");
			port.Write(new byte[] { (byte)(buff.Length / 2 >> 8), (byte)(buff.Length / 2) }, 0, 2);

			int block_len = 2048;
			for (int i = 0;i < buff.Length;i += block_len) {
				port.Write(buff, i, block_len);
				if (i % 8192 == 0) Console.Write(".");
			}

			Console.WriteLine("Success");
			exit = true;
		}
	}
}
