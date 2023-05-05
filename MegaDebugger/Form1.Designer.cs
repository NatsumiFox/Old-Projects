using System;
using System.IO;
using System.Windows.Forms;

namespace MegaDebugger {
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
			this.rambox = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.rombox = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.gotoramaddr = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.setramaddr = new System.Windows.Forms.TextBox();
			this.setramval = new System.Windows.Forms.TextBox();
			this.label5 = new System.Windows.Forms.Label();
			this.showromstart = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.showromend = new System.Windows.Forms.TextBox();
			this.setromval = new System.Windows.Forms.TextBox();
			this.setromaddr = new System.Windows.Forms.TextBox();
			this.label7 = new System.Windows.Forms.Label();
			this.label8 = new System.Windows.Forms.Label();
			this.label9 = new System.Windows.Forms.Label();
			this.label10 = new System.Windows.Forms.Label();
			this.label11 = new System.Windows.Forms.Label();
			this.label12 = new System.Windows.Forms.Label();
			this.label13 = new System.Windows.Forms.Label();
			this.label14 = new System.Windows.Forms.Label();
			this.label15 = new System.Windows.Forms.Label();
			this.label16 = new System.Windows.Forms.Label();
			this.label17 = new System.Windows.Forms.Label();
			this.label18 = new System.Windows.Forms.Label();
			this.label19 = new System.Windows.Forms.Label();
			this.label20 = new System.Windows.Forms.Label();
			this.label21 = new System.Windows.Forms.Label();
			this.label22 = new System.Windows.Forms.Label();
			this.label23 = new System.Windows.Forms.Label();
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.textBox2 = new System.Windows.Forms.TextBox();
			this.textBox3 = new System.Windows.Forms.TextBox();
			this.textBox4 = new System.Windows.Forms.TextBox();
			this.textBox5 = new System.Windows.Forms.TextBox();
			this.textBox6 = new System.Windows.Forms.TextBox();
			this.textBox7 = new System.Windows.Forms.TextBox();
			this.textBox8 = new System.Windows.Forms.TextBox();
			this.textBox9 = new System.Windows.Forms.TextBox();
			this.textBox10 = new System.Windows.Forms.TextBox();
			this.textBox11 = new System.Windows.Forms.TextBox();
			this.textBox12 = new System.Windows.Forms.TextBox();
			this.textBox13 = new System.Windows.Forms.TextBox();
			this.textBox14 = new System.Windows.Forms.TextBox();
			this.textBox15 = new System.Windows.Forms.TextBox();
			this.textBox16 = new System.Windows.Forms.TextBox();
			this.textBox17 = new System.Windows.Forms.TextBox();
			this.label24 = new System.Windows.Forms.Label();
			this.textBox18 = new System.Windows.Forms.TextBox();
			this.label25 = new System.Windows.Forms.Label();
			this.label26 = new System.Windows.Forms.Label();
			this.checkBox1 = new System.Windows.Forms.CheckBox();
			this.comboBox1 = new System.Windows.Forms.ComboBox();
			this.comboBox2 = new System.Windows.Forms.ComboBox();
			this.label27 = new System.Windows.Forms.Label();
			this.textBox19 = new System.Windows.Forms.TextBox();
			this.button1 = new System.Windows.Forms.Button();
			this.label28 = new System.Windows.Forms.Label();
			this.textBox20 = new System.Windows.Forms.TextBox();
			this.textBox21 = new System.Windows.Forms.TextBox();
			this.romProgress = new System.Windows.Forms.ProgressBar();
			this.ramProgress = new System.Windows.Forms.ProgressBar();
			this.button2 = new System.Windows.Forms.Button();
			this.bgw = new System.ComponentModel.BackgroundWorker();
			this.recom = new System.Windows.Forms.TextBox();
			this.secom = new System.Windows.Forms.TextBox();
			this.progressBar1 = new System.Windows.Forms.ProgressBar();
			this.MEDstatus = new System.Windows.Forms.Label();
			this.MEDcmd = new System.Windows.Forms.TextBox();
			this.ofd = new System.Windows.Forms.OpenFileDialog();
			this.outbt = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// rambox
			// 
			this.rambox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
			this.rambox.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.rambox.Location = new System.Drawing.Point(13, 33);
			this.rambox.MaxLength = 0;
			this.rambox.Multiline = true;
			this.rambox.Name = "rambox";
			this.rambox.ReadOnly = true;
			this.rambox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.rambox.Size = new System.Drawing.Size(394, 374);
			this.rambox.TabIndex = 0;
			this.rambox.WordWrap = false;
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.label1.Location = new System.Drawing.Point(16, 9);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(371, 13);
			this.label1.TabIndex = 1;
			this.label1.Text = "RAM  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F";
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.label2.Location = new System.Drawing.Point(416, 9);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(385, 13);
			this.label2.TabIndex = 2;
			this.label2.Text = "ROM    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F";
			// 
			// rombox
			// 
			this.rombox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
			this.rombox.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.rombox.Location = new System.Drawing.Point(413, 33);
			this.rombox.MaxLength = 0;
			this.rombox.Multiline = true;
			this.rombox.Name = "rombox";
			this.rombox.ReadOnly = true;
			this.rombox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.rombox.Size = new System.Drawing.Size(407, 374);
			this.rombox.TabIndex = 3;
			this.rombox.WordWrap = false;
			// 
			// label3
			// 
			this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label3.AutoSize = true;
			this.label3.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label3.Location = new System.Drawing.Point(10, 416);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(35, 13);
			this.label3.TabIndex = 4;
			this.label3.Text = "goto";
			// 
			// gotoramaddr
			// 
			this.gotoramaddr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.gotoramaddr.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.gotoramaddr.Location = new System.Drawing.Point(46, 413);
			this.gotoramaddr.MaxLength = 4;
			this.gotoramaddr.Name = "gotoramaddr";
			this.gotoramaddr.Size = new System.Drawing.Size(35, 20);
			this.gotoramaddr.TabIndex = 5;
			this.gotoramaddr.Text = "0000";
			// 
			// label4
			// 
			this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label4.AutoSize = true;
			this.label4.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label4.Location = new System.Drawing.Point(87, 416);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(28, 13);
			this.label4.TabIndex = 6;
			this.label4.Text = "set";
			// 
			// setramaddr
			// 
			this.setramaddr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.setramaddr.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.setramaddr.Location = new System.Drawing.Point(116, 413);
			this.setramaddr.MaxLength = 4;
			this.setramaddr.Name = "setramaddr";
			this.setramaddr.Size = new System.Drawing.Size(35, 20);
			this.setramaddr.TabIndex = 7;
			this.setramaddr.Text = "0000";
			// 
			// setramval
			// 
			this.setramval.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.setramval.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.setramval.Location = new System.Drawing.Point(156, 413);
			this.setramval.MaxLength = 2;
			this.setramval.Name = "setramval";
			this.setramval.Size = new System.Drawing.Size(20, 20);
			this.setramval.TabIndex = 8;
			this.setramval.Text = "00";
			// 
			// label5
			// 
			this.label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label5.AutoSize = true;
			this.label5.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label5.Location = new System.Drawing.Point(410, 415);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(35, 13);
			this.label5.TabIndex = 9;
			this.label5.Text = "show";
			// 
			// showromstart
			// 
			this.showromstart.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.showromstart.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.showromstart.Location = new System.Drawing.Point(447, 412);
			this.showromstart.MaxLength = 6;
			this.showromstart.Name = "showromstart";
			this.showromstart.Size = new System.Drawing.Size(50, 20);
			this.showromstart.TabIndex = 10;
			this.showromstart.Text = "000000";
			// 
			// label6
			// 
			this.label6.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label6.AutoSize = true;
			this.label6.Location = new System.Drawing.Point(495, 414);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(10, 13);
			this.label6.TabIndex = 11;
			this.label6.Text = "-";
			// 
			// showromend
			// 
			this.showromend.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.showromend.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.showromend.Location = new System.Drawing.Point(503, 412);
			this.showromend.MaxLength = 6;
			this.showromend.Name = "showromend";
			this.showromend.Size = new System.Drawing.Size(50, 20);
			this.showromend.TabIndex = 12;
			this.showromend.Text = "000000";
			// 
			// setromval
			// 
			this.setromval.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.setromval.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.setromval.Location = new System.Drawing.Point(644, 414);
			this.setromval.MaxLength = 2;
			this.setromval.Name = "setromval";
			this.setromval.Size = new System.Drawing.Size(20, 20);
			this.setromval.TabIndex = 15;
			this.setromval.Text = "00";
			// 
			// setromaddr
			// 
			this.setromaddr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.setromaddr.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.setromaddr.Location = new System.Drawing.Point(590, 414);
			this.setromaddr.MaxLength = 4;
			this.setromaddr.Name = "setromaddr";
			this.setromaddr.Size = new System.Drawing.Size(50, 20);
			this.setromaddr.TabIndex = 14;
			this.setromaddr.Text = "000000";
			// 
			// label7
			// 
			this.label7.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label7.AutoSize = true;
			this.label7.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label7.Location = new System.Drawing.Point(559, 416);
			this.label7.Name = "label7";
			this.label7.Size = new System.Drawing.Size(28, 13);
			this.label7.TabIndex = 13;
			this.label7.Text = "set";
			// 
			// label8
			// 
			this.label8.AutoSize = true;
			this.label8.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label8.Location = new System.Drawing.Point(826, 48);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(21, 13);
			this.label8.TabIndex = 16;
			this.label8.Text = "D2";
			// 
			// label9
			// 
			this.label9.AutoSize = true;
			this.label9.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label9.Location = new System.Drawing.Point(826, 8);
			this.label9.Name = "label9";
			this.label9.Size = new System.Drawing.Size(21, 13);
			this.label9.TabIndex = 17;
			this.label9.Text = "D0";
			// 
			// label10
			// 
			this.label10.AutoSize = true;
			this.label10.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label10.Location = new System.Drawing.Point(826, 28);
			this.label10.Name = "label10";
			this.label10.Size = new System.Drawing.Size(21, 13);
			this.label10.TabIndex = 18;
			this.label10.Text = "D1";
			// 
			// label11
			// 
			this.label11.AutoSize = true;
			this.label11.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label11.Location = new System.Drawing.Point(826, 68);
			this.label11.Name = "label11";
			this.label11.Size = new System.Drawing.Size(21, 13);
			this.label11.TabIndex = 19;
			this.label11.Text = "D3";
			// 
			// label12
			// 
			this.label12.AutoSize = true;
			this.label12.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label12.Location = new System.Drawing.Point(826, 88);
			this.label12.Name = "label12";
			this.label12.Size = new System.Drawing.Size(21, 13);
			this.label12.TabIndex = 20;
			this.label12.Text = "D4";
			// 
			// label13
			// 
			this.label13.AutoSize = true;
			this.label13.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label13.Location = new System.Drawing.Point(826, 108);
			this.label13.Name = "label13";
			this.label13.Size = new System.Drawing.Size(21, 13);
			this.label13.TabIndex = 21;
			this.label13.Text = "D5";
			// 
			// label14
			// 
			this.label14.AutoSize = true;
			this.label14.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label14.Location = new System.Drawing.Point(826, 128);
			this.label14.Name = "label14";
			this.label14.Size = new System.Drawing.Size(21, 13);
			this.label14.TabIndex = 22;
			this.label14.Text = "D6";
			// 
			// label15
			// 
			this.label15.AutoSize = true;
			this.label15.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label15.Location = new System.Drawing.Point(826, 148);
			this.label15.Name = "label15";
			this.label15.Size = new System.Drawing.Size(21, 13);
			this.label15.TabIndex = 23;
			this.label15.Text = "D7";
			// 
			// label16
			// 
			this.label16.AutoSize = true;
			this.label16.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label16.Location = new System.Drawing.Point(826, 308);
			this.label16.Name = "label16";
			this.label16.Size = new System.Drawing.Size(21, 13);
			this.label16.TabIndex = 31;
			this.label16.Text = "SP";
			// 
			// label17
			// 
			this.label17.AutoSize = true;
			this.label17.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label17.Location = new System.Drawing.Point(826, 288);
			this.label17.Name = "label17";
			this.label17.Size = new System.Drawing.Size(21, 13);
			this.label17.TabIndex = 30;
			this.label17.Text = "A6";
			// 
			// label18
			// 
			this.label18.AutoSize = true;
			this.label18.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label18.Location = new System.Drawing.Point(826, 268);
			this.label18.Name = "label18";
			this.label18.Size = new System.Drawing.Size(21, 13);
			this.label18.TabIndex = 29;
			this.label18.Text = "A5";
			// 
			// label19
			// 
			this.label19.AutoSize = true;
			this.label19.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label19.Location = new System.Drawing.Point(826, 248);
			this.label19.Name = "label19";
			this.label19.Size = new System.Drawing.Size(21, 13);
			this.label19.TabIndex = 28;
			this.label19.Text = "A4";
			// 
			// label20
			// 
			this.label20.AutoSize = true;
			this.label20.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label20.Location = new System.Drawing.Point(826, 228);
			this.label20.Name = "label20";
			this.label20.Size = new System.Drawing.Size(21, 13);
			this.label20.TabIndex = 27;
			this.label20.Text = "A3";
			// 
			// label21
			// 
			this.label21.AutoSize = true;
			this.label21.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label21.Location = new System.Drawing.Point(826, 188);
			this.label21.Name = "label21";
			this.label21.Size = new System.Drawing.Size(21, 13);
			this.label21.TabIndex = 26;
			this.label21.Text = "A1";
			// 
			// label22
			// 
			this.label22.AutoSize = true;
			this.label22.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label22.Location = new System.Drawing.Point(826, 168);
			this.label22.Name = "label22";
			this.label22.Size = new System.Drawing.Size(21, 13);
			this.label22.TabIndex = 25;
			this.label22.Text = "A0";
			// 
			// label23
			// 
			this.label23.AutoSize = true;
			this.label23.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label23.Location = new System.Drawing.Point(826, 208);
			this.label23.Name = "label23";
			this.label23.Size = new System.Drawing.Size(21, 13);
			this.label23.TabIndex = 24;
			this.label23.Text = "A2";
			// 
			// textBox1
			// 
			this.textBox1.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox1.Location = new System.Drawing.Point(845, 5);
			this.textBox1.MaxLength = 8;
			this.textBox1.Name = "textBox1";
			this.textBox1.Size = new System.Drawing.Size(55, 20);
			this.textBox1.TabIndex = 32;
			this.textBox1.Text = "00000000";
			// 
			// textBox2
			// 
			this.textBox2.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox2.Location = new System.Drawing.Point(845, 25);
			this.textBox2.MaxLength = 8;
			this.textBox2.Name = "textBox2";
			this.textBox2.Size = new System.Drawing.Size(55, 20);
			this.textBox2.TabIndex = 33;
			this.textBox2.Text = "00000000";
			// 
			// textBox3
			// 
			this.textBox3.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox3.Location = new System.Drawing.Point(845, 65);
			this.textBox3.MaxLength = 8;
			this.textBox3.Name = "textBox3";
			this.textBox3.Size = new System.Drawing.Size(55, 20);
			this.textBox3.TabIndex = 35;
			this.textBox3.Text = "00000000";
			// 
			// textBox4
			// 
			this.textBox4.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox4.Location = new System.Drawing.Point(845, 45);
			this.textBox4.MaxLength = 8;
			this.textBox4.Name = "textBox4";
			this.textBox4.Size = new System.Drawing.Size(55, 20);
			this.textBox4.TabIndex = 34;
			this.textBox4.Text = "00000000";
			// 
			// textBox5
			// 
			this.textBox5.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox5.Location = new System.Drawing.Point(845, 85);
			this.textBox5.MaxLength = 8;
			this.textBox5.Name = "textBox5";
			this.textBox5.Size = new System.Drawing.Size(55, 20);
			this.textBox5.TabIndex = 36;
			this.textBox5.Text = "00000000";
			// 
			// textBox6
			// 
			this.textBox6.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox6.Location = new System.Drawing.Point(845, 105);
			this.textBox6.MaxLength = 8;
			this.textBox6.Name = "textBox6";
			this.textBox6.Size = new System.Drawing.Size(55, 20);
			this.textBox6.TabIndex = 37;
			this.textBox6.Text = "00000000";
			// 
			// textBox7
			// 
			this.textBox7.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox7.Location = new System.Drawing.Point(845, 125);
			this.textBox7.MaxLength = 8;
			this.textBox7.Name = "textBox7";
			this.textBox7.Size = new System.Drawing.Size(55, 20);
			this.textBox7.TabIndex = 38;
			this.textBox7.Text = "00000000";
			// 
			// textBox8
			// 
			this.textBox8.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox8.Location = new System.Drawing.Point(845, 265);
			this.textBox8.MaxLength = 8;
			this.textBox8.Name = "textBox8";
			this.textBox8.Size = new System.Drawing.Size(55, 20);
			this.textBox8.TabIndex = 47;
			this.textBox8.Text = "00000000";
			// 
			// textBox9
			// 
			this.textBox9.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox9.Location = new System.Drawing.Point(845, 245);
			this.textBox9.MaxLength = 8;
			this.textBox9.Name = "textBox9";
			this.textBox9.Size = new System.Drawing.Size(55, 20);
			this.textBox9.TabIndex = 44;
			this.textBox9.Text = "00000000";
			// 
			// textBox10
			// 
			this.textBox10.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox10.Location = new System.Drawing.Point(845, 225);
			this.textBox10.MaxLength = 8;
			this.textBox10.Name = "textBox10";
			this.textBox10.Size = new System.Drawing.Size(55, 20);
			this.textBox10.TabIndex = 43;
			this.textBox10.Text = "00000000";
			// 
			// textBox11
			// 
			this.textBox11.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox11.Location = new System.Drawing.Point(845, 185);
			this.textBox11.MaxLength = 8;
			this.textBox11.Name = "textBox11";
			this.textBox11.Size = new System.Drawing.Size(55, 20);
			this.textBox11.TabIndex = 41;
			this.textBox11.Text = "00000000";
			// 
			// textBox12
			// 
			this.textBox12.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox12.Location = new System.Drawing.Point(845, 205);
			this.textBox12.MaxLength = 8;
			this.textBox12.Name = "textBox12";
			this.textBox12.Size = new System.Drawing.Size(55, 20);
			this.textBox12.TabIndex = 42;
			this.textBox12.Text = "00000000";
			// 
			// textBox13
			// 
			this.textBox13.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox13.Location = new System.Drawing.Point(845, 165);
			this.textBox13.MaxLength = 8;
			this.textBox13.Name = "textBox13";
			this.textBox13.Size = new System.Drawing.Size(55, 20);
			this.textBox13.TabIndex = 40;
			this.textBox13.Text = "00000000";
			// 
			// textBox14
			// 
			this.textBox14.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox14.Location = new System.Drawing.Point(845, 145);
			this.textBox14.MaxLength = 8;
			this.textBox14.Name = "textBox14";
			this.textBox14.Size = new System.Drawing.Size(55, 20);
			this.textBox14.TabIndex = 39;
			this.textBox14.Text = "00000000";
			// 
			// textBox15
			// 
			this.textBox15.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox15.Location = new System.Drawing.Point(845, 285);
			this.textBox15.MaxLength = 8;
			this.textBox15.Name = "textBox15";
			this.textBox15.Size = new System.Drawing.Size(55, 20);
			this.textBox15.TabIndex = 48;
			this.textBox15.Text = "00000000";
			// 
			// textBox16
			// 
			this.textBox16.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox16.Location = new System.Drawing.Point(845, 305);
			this.textBox16.MaxLength = 8;
			this.textBox16.Name = "textBox16";
			this.textBox16.Size = new System.Drawing.Size(55, 20);
			this.textBox16.TabIndex = 49;
			this.textBox16.Text = "00000000";
			// 
			// textBox17
			// 
			this.textBox17.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox17.Location = new System.Drawing.Point(845, 325);
			this.textBox17.MaxLength = 8;
			this.textBox17.Name = "textBox17";
			this.textBox17.Size = new System.Drawing.Size(55, 20);
			this.textBox17.TabIndex = 50;
			this.textBox17.Text = "00000000";
			// 
			// label24
			// 
			this.label24.AutoSize = true;
			this.label24.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label24.Location = new System.Drawing.Point(826, 328);
			this.label24.Name = "label24";
			this.label24.Size = new System.Drawing.Size(21, 13);
			this.label24.TabIndex = 49;
			this.label24.Text = "PC";
			// 
			// textBox18
			// 
			this.textBox18.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox18.Location = new System.Drawing.Point(845, 345);
			this.textBox18.MaxLength = 4;
			this.textBox18.Name = "textBox18";
			this.textBox18.Size = new System.Drawing.Size(34, 20);
			this.textBox18.TabIndex = 51;
			this.textBox18.Text = "0000";
			// 
			// label25
			// 
			this.label25.AutoSize = true;
			this.label25.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label25.Location = new System.Drawing.Point(826, 348);
			this.label25.Name = "label25";
			this.label25.Size = new System.Drawing.Size(21, 13);
			this.label25.TabIndex = 51;
			this.label25.Text = "SR";
			// 
			// label26
			// 
			this.label26.AutoSize = true;
			this.label26.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label26.Location = new System.Drawing.Point(907, 8);
			this.label26.Name = "label26";
			this.label26.Size = new System.Drawing.Size(84, 13);
			this.label26.TabIndex = 53;
			this.label26.Text = "VDP command";
			// 
			// checkBox1
			// 
			this.checkBox1.AutoSize = true;
			this.checkBox1.Checked = true;
			this.checkBox1.CheckState = System.Windows.Forms.CheckState.Checked;
			this.checkBox1.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.checkBox1.Location = new System.Drawing.Point(907, 28);
			this.checkBox1.Name = "checkBox1";
			this.checkBox1.Size = new System.Drawing.Size(82, 17);
			this.checkBox1.TabIndex = 54;
			this.checkBox1.Text = "Do first";
			this.checkBox1.UseVisualStyleBackColor = true;
			// 
			// comboBox1
			// 
			this.comboBox1.DisplayMember = "VRAM";
			this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.comboBox1.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.comboBox1.Items.AddRange(new object[] {
            "VRAM",
            "CRAM",
            "VSRAM"});
			this.comboBox1.Location = new System.Drawing.Point(907, 44);
			this.comboBox1.MaxDropDownItems = 3;
			this.comboBox1.Name = "comboBox1";
			this.comboBox1.Size = new System.Drawing.Size(121, 21);
			this.comboBox1.TabIndex = 55;
			// 
			// comboBox2
			// 
			this.comboBox2.DisplayMember = "VRAM";
			this.comboBox2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.comboBox2.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.comboBox2.Items.AddRange(new object[] {
            "WRITE",
            "DMA"});
			this.comboBox2.Location = new System.Drawing.Point(907, 71);
			this.comboBox2.MaxDropDownItems = 3;
			this.comboBox2.Name = "comboBox2";
			this.comboBox2.Size = new System.Drawing.Size(121, 21);
			this.comboBox2.TabIndex = 56;
			// 
			// label27
			// 
			this.label27.AutoSize = true;
			this.label27.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label27.Location = new System.Drawing.Point(904, 95);
			this.label27.Name = "label27";
			this.label27.Size = new System.Drawing.Size(63, 13);
			this.label27.TabIndex = 57;
			this.label27.Text = "VDP data";
			// 
			// textBox19
			// 
			this.textBox19.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
			this.textBox19.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox19.Location = new System.Drawing.Point(907, 112);
			this.textBox19.MaxLength = 100;
			this.textBox19.Multiline = true;
			this.textBox19.Name = "textBox19";
			this.textBox19.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.textBox19.Size = new System.Drawing.Size(60, 276);
			this.textBox19.TabIndex = 57;
			// 
			// button1
			// 
			this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.button1.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.button1.Location = new System.Drawing.Point(907, 391);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(60, 23);
			this.button1.TabIndex = 58;
			this.button1.Text = "GO";
			this.button1.UseVisualStyleBackColor = true;
			// 
			// label28
			// 
			this.label28.AutoSize = true;
			this.label28.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.label28.Location = new System.Drawing.Point(826, 368);
			this.label28.Name = "label28";
			this.label28.Size = new System.Drawing.Size(56, 13);
			this.label28.TabIndex = 60;
			this.label28.Text = "VDP reg";
			// 
			// textBox20
			// 
			this.textBox20.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox20.Location = new System.Drawing.Point(829, 384);
			this.textBox20.MaxLength = 2;
			this.textBox20.Name = "textBox20";
			this.textBox20.Size = new System.Drawing.Size(20, 20);
			this.textBox20.TabIndex = 52;
			this.textBox20.Text = "00";
			// 
			// textBox21
			// 
			this.textBox21.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.textBox21.Location = new System.Drawing.Point(855, 384);
			this.textBox21.MaxLength = 2;
			this.textBox21.Name = "textBox21";
			this.textBox21.Size = new System.Drawing.Size(20, 20);
			this.textBox21.TabIndex = 53;
			this.textBox21.Text = "00";
			// 
			// romProgress
			// 
			this.romProgress.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.romProgress.Location = new System.Drawing.Point(670, 409);
			this.romProgress.Name = "romProgress";
			this.romProgress.Size = new System.Drawing.Size(150, 23);
			this.romProgress.TabIndex = 63;
			// 
			// ramProgress
			// 
			this.ramProgress.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.ramProgress.Location = new System.Drawing.Point(254, 410);
			this.ramProgress.Name = "ramProgress";
			this.ramProgress.Size = new System.Drawing.Size(153, 23);
			this.ramProgress.TabIndex = 64;
			// 
			// button2
			// 
			this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.button2.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.button2.Location = new System.Drawing.Point(182, 410);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(66, 23);
			this.button2.TabIndex = 9;
			this.button2.Text = "Update";
			this.button2.UseVisualStyleBackColor = true;
			// 
			// bgw
			// 
			this.bgw.WorkerReportsProgress = true;
			// 
			// recom
			// 
			this.recom.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.recom.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.recom.Location = new System.Drawing.Point(1034, 6);
			this.recom.Multiline = true;
			this.recom.Name = "recom";
			this.recom.ReadOnly = true;
			this.recom.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.recom.Size = new System.Drawing.Size(101, 198);
			this.recom.TabIndex = 65;
			this.recom.TabStop = false;
			this.recom.WordWrap = false;
			// 
			// secom
			// 
			this.secom.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.secom.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.secom.Location = new System.Drawing.Point(1034, 231);
			this.secom.Multiline = true;
			this.secom.Name = "secom";
			this.secom.ReadOnly = true;
			this.secom.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.secom.Size = new System.Drawing.Size(101, 198);
			this.secom.TabIndex = 66;
			this.secom.TabStop = false;
			this.secom.WordWrap = false;
			// 
			// progressBar1
			// 
			this.progressBar1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.progressBar1.Location = new System.Drawing.Point(973, 391);
			this.progressBar1.Name = "progressBar1";
			this.progressBar1.Size = new System.Drawing.Size(55, 23);
			this.progressBar1.TabIndex = 67;
			this.progressBar1.Value = 100;
			// 
			// MEDstatus
			// 
			this.MEDstatus.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.MEDstatus.AutoSize = true;
			this.MEDstatus.Location = new System.Drawing.Point(910, 421);
			this.MEDstatus.Name = "MEDstatus";
			this.MEDstatus.Size = new System.Drawing.Size(64, 13);
			this.MEDstatus.TabIndex = 68;
			this.MEDstatus.Text = "Searching...";
			// 
			// MEDcmd
			// 
			this.MEDcmd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.MEDcmd.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.MEDcmd.Location = new System.Drawing.Point(827, 415);
			this.MEDcmd.MaxLength = 100;
			this.MEDcmd.Name = "MEDcmd";
			this.MEDcmd.Size = new System.Drawing.Size(85, 20);
			this.MEDcmd.TabIndex = 69;
			// 
			// ofd
			// 
			this.ofd.FileName = "openFileDialog1";
			// 
			// outbt
			// 
			this.outbt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.outbt.AutoSize = true;
			this.outbt.Font = new System.Drawing.Font("DejaVu Sans Mono", 8.25F);
			this.outbt.Location = new System.Drawing.Point(973, 375);
			this.outbt.Name = "outbt";
			this.outbt.Size = new System.Drawing.Size(14, 13);
			this.outbt.TabIndex = 70;
			this.outbt.Text = "0";
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(1143, 435);
			this.Controls.Add(this.outbt);
			this.Controls.Add(this.MEDcmd);
			this.Controls.Add(this.MEDstatus);
			this.Controls.Add(this.progressBar1);
			this.Controls.Add(this.secom);
			this.Controls.Add(this.recom);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.ramProgress);
			this.Controls.Add(this.romProgress);
			this.Controls.Add(this.textBox21);
			this.Controls.Add(this.textBox20);
			this.Controls.Add(this.label28);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.textBox19);
			this.Controls.Add(this.label27);
			this.Controls.Add(this.comboBox2);
			this.Controls.Add(this.comboBox1);
			this.Controls.Add(this.checkBox1);
			this.Controls.Add(this.label26);
			this.Controls.Add(this.textBox18);
			this.Controls.Add(this.label25);
			this.Controls.Add(this.textBox17);
			this.Controls.Add(this.label24);
			this.Controls.Add(this.textBox16);
			this.Controls.Add(this.textBox15);
			this.Controls.Add(this.textBox8);
			this.Controls.Add(this.textBox9);
			this.Controls.Add(this.textBox10);
			this.Controls.Add(this.textBox11);
			this.Controls.Add(this.textBox12);
			this.Controls.Add(this.textBox13);
			this.Controls.Add(this.textBox14);
			this.Controls.Add(this.textBox7);
			this.Controls.Add(this.textBox6);
			this.Controls.Add(this.textBox5);
			this.Controls.Add(this.textBox4);
			this.Controls.Add(this.textBox3);
			this.Controls.Add(this.textBox2);
			this.Controls.Add(this.textBox1);
			this.Controls.Add(this.label16);
			this.Controls.Add(this.label17);
			this.Controls.Add(this.label18);
			this.Controls.Add(this.label19);
			this.Controls.Add(this.label20);
			this.Controls.Add(this.label21);
			this.Controls.Add(this.label22);
			this.Controls.Add(this.label23);
			this.Controls.Add(this.label15);
			this.Controls.Add(this.label14);
			this.Controls.Add(this.label13);
			this.Controls.Add(this.label12);
			this.Controls.Add(this.label11);
			this.Controls.Add(this.label10);
			this.Controls.Add(this.label9);
			this.Controls.Add(this.label8);
			this.Controls.Add(this.setromval);
			this.Controls.Add(this.setromaddr);
			this.Controls.Add(this.label7);
			this.Controls.Add(this.showromend);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.showromstart);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.setramval);
			this.Controls.Add(this.setramaddr);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.gotoramaddr);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.rombox);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.rambox);
			this.Name = "Form1";
			this.ShowIcon = false;
			this.Text = "Mega Debugger";
			this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		private void MEDcmdKeyUp(object sender, KeyEventArgs e) {
			if (e.KeyCode == Keys.Enter) {
				med.Send(MEDcmd.Text);
				MEDcmd.Text = "";
				e.Handled = true;

			} else if (e.KeyCode == Keys.F1) {
				ofd.CheckFileExists = true;
				ofd.InitialDirectory = @"A:\alarm\";
				if (ofd.ShowDialog() == DialogResult.OK) {
					med.StartPCM(ofd.FileName);
				}

			} else if (e.KeyCode == Keys.F2) {
				med.StopPCM();
			}
		}

		#endregion

		private System.Windows.Forms.TextBox rambox;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox rombox;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox gotoramaddr;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.TextBox setramaddr;
		private System.Windows.Forms.TextBox setramval;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox showromstart;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.TextBox showromend;
		private System.Windows.Forms.TextBox setromval;
		private System.Windows.Forms.TextBox setromaddr;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.Label label9;
		private System.Windows.Forms.Label label10;
		private System.Windows.Forms.Label label11;
		private System.Windows.Forms.Label label12;
		private System.Windows.Forms.Label label13;
		private System.Windows.Forms.Label label14;
		private System.Windows.Forms.Label label15;
		private System.Windows.Forms.Label label16;
		private System.Windows.Forms.Label label17;
		private System.Windows.Forms.Label label18;
		private System.Windows.Forms.Label label19;
		private System.Windows.Forms.Label label20;
		private System.Windows.Forms.Label label21;
		private System.Windows.Forms.Label label22;
		private System.Windows.Forms.Label label23;
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.TextBox textBox2;
		private System.Windows.Forms.TextBox textBox3;
		private System.Windows.Forms.TextBox textBox4;
		private System.Windows.Forms.TextBox textBox5;
		private System.Windows.Forms.TextBox textBox6;
		private System.Windows.Forms.TextBox textBox7;
		private System.Windows.Forms.TextBox textBox8;
		private System.Windows.Forms.TextBox textBox9;
		private System.Windows.Forms.TextBox textBox10;
		private System.Windows.Forms.TextBox textBox11;
		private System.Windows.Forms.TextBox textBox12;
		private System.Windows.Forms.TextBox textBox13;
		private System.Windows.Forms.TextBox textBox14;
		private System.Windows.Forms.TextBox textBox15;
		private System.Windows.Forms.TextBox textBox16;
		private System.Windows.Forms.TextBox textBox17;
		private System.Windows.Forms.Label label24;
		private System.Windows.Forms.TextBox textBox18;
		private System.Windows.Forms.Label label25;
		private System.Windows.Forms.Label label26;
		private System.Windows.Forms.CheckBox checkBox1;
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.ComboBox comboBox2;
		private System.Windows.Forms.Label label27;
		private System.Windows.Forms.TextBox textBox19;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Label label28;
		private System.Windows.Forms.TextBox textBox20;
		private System.Windows.Forms.TextBox textBox21;
		private System.Windows.Forms.ProgressBar romProgress;
		private System.Windows.Forms.ProgressBar ramProgress;
		private System.Windows.Forms.Button button2;
		private System.ComponentModel.BackgroundWorker bgw;
		private System.Windows.Forms.TextBox recom;
		private System.Windows.Forms.TextBox secom;
		private System.Windows.Forms.ProgressBar progressBar1;
		private System.Windows.Forms.Label MEDstatus;
		private System.Windows.Forms.TextBox MEDcmd;
		private OpenFileDialog ofd;
		private Label outbt;
	}
}

