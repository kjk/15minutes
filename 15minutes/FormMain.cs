using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Text;
using System.Windows.Forms;

namespace _15minutes
{
    public enum State
    {
        SettingTime, Running, Paused, Finished
    }

    public partial class FormMain : Form
    {
        int Hours;
        int Minutes;
        int Seconds;

        TimeSpan TotalTime;
        TimeSpan RemainingTime;
        State CurrentState;
        DateTime StartTime;

        public void SetTime(int hours, int minutes, int seconds)
        {
            Hours = hours;
            Minutes = minutes;
            Seconds = seconds;
            TotalTime = new TimeSpan(hours, minutes, seconds);
            this.Invalidate();
        }

        public FormMain()
        {
            InitializeComponent();
            this.label5min.MouseEnter += new EventHandler(label_MouseEnter);
            this.label5min.MouseLeave += new EventHandler(label_MouseLeave);
            this.label15min.MouseEnter += new EventHandler(label_MouseEnter);
            this.label15min.MouseLeave += new EventHandler(label_MouseLeave);
            this.label30min.MouseEnter += new EventHandler(label_MouseEnter);
            this.label30min.MouseLeave += new EventHandler(label_MouseLeave);
            this.DoubleBuffered = true;
            SwitchToSettingTimeState();
        }

        public void SwitchToSettingTimeState()
        {
            CurrentState = State.SettingTime;

            // TODO: remember what it was last
            SetTime(0, 15, 0);
            //SetTime(0, 0, 5);
            timer.Stop();

            label5min.Visible = true;
            label15min.Visible = true;
            label30min.Visible = true;

            buttonStartOk.Text = "Start countdown";
            buttonStartOk.Visible = true;

            buttonPauseResume.Visible = false;
            buttonStop.Visible = false;

            this.BackColor = SystemColors.Control;
            this.Invalidate();
        }

        public void SwitchToRunningState(bool resetTime)
        {
            CurrentState = State.Running;

            label5min.Visible = false;
            label15min.Visible = false;
            label30min.Visible = false;

            buttonStartOk.Visible = false;

            buttonPauseResume.Visible = true;
            buttonStop.Visible = true;

            if (resetTime)
                StartTime = DateTime.Now;
            CalcRemaining();
            timer.Interval = 1000;
            timer.Start();
            this.Invalidate();
        }

        public void SwitchToPausedState()
        {
            CurrentState = State.Paused;

            label5min.Visible = false;
            label15min.Visible = false;
            label30min.Visible = false;

            buttonStartOk.Visible = false;

            buttonPauseResume.Visible = true;
            buttonStop.Visible = true;

            timer.Stop();
            buttonPauseResume.Text = "Resume";
            this.Invalidate();
        }

        public void SwitchToFinishedState()
        {
            CurrentState = State.Finished;

            label5min.Visible = false;
            label15min.Visible = false;
            label30min.Visible = false;

            buttonStartOk.Visible = true;
            buttonStartOk.Text = "Ok";

            buttonPauseResume.Visible = false;
            buttonStop.Visible = false;

            timer.Stop();
            timer.Interval = 200;
            timer.Start();

            this.Invalidate();
        }

        private void label_MouseEnter(object sender, EventArgs e)
        {
            Control c = sender as Control;
            c.BackColor = System.Drawing.Color.White;
        }

        private void label_MouseLeave(object sender, EventArgs e)
        {
            Control c = sender as Control;
            c.BackColor = System.Drawing.SystemColors.Control;
        }

        private void label5min_Click(object sender, EventArgs e)
        {
            SetTime(0, 5, 0);
        }

        private void label15min_Click(object sender, EventArgs e)
        {
            SetTime(0, 15, 0);
        }

        private void label30min_Click(object sender, EventArgs e)
        {
            SetTime(0, 30, 0);
        }

        private void buttonStartOk_Click(object sender, EventArgs e)
        {
            if (CurrentState == State.SettingTime)
            {
                SwitchToRunningState(true);
            }
            else
            {
                Debug.Assert(CurrentState == State.Finished);
                SwitchToSettingTimeState();
            }
        }

        private bool CalcRemaining()
        {
            DateTime curr = DateTime.Now;
            TimeSpan passed = curr - StartTime;
            if (passed > TotalTime)
                RemainingTime = new TimeSpan(0, 0, 0);
            else
                RemainingTime = TotalTime - passed;
            return passed > TotalTime;
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            if (CurrentState == State.Running)
            {
                bool shouldStop = CalcRemaining();
                if (shouldStop)
                    SwitchToFinishedState();
            }
            else
            {
                Debug.Assert(CurrentState == State.Finished);
                if (this.BackColor == Color.White)
                {
                    this.BackColor = Color.Red;
                }
                else
                {
                    this.BackColor = Color.White;
                }
            }
            this.Invalidate(true);
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            TimeSpan timeToShow = RemainingTime;
            if (CurrentState == State.SettingTime)
                timeToShow = TotalTime;
            int hours = timeToShow.Hours;
            int minutes = timeToShow.Minutes;
            int seconds = timeToShow.Seconds;

            using (var font = new Font("Arial", 24, FontStyle.Bold))
            {
                Graphics g = e.Graphics;
                g.SmoothingMode = SmoothingMode.AntiAlias;
                Rectangle rect = this.ClientRectangle;
                int dx = rect.Width;
                int dy = rect.Height - buttonStartOk.Height;
                string s = String.Format("{0:D2} : {1:D2} : {2:D2}", hours, minutes, seconds);
                SizeF strSize = g.MeasureString(s, font);

                float x = (dx - strSize.Width) / 2;
                float y = (dy - strSize.Height) / 2;
                PointF pos = new PointF(x, y);
                g.DrawString(s, font, Brushes.Black, pos);
            }
            base.OnPaint(e);
        }

        private void buttonPauseResume_Click(object sender, EventArgs e)
        {
            if (CurrentState == State.Running)
                SwitchToPausedState();
            else 
            {
                Debug.Assert(CurrentState == State.Paused);
                SwitchToRunningState(false);
            }
        }

        private void buttonStop_Click(object sender, EventArgs e)
        {
            SwitchToSettingTimeState();
        }
    }
}
