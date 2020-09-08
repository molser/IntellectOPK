using IntellectOPK.Commands;
using IntellectOPK.Utilities;
using IntellectOPK.MessageService;
using IntellectOPK.Model;
using System;
using System.ComponentModel;
using System.Text;
using System.Windows.Input;
using System.Threading;
using System.Windows;
using System.Security;
using System.Text.RegularExpressions;

namespace IntellectOPK.Views
{
    public class LoginViewModel: ViewModelBase
    {
        #region Member Data
        
        private System.Windows.Window view;
        private string title;
        private SecureString password;
        //private bool isBusy;
        //private Nullable<bool> dialogResult; //результат операции (удачно или нет)
        //private Action<bool> loginResult; //событие о результате выполнения авторизации
        //private BackgroundWorker worker;

        private RelayCommand setLoginCommand;
        //private RelayCommand cancelCommand;

        private LoginParams loginParams;
        private bool wrongPasswordDetected = false;
        #endregion
        
        #region Constructor
        public LoginViewModel(System.Windows.Window view)
        {
            this.view = view;
            this.title = "Авторизация - " + AssemlyInfoHelper.AssemblyTitle;
            this.loginParams = new LoginParams();
            this.password = null;
            //this.isBusy = false;
            //this.dialogResult = null;
            //this.worker = new BackgroundWorker();
        }
        #endregion

        #region Events
        
        //событие результата выполнения операции авторизации
        //public event Action<bool> LoginResult
        //{
        //    add { this.nLoginResult += value; }
        //    remove { this.nLoginResult -= value; }
        //}
                
        #endregion

        #region Properties
        public string Title
        {
            get {return this.title;}
        }
        public LoginParams LoginParams
        {
            get { return this.loginParams; }
            set
            {
                this.loginParams = value;
            }
        }

        public SecureString Password
        {
            get { return this.password; }            
        }
        
        public bool WrongPasswordDetected
        {
            get {return this.wrongPasswordDetected;}
            set 
            {
                this.wrongPasswordDetected = value;
                this.OnPropertyChanged("WrongPasswordDetected");
            }
        }
        
        
        #endregion

        #region Protected Methods

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            if (this.password != null)
            {
                this.password.Dispose();
            }                       
        }
        #endregion
        
        #region Commands
        public ICommand SetLoginCommand
        {
            get
            {
                if (this.setLoginCommand == null)
                {
                    this.setLoginCommand = new RelayCommand(ExecuteSetLoginCommand, CanExecuteSetLoginCommand);
                }
                return this.setLoginCommand;
            }
        }

        //public ICommand Cancel
        //{
        //    get
        //    {
        //        if (this.cancelCommand == null)
        //        {
        //            this.cancelCommand = new RelayCommand(ExecuteCancelCommand);
        //        }
        //        return this.cancelCommand;
        //    }
        //}

        #endregion

        #region Helper Methods
        protected void ExecuteSetLoginCommand(object param)
        {
            this.password = (param as System.Windows.Controls.PasswordBox).SecurePassword;
            this.view.DialogResult = true;
            
        }
        protected bool CanExecuteSetLoginCommand(object param)
        {
            if (string.IsNullOrEmpty(loginParams.User.Login) 
                || loginParams.User.HasErrors)
                return false;            
            return true;
        }

        #endregion

    }
}
