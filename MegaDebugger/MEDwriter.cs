using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Ports;
using System.Timers;
using System.Threading;

namespace MegaDebugger {
	internal class MEDwriter {
		static SerialPort port;
		static List<byte[]> commands;
		static System.Timers.Timer conn, comms;
		static bool pong = false, check = false;
		static Form1 f;
		static Thread pcm;
		static bool running = true;
		static int oub = 0;

		public MEDwriter(Form1 fo) {
			f = fo;
			commands = new List<byte[]>();
			conn = new System.Timers.Timer();
			conn.Enabled = true;

			comms = new System.Timers.Timer();
			comms.Elapsed += sendComm;
			comms.Interval = 100;
			comms.Enabled = true;
			checkPONG(null, null);
		}

		private void sendComm(object sender, ElapsedEventArgs e) {
			if (commands.Count > 0 && port != null) {
				try {
					if (port.IsOpen) {
						port.Write(commands[0], 0, commands[0].Length);
						f.Addsec(System.Text.Encoding.ASCII.GetString(commands[0]) + "\r\n");
						commands.RemoveAt(0);
					}
				} catch (Exception ex) {
					f.SetMEDStatus(ex.Message);
				}
			}
		}

		private void sendPING(object sender, ElapsedEventArgs e) {
			Send("PING");
			conn.Elapsed += checkPONG;
			conn.Elapsed -= sendPING;
			conn.Interval = 5 * 1000;
			conn.Stop();
			conn.Start();
		}

		private void checkPONG(object sender, ElapsedEventArgs e) {
			if (pong) {
				conn.Elapsed -= checkPONG;
				conn.Elapsed += sendPING;
				conn.Elapsed -= checkPorts;
				conn.Interval = 5 * 1000;
				conn.Stop();
				conn.Start();
				pong = false;

			} else {
				conn.Elapsed += checkPorts;
				conn.Interval = 1 * 1000;
				conn.Stop();
				conn.Start();
			}
		}

		private void checkPorts(object sender, ElapsedEventArgs e) {
			if(check) return;
			check = true;
			f.SetMEDStatus("Checking for MED");

			foreach (string p in SerialPort.GetPortNames()) {
				try {
					port = new SerialPort(p);
					port.ReadTimeout = 1 * 1000;
					port.WriteTimeout = 200;
					port.Open();
					port.ReadExisting();
					port.Write("XFND");

					// if we could read data from port and its PONG, then its all fine
					if (port.ReadByte() == (byte) 'K') {
						pong = true;
						checkPONG(null, null);
						f.SetMEDStatus("Found MED in " + p + "!");
						port.DataReceived += Port_DataReceived;
						check = false;
						return;
					}

					port.Close();
				} catch (Exception) {
					if (port.IsOpen) {
						port.Close();
						port = null;
					}
				}
			}

			f.SetMEDStatus("Could not find MED");
			check = false;
		}

		private void Port_DataReceived(object sender, SerialDataReceivedEventArgs e) {
			if (port.IsOpen && port.BytesToRead >= 4) {
				string com = "" + (char) port.ReadByte() + (char) port.ReadByte() + (char) port.ReadByte() + (char) port.ReadByte();
				f.Addrec(com);

				switch (com) {
					case "PONG":
						pong = true;
						break;

					case "NACK":
						port.ReadByte();
						f.Addrec(" " + (char) port.ReadByte() + (char) port.ReadByte() + (char) port.ReadByte() + (char) port.ReadByte());
						break;
				}

				f.Addrec("\r\n");
			}
		}

		public void Send(string v) {
			Send(System.Text.Encoding.ASCII.GetBytes(v));
		}

		public void Send(byte[] v) {
			commands.Add(v);

			oub += v.Length;
			f.SetOutBytes(""+ oub);
		}

		public void StopPCM() {
			if (pcm != null) {
				conn.Elapsed -= checkPONG;
				conn.Elapsed += sendPING;
				conn.Interval = 5 * 1000;
				conn.Stop();
				conn.Start();
				Send("STOP");
				running = false;
				f.SetMEDStatus("PCM stop");
			}
		}

		public void StartPCM(string file) {
			f.SetMEDStatus(file);
			File.Delete("A:\\tmp.wav");
			Process p = Process.Start(@"H:\ffmpeg\bin\ffmpeg.exe", "-i \""+ file + "\" -ar 22500 -acodec pcm_u8 -ac 1 A:\\tmp.wav");
			p.WaitForExit();
			conn.Elapsed -= checkPONG;
			conn.Elapsed -= sendPING;
			conn.Elapsed -= checkPorts;
			pcm = new Thread(pcmloop);
			pcm.Start();
			f.SetMEDStatus("PCM process");
		}

		private void pcmloop() {
			try {
				FileStream fs = new FileStream("A:\\tmp.wav", FileMode.Open);
				f.SetMEDStatus("PCM collect");

				byte[] data = new byte[fs.Length];
				fs.Read(data, 0, data.Length);
				fs.Close();
				f.SetMEDStatus("PCM start");
				try {
					// 1 hour for timeout hehe
					port.WriteTimeout = 60 * 60 * 1000;
					port.Write("PCM ");
					port.Write(data, 0, data.Length);
					f.SetMEDStatus("PCM end");

				} catch(Exception ex) {
					f.SetMEDStatus("PCM no "+ ex.Message);
				}

			//	Send("STOP");
				conn.Elapsed -= checkPONG;
				conn.Elapsed += sendPING;
				conn.Elapsed -= checkPorts;
				conn.Interval = 5 * 1000;
				conn.Stop();
				conn.Start();
			} catch (Exception ex) {
				f.SetMEDStatus("PCM no " + ex.Message);
			}
		}
	}
}