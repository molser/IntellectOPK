using IntellectOPK.Model;
using IntellectOPK.Utilities;
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
    /// Interaction logic for UsersView.xaml
    /// </summary>
    public partial class UsersView : Window
    {
        public bool IsMinimizeButtonHidden { get { return true; } }
        public UsersView()
        {
            InitializeComponent();
            this.SourceInitialized += (x, y) =>
            {
                WindowHelper.HideMinimizeButton(this);
            };
        }

        public UsersViewModel ViewModel
        {
            get { return this.DataContext as UsersViewModel; }
            set { this.DataContext = value; }
        }
        private void dataGrid_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }

        private void Roles_SelectedItemChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            //Perform actions when SelectedItem changes
            this.ViewModel.CurrentRole = (RoleNode)e.NewValue;
            //MessageBox.Show(((TreeViewItem)e.NewValue).Header.ToString());
        }

        private void Users_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            this.dataGrid_LoadingRow(sender, e);
            User user = (User)e.Row.DataContext;
            if (user.IsLocked == true)
                e.Row.Foreground = new SolidColorBrush(Colors.Gray);
        }
        private void CloseWindow_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
