using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security;
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
    /// Interaction logic for ChangePasswordView.xaml
    /// </summary>
    public partial class ChangePasswordView : Window
    {
        public ChangePasswordView()
        {
            this.ViewModel = new ChangePasswordViewModel(this);
            InitializeComponent();
        }
        public ChangePasswordViewModel ViewModel
        {
            get { return this.DataContext as ChangePasswordViewModel; }
            set { this.DataContext = value; }
        }

        protected override void OnActivated(EventArgs e)
        {
            base.OnActivated(e);
            this.passwordBox.Focus();
        }

        private void passwordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            //if (this.DataContext != null)
            //{ ((dynamic)this.DataContext).SecurePassword = ((PasswordBox)sender).SecurePassword; }

            this.ViewModel.Password = ((PasswordBox)sender).SecurePassword;  
        }

        private void confirmPasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            this.ViewModel.ConfirmPassword = ((PasswordBox)sender).SecurePassword;
        }
        

        //private void ButtonOK_Click(object sender, RoutedEventArgs e)
        //{
        //    if (this.passwordBox.SecurePassword.Length == 0)
        //    {
        //        MessageBox.Show(this, "Пароль не может быть пустым!", "Внимание", MessageBoxButton.OK, MessageBoxImage.Information);
        //    }
        //    else if (compareSecureStrings(this.passwordBox.SecurePassword, this.confirmPasswordBox.SecurePassword) == false)
        //    {
        //        MessageBox.Show(this, "Пароли не совпадают!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Exclamation);
        //    }
        //    else
        //    {
        //        this.ViewModel.ChangePasswordCommand.Execute(this.passwordBox);
        //    }           
        //}
        //private bool compareSecureStrings(SecureString ss1, SecureString ss2)
        //{
        //    IntPtr bstr1 = IntPtr.Zero;
        //    IntPtr bstr2 = IntPtr.Zero;
        //    try
        //    {
        //        bstr1 = Marshal.SecureStringToBSTR(ss1);
        //        bstr2 = Marshal.SecureStringToBSTR(ss2);
        //        int length1 = Marshal.ReadInt32(bstr1, -4);
        //        int length2 = Marshal.ReadInt32(bstr2, -4);
        //        if (length1 == length2)
        //        {
        //            for (int x = 0; x < length1; ++x)
        //            {
        //                byte b1 = Marshal.ReadByte(bstr1, x);
        //                byte b2 = Marshal.ReadByte(bstr2, x);
        //                if (b1 != b2) return false;
        //            }
        //        }
        //        else return false;
        //        return true;
        //    }
        //    finally
        //    {
        //        if (bstr2 != IntPtr.Zero) Marshal.ZeroFreeBSTR(bstr2);
        //        if (bstr1 != IntPtr.Zero) Marshal.ZeroFreeBSTR(bstr1);
        //    }
        //}
    }
}
