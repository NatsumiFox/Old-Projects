namespace MainMenuCardMaker {
	partial class Form1 {
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing) {
			if (disposing && (components != null)) {
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {
			this.menuStrip1 = new System.Windows.Forms.MenuStrip();
			this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.openToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.saveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.CheckFileUpdate = new System.IO.FileSystemWatcher();
			this.tabPage4 = new System.Windows.Forms.TabPage();
			this.tabPage3 = new System.Windows.Forms.TabPage();
			this.statusStrip1 = new System.Windows.Forms.StatusStrip();
			this.tileNumber = new System.Windows.Forms.ToolStripStatusLabel();
			this.loadTime = new System.Windows.Forms.ToolStripStatusLabel();
			this.loadedTime = new System.Windows.Forms.ToolStripStatusLabel();
			this.convertControl1 = new MainMenuCardMaker.Controls.ConvertControl();
			this.tabPage1 = new System.Windows.Forms.TabPage();
			this.splitContainer1 = new System.Windows.Forms.SplitContainer();
			this.importPaletteControl = new MainMenuCardMaker.Controls.ImportPaletteControl();
			this.importImagesControl1 = new MainMenuCardMaker.Controls.ImportImagesControl();
			this.tabControl1 = new System.Windows.Forms.TabControl();
			this.menuStrip1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.CheckFileUpdate)).BeginInit();
			this.tabPage3.SuspendLayout();
			this.statusStrip1.SuspendLayout();
			this.tabPage1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
			this.splitContainer1.Panel1.SuspendLayout();
			this.splitContainer1.Panel2.SuspendLayout();
			this.splitContainer1.SuspendLayout();
			this.tabControl1.SuspendLayout();
			this.SuspendLayout();
			// 
			// menuStrip1
			// 
			this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
			this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem});
			this.menuStrip1.Location = new System.Drawing.Point(0, 0);
			this.menuStrip1.Name = "menuStrip1";
			this.menuStrip1.Size = new System.Drawing.Size(912, 28);
			this.menuStrip1.TabIndex = 0;
			this.menuStrip1.Text = "menuStrip1";
			// 
			// fileToolStripMenuItem
			// 
			this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.openToolStripMenuItem,
            this.saveToolStripMenuItem,
            this.exitToolStripMenuItem});
			this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
			this.fileToolStripMenuItem.Size = new System.Drawing.Size(46, 24);
			this.fileToolStripMenuItem.Text = "File";
			// 
			// openToolStripMenuItem
			// 
			this.openToolStripMenuItem.Name = "openToolStripMenuItem";
			this.openToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
			this.openToolStripMenuItem.Size = new System.Drawing.Size(181, 26);
			this.openToolStripMenuItem.Text = "&Open";
			this.openToolStripMenuItem.Click += new System.EventHandler(this.openToolStripMenuItem_Click);
			// 
			// saveToolStripMenuItem
			// 
			this.saveToolStripMenuItem.Name = "saveToolStripMenuItem";
			this.saveToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.S)));
			this.saveToolStripMenuItem.Size = new System.Drawing.Size(181, 26);
			this.saveToolStripMenuItem.Text = "&Save";
			this.saveToolStripMenuItem.Click += new System.EventHandler(this.saveToolStripMenuItem_Click);
			// 
			// exitToolStripMenuItem
			// 
			this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
			this.exitToolStripMenuItem.Size = new System.Drawing.Size(181, 26);
			this.exitToolStripMenuItem.Text = "Exit";
			this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
			// 
			// CheckFileUpdate
			// 
			this.CheckFileUpdate.EnableRaisingEvents = true;
			this.CheckFileUpdate.NotifyFilter = System.IO.NotifyFilters.LastWrite;
			this.CheckFileUpdate.SynchronizingObject = this;
			// 
			// tabPage4
			// 
			this.tabPage4.Location = new System.Drawing.Point(4, 25);
			this.tabPage4.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.tabPage4.Name = "tabPage4";
			this.tabPage4.Size = new System.Drawing.Size(904, 651);
			this.tabPage4.TabIndex = 3;
			this.tabPage4.Text = "Scroll Editor";
			this.tabPage4.UseVisualStyleBackColor = true;
			// 
			// tabPage3
			// 
			this.tabPage3.Controls.Add(this.statusStrip1);
			this.tabPage3.Controls.Add(this.convertControl1);
			this.tabPage3.Location = new System.Drawing.Point(4, 25);
			this.tabPage3.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.tabPage3.Name = "tabPage3";
			this.tabPage3.Size = new System.Drawing.Size(904, 651);
			this.tabPage3.TabIndex = 2;
			this.tabPage3.Text = "Converter";
			this.tabPage3.UseVisualStyleBackColor = true;
			// 
			// statusStrip1
			// 
			this.statusStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
			this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tileNumber,
            this.loadTime,
            this.loadedTime});
			this.statusStrip1.Location = new System.Drawing.Point(0, 625);
			this.statusStrip1.Name = "statusStrip1";
			this.statusStrip1.Padding = new System.Windows.Forms.Padding(1, 0, 19, 0);
			this.statusStrip1.Size = new System.Drawing.Size(904, 26);
			this.statusStrip1.TabIndex = 1;
			this.statusStrip1.Text = "statusStrip1";
			// 
			// tileNumber
			// 
			this.tileNumber.Name = "tileNumber";
			this.tileNumber.Size = new System.Drawing.Size(0, 20);
			// 
			// loadTime
			// 
			this.loadTime.Name = "loadTime";
			this.loadTime.Size = new System.Drawing.Size(100, 20);
			this.loadTime.Text = "Convert Time:";
			// 
			// loadedTime
			// 
			this.loadedTime.Name = "loadedTime";
			this.loadedTime.Size = new System.Drawing.Size(82, 20);
			this.loadedTime.Text = "Load Time:";
			// 
			// convertControl1
			// 
			this.convertControl1.BackColor = System.Drawing.Color.Black;
			this.convertControl1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.convertControl1.Location = new System.Drawing.Point(0, 0);
			this.convertControl1.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
			this.convertControl1.Name = "convertControl1";
			this.convertControl1.Size = new System.Drawing.Size(904, 651);
			this.convertControl1.TabIndex = 0;
			this.convertControl1.ViewportH = 512;
			this.convertControl1.ViewportW = 512;
			this.convertControl1.VSync = false;
			this.convertControl1.ZoomMax = 0.25D;
			this.convertControl1.ZoomMin = 32D;
			// 
			// tabPage1
			// 
			this.tabPage1.Controls.Add(this.splitContainer1);
			this.tabPage1.Location = new System.Drawing.Point(4, 25);
			this.tabPage1.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.tabPage1.Name = "tabPage1";
			this.tabPage1.Padding = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.tabPage1.Size = new System.Drawing.Size(904, 651);
			this.tabPage1.TabIndex = 0;
			this.tabPage1.Text = "Palette Converter";
			this.tabPage1.UseVisualStyleBackColor = true;
			// 
			// splitContainer1
			// 
			this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer1.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
			this.splitContainer1.Location = new System.Drawing.Point(4, 4);
			this.splitContainer1.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.splitContainer1.Name = "splitContainer1";
			// 
			// splitContainer1.Panel1
			// 
			this.splitContainer1.Panel1.Controls.Add(this.importPaletteControl);
			// 
			// splitContainer1.Panel2
			// 
			this.splitContainer1.Panel2.Controls.Add(this.importImagesControl1);
			this.splitContainer1.Size = new System.Drawing.Size(896, 643);
			this.splitContainer1.SplitterDistance = 150;
			this.splitContainer1.SplitterWidth = 5;
			this.splitContainer1.TabIndex = 0;
			// 
			// importPaletteControl
			// 
			this.importPaletteControl.BackColor = System.Drawing.Color.Black;
			this.importPaletteControl.Dock = System.Windows.Forms.DockStyle.Fill;
			this.importPaletteControl.Location = new System.Drawing.Point(0, 0);
			this.importPaletteControl.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
			this.importPaletteControl.Name = "importPaletteControl";
			this.importPaletteControl.Size = new System.Drawing.Size(150, 643);
			this.importPaletteControl.TabIndex = 1;
			this.importPaletteControl.ViewportH = 0;
			this.importPaletteControl.ViewportW = 0;
			this.importPaletteControl.VSync = false;
			this.importPaletteControl.ZoomMax = 1D;
			this.importPaletteControl.ZoomMin = 1D;
			// 
			// importImagesControl1
			// 
			this.importImagesControl1.BackColor = System.Drawing.Color.Black;
			this.importImagesControl1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.importImagesControl1.Location = new System.Drawing.Point(0, 0);
			this.importImagesControl1.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
			this.importImagesControl1.Name = "importImagesControl1";
			this.importImagesControl1.Size = new System.Drawing.Size(741, 643);
			this.importImagesControl1.TabIndex = 0;
			this.importImagesControl1.ViewportH = 512;
			this.importImagesControl1.ViewportW = 576;
			this.importImagesControl1.VSync = false;
			this.importImagesControl1.ZoomMax = 0.25D;
			this.importImagesControl1.ZoomMin = 32D;
			// 
			// tabControl1
			// 
			this.tabControl1.Controls.Add(this.tabPage1);
			this.tabControl1.Controls.Add(this.tabPage3);
			this.tabControl1.Controls.Add(this.tabPage4);
			this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.tabControl1.Location = new System.Drawing.Point(0, 28);
			this.tabControl1.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.tabControl1.Name = "tabControl1";
			this.tabControl1.SelectedIndex = 0;
			this.tabControl1.Size = new System.Drawing.Size(912, 680);
			this.tabControl1.TabIndex = 1;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.SystemColors.ControlLight;
			this.ClientSize = new System.Drawing.Size(912, 708);
			this.Controls.Add(this.tabControl1);
			this.Controls.Add(this.menuStrip1);
			this.Cursor = System.Windows.Forms.Cursors.Default;
			this.MainMenuStrip = this.menuStrip1;
			this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.MinimumSize = new System.Drawing.Size(327, 205);
			this.Name = "Form1";
			this.Text = "Card Maker";
			this.menuStrip1.ResumeLayout(false);
			this.menuStrip1.PerformLayout();
			((System.ComponentModel.ISupportInitialize)(this.CheckFileUpdate)).EndInit();
			this.tabPage3.ResumeLayout(false);
			this.tabPage3.PerformLayout();
			this.statusStrip1.ResumeLayout(false);
			this.statusStrip1.PerformLayout();
			this.tabPage1.ResumeLayout(false);
			this.splitContainer1.Panel1.ResumeLayout(false);
			this.splitContainer1.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
			this.splitContainer1.ResumeLayout(false);
			this.tabControl1.ResumeLayout(false);
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		internal System.Windows.Forms.MenuStrip menuStrip1;
		internal System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem openToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem saveToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
		internal System.IO.FileSystemWatcher CheckFileUpdate;
		internal System.Windows.Forms.TabControl tabControl1;
		internal System.Windows.Forms.TabPage tabPage1;
		internal System.Windows.Forms.SplitContainer splitContainer1;
		internal Controls.ImportPaletteControl importPaletteControl;
		internal Controls.ImportImagesControl importImagesControl1;
		internal System.Windows.Forms.TabPage tabPage3;
		private System.Windows.Forms.StatusStrip statusStrip1;
		internal System.Windows.Forms.ToolStripStatusLabel tileNumber;
		internal Controls.ConvertControl convertControl1;
		internal System.Windows.Forms.TabPage tabPage4;
		internal System.Windows.Forms.ToolStripStatusLabel loadTime;
		private System.Windows.Forms.ToolStripStatusLabel loadedTime;
	}
}

