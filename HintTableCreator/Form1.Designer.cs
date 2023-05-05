namespace HintTableCreator {
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
			this.md = new System.Windows.Forms.Panel();
			this.button1 = new System.Windows.Forms.Button();
			this.button2 = new System.Windows.Forms.Button();
			this.button3 = new System.Windows.Forms.Button();
			this.button4 = new System.Windows.Forms.Button();
			this.mdn = new System.Windows.Forms.Label();
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.button5 = new System.Windows.Forms.Button();
			this.button6 = new System.Windows.Forms.Button();
			this.textBox2 = new System.Windows.Forms.TextBox();
			this.clrb = new System.Windows.Forms.Button();
			this.clrr = new System.Windows.Forms.Button();
			this.button7 = new System.Windows.Forms.Button();
			this.button8 = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// md
			// 
			this.md.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
			this.md.Location = new System.Drawing.Point(0, 68);
			this.md.Name = "md";
			this.md.Size = new System.Drawing.Size(640, 448);
			this.md.TabIndex = 0;
			this.md.Paint += new System.Windows.Forms.PaintEventHandler(this.md_Paint);
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(0, 0);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(36, 64);
			this.button1.TabIndex = 1;
			this.button1.Text = "<";
			this.button1.UseVisualStyleBackColor = true;
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(110, 0);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(36, 64);
			this.button2.TabIndex = 2;
			this.button2.Text = ">";
			this.button2.UseVisualStyleBackColor = true;
			this.button2.Click += new System.EventHandler(this.button2_Click);
			// 
			// button3
			// 
			this.button3.Location = new System.Drawing.Point(36, 0);
			this.button3.Name = "button3";
			this.button3.Size = new System.Drawing.Size(32, 23);
			this.button3.TabIndex = 3;
			this.button3.Text = "ins";
			this.button3.UseVisualStyleBackColor = true;
			this.button3.Click += new System.EventHandler(this.button3_Click);
			// 
			// button4
			// 
			this.button4.Location = new System.Drawing.Point(36, 41);
			this.button4.Name = "button4";
			this.button4.Size = new System.Drawing.Size(75, 23);
			this.button4.TabIndex = 4;
			this.button4.Text = "del";
			this.button4.UseVisualStyleBackColor = true;
			this.button4.Click += new System.EventHandler(this.button4_Click);
			// 
			// mdn
			// 
			this.mdn.AutoSize = true;
			this.mdn.Location = new System.Drawing.Point(36, 26);
			this.mdn.MaximumSize = new System.Drawing.Size(75, 0);
			this.mdn.MinimumSize = new System.Drawing.Size(75, 0);
			this.mdn.Name = "mdn";
			this.mdn.Size = new System.Drawing.Size(75, 13);
			this.mdn.TabIndex = 5;
			this.mdn.Text = "0/0";
			this.mdn.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
			// 
			// textBox1
			// 
			this.textBox1.Location = new System.Drawing.Point(177, 2);
			this.textBox1.MaxLength = 5;
			this.textBox1.Name = "textBox1";
			this.textBox1.ShortcutsEnabled = false;
			this.textBox1.Size = new System.Drawing.Size(53, 20);
			this.textBox1.TabIndex = 6;
			this.textBox1.Text = "0";
			this.textBox1.WordWrap = false;
			// 
			// button5
			// 
			this.button5.Location = new System.Drawing.Point(177, 26);
			this.button5.Name = "button5";
			this.button5.Size = new System.Drawing.Size(53, 36);
			this.button5.TabIndex = 7;
			this.button5.Text = "animate";
			this.button5.UseVisualStyleBackColor = true;
			this.button5.Click += new System.EventHandler(this.button5_Click);
			// 
			// button6
			// 
			this.button6.Location = new System.Drawing.Point(230, 0);
			this.button6.Name = "button6";
			this.button6.Size = new System.Drawing.Size(53, 30);
			this.button6.TabIndex = 8;
			this.button6.Text = "convert";
			this.button6.UseVisualStyleBackColor = true;
			this.button6.Click += new System.EventHandler(this.button6_Click);
			// 
			// textBox2
			// 
			this.textBox2.Location = new System.Drawing.Point(284, 2);
			this.textBox2.Multiline = true;
			this.textBox2.Name = "textBox2";
			this.textBox2.ReadOnly = true;
			this.textBox2.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.textBox2.Size = new System.Drawing.Size(356, 62);
			this.textBox2.TabIndex = 9;
			this.textBox2.WordWrap = false;
			// 
			// clrb
			// 
			this.clrb.BackColor = System.Drawing.Color.Black;
			this.clrb.FlatAppearance.BorderSize = 0;
			this.clrb.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.clrb.ForeColor = System.Drawing.SystemColors.ControlText;
			this.clrb.Location = new System.Drawing.Point(146, 0);
			this.clrb.Name = "clrb";
			this.clrb.Size = new System.Drawing.Size(30, 30);
			this.clrb.TabIndex = 12;
			this.clrb.UseVisualStyleBackColor = false;
			this.clrb.Click += new System.EventHandler(this.clrb_Click);
			// 
			// clrr
			// 
			this.clrr.BackColor = System.Drawing.Color.DarkRed;
			this.clrr.Cursor = System.Windows.Forms.Cursors.Default;
			this.clrr.FlatAppearance.BorderSize = 0;
			this.clrr.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.clrr.Location = new System.Drawing.Point(146, 32);
			this.clrr.Name = "clrr";
			this.clrr.Size = new System.Drawing.Size(30, 30);
			this.clrr.TabIndex = 13;
			this.clrr.UseVisualStyleBackColor = false;
			this.clrr.Click += new System.EventHandler(this.clrr_Click);
			// 
			// button7
			// 
			this.button7.Location = new System.Drawing.Point(230, 32);
			this.button7.Name = "button7";
			this.button7.Size = new System.Drawing.Size(53, 30);
			this.button7.TabIndex = 14;
			this.button7.Text = "save all";
			this.button7.UseVisualStyleBackColor = true;
			this.button7.Click += new System.EventHandler(this.button7_Click);
			// 
			// button8
			// 
			this.button8.Location = new System.Drawing.Point(67, 0);
			this.button8.Name = "button8";
			this.button8.Size = new System.Drawing.Size(44, 23);
			this.button8.TabIndex = 15;
			this.button8.Text = "copy";
			this.button8.UseVisualStyleBackColor = true;
			this.button8.Click += new System.EventHandler(this.button8_Click);
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(641, 517);
			this.Controls.Add(this.button8);
			this.Controls.Add(this.button7);
			this.Controls.Add(this.clrr);
			this.Controls.Add(this.clrb);
			this.Controls.Add(this.textBox2);
			this.Controls.Add(this.button6);
			this.Controls.Add(this.button5);
			this.Controls.Add(this.textBox1);
			this.Controls.Add(this.mdn);
			this.Controls.Add(this.button4);
			this.Controls.Add(this.button3);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.md);
			this.DoubleBuffered = true;
			this.Name = "Form1";
			this.Text = "Form1";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Panel md;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Button button4;
		private System.Windows.Forms.Label mdn;
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.Button button5;
		private System.Windows.Forms.Button button6;
		private System.Windows.Forms.TextBox textBox2;
		private System.Windows.Forms.Button clrb;
		private System.Windows.Forms.Button clrr;
		private System.Windows.Forms.Button button7;
		private System.Windows.Forms.Button button8;
	}
}

