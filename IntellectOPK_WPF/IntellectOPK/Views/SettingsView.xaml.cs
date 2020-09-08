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
    /// Interaction logic for SettingsView.xaml
    /// </summary>
    public partial class SettingsView : Window
    {
        public bool IsMinimizeButtonHidden { get { return true; } }
        public SettingsView()
        {
            InitializeComponent();
        }
        public SettingsViewModel ViewModel
        {
            get { return this.DataContext as SettingsViewModel; }
            set { this.DataContext = value; }
        }

        private void Button_OK_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
        }
    }
}
