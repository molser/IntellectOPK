using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IntellectOPK.Commands;
using System.Security;
using IntellectOPK.Utilities;
using System.Windows.Input;
using System.Runtime.InteropServices;
using IntellectOPK.MessageService;

namespace IntellectOPK.Views
{
    public class ChangePasswordViewModel: ViewModelBase
    {
        #region Member Data
        private System.Windows.Window view;
        private SecureString password;
        private SecureString confirmPassword;
        private string title;
        //private SecureString confirmPassword;
        private RelayCommand changePasswordCommand;

        #endregion


        #region Constructor
        public ChangePasswordViewModel(System.Windows.Window view)
        {
            this.view = view;
            this.title = "Изменение пароля - " + AssemlyInfoHelper.AssemblyTitle;
            this.password = new SecureString();
            this.confirmPassword = new SecureString();
        }
        #endregion


        #region Properties
        public string Title
        {
            get { return this.title; }
            set 
            { 
                this.title = value;
                this.OnPropertyChanged("Title");
            }
        }
        public SecureString Password
        {
            get { return this.password; }
            set { this.password = value; }
        }

        public SecureString ConfirmPassword
        {
            set { this.confirmPassword = value; }
        }

        #endregion


        #region Protected Methods
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            if (this.password != null)
            {
                this.password.Dispose();
                this.password = null;
            }
            if (this.confirmPassword != null)
            {
                this.confirmPassword.Dispose();
                this.confirmPassword = null;
            }
        }
        #endregion


        #region Commands
        public ICommand ChangePasswordCommand
        {
            get
            {
                if (this.changePasswordCommand == null)
                {
                    this.changePasswordCommand = new RelayCommand(executeChangePasswordCommand, canExecuteChangePasswordCommand);
                }
                return this.changePasswordCommand;
            }
        }

        #endregion


        #region Helper Methods

        protected void executeChangePasswordCommand(object param)
        {

            if (SecureStringHelper.CompareSecureStrings(this.password, this.confirmPassword) == false)
            {
                Message.ShowExclamation("Пароли не совпадают!", "Ошибка");                
            }
            else
            {
                //this.password = (param as System.Windows.Controls.PasswordBox).SecurePassword;
                this.view.DialogResult = true;
            }
        }
        protected bool canExecuteChangePasswordCommand(object param)
        {
            if (this.password == null || this.confirmPassword == null)
            {
                return false;
            }
            else if (this.password.Length == 0 || (this.password.Length != this.confirmPassword.Length))
            {               
               return false;               
            }
            else return true;
        }       
        #endregion
    }
}
