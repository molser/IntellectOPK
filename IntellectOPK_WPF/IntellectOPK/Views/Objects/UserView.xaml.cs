using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace IntellectOPK.Views
{
    /// <summary>
    /// Interaction logic for UserView.xaml
    /// </summary>
    public partial class UserView : Window
    {
        public bool IsMinimizeButtonHidden { get { return true; } }
        public UserView()
        {
            InitializeComponent();
            this.SourceInitialized += (x, y) =>
            {
                WindowHelper.HideMinimizeButton(this);
            };
            //this.WindowStartupLocation = WindowStartupLocation.CenterOwner;
        }
        public UserViewModel ViewModel
        {
            get { return this.DataContext as UserViewModel; }
            set { this.DataContext = value; }
        }

        private void dataGrid_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }

        private void DataGrid_OneClickCheckBoxEdit(object sender, RoutedEventArgs e)
        {
            //изменение чекбокса по одному клику мыши
            DataGridHelper.OneClickCheckBoxEdit(sender, e);
        }

        private void CheckUnCheckAll(object sender, RoutedEventArgs e)
        {
            //SelectAll CheckBoxes in Column             
            DataGridHelper.CheckUnCheckAll(sender, e);
        }
        
    }
}
