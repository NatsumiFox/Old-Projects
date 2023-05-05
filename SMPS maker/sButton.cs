using System;
using System.ComponentModel;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace SMPS_maker {
	public class sButton : Button {
		// last mouse down position
		private Point pos = new Point { X = -1, Y = -1, };
		private bool dragging;
		private Thickness orig;

		public Channels ch { get; private set; }
		public RoutedEventHandler ClickHand { get; private set; }
		public MouseButtonEventHandler DoubleClickHand { get; private set; }

		public double MiddleX { set { SetValue(MiddleXProperty, Margin.Left + (ActualWidth / 2)); } }
		public double MiddleY { set { SetValue(MiddleYProperty, Margin.Top + (ActualHeight / 2)); } }
		public static readonly DependencyProperty MiddleXProperty = DependencyProperty.Register("z", typeof(double), typeof(sButton));
		public static readonly DependencyProperty MiddleYProperty = DependencyProperty.Register("c", typeof(double), typeof(sButton));

		public bool IsSelected { get { return (bool) GetValue(IsSelectedProperty); } set { SetValue(IsSelectedProperty, value); } }
		public static readonly DependencyProperty IsSelectedProperty = DependencyProperty.Register("IsSelected", typeof(bool), typeof(sButton));

		public sButton(bool drag) : base() {
			if (drag) {
				PreviewMouseLeftButtonDown += msd;
				PreviewMouseLeftButtonUp += msu;
				Loaded += SMPSmanager.strobeConnections;
				MouseEnter += highlight;
				MouseLeave += rmvhighlight;
			}
		}

		public sButton(Channels ch, bool drag) : base() {
			this.ch = ch;
			if (drag) {
				PreviewMouseLeftButtonDown += msd;
				PreviewMouseLeftButtonUp += msu;
				MouseEnter += highlight;
				MouseLeave += rmvhighlight;
			}
		}

		public void AddClickHandler(RoutedEventHandler r) {
			if(r == null) return;
			ClickHand = r;
			Click += r;
		}

		public void AddDoubleClickHandler(MouseButtonEventHandler r) {
			if(r == null) return;
			DoubleClickHand = r;
			MouseDoubleClick += r;
		}

		private void msd(object sender, MouseButtonEventArgs e) {
			MainWindow.smps.Select(this);
			MouseEnter -= highlight;
			MouseLeave -= rmvhighlight;

			//	MainWindow.mw.canvas.Children.Remove(this);
			//	MainWindow.mw.canvas.Children.Add(this);
			if (e.ClickCount == 1 && ClickHand != null) ClickHand(sender, null);
			else if(e.ClickCount > 1 && DoubleClickHand != null) DoubleClickHand(sender, null);
			(sender as sButton).CaptureMouse();
			PreviewMouseMove += msm;
			pos = e.GetPosition(this);
			orig = Margin;
			dragging = true;
			IsSelected = true;
			e.Handled = true;
		}

		private void msm(object sender, MouseEventArgs e) {
			if (dragging) {
				e.Handled = true;
				Point cp = e.GetPosition(MainWindow.mw.canvas);

				if (FixPosition(cp.X - pos.X, cp.Y - pos.Y)) {
					Opacity = 0.25;
				} else {
					Opacity = 1;
				}
			}
		}

		private void msu(object sender, MouseButtonEventArgs e) {
			PreviewMouseMove -= msm;
			Point cp = e.GetPosition(MainWindow.mw.canvas);
			if(FixPosition(cp.X - pos.X, cp.Y - pos.Y)) {
				Margin = orig;
				Opacity = 1;
				MiddleX = 0;
				MiddleY = 0;
			}

			(sender as sButton).ReleaseMouseCapture();
			dragging = false;
			e.Handled = true;
		}

		private bool FixPosition(double left, double top) {
			Opacity = 1;
			double w = MainWindow.mw.canvas.Width - ActualWidth, h = MainWindow.mw.canvas.Height - ActualHeight;

			// check for collisions with another object
			bool coll = false, c = false;
			byte pass = 0;
			sButton a = null;
			while (pass != 3) {
				foreach (UIElement e in MainWindow.mw.canvas.Children) {
					sButton b = e as sButton;
					if (b != null && b != this && CheckCollision(
							new Vector2 { x = left, y = top },
							new Vector2 { x = left + ActualWidth, y = top + ActualHeight },
							new Vector2 { x = b.Margin.Left - 5, y = b.Margin.Top - 5 },
							new Vector2 { x = b.Margin.Left + b.ActualWidth + 5, y = b.Margin.Top + b.ActualHeight + 5 })) {

						if ((pass == 0 && !c) || pass == 1 || (pass == 2 && a == b)) {
							a = b;
							if (Math.Abs(b.Margin.Left - left) > Math.Abs(b.Margin.Top - top)) {
								if (b.Margin.Left - left >= 0) {
									left = b.Margin.Left - 6 - ActualWidth;
								} else {
									left = b.Margin.Left + 6 + b.ActualWidth;
								}
							} else {
								if (b.Margin.Top - top >= 0) {
									top = b.Margin.Top - 6 - ActualHeight;
								} else {
									top = b.Margin.Top + 6 + b.ActualHeight;
								}
							}
							c = true;
							
						} else if(pass == 2){
							coll = true;
						}
					}
				}

				if (left < 0) {
					left = 0;
					if(pass == 1) coll = true;

				} else if (left > w) {
					left = w;
					if(pass == 1) coll = true;
				}

				if (top < 0) {
					top = 0;
					if(pass == 1) coll = true;

				} else if (top > h) {
					top = h;
					if(pass == 1) coll = true;
				}
				pass++;
			}

			Margin = new Thickness(left, top, 0, 0);
			MiddleX = 0;
			MiddleY = 0;
			return coll;
		}

		private bool CheckCollision(Vector2 tl1, Vector2 br1, Vector2 tl2, Vector2 br2) {
			if (tl2.x - br1.x > 0 || tl2.y - br1.y > 0 || tl1.x - br2.x > 0 || tl1.y - br2.y > 0)
				return false;
			return true;
		}

		internal void highlight(object sender, MouseEventArgs e) {
			MainWindow.smps.HLitePath(this);
		}

		internal void rmvhighlight(object sender, MouseEventArgs e) {
			MainWindow.smps.NormalizeitePath(this);
		}
	}

	internal struct Vector2 {
		public double x;
		public double y;
	}
}