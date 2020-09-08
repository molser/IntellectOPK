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
    /// Interaction logic for CardConverterView.xaml
    /// </summary>
    public partial class CardConverterView : Window
    {
        private Action onCloseAction;
        public CardConverterView(Action onCloseAction)
        {
            this.ViewModel = new CardConverterViewModel(this);
            this.onCloseAction = onCloseAction;
            InitializeComponent();
        }
        public CardConverterViewModel ViewModel
        {
            get { return this.DataContext as CardConverterViewModel; }
            set { this.DataContext = value; }
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
        private void SelectAddress(object sender, RoutedEventArgs e)
        {
            TextBox tb = (sender as TextBox);
            if (tb != null)
            {
                tb.SelectAll();
            }
        }

        private void SelectivelyIgnoreMouseButton(object sender, MouseButtonEventArgs e)
        {
            TextBox tb = (sender as TextBox);
            if (tb != null)
            {
                if (!tb.IsKeyboardFocusWithin)
                {
                    e.Handled = true;
                    tb.Focus();
                }
            }
        }
    }
}
