namespace _15minutes
{
    partial class FormMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.buttonStartOk = new System.Windows.Forms.Button();
            this.label5min = new System.Windows.Forms.Label();
            this.label15min = new System.Windows.Forms.Label();
            this.label30min = new System.Windows.Forms.Label();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.buttonStop = new System.Windows.Forms.Button();
            this.buttonPauseResume = new System.Windows.Forms.Button();
            this.labelWebSite = new System.Windows.Forms.Label();
            this.label1hr = new System.Windows.Forms.Label();
            this.labelOther = new System.Windows.Forms.Label();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.SuspendLayout();
            // 
            // buttonStartOk
            // 
            this.buttonStartOk.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.buttonStartOk.Location = new System.Drawing.Point(0, 77);
            this.buttonStartOk.Name = "buttonStartOk";
            this.buttonStartOk.Size = new System.Drawing.Size(224, 23);
            this.buttonStartOk.TabIndex = 0;
            this.buttonStartOk.Text = "Start";
            this.buttonStartOk.UseVisualStyleBackColor = true;
            this.buttonStartOk.Click += new System.EventHandler(this.buttonStartOk_Click);
            // 
            // label5min
            // 
            this.label5min.AutoSize = true;
            this.label5min.Location = new System.Drawing.Point(188, 1);
            this.label5min.Name = "label5min";
            this.label5min.Size = new System.Drawing.Size(32, 13);
            this.label5min.TabIndex = 1;
            this.label5min.Text = "5 min";
            this.label5min.Click += new System.EventHandler(this.label5min_Click);
            // 
            // label15min
            // 
            this.label15min.AutoSize = true;
            this.label15min.Location = new System.Drawing.Point(182, 13);
            this.label15min.Name = "label15min";
            this.label15min.Size = new System.Drawing.Size(38, 13);
            this.label15min.TabIndex = 2;
            this.label15min.Text = "15 min";
            this.label15min.Click += new System.EventHandler(this.label15min_Click);
            // 
            // label30min
            // 
            this.label30min.AutoSize = true;
            this.label30min.BackColor = System.Drawing.Color.White;
            this.label30min.Location = new System.Drawing.Point(182, 26);
            this.label30min.Name = "label30min";
            this.label30min.Size = new System.Drawing.Size(38, 13);
            this.label30min.TabIndex = 3;
            this.label30min.Text = "30 min";
            this.label30min.Click += new System.EventHandler(this.label30min_Click);
            // 
            // timer
            // 
            this.timer.Interval = 1000;
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
            // 
            // buttonStop
            // 
            this.buttonStop.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonStop.Location = new System.Drawing.Point(106, 76);
            this.buttonStop.Name = "buttonStop";
            this.buttonStop.Size = new System.Drawing.Size(118, 23);
            this.buttonStop.TabIndex = 4;
            this.buttonStop.Text = "Stop";
            this.buttonStop.UseVisualStyleBackColor = true;
            this.buttonStop.Visible = false;
            this.buttonStop.Click += new System.EventHandler(this.buttonStop_Click);
            // 
            // buttonPauseResume
            // 
            this.buttonPauseResume.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.buttonPauseResume.Location = new System.Drawing.Point(0, 76);
            this.buttonPauseResume.Name = "buttonPauseResume";
            this.buttonPauseResume.Size = new System.Drawing.Size(105, 23);
            this.buttonPauseResume.TabIndex = 5;
            this.buttonPauseResume.Text = "Pause";
            this.buttonPauseResume.UseVisualStyleBackColor = true;
            this.buttonPauseResume.Visible = false;
            this.buttonPauseResume.Click += new System.EventHandler(this.buttonPauseResume_Click);
            // 
            // labelWebSite
            // 
            this.labelWebSite.AutoSize = true;
            this.labelWebSite.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
            this.labelWebSite.Location = new System.Drawing.Point(1, 60);
            this.labelWebSite.Name = "labelWebSite";
            this.labelWebSite.Size = new System.Drawing.Size(64, 13);
            this.labelWebSite.TabIndex = 6;
            this.labelWebSite.Text = "visit website";
            this.labelWebSite.Click += new System.EventHandler(this.labelWebSite_Click);
            // 
            // label1hr
            // 
            this.label1hr.AutoSize = true;
            this.label1hr.BackColor = System.Drawing.Color.White;
            this.label1hr.Location = new System.Drawing.Point(193, 39);
            this.label1hr.Name = "label1hr";
            this.label1hr.Size = new System.Drawing.Size(25, 13);
            this.label1hr.TabIndex = 7;
            this.label1hr.Text = "1 hr";
            this.label1hr.Click += new System.EventHandler(this.label1hr_Click);
            // 
            // labelOther
            // 
            this.labelOther.AutoSize = true;
            this.labelOther.BackColor = System.Drawing.Color.White;
            this.labelOther.Location = new System.Drawing.Point(178, 52);
            this.labelOther.Name = "labelOther";
            this.labelOther.Size = new System.Drawing.Size(41, 13);
            this.labelOther.TabIndex = 8;
            this.labelOther.Text = "custom";
            this.labelOther.Click += new System.EventHandler(this.labelOther_Click);
            // 
            // FormMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(224, 100);
            this.Controls.Add(this.labelOther);
            this.Controls.Add(this.label1hr);
            this.Controls.Add(this.labelWebSite);
            this.Controls.Add(this.buttonPauseResume);
            this.Controls.Add(this.buttonStop);
            this.Controls.Add(this.label30min);
            this.Controls.Add(this.label15min);
            this.Controls.Add(this.label5min);
            this.Controls.Add(this.buttonStartOk);
            this.MaximumSize = new System.Drawing.Size(240, 138);
            this.MinimumSize = new System.Drawing.Size(240, 138);
            this.Name = "FormMain";
            this.Text = "15minutes v1.1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonStartOk;
        private System.Windows.Forms.Label label5min;
        private System.Windows.Forms.Label label15min;
        private System.Windows.Forms.Label label30min;
        private System.Windows.Forms.Timer timer;
        private System.Windows.Forms.Button buttonStop;
        private System.Windows.Forms.Button buttonPauseResume;
        private System.Windows.Forms.Label labelWebSite;
        private System.Windows.Forms.Label label1hr;
        private System.Windows.Forms.Label labelOther;
        private System.Windows.Forms.ToolTip toolTip1;
    }
}

