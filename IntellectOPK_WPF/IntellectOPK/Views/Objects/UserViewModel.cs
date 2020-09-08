using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IntellectOPK.Commands;
using IntellectOPK.MessageService;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System.Data;
using System.Windows.Input;
using System.Diagnostics;
using System.Threading;

namespace IntellectOPK.Views
{
    
    public class UserViewModel : ViewModelBase
    {
        #region Member Data
        private UserView view;
        private ManageUserAction action;
        private string title;
        private IDataAccessService das = null;
        private User user;
        private User oldUser;
        private DataTable userRoles;
        private List<RolePermission> rolesPermissions;
        private DataTable userPermissions;
        private Permissions appUserPermissions;
        private RelayCommand confirmCommand;
        private bool userChanged = false;
        #endregion


        #region Constructor

        public UserViewModel(IDataAccessService dataService, 
                            UserView view, 
                            ManageUserAction action,
                            Permissions appUserPermissions,
                            List<Role> appRoles,
                            List<Permission> appPermissions,
                            List<RolePermission> rolesPermissions,
                            User user = null,
                            List<Role> userRoles = null)
            : base()
        {
            this.view = view;
            this.das = dataService;
            this.action = action;
            this.appUserPermissions = appUserPermissions;
            if (action == ManageUserAction.Add) this.title = "Создание пользователя";
            else if (action == ManageUserAction.Modify) this.title = "Редактирование пользователя";
            
            if (user == null)
            {
                this.user = new User();
            }                
            else
            {
                this.user = user;
                this.oldUser = user.Clone();                
                this.user.PropertyChanged += User_PropertyChanged;
            }

            this.rolesPermissions = rolesPermissions;
                       
            this.userRoles = DataTablesHelper.CreateRolesTable();
            DataTablesHelper.FillUserRolesTable(this.userRoles, appRoles, userRoles);

            this.userPermissions = DataTablesHelper.CreatePermissionsTable();
            DataTablesHelper.FillPermissionsTable(this.userPermissions, appPermissions);
            this.updateUserPermissions();
            this.UserChanged = false;

            //this.userRoles.RowChanging += UserRoles_RowChanging;
            //this.userRoles.ColumnChanging += UserRoles_ColumnChanging;
            this.userRoles.ColumnChanged += UserRoles_ColumnChanged;
        }

        #endregion

        #region Private Methods

        private void getTableRowsState()
        {
            Debug.WriteLine("-----------------------------------------");
            foreach (DataRow row in userRoles.Rows)
            {
                Debug.WriteLine("RowState: " + row.RowState);
            }
        }


        private void UserRoles_ColumnChanged(object sender, DataColumnChangeEventArgs e)
        {
            this.UserChanged = true;
            getTableRowsState();
            this.updateUserPermissions();
        }

        private void UserRoles_ColumnChanging(object sender, DataColumnChangeEventArgs e)
        {
            this.UserChanged = true;
            getTableRowsState();
            this.updateUserPermissions();
        }

        //private void UserRoles_RowChanging(object sender, DataRowChangeEventArgs e)
        //{
        //    this.UserChanged = true;
        //}

