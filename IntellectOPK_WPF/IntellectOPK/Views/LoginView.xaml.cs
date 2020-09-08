using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    /// Interaction logic for Login.xaml
    /// </summary>
    public partial class LoginView : Window
    {        
        public LoginView()
        {
            this.ViewModel = new LoginViewModel(this);
            InitializeComponent();            
        }
        public LoginViewModel ViewModel
        {
            get { return this.DataContext as LoginViewModel; }
            set { this.DataContext = value; }
        }
        
          
        //private void ok_Click(object sender, RoutedEventArgs e)
        //{
        //    if (UserInterfaceUtilities.ValidateVisualTree(this) == true)
        //    {
        //        this.DialogResult = true;
        //    }
        //}

        protected override void OnActivated(EventArgs e)
        {
            base.OnActivated(e);
            this.Login.Focus();
            //this.Login.SelectAll();
        }
        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            //оключаем возможность закрытия окна, если выполняется процесс авторизации
            //if (this.ViewModel.IsBusy == true)
            //{
            //    e.Cancel = true;
            //}
            base.OnClosing(e);
            //this.ViewModel.Dispose();
        }
        //private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        //{
        //    //оключаем возможность закрытия окна, если выполняется процесс авторизации
        //    if (this.ViewModel.IsBusy == true)
        //    {
        //        e.Cancel = true;
        //    }
        //    //MessageBoxResult result = MessageBox.Show("Are you shure?", "Confirm", MessageBoxButton.YesNo);
        //    //if (result == MessageBoxResult.No)
        //    //{
        //    //    e.Cancel = true;
        //    //}

        //    //Window2 w = new Window2();
        //    //if(w.ShowDialog() == false)
        //    //    e.Cancel = true; // Отмена закрытия окна.
        //}
    }
}
