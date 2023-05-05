using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace StateExplorer {
	static class Program {
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() {
			AppDomain.CurrentDomain.UnhandledException += (sender, args) => UnhandledException(args.ExceptionObject as Exception);
			Application.ThreadException += (sender, args) => UnhandledException(args.Exception);
			Application.EnableVisualStyles();
			Application.SetCompatibleTextRenderingDefault(false);
			Application.Run(new MainWindow());
		}

		private static void UnhandledException(Exception ex) {
			Console.WriteLine(ex);
		}
	}
}
