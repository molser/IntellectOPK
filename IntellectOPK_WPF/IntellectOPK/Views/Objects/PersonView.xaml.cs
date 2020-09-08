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
    public partial class PersonView : Window
    {
        public PersonView()
        {
            InitializeComponent();
            //this.WindowStartupLocation = WindowStartupLocation.CenterOwner;
        }
        public PersonViewModel ViewModel
        {
            get { return this.DataContext as PersonViewModel; }
            set
            {
                this.DataContext = value;                
            }
        }

        
        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            base.OnClosing(e);
            if (this.Owner != null)
            {
                this.Owner.Activate();
            }
            this.ViewModel.Dispose();
        }

        private void dataGrid_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }

        
        private void CheckUnCheckAll(object sender, RoutedEventArgs e)
        {
            //SelectAll CheckBoxes in Column             
            DataGridHelper.CheckUnCheckAll(sender, e);
        }

        private void ButtonCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        
    }
}
