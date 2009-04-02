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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormMain));
            this.buttonStartOk = new System.Windows.Forms.Button();
            this.label5min = new System.Windows.Forms.Label();
            this.label15min = new System.Windows.Forms.Label();
            this.label30min = new System.Windows.Forms.Label();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.buttonStop = new System.Windows.Forms.Button();
            this.buttonPauseResume = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // buttonStartOk
            // 
            this.buttonStartOk.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.buttonStartOk.Location = new System.Drawing.Point(0, 100);
            this.buttonStartOk.Name = "buttonStartOk";
            this.buttonStartOk.Size = new System.Drawing.Size(290, 23);
            this.buttonStartOk.TabIndex = 0;
            this.buttonStartOk.Text = "Start countdown";
            this.buttonStartOk.UseVisualStyleBackColor = true;
            this.buttonStartOk.Click += new System.EventHandler(this.buttonStartOk_Click);
            // 
            // label5min
            // 
            this.label5min.AutoSize = true;
            this.label5min.Location = new System.Drawing.Point(252, 9);
            this.label5min.Name = "label5min";
            this.label5min.Size = new System.Drawing.Size(32, 13);
            this.label5min.TabIndex = 1;
            this.label5min.Text = "5 min";
            this.label5min.Click += new System.EventHandler(this.label5min_Click);
            // 
            // label15min
            // 
            this.label15min.AutoSize = true;
            this.label15min.Location = new System.Drawing.Point(246, 21);
            this.label15min.Name = "label15min";
            this.label15min.Size = new System.Drawing.Size(38, 13);
            this.label15min.TabIndex = 2;
            this.label15min.Text = "15 min";
            this.label15min.Click += new System.EventHandler(this.label15min_Click);
            // 
            // label30min
            // 
            this.label30min.AutoSize = true;
            this.label30min.BackColor = System.Drawing.SystemColors.Control;
            this.label30min.Location = new System.Drawing.Point(246, 34);
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
            this.buttonStop.Location = new System.Drawing.Point(152, 100);
            this.buttonStop.Name = "buttonStop";
            this.buttonStop.Size = new System.Drawing.Size(139, 23);
            this.buttonStop.TabIndex = 4;
            this.buttonStop.Text = "Stop";
            this.buttonStop.UseVisualStyleBackColor = true;
            this.buttonStop.Visible = false;
            this.buttonStop.Click += new System.EventHandler(this.buttonStop_Click);
            // 
            // buttonPauseResume
            // 
            this.buttonPauseResume.Location = new System.Drawing.Point(0, 100);
            this.buttonPauseResume.Name = "buttonPauseResume";
            this.buttonPauseResume.Size = new System.Drawing.Size(152, 23);
            this.buttonPauseResume.TabIndex = 5;
            this.buttonPauseResume.Text = "Pause";
            this.buttonPauseResume.UseVisualStyleBackColor = true;
            this.buttonPauseResume.Visible = false;
            this.buttonPauseResume.Click += new System.EventHandler(this.buttonPauseResume_Click);
            // 
            // FormMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(290, 123);
            this.Controls.Add(this.buttonPauseResume);
            this.Controls.Add(this.buttonStop);
            this.Controls.Add(this.label30min);
            this.Controls.Add(this.label15min);
            this.Controls.Add(this.label5min);
            this.Controls.Add(this.buttonStartOk);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximumSize = new System.Drawing.Size(298, 152);
            this.MinimumSize = new System.Drawing.Size(298, 152);
            this.Name = "FormMain";
            this.Text = "15minutes";
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
    }
}

