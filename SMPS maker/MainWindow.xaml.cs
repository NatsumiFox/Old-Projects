using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Interop;

namespace SMPS_maker {
	[Flags]
	public enum Channels : byte {
		chFM = 0,
		chPSG = 0x10,
		chDAC = 0x40,
		chNoise = 0x80,
		chAll = chFM | chPSG | chDAC | chNoise,
		ch1 = 0,
		ch2 = 1,
		ch3 = 2,
		ch4 = 3,
		ch5 = 4,
		ch6 = 5,
		FM1 = chFM | ch1,
		FM2 = chFM | ch1,
		FM3 = chFM | ch2,
		FM4 = chFM | ch3,
		FM5 = chFM | ch4,
		FM6 = chFM | ch5 | chDAC,
		PSG1 = chPSG | ch1,
		PSG2 = chPSG | ch2,
		PSG3 = chPSG | ch3 | chNoise,
	}

	public partial class MainWindow : Window {
		public const int WM_MOUSEHWHEEL = 0x020E;
		// is set to false in initializations, so do not fret!
		static bool playing = true;
		// whether or not FM& is DAC (NOTE: TEMPORARY(!))
		static bool fm6dac = false;
		// list of channel-specific children objects
		static List<UIElement> chchild;
		// tree of where you have gone to last
		static List<UIElement> chtree;
		// the SMPS file manager
		public static SMPSmanager smps;
		// current instance of the window
		internal static MainWindow mw;
		// constant on how many milliseconds a frame is
		public static double FRAME_MILLIS = 1000 / 60d;

		public MainWindow() {
			InitializeComponent();
			mw = this;
			scroll.Content = canvas;

			chchild = new List<UIElement>();
			chtree = new List<UIElement>();
			TreeAdd(CreateButtonTopRow("Main", ball_Click, ball_2click, Channels.chAll));
			// initialize button
			button_Click(bplps, null);
			// initialize Main window
			ball_Click(null, null);
			smps = new SMPSmanager();

			ComponentDispatcher.ThreadPreprocessMessage += (ref MSG m, ref bool handled) => {
				//check if WM_KEYDOWN, print some message to test it
				if (m.message == WM_MOUSEHWHEEL) {
					if(m.wParam.ToInt32() >> 16 > 0) {
						scroll.LineRight();
						scroll.LineRight();
						scroll.LineRight();
						scroll.LineRight();
					} else {
						scroll.LineLeft();
						scroll.LineLeft();
						scroll.LineLeft();
						scroll.LineLeft();
					}

					handled = true;
				}
			};
		}

		private UIElement TreeAdd(UIElement v) {
			if (!chtree.Contains(v)) {
				chtree.Insert(chtree.Count, v);
				chlist.Children.Add(v);
			}
			return v;
		}

		private bool GoToTreeEntry(UIElement v, string name, RoutedEventHandler c, MouseButtonEventHandler dc, Channels ch) {
			int off;
			if (v != null && (off = TreeHas(name)) != -1) {
				while (chtree.Count > off + 1) {
					chlist.Children.Remove(chtree.Last());
					chtree.Remove(chtree.Last());
				}

				return true;
			} else if (v != null){
				TreeAdd(CreateButtonTopRow(name, c, dc, ch));
				return true;
			}
			return false;
		}

		private int TreeHas(string name) {
			if(name == null) return -1;
			int o = 0;
			foreach(UIElement e in chtree) {
				sButton b = e as sButton;
				if(b != null && b.Content as string != null && b.Content as string == name) {
					return o;
				}

				o++;
			}

			return -1;
		}

		private void OpenCommandBinding_Executed(object sender, RoutedEventArgs e) {
			MessageBox.Show("Do you want to close this window?", "Confirmation", MessageBoxButton.YesNo, MessageBoxImage.Question);
		}

		private void SaveCommandBinding_Executed(object sender, RoutedEventArgs e) {

		}

		private void SaveAsCommandBinding_Executed(object sender, RoutedEventArgs e) {

		}

		private void NewCommandBinding_Executed(object sender, RoutedEventArgs e) {

		}

		public void brt_Click(object sender, RoutedEventArgs e) {
			InitializeRoutine((sender as sButton).Content as string);
		}

