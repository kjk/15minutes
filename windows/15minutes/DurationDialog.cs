using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace _15minutes
{
    public partial class DurationDialog : Form
    {
        public DurationDialog()
        {
            InitializeComponent();

            this.Load += new EventHandler(DurationDialog_Load);
        }

        private void DurationDialog_Load(object sender, EventArgs e)
        {
            nudMinutes.Select(0, nudMinutes.Text.Length);
        }

        public int Value
        {
            get { return (int)nudMinutes.Value; }
            set { nudMinutes.Value = value; }
        }
    }
}
