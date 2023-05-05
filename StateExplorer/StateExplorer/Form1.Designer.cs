namespace StateExplorer {
	partial class MainWindow {
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
			this.LoadBar = new System.Windows.Forms.StatusStrip();
			this.ProgressBar = new System.Windows.Forms.ToolStripProgressBar();
			this.menuStrip1 = new System.Windows.Forms.MenuStrip();
			this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.openToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.saveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.quitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.tabControl1 = new System.Windows.Forms.TabControl();
			this.tbGame = new System.Windows.Forms.TabPage();
			this.splitContainer2 = new System.Windows.Forms.SplitContainer();
			this.checkBox7 = new System.Windows.Forms.CheckBox();
			this.label1 = new System.Windows.Forms.Label();
			this.checkBox2 = new System.Windows.Forms.CheckBox();
			this.checkBox6 = new System.Windows.Forms.CheckBox();
			this.checkBox3 = new System.Windows.Forms.CheckBox();
			this.comboBox1 = new System.Windows.Forms.ComboBox();
			this.checkBox1 = new System.Windows.Forms.CheckBox();
			this.label3 = new System.Windows.Forms.Label();
			this.checkBox4 = new System.Windows.Forms.CheckBox();
			this.label2 = new System.Windows.Forms.Label();
			this.checkBox5 = new System.Windows.Forms.CheckBox();
			this.glGame = new StateExplorer.GameView();
			this.tbPlanes = new System.Windows.Forms.TabPage();
			this.splitContainer3 = new System.Windows.Forms.SplitContainer();
			this.label5 = new System.Windows.Forms.Label();
			this.checkBox14 = new System.Windows.Forms.CheckBox();
			this.checkBox10 = new System.Windows.Forms.CheckBox();
			this.checkBox13 = new System.Windows.Forms.CheckBox();
			this.checkBox9 = new System.Windows.Forms.CheckBox();
			this.checkBox8 = new System.Windows.Forms.CheckBox();
			this.checkBox11 = new System.Windows.Forms.CheckBox();
			this.checkBox12 = new System.Windows.Forms.CheckBox();
			this.label4 = new System.Windows.Forms.Label();
			this.splitContainer1 = new System.Windows.Forms.SplitContainer();
			this.tabControl2 = new System.Windows.Forms.TabControl();
			this.tbScroll = new System.Windows.Forms.TabPage();
			this.tbCram = new System.Windows.Forms.TabPage();
			this.tbSprite = new System.Windows.Forms.TabPage();
			this.tbReg = new System.Windows.Forms.TabPage();
			this.tbVram = new System.Windows.Forms.TabPage();
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.LoadBar.SuspendLayout();
			this.menuStrip1.SuspendLayout();
			this.tabControl1.SuspendLayout();
			this.tbGame.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
			this.splitContainer2.Panel1.SuspendLayout();
			this.splitContainer2.Panel2.SuspendLayout();
			this.splitContainer2.SuspendLayout();
			this.tbPlanes.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).BeginInit();
			this.splitContainer3.Panel1.SuspendLayout();
			this.splitContainer3.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
			this.splitContainer1.Panel1.SuspendLayout();
			this.splitContainer1.Panel2.SuspendLayout();
			this.splitContainer1.SuspendLayout();
			this.tabControl2.SuspendLayout();
			this.SuspendLayout();
			// 
			// LoadBar
			// 
			this.LoadBar.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ProgressBar});
			this.LoadBar.Location = new System.Drawing.Point(0, 589);
			this.LoadBar.Name = "LoadBar";
			this.LoadBar.Padding = new System.Windows.Forms.Padding(1, 0, 12, 0);
			this.LoadBar.Size = new System.Drawing.Size(990, 22);
			this.LoadBar.TabIndex = 0;
			// 
			// ProgressBar
			// 
			this.ProgressBar.Name = "ProgressBar";
			this.ProgressBar.Size = new System.Drawing.Size(86, 16);
			this.ProgressBar.ToolTipText = "Loading...";
			// 
			// menuStrip1
			// 
			this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem});
			this.menuStrip1.Location = new System.Drawing.Point(0, 0);
			this.menuStrip1.Name = "menuStrip1";
			this.menuStrip1.Size = new System.Drawing.Size(990, 24);
			this.menuStrip1.TabIndex = 1;
			this.menuStrip1.Text = "menuStrip1";
			// 
			// fileToolStripMenuItem
			// 
			this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.openToolStripMenuItem,
            this.saveToolStripMenuItem,
            this.quitToolStripMenuItem});
			this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
			this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
			this.fileToolStripMenuItem.Text = "File";
			// 
			// openToolStripMenuItem
			// 
			this.openToolStripMenuItem.BackColor = System.Drawing.SystemColors.Control;
			this.openToolStripMenuItem.Name = "openToolStripMenuItem";
			this.openToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
			this.openToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
			this.openToolStripMenuItem.Text = "Open";
			this.openToolStripMenuItem.Click += new System.EventHandler(this.openToolStripMenuItem_Click);
			// 
			// saveToolStripMenuItem
			// 
			this.saveToolStripMenuItem.BackColor = System.Drawing.SystemColors.Control;
			this.saveToolStripMenuItem.Name = "saveToolStripMenuItem";
			this.saveToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.S)));
			this.saveToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
			this.saveToolStripMenuItem.Text = "Save";
			// 
			// quitToolStripMenuItem
			// 
			this.quitToolStripMenuItem.BackColor = System.Drawing.SystemColors.Control;
			this.quitToolStripMenuItem.Name = "quitToolStripMenuItem";
			this.quitToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
			this.quitToolStripMenuItem.Text = "Quit";
			// 
			// tabControl1
			// 
			this.tabControl1.Controls.Add(this.tbGame);
			this.tabControl1.Controls.Add(this.tbPlanes);
			this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.tabControl1.Location = new System.Drawing.Point(0, 0);
			this.tabControl1.Multiline = true;
			this.tabControl1.Name = "tabControl1";
			this.tabControl1.SelectedIndex = 0;
			this.tabControl1.Size = new System.Drawing.Size(741, 565);
			this.tabControl1.TabIndex = 2;
			// 
			// tbGame
			// 
			this.tbGame.Controls.Add(this.splitContainer2);
			this.tbGame.Location = new System.Drawing.Point(4, 22);
			this.tbGame.Name = "tbGame";
			this.tbGame.Padding = new System.Windows.Forms.Padding(3);
			this.tbGame.Size = new System.Drawing.Size(733, 539);
			this.tbGame.TabIndex = 0;
			this.tbGame.Text = "Game Screen";
			this.tbGame.UseVisualStyleBackColor = true;
			// 
			// splitContainer2
			// 
			this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer2.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
			this.splitContainer2.IsSplitterFixed = true;
			this.splitContainer2.Location = new System.Drawing.Point(3, 3);
			this.splitContainer2.Name = "splitContainer2";
			// 
			// splitContainer2.Panel1
			// 
			this.splitContainer2.Panel1.Controls.Add(this.checkBox7);
			this.splitContainer2.Panel1.Controls.Add(this.label1);
			this.splitContainer2.Panel1.Controls.Add(this.checkBox2);
			this.splitContainer2.Panel1.Controls.Add(this.checkBox6);
			this.splitContainer2.Panel1.Controls.Add(this.checkBox3);
			this.splitContainer2.Panel1.Controls.Add(this.comboBox1);
			this.splitContainer2.Panel1.Controls.Add(this.checkBox1);
			this.splitContainer2.Panel1.Controls.Add(this.label3);
			this.splitContainer2.Panel1.Controls.Add(this.checkBox4);
			this.splitContainer2.Panel1.Controls.Add(this.label2);
			this.splitContainer2.Panel1.Controls.Add(this.checkBox5);
			// 
			// splitContainer2.Panel2
			// 
			this.splitContainer2.Panel2.Controls.Add(this.glGame);
			this.splitContainer2.Size = new System.Drawing.Size(727, 533);
			this.splitContainer2.SplitterDistance = 84;
			this.splitContainer2.SplitterWidth = 1;
			this.splitContainer2.TabIndex = 0;
			// 
			// checkBox7
			// 
			this.checkBox7.AutoSize = true;
			this.checkBox7.Location = new System.Drawing.Point(3, 217);
			this.checkBox7.Name = "checkBox7";
			this.checkBox7.Size = new System.Drawing.Size(74, 17);
			this.checkBox7.TabIndex = 10;
			this.checkBox7.Text = "No Border";
			this.checkBox7.TextAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox7.UseVisualStyleBackColor = true;
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(0, 0);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(71, 13);
			this.label1.TabIndex = 0;
			this.label1.Text = "Display Mode";
			// 
			// checkBox2
			// 
			this.checkBox2.AutoSize = true;
			this.checkBox2.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox2.Location = new System.Drawing.Point(3, 84);
			this.checkBox2.Name = "checkBox2";
			this.checkBox2.Size = new System.Drawing.Size(63, 17);
			this.checkBox2.TabIndex = 4;
			this.checkBox2.Text = "Plane B";
			this.checkBox2.UseVisualStyleBackColor = true;
			// 
			// checkBox6
			// 
			this.checkBox6.AutoSize = true;
			this.checkBox6.Location = new System.Drawing.Point(3, 194);
			this.checkBox6.Name = "checkBox6";
			this.checkBox6.Size = new System.Drawing.Size(69, 17);
			this.checkBox6.TabIndex = 9;
			this.checkBox6.Text = "No Scroll";
			this.checkBox6.TextAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox6.UseVisualStyleBackColor = true;
			// 
			// checkBox3
			// 
			this.checkBox3.AutoSize = true;
			this.checkBox3.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox3.Location = new System.Drawing.Point(3, 107);
			this.checkBox3.Name = "checkBox3";
			this.checkBox3.Size = new System.Drawing.Size(63, 17);
			this.checkBox3.TabIndex = 5;
			this.checkBox3.Text = "Plane A";
			this.checkBox3.UseVisualStyleBackColor = true;
			// 
			// comboBox1
			// 
			this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.comboBox1.FormattingEnabled = true;
			this.comboBox1.Items.AddRange(new object[] {
            "NTSC hardware",
            "PAL hardware",
            "NTSC emulator",
            "PAL emulator"});
			this.comboBox1.Location = new System.Drawing.Point(3, 16);
			this.comboBox1.Name = "comboBox1";
			this.comboBox1.Size = new System.Drawing.Size(80, 21);
			this.comboBox1.TabIndex = 1;
			// 
			// checkBox1
			// 
			this.checkBox1.AutoSize = true;
			this.checkBox1.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox1.Location = new System.Drawing.Point(3, 61);
			this.checkBox1.Name = "checkBox1";
			this.checkBox1.Size = new System.Drawing.Size(72, 17);
			this.checkBox1.TabIndex = 3;
			this.checkBox1.Text = "Backdrop";
			this.checkBox1.UseVisualStyleBackColor = true;
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(3, 177);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(36, 13);
			this.label3.TabIndex = 8;
			this.label3.Text = "Extras";
			// 
			// checkBox4
			// 
			this.checkBox4.AutoSize = true;
			this.checkBox4.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox4.Location = new System.Drawing.Point(3, 130);
			this.checkBox4.Name = "checkBox4";
			this.checkBox4.Size = new System.Drawing.Size(58, 17);
			this.checkBox4.TabIndex = 6;
			this.checkBox4.Text = "Sprites";
			this.checkBox4.UseVisualStyleBackColor = true;
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(3, 44);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(76, 13);
			this.label2.TabIndex = 2;
			this.label2.Text = "Plane Selector";
			// 
			// checkBox5
			// 
			this.checkBox5.AutoSize = true;
			this.checkBox5.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox5.Location = new System.Drawing.Point(3, 153);
			this.checkBox5.Name = "checkBox5";
			this.checkBox5.Size = new System.Drawing.Size(65, 17);
			this.checkBox5.TabIndex = 7;
			this.checkBox5.Text = "Window";
			this.checkBox5.UseVisualStyleBackColor = true;
			// 
			// glGame
			// 
			this.glGame.BackColor = System.Drawing.Color.Black;
			this.glGame.Dock = System.Windows.Forms.DockStyle.Fill;
			this.glGame.Location = new System.Drawing.Point(0, 0);
			this.glGame.Name = "glGame";
			this.glGame.Size = new System.Drawing.Size(642, 533);
			this.glGame.TabIndex = 0;
			this.glGame.TabStop = false;
			this.glGame.VSync = false;
			// 
			// tbPlanes
			// 
			this.tbPlanes.Controls.Add(this.splitContainer3);
			this.tbPlanes.Location = new System.Drawing.Point(4, 22);
			this.tbPlanes.Name = "tbPlanes";
			this.tbPlanes.Padding = new System.Windows.Forms.Padding(3);
			this.tbPlanes.Size = new System.Drawing.Size(733, 539);
			this.tbPlanes.TabIndex = 1;
			this.tbPlanes.Text = "Plane View";
			this.tbPlanes.UseVisualStyleBackColor = true;
			// 
			// splitContainer3
			// 
			this.splitContainer3.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer3.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
			this.splitContainer3.IsSplitterFixed = true;
			this.splitContainer3.Location = new System.Drawing.Point(3, 3);
			this.splitContainer3.Name = "splitContainer3";
			// 
			// splitContainer3.Panel1
			// 
			this.splitContainer3.Panel1.Controls.Add(this.label5);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox14);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox10);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox13);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox9);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox8);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox11);
			this.splitContainer3.Panel1.Controls.Add(this.checkBox12);
			this.splitContainer3.Panel1.Controls.Add(this.label4);
			this.splitContainer3.Size = new System.Drawing.Size(727, 533);
			this.splitContainer3.SplitterDistance = 90;
			this.splitContainer3.SplitterWidth = 1;
			this.splitContainer3.TabIndex = 21;
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Location = new System.Drawing.Point(3, 0);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(76, 13);
			this.label5.TabIndex = 12;
			this.label5.Text = "Plane Selector";
			// 
			// checkBox14
			// 
			this.checkBox14.AutoSize = true;
			this.checkBox14.Location = new System.Drawing.Point(3, 173);
			this.checkBox14.Name = "checkBox14";
			this.checkBox14.Size = new System.Drawing.Size(86, 17);
			this.checkBox14.TabIndex = 20;
			this.checkBox14.Text = "Screen View";
			this.checkBox14.TextAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox14.UseVisualStyleBackColor = true;
			// 
			// checkBox10
			// 
			this.checkBox10.AutoSize = true;
			this.checkBox10.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox10.Location = new System.Drawing.Point(3, 86);
			this.checkBox10.Name = "checkBox10";
			this.checkBox10.Size = new System.Drawing.Size(58, 17);
			this.checkBox10.TabIndex = 16;
			this.checkBox10.Text = "Sprites";
			this.checkBox10.UseVisualStyleBackColor = true;
			// 
			// checkBox13
			// 
			this.checkBox13.AutoSize = true;
			this.checkBox13.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox13.Location = new System.Drawing.Point(3, 17);
			this.checkBox13.Name = "checkBox13";
			this.checkBox13.Size = new System.Drawing.Size(72, 17);
			this.checkBox13.TabIndex = 13;
			this.checkBox13.Text = "Backdrop";
			this.checkBox13.UseVisualStyleBackColor = true;
			// 
			// checkBox9
			// 
			this.checkBox9.AutoSize = true;
			this.checkBox9.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox9.Location = new System.Drawing.Point(3, 109);
			this.checkBox9.Name = "checkBox9";
			this.checkBox9.Size = new System.Drawing.Size(65, 17);
			this.checkBox9.TabIndex = 17;
			this.checkBox9.Text = "Window";
			this.checkBox9.UseVisualStyleBackColor = true;
			// 
			// checkBox8
			// 
			this.checkBox8.AutoSize = true;
			this.checkBox8.Location = new System.Drawing.Point(3, 150);
			this.checkBox8.Name = "checkBox8";
			this.checkBox8.Size = new System.Drawing.Size(69, 17);
			this.checkBox8.TabIndex = 19;
			this.checkBox8.Text = "No Scroll";
			this.checkBox8.TextAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox8.UseVisualStyleBackColor = true;
			// 
			// checkBox11
			// 
			this.checkBox11.AutoSize = true;
			this.checkBox11.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox11.Location = new System.Drawing.Point(3, 63);
			this.checkBox11.Name = "checkBox11";
			this.checkBox11.Size = new System.Drawing.Size(63, 17);
			this.checkBox11.TabIndex = 15;
			this.checkBox11.Text = "Plane A";
			this.checkBox11.UseVisualStyleBackColor = true;
			// 
			// checkBox12
			// 
			this.checkBox12.AutoSize = true;
			this.checkBox12.CheckAlign = System.Drawing.ContentAlignment.TopLeft;
			this.checkBox12.Location = new System.Drawing.Point(3, 40);
			this.checkBox12.Name = "checkBox12";
			this.checkBox12.Size = new System.Drawing.Size(63, 17);
			this.checkBox12.TabIndex = 14;
			this.checkBox12.Text = "Plane B";
			this.checkBox12.UseVisualStyleBackColor = true;
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(3, 133);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(36, 13);
			this.label4.TabIndex = 18;
			this.label4.Text = "Extras";
			// 
			// splitContainer1
			// 
			this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer1.Location = new System.Drawing.Point(0, 24);
			this.splitContainer1.Name = "splitContainer1";
			// 
			// splitContainer1.Panel1
			// 
			this.splitContainer1.Panel1.Controls.Add(this.tabControl1);
			// 
			// splitContainer1.Panel2
			// 
			this.splitContainer1.Panel2.Controls.Add(this.tabControl2);
			this.splitContainer1.Size = new System.Drawing.Size(990, 565);
			this.splitContainer1.SplitterDistance = 741;
			this.splitContainer1.TabIndex = 3;
			// 
			// tabControl2
			// 
			this.tabControl2.Controls.Add(this.tbScroll);
			this.tabControl2.Controls.Add(this.tbCram);
			this.tabControl2.Controls.Add(this.tbSprite);
			this.tabControl2.Controls.Add(this.tbReg);
			this.tabControl2.Controls.Add(this.tbVram);
			this.tabControl2.Dock = System.Windows.Forms.DockStyle.Fill;
			this.tabControl2.Location = new System.Drawing.Point(0, 0);
			this.tabControl2.Name = "tabControl2";
			this.tabControl2.SelectedIndex = 0;
			this.tabControl2.Size = new System.Drawing.Size(245, 565);
			this.tabControl2.TabIndex = 0;
			// 
			// tbScroll
			// 
			this.tbScroll.Location = new System.Drawing.Point(4, 22);
			this.tbScroll.Name = "tbScroll";
			this.tbScroll.Padding = new System.Windows.Forms.Padding(3);
			this.tbScroll.Size = new System.Drawing.Size(237, 539);
			this.tbScroll.TabIndex = 0;
			this.tbScroll.Text = "Scroll";
			this.tbScroll.UseVisualStyleBackColor = true;
			// 
			// tbCram
			// 
			this.tbCram.Location = new System.Drawing.Point(4, 22);
			this.tbCram.Name = "tbCram";
			this.tbCram.Padding = new System.Windows.Forms.Padding(3);
			this.tbCram.Size = new System.Drawing.Size(237, 539);
			this.tbCram.TabIndex = 1;
			this.tbCram.Text = "Palettes";
			this.tbCram.UseVisualStyleBackColor = true;
			// 
			// tbSprite
			// 
			this.tbSprite.Location = new System.Drawing.Point(4, 22);
			this.tbSprite.Name = "tbSprite";
			this.tbSprite.Size = new System.Drawing.Size(237, 539);
			this.tbSprite.TabIndex = 4;
			this.tbSprite.Text = "Sprites";
			this.tbSprite.UseVisualStyleBackColor = true;
			// 
			// tbReg
			// 
			this.tbReg.Location = new System.Drawing.Point(4, 22);
			this.tbReg.Name = "tbReg";
			this.tbReg.Size = new System.Drawing.Size(237, 539);
			this.tbReg.TabIndex = 2;
			this.tbReg.Text = "Registers";
			this.tbReg.UseVisualStyleBackColor = true;
			// 
			// tbVram
			// 
			this.tbVram.Location = new System.Drawing.Point(4, 22);
			this.tbVram.Name = "tbVram";
			this.tbVram.Size = new System.Drawing.Size(237, 539);
			this.tbVram.TabIndex = 3;
			this.tbVram.Text = "VRAM";
			this.tbVram.UseVisualStyleBackColor = true;
			// 
			// openFileDialog1
			// 
			this.openFileDialog1.FileName = "openFileDialog1";
			// 
			// MainWindow
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.SystemColors.Control;
			this.ClientSize = new System.Drawing.Size(990, 611);
			this.Controls.Add(this.splitContainer1);
			this.Controls.Add(this.LoadBar);
			this.Controls.Add(this.menuStrip1);
			this.DoubleBuffered = true;
			this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.MinimumSize = new System.Drawing.Size(150, 400);
			this.Name = "MainWindow";
			this.Text = "State Explorer";
			this.LoadBar.ResumeLayout(false);
			this.LoadBar.PerformLayout();
			this.menuStrip1.ResumeLayout(false);
			this.menuStrip1.PerformLayout();
			this.tabControl1.ResumeLayout(false);
			this.tbGame.ResumeLayout(false);
			this.splitContainer2.Panel1.ResumeLayout(false);
			this.splitContainer2.Panel1.PerformLayout();
			this.splitContainer2.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
			this.splitContainer2.ResumeLayout(false);
			this.tbPlanes.ResumeLayout(false);
			this.splitContainer3.Panel1.ResumeLayout(false);
			this.splitContainer3.Panel1.PerformLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).EndInit();
			this.splitContainer3.ResumeLayout(false);
			this.splitContainer1.Panel1.ResumeLayout(false);
			this.splitContainer1.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
			this.splitContainer1.ResumeLayout(false);
			this.tabControl2.ResumeLayout(false);
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion
		private System.Windows.Forms.MenuStrip menuStrip1;
		private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem openToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem saveToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem quitToolStripMenuItem;
		private System.Windows.Forms.TabControl tabControl1;
		private System.Windows.Forms.TabPage tbGame;
		private System.Windows.Forms.TabPage tbPlanes;
		private System.Windows.Forms.SplitContainer splitContainer1;
		private System.Windows.Forms.TabControl tabControl2;
		private System.Windows.Forms.TabPage tbScroll;
		private System.Windows.Forms.TabPage tbCram;
		private System.Windows.Forms.TabPage tbSprite;
		private System.Windows.Forms.TabPage tbReg;
		private System.Windows.Forms.TabPage tbVram;
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.CheckBox checkBox7;
		private System.Windows.Forms.CheckBox checkBox6;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.CheckBox checkBox5;
		private System.Windows.Forms.CheckBox checkBox4;
		private System.Windows.Forms.CheckBox checkBox3;
		private System.Windows.Forms.CheckBox checkBox2;
		private System.Windows.Forms.CheckBox checkBox1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.CheckBox checkBox14;
		private System.Windows.Forms.CheckBox checkBox8;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.CheckBox checkBox9;
		private System.Windows.Forms.CheckBox checkBox10;
		private System.Windows.Forms.CheckBox checkBox11;
		private System.Windows.Forms.CheckBox checkBox12;
		private System.Windows.Forms.CheckBox checkBox13;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.SplitContainer splitContainer2;
		private System.Windows.Forms.SplitContainer splitContainer3;
		private GameView glGame;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;
		public System.Windows.Forms.ToolStripProgressBar ProgressBar;
		private System.Windows.Forms.StatusStrip LoadBar;
	}
}

