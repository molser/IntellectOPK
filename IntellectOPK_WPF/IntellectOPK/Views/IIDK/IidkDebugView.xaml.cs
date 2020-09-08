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
    /// Interaction logic for IidkDebugView.xaml
    /// </summary>
    public partial class IidkDebugView : Window
    {
        private Action onCloseAction;
        public IidkDebugView(Action onCloseAction)
        {
            this.onCloseAction = onCloseAction;
            InitializeComponent();
        }
        public IidkDebugViewModel ViewModel
        {
            get { return this.DataContext as IidkDebugViewModel; }
            set
            {
                this.DataContext = value;                
            }
        }
        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            this.onCloseAction.Invoke();
            base.OnClosing(e);
            if (this.Owner != null)
            {
                this.Owner.Activate();
            }
            this.ViewModel.Dispose();
        }
}
}
