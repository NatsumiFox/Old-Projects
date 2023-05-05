using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SMPSTestingUtil {
	class Program {
		static void Main(string[] args) {
			if(args.Length < 2 && args[0].Count() != 1)
				return;

			System.Console.WriteLine("SMPS Testing Util (c) Natsumi 2017 ("+ (byte)args[0].ElementAt(0) + ")\nFinding the right port...");
			SerialPort port = null;

			{
				string[] port_list = SerialPort.GetPortNames();

				for(int i = 0;i < port_list.Length;i++) {
					try {
						port = new SerialPort(port_list[i]);
						System.Console.WriteLine("Check "+ port.PortName);
						port.ReadTimeout = 500;
						port.WriteTimeout = 500;
						port.Open();
						port.ReadExisting();
						port.Write("SC");

						System.Console.WriteLine("Read " + port.PortName);
						int a = 1000;
						while(port.IsOpen && a-- > 0) {
							if(port.BytesToRead >= 2) {
								if(port.ReadByte() == (byte)'O' & port.ReadByte() == (byte)'K')
									goto found;
								else
									break;
							}

							Thread.Sleep(10);
						}
						System.Console.WriteLine("Close " + port.PortName);
						port.Close();
					} catch(Exception) {
						if(port.IsOpen)
							port.Close();
						return;
					}
				}

				System.Console.WriteLine("program not detected :(");
				return;
			}

		found:
			System.Console.WriteLine("Program detected on "+ port.PortName);
			byte[] f = File.ReadAllBytes(args[1]);
			short s = (short)(f.Length - 1);
			byte[] u = new byte[] { (byte)args[0].ElementAt(0), (byte)(s>>8), (byte)s };
			System.Console.WriteLine("Stream size is "+ f.Length);

			port.Write(u, 0, u.Length);
			port.Write(f, 0, f.Length);

			System.Console.WriteLine("Wait...");
			Thread.Sleep(100);
			int ct = 10000;
			while(port.IsOpen && ct-- > 0) {
				if(port.BytesToRead >= 2) {
					if(port.ReadByte() == (byte)'O' & port.ReadByte() == (byte)'K')
						goto exit;
					else
						break;
				}
			}

			port.Close();
		err:
			System.Console.WriteLine("There was an error...");
			System.Console.ReadKey();
			return;

		exit:
			port.Close();
			System.Console.WriteLine("Finished, closing port...");
		}
	}
}
