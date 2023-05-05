﻿
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace SonicRetro.SonLVL.API {
	public partial class DragListView : ListView {
		#region Constants

		private const int WM_PAINT = 0xF;

		#endregion

		#region Instance Fields

		private bool _allowItemDrag;

		private Color _insertionLineColor;

		#endregion

		#region Public Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="ListView"/> class.
		/// </summary>
		public DragListView() {
			this.DoubleBuffered = true;
			this.InsertionLineColor = Color.Red;
			this.InsertionIndex = -1;
			InitializeComponent();
		}

		#endregion

		#region Events

		/// <summary>
		/// Occurs when the AllowItemDrag property value changes.
		/// </summary>
		[Category("Property Changed")]
		public event EventHandler AllowItemDragChanged;

		/// <summary>
		/// Occurs when the InsertionLineColor property value changes.
		/// </summary>
		[Category("Property Changed")]
		public event EventHandler InsertionLineColorChanged;

		/// <summary>
		/// Occurs when a drag-and-drop operation for an item is completed.
		/// </summary>
		[Category("Drag Drop")]
		public event EventHandler<ListViewItemDragEventArgs> ItemDragDrop;

		[Category("Drag Drop")]
		public event EventHandler<ListViewItemDragEventArgs> ItemDragDrop2;

		/// <summary>
		/// Occurs when the user begins dragging an item.
		/// </summary>
		[Category("Drag Drop")]
		public event EventHandler<CancelListViewItemDragEventArgs> ItemDragging;

		#endregion

		#region Overridden Methods

		/// <summary>
		/// Raises the <see cref="E:System.Windows.Forms.Control.DragDrop" /> event.
		/// </summary>
		/// <param name="drgevent">A <see cref="T:System.Windows.Forms.DragEventArgs" /> that contains the event data.</param>
		protected override void OnDragDrop(DragEventArgs drgevent) {
			if (this.IsRowDragInProgress) {
				try {
					ListViewItem dropItem;

					dropItem = this.InsertionIndex != -1 ? this.Items[this.InsertionIndex] : null;

					if (dropItem != null) {
						ListViewItem dragItem;
						int dropIndex;

						dragItem = (ListViewItem)drgevent.Data.GetData(typeof(ListViewItem));
						dropIndex = dropItem.Index;

						if (dragItem.Index < dropIndex) {
							dropIndex--;
						}
						if (this.InsertionMode == InsertionMode.After && dragItem.Index < this.Items.Count - 1) {
							dropIndex++;
						}

						if (dropIndex != dragItem.Index) {
							ListViewItemDragEventArgs args;
							Point clientPoint;

							clientPoint = this.PointToClient(new Point(drgevent.X, drgevent.Y));
							args = new ListViewItemDragEventArgs(dragItem, dropItem, dropIndex, this.InsertionMode, clientPoint.X, clientPoint.Y);

							this.OnItemDragDrop(args);

							if (!args.Cancel) {
								this.Items.Remove(dragItem);
								this.Items.Insert(dropIndex, dragItem);
								this.SelectedItem = dragItem;
							}

							this.OnItemDragDrop2(args);
						}
					}
				} finally {
					this.InsertionIndex = -1;
					this.IsRowDragInProgress = false;
					this.Invalidate();
				}
			}

			base.OnDragDrop(drgevent);
		}

		/// <summary>
		/// Raises the <see cref="E:System.Windows.Forms.Control.DragLeave" /> event.
		/// </summary>
		/// <param name="e">An <see cref="T:System.EventArgs" /> that contains the event data.</param>
		protected override void OnDragLeave(EventArgs e) {
			this.InsertionIndex = -1;
			this.Invalidate();

			base.OnDragLeave(e);
		}

		/// <summary>
		/// Raises the <see cref="E:System.Windows.Forms.Control.DragOver" /> event.
		/// </summary>
		/// <param name="drgevent">A <see cref="T:System.Windows.Forms.DragEventArgs" /> that contains the event data.</param>
		protected override void OnDragOver(DragEventArgs drgevent) {
			if (this.IsRowDragInProgress) {
				int insertionIndex;
				InsertionMode insertionMode;
				ListViewItem dropItem;
				Point clientPoint;

				clientPoint = this.PointToClient(new Point(drgevent.X, drgevent.Y));
				dropItem = this.GetItemAt(0, Math.Min(clientPoint.Y, this.Items[this.Items.Count - 1].GetBounds(ItemBoundsPortion.Entire).Bottom - 1));

				if (dropItem != null) {
					Rectangle bounds;

					bounds = dropItem.GetBounds(ItemBoundsPortion.Entire);
					insertionIndex = dropItem.Index;
					insertionMode = clientPoint.Y < bounds.Top + (bounds.Height / 2) ? InsertionMode.Before : InsertionMode.After;

					drgevent.Effect = DragDropEffects.Move | DragDropEffects.Scroll;
				} else {
					insertionIndex = -1;
					insertionMode = this.InsertionMode;

					drgevent.Effect = DragDropEffects.None;
				}

				if (insertionIndex != this.InsertionIndex || insertionMode != this.InsertionMode) {
					this.InsertionMode = insertionMode;
					this.InsertionIndex = insertionIndex;
					this.Invalidate();
				}
			}

			base.OnDragOver(drgevent);
		}

		/// <summary>
		/// Raises the <see cref="E:System.Windows.Forms.ListView.ItemDrag" /> event.
		/// </summary>
		/// <param name="e">An <see cref="T:System.Windows.Forms.ItemDragEventArgs" /> that contains the event data.</param>
		protected override void OnItemDrag(ItemDragEventArgs e) {
			if (this.AllowItemDrag && this.Items.Count > 1) {
				CancelListViewItemDragEventArgs args;

				args = new CancelListViewItemDragEventArgs((ListViewItem)e.Item);

				this.OnItemDragging(args);

				if (!args.Cancel) {
					this.IsRowDragInProgress = true;
					this.DoDragDrop(e.Item, DragDropEffects.Move | DragDropEffects.Scroll);
				}
			}

			base.OnItemDrag(e);
		}

		/// <summary>
		/// Raises the <see cref="E:System.Windows.Forms.Control.Paint"/> event.
		/// </summary>
		/// <param name="e">A <see cref="T:System.Windows.Forms.PaintEventArgs"/> that contains the event data. </param>
		protected override void OnPaint(PaintEventArgs e) {
			base.OnPaint(e);
		}

		/// <summary>
		/// Overrides <see cref="M:System.Windows.Forms.Control.WndProc(System.Windows.Forms.Message@)" />.
		/// </summary>
		/// <param name="m">The Windows <see cref="T:System.Windows.Forms.Message" /> to process.</param>
		[DebuggerStepThrough]
		protected override void WndProc(ref Message m) {
			base.WndProc(ref m);

			switch (m.Msg) {
				case WM_PAINT:
					this.OnWmPaint(ref m);
					break;
			}
		}

		#endregion

		#region Public Properties

		[Category("Behavior")]
		[DefaultValue(false)]
		public virtual bool AllowItemDrag {
			get { return _allowItemDrag; }
			set {
				if (this.AllowItemDrag != value) {
					_allowItemDrag = value;

					this.OnAllowItemDragChanged(EventArgs.Empty);
				}
			}
		}

		/// <summary>
		/// Gets or sets the color of the insertion line drawn when dragging items within the control.
		/// </summary>
		/// <value>The color of the insertion line.</value>
		[Category("Appearance")]
		[DefaultValue(typeof(Color), "Red")]
		public virtual Color InsertionLineColor {
			get { return _insertionLineColor; }
			set {
				if (this.InsertionLineColor != value) {
					_insertionLineColor = value;

					this.OnInsertionLineColorChanged(EventArgs.Empty);
				}
			}
		}

		/// <summary>
		/// Gets or sets the selected <see cref="ListViewItem"/>.
		/// </summary>
		/// <value>The selected <see cref="ListViewItem"/>.</value>
		[Browsable(false)]
		[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
		public ListViewItem SelectedItem {
			get { return this.SelectedItems.Count != 0 ? this.SelectedItems[0] : null; }
			set {
				this.SelectedItems.Clear();
				if (value != null) {
					value.Selected = true;
				}
				this.FocusedItem = value;
			}
		}

		#endregion

		#region Protected Properties

		protected int InsertionIndex { get; set; }

		protected InsertionMode InsertionMode { get; set; }

		protected bool IsRowDragInProgress { get; set; }

		#endregion

		#region Protected Members

		/// <summary>
		/// Raises the <see cref="AllowItemDragChanged" /> event.
		/// </summary>
		/// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
		protected virtual void OnAllowItemDragChanged(EventArgs e) {
			EventHandler handler;

			handler = this.AllowItemDragChanged;

			if (handler != null) {
				handler(this, e);
			}
		}

		/// <summary>
		/// Raises the <see cref="InsertionLineColorChanged" /> event.
		/// </summary>
		/// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
		protected virtual void OnInsertionLineColorChanged(EventArgs e) {
			EventHandler handler;

			handler = this.InsertionLineColorChanged;

			if (handler != null) {
				handler(this, e);
			}
		}

		/// <summary>
		/// Raises the <see cref="ItemDragDrop" /> event.
		/// </summary>
		/// <param name="e">The <see cref="ListViewItemDragEventArgs" /> instance containing the event data.</param>
		protected virtual void OnItemDragDrop(ListViewItemDragEventArgs e) {
			EventHandler<ListViewItemDragEventArgs> handler;

			handler = this.ItemDragDrop;

			if (handler != null) {
				handler(this, e);
			}
		}

		protected virtual void OnItemDragDrop2(ListViewItemDragEventArgs e) {
			EventHandler<ListViewItemDragEventArgs> handler;

			handler = this.ItemDragDrop2;

			if (handler != null) {
				handler(this, e);
			}
		}
		/// <summary>
		/// Raises the <see cref="ItemDragging" /> event.
		/// </summary>
		/// <param name="e">The <see cref="CancelListViewItemDragEventArgs" /> instance containing the event data.</param>
		protected virtual void OnItemDragging(CancelListViewItemDragEventArgs e) {
			EventHandler<CancelListViewItemDragEventArgs> handler;

			handler = this.ItemDragging;

			if (handler != null) {
				handler(this, e);
			}
		}

		protected virtual void OnWmPaint(ref Message m) {
			this.DrawInsertionLine();
		}

		#endregion

		#region Private Members

		private void DrawInsertionLine() {
			if (this.InsertionIndex != -1) {
				int index;

				index = this.InsertionIndex;

				if (index >= 0 && index < this.Items.Count) {
					Rectangle bounds;
					int x;
					int y;
					int width;

					bounds = this.Items[index].GetBounds(ItemBoundsPortion.Entire);
					x = 0; // aways fit the line to the client area, regardless of how the user is scrolling
					y = this.InsertionMode == InsertionMode.Before ? bounds.Top : bounds.Bottom;
					width = Math.Min(bounds.Width - bounds.Left, this.ClientSize.Width); // again, make sure the full width fits in the client area

					this.DrawInsertionLine(x, y, width);
				}
			}
		}

		private void DrawInsertionLine(int x1, int y, int width) {
			using (Graphics g = this.CreateGraphics()) {
				Point[] leftArrowHead;
				Point[] rightArrowHead;
				int arrowHeadSize;
				int x2;

				x2 = x1 + width;
				arrowHeadSize = 7;
				leftArrowHead = new[]
								{
						  new Point(x1, y - (arrowHeadSize / 2)), new Point(x1 + arrowHeadSize, y), new Point(x1, y + (arrowHeadSize / 2))
						};
				rightArrowHead = new[]
								 {
						   new Point(x2, y - (arrowHeadSize / 2)), new Point(x2 - arrowHeadSize, y), new Point(x2, y + (arrowHeadSize / 2))
						 };

				using (Pen pen = new Pen(this.InsertionLineColor)) {
					g.DrawLine(pen, x1, y, x2 - 1, y);
				}

				using (Brush brush = new SolidBrush(this.InsertionLineColor)) {
					g.FillPolygon(brush, leftArrowHead);
					g.FillPolygon(brush, rightArrowHead);
				}
			}
		}

		#endregion
	}

	/// <summary>
	/// Determines the insertion mode of a drag operation
	/// </summary>
	public enum InsertionMode {
		/// <summary>
		/// The source item will be inserted before the destination item
		/// </summary>
		Before,

		/// <summary>
		/// The source item will be inserted after the destination item
		/// </summary>
		After
	}

	public class CancelListViewItemDragEventArgs : CancelEventArgs {
		#region Public Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="CancelListViewItemDragEventArgs"/> class.
		/// </summary>
		/// <param name="item">The source <see cref="ListViewItem"/> the event data relates to.</param>
		public CancelListViewItemDragEventArgs(ListViewItem item) {
			this.Item = item;
		}

		#endregion

		#region Protected Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="CancelListViewItemDragEventArgs"/> class.
		/// </summary>
		protected CancelListViewItemDragEventArgs() { }

		#endregion

		#region Public Properties

		/// <summary>
		/// Gets the <see cref="ListViewItem"/> that is the source of the drag operation.
		/// </summary>
		/// <value>The <see cref="ListViewItem"/> that initiated the drag operation.</value>
		public ListViewItem Item { get; protected set; }

		#endregion
	}

	public class ListViewItemDragEventArgs : CancelListViewItemDragEventArgs {
		#region Public Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="ListViewItemDragEventArgs"/> class.
		/// </summary>
		/// <param name="sourceItem">The <see cref="ListViewItem"/> that initiated the drag operation.</param>
		/// <param name="dropItem">The <see cref="ListViewItem"/> located at the mouse coordinates.</param>
		/// <param name="insertionIndex">The index of the the <see cref="ListViewItem"/> that is the target of the drag operation.</param>
		/// <param name="insertionMode">The relation of the <see cref="InsertionIndex"/>.</param>
		/// <param name="x">The x-coordinate of a mouse click, in pixels.</param>
		/// <param name="y">The y-coordinate of a mouse click, in pixels.</param>
		public ListViewItemDragEventArgs(ListViewItem sourceItem, ListViewItem dropItem, int insertionIndex, InsertionMode insertionMode, int x, int y)
		  : this() {
			this.Item = sourceItem;
			this.DropItem = dropItem;
			this.X = x;
			this.Y = y;
			this.InsertionIndex = insertionIndex;
			this.InsertionMode = insertionMode;
		}

		#endregion

		#region Protected Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="ListViewItemDragEventArgs"/> class.
		/// </summary>
		protected ListViewItemDragEventArgs() { }

		#endregion

		#region Public Properties

		/// <summary>
		/// Gets the <see cref="ListViewItem"/> located at the <see cref="X"/> and <see cref="Y"/> coordinates.
		/// </summary>
		/// <value>The <see cref="ListViewItem"/> located at the mouse coordinates.</value>
		public ListViewItem DropItem { get; protected set; }

		/// <summary>
		/// Gets the insertion index of the drag operation.
		/// </summary>
		/// <value>The index of the the <see cref="System.Windows.Forms.ListViewItem"/> that is the target of the drag operation.</value>
		public int InsertionIndex { get; protected set; }

		/// <summary>
		/// Gets the relation of the <see cref="InsertionIndex"/>
		/// </summary>
		/// <value>The relation of the <see cref="InsertionIndex"/>.</value>
		public InsertionMode InsertionMode { get; protected set; }

		/// <summary>
		/// Gets the x-coordinate of the mouse during the generating event.
		/// </summary>
		/// <value>The x-coordinate of the mouse, in pixels.</value>
		public int X { get; protected set; }

		/// <summary>
		/// Gets the y-coordinate of the mouse during the generating event.
		/// </summary>
		/// <value>The y-coordinate of the mouse, in pixels.</value>
		public int Y { get; protected set; }

		#endregion
	}
}