		public void button_Click(object sender, RoutedEventArgs e) {
			Button b = sender as Button;
			if (playing = !playing) {
				b.OpacityMask = new ImageBrush((BitmapImage) this.FindResource("ImgPauseButton"));
				b.Background = new SolidColorBrush(Color.FromRgb(216, 200, 0));

			} else {
				b.OpacityMask = new ImageBrush((BitmapImage) this.FindResource("ImgPlayButton"));
				b.Background = new SolidColorBrush(Color.FromRgb(66, 207, 24));
			}
		}

		public void bch_2click(object sender, MouseButtonEventArgs e) {
			sButton b = sender as sButton;
			if (b != null) {
				GoToTreeEntry(b, b.Content as string, b.ClickHand, b.DoubleClickHand, b.ch);
				b.ClickHand(sender, e);
			}
			if(e != null) e.Handled = true;
		}

		public void bch_Click(object sender, RoutedEventArgs e) {
			InitializeChannel((sender as sButton).ch);
		}

		public void ball_2click(object sender, MouseButtonEventArgs e) {
			sButton b = sender as sButton;
			if (b != null) {
				GoToTreeEntry(b, b.Content as string, ball_Click, ball_2click, Channels.chAll);
				ball_Click(sender, null);
			}
		}

		private void ball_Click(object sender, RoutedEventArgs e) {
			DeleteChannelContent(chstack);
			AddChannelContent(CreateLable("Base Tempo", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the base tempo", 3, REH_TempoDiv));
			AddChannelContent(CreateLable("Base Tick Multiplier", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the base tick multiplier", 3, REH_TempoMod));
		}

		private void InitializeRoutine(string name) {
			DeleteChannelContent(chstack);
			
		}

		private void InitializeChannel(Channels ch) {
			DeleteChannelContent(chstack);

			// initialize channel shits
			if (ch.HasFlag(Channels.chPSG)) InitPSGChannelContent();
			else if(ch.HasFlag(Channels.chDAC)) InitFM6ChannelContent();
			else InitFMChannelContent();
		}

		private void InitFMChannelContent() {
			AddChannelContent(CreateLable("Base Volume", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the initial channel volume", 3, REH_chVolume));
			AddChannelContent(CreateLable("Base Pitch", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the initial pitch", 3, REH_chPitch));
		}

		private void InitPSGChannelContent() {
			AddChannelContent(CreateLable("Base Volume", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the initial channel volume", 3, REH_chVolume));
			AddChannelContent(CreateLable("Base Pitch", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the initial pitch", 3, REH_chPitch));
			AddChannelContent(CreateLable("Base ModEnv", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the initial module envelope", 3, REH_chModEnv));
			AddChannelContent(CreateLable("Base VolEnv", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateTextBox("0", "Set the initial volume envelope", 3, REH_chVolEnv));
		}

		private void InitFM6ChannelContent() {
			if (!fm6dac) {
				AddChannelContent(CreateLable("Base Volume", new Thickness(0, -2, 0, 0)));
				AddChannelContent(CreateTextBox("0", "Set the initial channel volume", 3, REH_chVolume));
				AddChannelContent(CreateLable("Base Pitch", new Thickness(0, -2, 0, 0)));
				AddChannelContent(CreateTextBox("0", "Set the initial pitch", 3, REH_chPitch));
			}
			AddChannelContent(CreateLable("FM6 is DAC", new Thickness(0, -2, 0, 0)));
			AddChannelContent(CreateCheckBox(fm6dac, "Choose whether you want to us FM& or DAC", REH_fm6DAC));
		}

		private void AddChannelContent(UIElement v) {
			chchild.Add(v);
			chstack.Children.Add(v);
		}

		private void DeleteChannelContent(StackPanel s) {
			foreach (UIElement e in chchild) {
				s.Children.Remove(e);
			}

			chchild.Clear();
		}

		private TextBox CreateTextBox(string v, string tool, int maxlen, RoutedEventHandler f) {
			TextBox l = new TextBox();
			l.Text = "0";
			l.Width = 30;
			l.UndoLimit = 105;
			l.ToolTip = tool;
			l.IsInactiveSelectionHighlightEnabled = true;
			l.AcceptsReturn = false;
			l.Foreground = new SolidColorBrush(Colors.WhiteSmoke);
			l.Background = new SolidColorBrush(Color.FromRgb(55,55,55));
			l.SelectionBrush = new SolidColorBrush(Color.FromArgb(191, 55, 55, 55));
			l.BorderBrush = new SolidColorBrush(Color.FromRgb(65, 65, 65));
			l.HorizontalScrollBarVisibility = ScrollBarVisibility.Disabled;
			l.MaxLength = maxlen;
			l.MaxLines = 1;
			l.MinLines = 1;
			l.LostFocus += f;
			return l;
		}

		private Label CreateLable(string v, Thickness margin) {
			Label l = new Label();
			l.Content = v;
			l.Foreground = new SolidColorBrush(Colors.WhiteSmoke);
			l.Background = null;
			l.Margin = margin;
			return l;
		}

		private CheckBox CreateCheckBox(bool check, string tool, RoutedEventHandler f) {
			CheckBox l = new CheckBox();
			l.IsChecked = check;
			l.Foreground = new SolidColorBrush(Colors.WhiteSmoke);
			l.Background = new SolidColorBrush(Color.FromRgb(55, 55, 55));
			l.BorderBrush = new SolidColorBrush(Color.FromRgb(65, 65, 65));
			l.Checked += f;
			l.Unchecked += f;
			l.Style = this.FindResource("CheckBoxStyle1") as Style;
			return l;
		}

		private sButton CreateButtonTopRow(string v, RoutedEventHandler c, MouseButtonEventHandler dc, Channels ch) {
			sButton l = new sButton(ch, false);
			l.Content = v;
			l.Margin = new Thickness(0, 0, 0, 0);
			l.Width = 40;
			l.Foreground = new SolidColorBrush(Colors.WhiteSmoke);
			l.Style = this.FindResource("MyButtonStyle") as Style;
			l.AddClickHandler(c);
			l.AddDoubleClickHandler(dc);
			return l;
		}

		public void REH_TempoDiv(object sender, RoutedEventArgs e) {
			throw new NotImplementedException();
		}

		public void REH_TempoMod(object sender, RoutedEventArgs e) {
			throw new NotImplementedException();
		}

		public void REH_chVolume(object sender, RoutedEventArgs e) {
			throw new NotImplementedException();
		}

		public void REH_chPitch(object sender, RoutedEventArgs e) {
			throw new NotImplementedException();
		}

		public void REH_chVolEnv(object sender, RoutedEventArgs e) {
			throw new NotImplementedException();
		}

		public void REH_chModEnv(object sender, RoutedEventArgs e) {
			throw new NotImplementedException();
		}

		public void REH_fm6DAC(object sender, RoutedEventArgs e) {
			fm6dac = !fm6dac;
			InitializeChannel(Channels.FM6);
		}

		private void flowchart_MouseLeftButtonDown(object sender, MouseButtonEventArgs e) {
			smps.Select(null);
			ball_Click(null, null);
		}

		private void SMPS_maker_SizeChanged(object sender, SizeChangedEventArgs e) {
			scroll.Height = ((Panel) Content).ActualHeight - scroll.TransformToAncestor(this).Transform(new Point(0, 0)).Y;
			scroll.Width = ((Panel) Content).ActualWidth;

			// attempt to resize flowchart. NOTE: redo when time line is active to have different code!!!
			double w = scroll.Width, h = scroll.Height;
			foreach (UIElement u in canvas.Children) {
				if ((u as sButton) != null) {
					w = Math.Max(w, (u as sButton).Margin.Left + (u as sButton).ActualWidth);
					h = Math.Max(h, (u as sButton).Margin.Top + (u as sButton).ActualHeight);
				}
			}

			canvas.Height = h;
			canvas.Width = w;
		}

		private void scroll_PreviewMouseWheel(object sender, MouseWheelEventArgs e) {
			if ((Keyboard.Modifiers & ModifierKeys.Control) > 0) {
				if(e.Delta > 0) {
					(sender as ScrollViewer).LineLeft();
					(sender as ScrollViewer).LineLeft();

				} else {
					(sender as ScrollViewer).LineRight();
					(sender as ScrollViewer).LineRight();
				}

			} else {
				if(e.Delta < 0) {
					(sender as ScrollViewer).LineDown();
					(sender as ScrollViewer).LineDown();

				} else {
					(sender as ScrollViewer).LineUp();
					(sender as ScrollViewer).LineUp();
				}
			}

			e.Handled = true;
		}

		private void tps_LostFocus(object sender, RoutedEventArgs e) {
			double res;
			if (Double.TryParse((sender as TextBox).Text.Replace(',', '.'), out res))
				FRAME_MILLIS = 1000 / res;
			else (sender as TextBox).Text = ""+ string.Format("{0:0.000}", 1000 / FRAME_MILLIS);
		}
	}
}
