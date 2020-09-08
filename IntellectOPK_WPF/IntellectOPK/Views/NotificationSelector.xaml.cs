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
    /// Interaction logic for NotificationSelector.xaml
    /// </summary>
    public partial class NotificationSelector : Window
    {
        public NotificationSelector()
        {
            InitializeComponent();
        }
        public NotificationSelectorViewModel ViewModel
        {
            get { return this.DataContext as NotificationSelectorViewModel; }
            set
            {
                this.DataContext = value;                
            }
        }
    }
}
