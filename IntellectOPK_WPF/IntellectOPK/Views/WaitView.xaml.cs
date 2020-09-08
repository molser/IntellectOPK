using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace IntellectOPK.Views
{
    /// <summary>
    /// Interaction logic for WaitView.xaml
    /// </summary>
    public partial class WaitView : Window
    {
        CancellationTokenSource CTS;
        public WaitView(CancellationTokenSource CTS = null)
        {
            this.CTS = CTS;
            this.ViewModel = new WaitViewModel();
            InitializeComponent();
        }
        
        public WaitViewModel ViewModel
        {
            get { return this.DataContext as WaitViewModel; }
            set { this.DataContext = value; }
        }
        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {  
            if (this.CTS != null && this.CTS.IsCancellationRequested == false)
                this.CTS.Cancel();
            base.OnClosing(e);
            if (this.Owner != null)
            {
                this.Owner.Activate();
            }
        }
    }
}
