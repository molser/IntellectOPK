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
    /// Interaction logic for IidkMessageView.xaml
    /// </summary>
    public partial class IidkMessageView : Window
    {
        public IidkMessageView()
        {
            InitializeComponent();
        }
        public IidkMessageViewModel ViewModel
        {
            get { return this.DataContext as IidkMessageViewModel; }
            set
            {
                this.DataContext = value;
            }
        }
    }
}
