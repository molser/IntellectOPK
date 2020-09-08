using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
    /// Interaction logic for AboutView.xaml
    /// </summary>
    public partial class AboutView : Window
    {
        //Action onClosing;
        //public AboutView(Action onClosing)
        public AboutView()
        {
            this.ViewModel = new AboutViewModel(this);
            //this.onClosing = onClosing;
            InitializeComponent();
        }

        public AboutViewModel ViewModel
        {
            get { return this.DataContext as AboutViewModel; }
            set { this.DataContext = value; }
        }

        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            //оключаем возможность закрытия окна
            //    e.Cancel = true;
            
            base.OnClosing(e);
            //this.onClosing();
            //this.ViewModel.Dispose();
        }

        private void Window_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            DragMove();
        }

    }
}
