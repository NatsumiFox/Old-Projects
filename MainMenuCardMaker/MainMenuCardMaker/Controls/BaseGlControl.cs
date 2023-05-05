using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using OpenTK;
using OpenTK.Graphics.OpenGL;
using System.Diagnostics;

namespace MainMenuCardMaker.Controls {
	public partial class BaseGlControl : GLControl {
		// gets set to true if we can safely update OpenGL
		protected bool update = false;
		// object to make operations thread-safe
		protected object busy = new object();

		// function to set or reset update flag
		public void SetUpdate(bool state) {
			lock (busy) update = state;
		}

		// define viewport widht and height. 0 means size is according to the real size of the control
		[Description("Defines the viewport's horizontal size. Leave to 0 if you want it to auto-resize."), Category("Misc")]
		public int ViewportW { get; set; } = 0;
		[Description("Defines the viewport's vertical size. Leave to 0 if you want it to auto-resize."), Category("Misc")]
		public int ViewportH { get; set; } = 0;

		// these calculate the actual viewport sizes taking in account the 0-rule
		public int ActualWidth => ViewportW != 0 ? ViewportW : Width;
		public int ActualHeight => ViewportH != 0 ? ViewportH : Height;

		// define settings regarding zooming. This control handles zooming for you and these params define how much zooming is possible
		public double ZoomLevel = 1;
		[Description("Defines the viewport's maximum zoom level. Leave to 1 to disable zooming out."), Category("Misc")]
		public double ZoomMax { get; set; } = 1;
		[Description("Defines the viewport's minumum zoom level. Leave to 1 to disable zooming in."), Category("Misc")]
		public double ZoomMin { get; set; } = 1;

		protected bool translate = false;

		// define x and y coordinates of the projection. Used to scroll around
		public double XPosition = 0, YPosition = 0;

		public BaseGlControl() {
			InitializeComponent();
		}

		protected override void OnLoad(EventArgs e) {
			base.OnLoad(e);

			if (update = !DesignMode) {
				OnResize(EventArgs.Empty);  // force run once more
				GL.Enable(EnableCap.Blend);
			}
		}

		protected override void OnMouseWheel(MouseEventArgs e) {
			base.OnMouseWheel(e);

			if (update) {
				// calculate the delta of the zoom (might want to check this code later! Not sure if this is good.)
				double delta = e.Delta * (0.001f * ZoomLevel), oldzoom = ZoomLevel;

				// Get the pixel the mouse is aiming at (relative to the zoom level)
				Point p = PointToClient(Cursor.Position);
				p.X = (int)((p.X - (ClientRectangle.Width / 2) + XPosition) / ZoomLevel);
				p.Y = (int)((p.Y - (ClientRectangle.Height / 2) + YPosition) / ZoomLevel);

				// fix the position to make sure it is on the actual viewport
				if (Math.Abs(p.X) > ActualWidth / 2) p.X = ActualWidth / 2 * (p.X > 0 ? 1 : -1);
				if (Math.Abs(p.Y) > ActualHeight / 2) p.Y = ActualHeight / 2 * (p.Y > 0 ? 1 : -1);

				// do some checking to make sure the Zoom level is in proper bounds
				ZoomLevel += delta;
				if (ZoomLevel < ZoomMax) {
					delta -= ZoomLevel - ZoomMax;
					ZoomLevel = ZoomMax;

				} else if (ZoomLevel > ZoomMin) {
					delta -= ZoomLevel - ZoomMin;
					ZoomLevel = ZoomMin;
				}

				if (oldzoom != ZoomLevel) {
					// offset x and y positions to zoom in the pixel where the mouse was
					XPosition += p.X * (delta);
					YPosition += p.Y * (delta);
					OnResize(EventArgs.Empty);
					Invalidate();
				}
			}
		}

		private Point? MousePos = null;

		protected override void OnMouseDown(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (e.Button == MouseButtons.Left)
				MousePos = new Point(e.X, e.Y);
		}

		protected override void OnMouseUp(MouseEventArgs e) {
			base.OnMouseUp(e);

			if (e.Button == MouseButtons.Left)
				MousePos = null;
		}

		protected override void OnMouseMove(MouseEventArgs e) {
			base.OnMouseMove(e);

			if (MousePos != null && update) {
				FixPos(MousePos.Value.X - e.X, MousePos.Value.Y - e.Y);
				MousePos = new Point(e.X, e.Y);

				OnResize(EventArgs.Empty);  // force run once more
				Invalidate();
			}
		}

		private void FixPos(int x, int y) {
			XPosition += x;
			YPosition += y;

			Point p = GetBounds();
			if (Math.Abs(XPosition) >= p.X) XPosition = p.X * (XPosition > 0 ? 1 : -1);
			if (Math.Abs(YPosition) >= p.Y) YPosition = p.Y * (YPosition > 0 ? 1 : -1);
		}

		private Point GetBounds() {
			Point p = new Point();
			double quadX = ActualWidth * ZoomLevel / 2, quadY = ActualHeight * ZoomLevel / 2;

			if (ClientRectangle.Width / 2 > quadX)
				p.X = 0;

			else p.X = (int)(quadX - ClientRectangle.Width / 2);

			if (ClientRectangle.Height / 2 > quadY)
				p.Y = 0;

			else p.Y = (int)(quadY - ClientRectangle.Height / 2);

			return p;
		}

		protected override void OnResize(EventArgs e) {
			base.OnResize(e);

			lock (busy)
				if (update) {
					FixPos(0, 0);
					MakeCurrent(); 

					GL.MatrixMode(MatrixMode.Projection);
					GL.LoadIdentity();
					GL.Viewport((int)((ClientRectangle.Width - (ActualWidth * ZoomLevel)) / 2 - XPosition), (int)((ClientRectangle.Height - (ActualHeight * ZoomLevel)) / 2 + YPosition),
						(int)(ActualWidth * ZoomLevel), (int)(ActualHeight * ZoomLevel));

					GL.MatrixMode(MatrixMode.Modelview);
					GL.LoadIdentity();
					GL.Ortho(0, ActualWidth, ActualHeight, 0, 1, -1);
					if(translate) GL.Translate(0.5f, 0.5f, 0f);
				}
		}

		protected override void OnPaint(PaintEventArgs e) {
			base.OnPaint(e);

			if (!DesignMode)
				lock (busy)
					if (update) {
						MakeCurrent();
						GL.Clear(ClearBufferMask.ColorBufferBit | ClearBufferMask.DepthBufferBit);
						Draw();
						GL.Flush();
						SwapBuffers();
					}
		}

		protected virtual void Draw() { }
	}
}
