using SMPS_maker;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;

namespace SMPS_maker {
	public class SMPSmanager {
		// FM and PSG channels
		public Channel FM1;
		public Channel FM2;
		public Channel FM3;
		public Channel FM4;
		public Channel FM5;
		public Channel FM6;
		public Channel PSG1;
		public Channel PSG2;
		public Channel PSG3;

		internal sButton Selected { get; private set; }
		public List<Node> routines;

		// create SMPS file from a file
		public SMPSmanager(string file) {
			// here we would load a file. But since we dont have one, dont =(
			FM1 = new Channel(Channels.FM1, "FM1");
			FM2 = new Channel(Channels.FM2, "FM2");
			FM3 = new Channel(Channels.FM3, "FM3");
			FM4 = new Channel(Channels.FM4, "FM4");
			FM5 = new Channel(Channels.FM5, "FM5");
			FM6 = new Channel(Channels.FM6, "FM6");
			PSG1 = new Channel(Channels.PSG1, "PSG1");
			PSG2 = new Channel(Channels.PSG2, "PSG2");
			PSG3 = new Channel(Channels.PSG3, "PSG3");

			int h = 5;
			MainWindow.mw.canvas.Children.Add(fwButton("FM1", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM1)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM2", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM2)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM3", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM3)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM4", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM4)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM5", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM5)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM6", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM6)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("PSG1", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.PSG1)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("PSG2", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.PSG2)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("PSG3", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.PSG3)); h += 58;
		}

