using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace OptimizerLibrary {
	enum ArgType {
		String, Byte, Sbyte, Word, Sword, 

		Optional = 0x1000,
	}

	class Util {
		// helper method to convert a list of argument values to uint
		public static bool ArgListToUint(string[] values, int start, out uint[] res) {
			res = new uint[values.Length - start];

			for(int i = 0;i < res.Length; i++) {
				if(!ArgToUint(values[start + i], out res[i])) {
					return false;
				}
			}

			return true;
		}

		// helper method to convert an argument value to uint
		public static bool ArgToUint(string value, out uint res) {
			bool rt = ArgToInt(value, out int resx);
			res = (uint) resx;
			return rt;
		}

		// helper method to convert an argument value to uint
		public static bool ArgToInt(string value, out int res) {
			NumberStyles fmt = NumberStyles.Integer;
			bool neg = false;

			// check for negation
			if (value.StartsWith('-')) {
				neg = true;
				value = value[1..];
			}

			// check for hex values
			if (value.Contains("$")) {
				fmt = NumberStyles.HexNumber;
				value = value[1..];

			} else if (value.StartsWith("0x")) {
				fmt = NumberStyles.HexNumber;
				value = value[2..];
			}

			// parse the result
			bool rt = int.TryParse(value, fmt, NumberFormatInfo.InvariantInfo, out res);
			res *= neg ? -1 : 1;
			return rt;
		}

		// convert number to hex string
		public static string ToHex(int value, int digits) {
			// negative values hack
			if(value < 0) {
				return "-$" + (-value).ToString("X" + digits);
			}

			return "$"+ value.ToString("X" + digits);
		}

		// convert number to hex string
		public static string ToHex(uint value, int digits) {
			return "$" + value.ToString("X" + digits);
		}

		// parse input settings data
		public static Dictionary<string, string> SettingsParse(string[] parts, int start, StreamWriter console) {
			Dictionary<string, string> data = new Dictionary<string, string>();

			// handle each part in order
			for(int i = start;i < parts.Length;i ++) {
				string[] pa = parts[i].Split("=");

				if(pa.Length > 2) {
					console.WriteLine("Unable to parse argument: " + pa);
					return null;

				} else if(pa.Length == 1) {
					data[pa[0]] = "";
						
				} else {
					data[pa[0]] = pa[1];
				}
			}

			return data;
		}

		// load a list of arguments
		internal static object[] LoadArguments(StreamWriter console, string[] arguments, string command, ArgType[] types) {
			object[] res = new object[arguments.Length];

			int i;

			// process defined arguments
			for(i = 0;i < arguments.Length; i++) {
				if(types.Length <= i) {
					console.WriteLine("Argument number "+ (1 + i) +" was not expected: " + command + string.Join(' ', arguments));
					return null;
				}

				// process argument
				if(!LoadArgument(arguments[i], types[i], out res[i])) {
					console.WriteLine("Argument number " + (1 + i) + " could not be parsed as "+ types[i] + ": " + command + string.Join(' ', arguments));
					return null;
				}
			}

			// check for all the remaining types
			for(;i < types.Length;i ++) {
				if((types[i] & ArgType.Optional) == 0) {
					console.WriteLine("Argument number " + (1 + i) + " ("+ types[i] +") was expected, but not provided: " + command + string.Join(' ', arguments));
					return null;
				}
			}

			return res;
		}

		// load a single argument with a specific type
		internal static bool LoadArgument(string arg, ArgType type, out object res) {
			switch((ArgType) ((int)type & 0xFFF)) {
				case ArgType.String:
					res = arg;
					return true;

				case ArgType.Byte: {
					bool rv = ArgToUint(arg, out uint x);
					res = (byte) x;
					return rv;
				}

				case ArgType.Word: {
					bool rv = ArgToUint(arg, out uint x);
					res = (ushort) x;
					return rv;
				}

				case ArgType.Sbyte: {
					bool rv = ArgToInt(arg, out int x);
					res = (sbyte) x;
					return rv;
				}

				case ArgType.Sword: {
					bool rv = ArgToInt(arg, out int x);
					res = (short) x;
					return rv;
				}
			}


			res = null;
			return true;
		}
	}
}