        private void User_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if(this.userChanged != true)
                this.UserChanged = true;
        }

        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }


        private void updateUserPermissions()
        {
            if (this.user.IsAdmin == true)
            {
                foreach (DataRow row in this.userPermissions.Rows)
                {
                    row["IsChecked"] = true;
                }
            }
            else
            {
                Permissions permissions = new Permissions();
                foreach (DataRow row in this.userRoles.Rows)
                {
                    if ((bool)row["IsChecked"] == true)
                    {
                        foreach (RolePermission rolePermission in this.rolesPermissions)
                        {
                            if (rolePermission.RoleName == row["Name"].ToString())
                            {
                                permissions.Add(rolePermission.PermissionName);
                            }
                        }
                    }
                }
                foreach (DataRow row in this.userPermissions.Rows)
                {
                    if (permissions[row["Name"].ToString()])
                        row["IsChecked"] = true;
                    else
                        row["IsChecked"] = false;
                }
            }

            this.OnPropertyChanged("UserPermissions");
            this.UserChanged = true;
        }

        #endregion

        #region Public Methods


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

        public User User
        {
            get { return this.user; }
            set
            {
                this.user = value;
                this.OnPropertyChanged("User");
            }

        }

        public DataTable UserRoles
        {
            get { return this.userRoles; }
            set
            {
                //DataView dv = value.DefaultView;
                //dv.Sort = "name acs";
                //DataTable dt = dv.ToTable();
                //this.userRoles = dt;
                this.userRoles = value;
                this.OnPropertyChanged("UserRoles");
            }
        }

        public Boolean AllUserRolesCheckedUnchecked
        {
            set
            {
                if (this.userRoles != null)
                {
                    DataTablesHelper.CheckUncheckAll(this.userRoles, value);
                }
            }
        }

        public DataTable UserPermissions
        {
            get { return this.userPermissions; }
            set
            {
                this.userPermissions = value;
                this.OnPropertyChanged("UserPermissions");
            }
        }

        public Boolean UserChanged
        {
            get { return this.userChanged; }
            set
            {
                this.userChanged = value;
                this.OnPropertyChanged("UserChanged");
                this.raiseCanExecuteChanged();                
            }
        }

        public Boolean UserIsAdmin
        {
            get { return this.user.IsAdmin; }
            set
            {
                this.user.IsAdmin = value;
                this.OnPropertyChanged("UserIsAdmin");
                this.updateUserPermissions();
            }
        }

        public Permissions AppUserPermissions
        {
            get { return this.appUserPermissions; }
            set
            {
                this.appUserPermissions = value;
                this.OnPropertyChanged("AppUserPermissions");
                this.raiseCanExecuteChanged();
            }
        }

        #endregion


        #region Protected Methods

        #endregion


        #region Commands
        public ICommand ConfirmCommand
        {
            get
            {
                if (this.confirmCommand == null)
                {
                    this.confirmCommand = new RelayCommand(executeConfirmCommand, canExecuteConfirmCommand);
                }
                return this.confirmCommand;
            }
        }

        
        #endregion


        #region Helper Methods
        private async void executeConfirmCommand(object obj)
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;

            ///*
            try
            {
                bool user_changed = true;

                if (this.action == ManageUserAction.Modify)
                {
                    if(this.user == this.oldUser)
                    {
                        //System.Windows.Forms.MessageBox.Show("Равны!");
                        user_changed = false;
                    }
                    //else System.Windows.Forms.MessageBox.Show("Не равны!");
                }

                if (user_changed)
                {
                    await das.ManageUserAsync(token, this.action, this.user, this.oldUser);
                }
                
                ManageUserRolesAction manageUserRolesAction;
                bool new_value;
                bool old_value;
                foreach (DataRow row in userRoles.Rows)
                {
                    //проверяем, что данные действительно изменились
                    if (row.RowState == DataRowState.Modified)
                    {
                        new_value = Convert.ToBoolean(row["IsChecked", DataRowVersion.Current]);
                        old_value = Convert.ToBoolean(row["IsChecked", DataRowVersion.Original]);

                        //Debug.WriteLine("new_row_value: " + new_value);
                        //Debug.WriteLine("old_row_value: " + old_value);
                        
                        if (new_value != old_value)
                        {
                            if (new_value == true) manageUserRolesAction = ManageUserRolesAction.Add;
                            else manageUserRolesAction = ManageUserRolesAction.Remove;
                            await das.ManageUserRolesAsync(token, manageUserRolesAction, this.user, row["Name"].ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
            //*/
            //getTableRowsState();
            this.view.DialogResult = true;
        }
        private bool canExecuteConfirmCommand(object obj)
        {
            if (string.IsNullOrEmpty(this.user.Login)) return false;
            else if (this.user.Login.Length < 2) return false;
            else if (this.user.HasErrors) return false;
            else if ((this.action == ManageUserAction.Modify) && (this.userChanged == false)) return false;
            else return true;
        }


        #endregion
    }
}