		// create empty SMPS manager.
		public SMPSmanager() {
			routines = new List<Node>();

			FM1 = new Channel(Channels.FM1, "FM1");
			FM2 = new Channel(Channels.FM2, "FM2");
			FM3 = new Channel(Channels.FM3, "FM3");
			FM4 = new Channel(Channels.FM4, "FM4");
			FM5 = new Channel(Channels.FM5, "FM5");
			FM6 = new Channel(Channels.FM6, "FM6");
			FM6.IsDAC = true;
			PSG1 = new Channel(Channels.PSG1, "PSG1");
			PSG2 = new Channel(Channels.PSG2, "PSG2");
			PSG3 = new Channel(Channels.PSG3, "PSG3");

			int h = 5;
			MainWindow.mw.canvas.Children.Add(fwButton("FM1", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM1)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM2", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM2)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM3", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM3)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM4", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM4)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM5", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM5)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("FM6", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.FM6)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("PSG1", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.PSG1)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("PSG2", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.PSG2)); h += 58;
			MainWindow.mw.canvas.Children.Add(fwButton("PSG3", new Thickness(5, h, 50, 50), MainWindow.mw.bch_Click, MainWindow.mw.bch_2click, Channels.PSG3)); h += 58;

			// Create test channel data NOTE: TEMPORARY(!)
			Routine s = new Routine("rt_01");
			s.addElementLast(new Note(0xBA, 5, true));
			s.addElementLast(new SMPScmdCall(new UnroutedTarget("rt_02")));
			s.addElementLast(new SMPScmdReturn());
			AddRoutine(s);

			FM1.addElementLast(new SMPScmdCall(new Target(s)));
			FM1.addElementLast(new Note(0x84, 0x33, true));
			FM1.addElementLast(new SMPScmdCall(new UnroutedTarget("rt_02")));
			FM1.addElementLast(new SMPScmdJump(new UnroutedTarget("rt_03")));

			s = new Routine("rt_02");
			s.addElementLast(new Note(0xEF, 0x10, true));
			s.addElementLast(new SMPScmdReturn());
			AddRoutine(s);

			PSG1.addElementLast(new SMPScmdCall(new Target(s)));
			PSG1.addElementLast(new SMPScmdStop());

			s = new Routine("rt_03");
			s.addElementLast(new SMPScmdStop());
			AddRoutine(s);

			FM3.addElementLast(new SMPScmdCall(new Target(s)));
			FM3.addElementLast(new SMPScmdStop());

			addConnection("rt_01", "rt_02");
			addConnection("FM1", "rt_01");
			addConnection("FM1", "rt_02");
			addConnection("FM1", "rt_03");
			addConnection("PSG1", "rt_02");
			addConnection("FM3", "rt_03");
		}

		internal void Select(sButton b) {
			if(Selected != b) {
				if (Selected != null) {
					NormalizeitePath(Selected);
					Selected.MouseEnter += Selected.highlight;
					Selected.MouseLeave += Selected.rmvhighlight;
					Selected.Background = null;
					Selected.IsSelected = false;
				}

				Selected = b;
				if(b != null) SelPath(b);
			}
		}

		public static void strobeConnections(object sender, RoutedEventArgs e) {
			foreach (UIElement n in MainWindow.mw.canvas.Children) {
				sButton b = n as sButton;
				if(b != null) {
					b.MiddleX = 0;
					b.MiddleY = 0;
				}
			}
		}

		internal Element FindTarget(string t) {
			switch (t) {
				case "FM1":
					return FM1;
				case "FM2":
					return FM2;
				case "FM3":
					return FM3;
				case "FM4":
					return FM4;
				case "FM5":
					return FM5;
				case "FM6":
					return FM6;
				case "PSG1":
					return PSG1;
				case "PSG2":
					return PSG2;
				case "PSG3":
					return PSG3;
				default:
					foreach (Node n in routines) {
						if (n.Name != null && n.Name == t) {
							return n;
						}
					}

					return null;
			}
		}

		internal sButton FindTargetUI(string t) {
			foreach (UIElement n in MainWindow.mw.canvas.Children) {
				if (n as sButton != null && (n as sButton).Content as string == t) {
					return n as sButton;
				}
			}

			return null;
		}

		private bool addConnection(string from, string to) {
			sButton ef = FindTargetUI(from), et = FindTargetUI(to);
			if (ef == null || et == null) return false;

			Line l = new Line();
			l.Stroke = new SolidColorBrush(Colors.White);
			l.StrokeThickness = 1.75;
			l.SetBinding(Line.X1Property, new Binding() { Source = ef, Path = new PropertyPath(sButton.MiddleXProperty) });
			l.SetBinding(Line.X2Property, new Binding() { Source = et, Path = new PropertyPath(sButton.MiddleXProperty) });
			l.SetBinding(Line.Y1Property, new Binding() { Source = ef, Path = new PropertyPath(sButton.MiddleYProperty) });
			l.SetBinding(Line.Y2Property, new Binding() { Source = et, Path = new PropertyPath(sButton.MiddleYProperty) });
			l.Name = from + '_' + to;
			MainWindow.mw.canvas.Children.Insert(0, l);
			return true;
		}

		private void AddRoutine(Routine s) {
			AddRoutine_(s);
			fwButton(s.GetName(), MainWindow.mw.canvas.Children);
		}

		private void AddRoutine_(Routine s) {
			routines.Add(s);
		}

		private void fwButton(string name, UIElementCollection c) {
			c.Add(fwButton(name, FindFreeSlot(c), MainWindow.mw.brt_Click, MainWindow.mw.bch_2click));
		}

		private UIElement fwButton(string name, Thickness t, RoutedEventHandler c, MouseButtonEventHandler dc) {
			sButton l = new sButton(true);
			l.Content = name;
			l.Margin = t;
			l.Foreground = new SolidColorBrush(Colors.WhiteSmoke);
			l.Style = MainWindow.mw.FindResource("SourceButton") as Style;
			l.AddClickHandler(c);
			l.AddDoubleClickHandler(dc);
			return l;
		}

		private UIElement fwButton(string name, Thickness t, RoutedEventHandler c, MouseButtonEventHandler dc, Channels ch) {
			sButton l = new sButton(ch, true);
			l.Content = name;
			l.Margin = t;
			l.Foreground = new SolidColorBrush(Colors.WhiteSmoke);
			l.Style = MainWindow.mw.FindResource("SourceButton") as Style;
			l.AddClickHandler(c);
			l.AddDoubleClickHandler(dc);
			return l;
		}

		private Thickness FindFreeSlot(UIElementCollection c) {
			Thickness t = new Thickness(0, 0, 0, 0);
			int x = 200, y = 5;

			while (true) {
				foreach (UIElement e in c) {
					sButton b = e as sButton;
					if(b != null && b.Margin.Left >= x && b.Margin.Right < x + 150 && b.Margin.Top >= y && b.Margin.Bottom < y + 75) {
						// some of the edges hit, failed to place item
						goto fail;
					}
				}

				goto end;

				fail:
				y += 75;
			}

			end:
			t.Left = x;
			t.Top = y;
			return t;
		}

		internal void HLitePath(sButton t) {
			ConnectionColor(getPath(FindTarget(t.Content as string) as Node), new SolidColorBrush(Colors.Yellow));
		}

		internal void SelPath(sButton t) {
			ConnectionColor(getPath(FindTarget(t.Content as string) as Node), new SolidColorBrush(Colors.CadetBlue));
		}

		internal void NormalizeitePath(sButton t) {
			ConnectionColor(getPath(FindTarget(t.Content as string) as Node), new SolidColorBrush(Colors.White));
		}

		private void ConnectionColor(P[] x, SolidColorBrush c) {
			foreach(P p in x) {
				Line l = getConnection((p.from.GetTarget() as Node).GetName() + '_' + ((p.to.GetTarget() as Node).GetName()));
				if(l != null) l.Stroke = c;

			}
		}

		private Line getConnection(string s) {
			foreach (UIElement n in MainWindow.mw.canvas.Children) {
				Line l = n as Line;
				if(l != null && l.Name == s) {
					return l;
				}
			}

			return null;
		}

		private P[] getPath(Node t) {
			List<P> o = new List<P>();
			foreach(Element e in t.Get()) {
				Command c = e as Command;
				if(c != null) {
					Target y = null;
					if (c.action.HasFlag(Actions.Routine) && c as SMPScmdCall != null) {
						y = (c as SMPScmdCall).getTarget();
						o.Add(new P (){ from = new Target(t), to = y });

					} else if (c.action.HasFlag(Actions.Routine) && c as SMPScmdJump != null) {
						y = (c as SMPScmdJump).getTarget();
						o.Add(new P() { from = new Target(t), to = y });
					}

					if(y != null && y.a as Node != null) {
						foreach (P p in getPath(y.a as Node)) {
							o.Add(p);
						}
					}
				}
			}

			return o.ToArray();
		}
	}

	internal struct P {
		public Target from { get; set; }
		public Target to { get; set; }
	}
}