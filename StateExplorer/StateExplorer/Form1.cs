using OpenTK.Graphics.OpenGL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace StateExplorer {
	public partial class MainWindow : Form {
		public static MainWindow mw;
		public static int shaderProg;

		public MainWindow() {
			mw = this;
			InitializeComponent();
			Load += LoadHandle;
		}

		private void LoadHandle(object sender, EventArgs e) {
			CompileShaders();
			using (Stream s = File.OpenRead(@"G:\C#\StateExplorer\TEST 1.gsx")) {
				VDP.Create(s);
			}
		}

		public static void CompileShaders() {
			// Compile vertex shader
			int vertShader = GL.CreateShader(ShaderType.VertexShader);
			GL.ShaderSource(vertShader, Properties.Resources.PixelVertexShader);
			GL.CompileShader(vertShader);
			GL.GetShader(vertShader, ShaderParameter.CompileStatus, out int status);

			if (status == 0) {
				MessageBox.Show("Failed to compile vertex shader!\n\n" + GL.GetShaderInfoLog(vertShader));
				GL.DeleteShader(vertShader);
				return;
			}

			// Compile fragment shader
			int fragShader = GL.CreateShader(ShaderType.FragmentShader);
			GL.ShaderSource(fragShader, Properties.Resources.PixelFragmentShader);
			GL.CompileShader(fragShader);
			GL.GetShader(fragShader, ShaderParameter.CompileStatus, out status);

			if (status == 0) {
				MessageBox.Show("Failed to compile vertex shader!\n\n" + GL.GetShaderInfoLog(fragShader));
				GL.DeleteShader(fragShader);
				return;
			}

			// Link shaders
			shaderProg = GL.CreateProgram();
			GL.AttachShader(shaderProg, vertShader);
			GL.AttachShader(shaderProg, fragShader);
			GL.LinkProgram(shaderProg);

			GL.GetProgram(shaderProg, GetProgramParameterName.LinkStatus, out int linked);

			if(linked == 0) {
				MessageBox.Show("Failed to link shader program!\n\n" + GL.GetProgramInfoLog(shaderProg));
				GL.DeleteProgram(shaderProg);
				GL.DeleteShader(fragShader);
				GL.DeleteShader(vertShader);
				return;
			}

			// Clean up
			GL.DetachShader(shaderProg, vertShader);
			GL.DetachShader(shaderProg, fragShader);
		}

		private void openToolStripMenuItem_Click(object sender, EventArgs e) {
			try {
				openFileDialog1.InitialDirectory = @"G:\C#\StateExplorer\";

				if (openFileDialog1.ShowDialog() == DialogResult.OK) {
					using (Stream s = openFileDialog1.OpenFile())
						VDP.Create(s);
				}
			} catch(Exception ex) {
				MessageBox.Show("Failed to load file as a save state. Are you sure this file is a valid save state?\n\n" + ex);
			}
		}
	}
}
