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
    
    public class RoleViewModel : ViewModelBase
    {
        #region Member Data
        private RoleView view;
        private string title;
        private IDataAccessService das = null;
        private Role role;
        private DataTable rolePermissions;
        private DataTable roleUsers;
        private RelayCommand confirmCommand;
        private Permissions appUserPermissions;
        private bool rolePermissionsChanged = false;
        private bool roleUsersChanged = false;
        #endregion


        #region Constructor

        public RoleViewModel(IDataAccessService dataService, 
                            RoleView view,
                            Permissions appUserPermissions,
                            Role role,
                            List<Permission> appPermissions,
                            List<Permission> rolePermissions,
                            List<User> appUsers,
                            List<User> roleUsers)
            : base()
        {
            this.view = view;
            this.das = dataService;
            this.title = "Редактирование группы \"" + role.Description + "\"";
            this.appUserPermissions = appUserPermissions;
            this.role = role;
                      
            this.rolePermissions = DataTablesHelper.CreatePermissionsTable();
            DataTablesHelper.FillPermissionsTable(this.rolePermissions, appPermissions, rolePermissions);

            this.roleUsers = DataTablesHelper.CreateUsersTable();
            DataTablesHelper.FillRoleUsersTable(this.roleUsers, appUsers, roleUsers);

            this.roleUsers.ColumnChanging += RoleUsers_ColumnChanging;
            this.rolePermissions.ColumnChanged += RolePermissions_ColumnChanged;

        }

        #endregion

        #region Private Methods

        private void RoleUsers_ColumnChanging(object sender, DataColumnChangeEventArgs e)
        {
            this.RoleUsersChanged = true;
            //getTableRowsState();
        }

        private void RolePermissions_ColumnChanged(object sender, DataColumnChangeEventArgs e)
        {
            this.RolePermissionsChanged = true;
        }

        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }

        #endregion

        #region Public Methods
        private void getTableRowsState()
        {
            foreach (DataRow row in this.roleUsers.Rows)
            {
                Debug.WriteLine("RowState: " + row.RowState);
            }
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


        public DataTable RolePermissions
        {
            get { return this.rolePermissions; }
            set
            {
                this.rolePermissions = value;
                this.OnPropertyChanged("RolePermissions");
            }

        }

        public DataTable RoleUsers
        {
            get { return this.roleUsers; }
            set
            {
                this.roleUsers = value;
                this.OnPropertyChanged("RoleUsers");
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


        public Boolean AllRolePermissionsCheckedUnchecked
        {
            set
            {
                if (this.rolePermissions != null)
                {
                    DataTablesHelper.CheckUncheckAll(this.rolePermissions, value);
                }
            }
        }

        public Boolean AllRoleUsersCheckedUnchecked
        {
            set
            {
                if (this.roleUsers != null)
                {
                    DataTablesHelper.CheckUncheckAll(this.roleUsers, value);
                }
            }
        }

        public Boolean RolePermissionsChanged
        {
            get { return this.rolePermissionsChanged; }
            set
            {
                this.rolePermissionsChanged = value;
                this.OnPropertyChanged("RolePermissionsChanged");
                this.raiseCanExecuteChanged();
                
            }
        }

        public Boolean RoleUsersChanged
        {
            get { return this.roleUsersChanged; }
            set
            {
                this.roleUsersChanged = value;
                this.OnPropertyChanged("RoleUsersChanged");
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

            //*
            try
            {
                if (this.rolePermissionsChanged)
                {                    
                    ManageRolePermissionsAction manageRolePermissionsAction;
                    bool new_value;
                    bool old_value;
                    foreach (DataRow row in rolePermissions.Rows)
                    {
                        if (row.RowState == DataRowState.Modified)
                        {
                            new_value = Convert.ToBoolean(row["IsChecked", DataRowVersion.Current]);
                            old_value = Convert.ToBoolean(row["IsChecked", DataRowVersion.Original]);

                            //проверяем, что данные действительно изменились
                            if (new_value != old_value)
                            {
                                if (new_value == true) manageRolePermissionsAction = ManageRolePermissionsAction.Add;
                                else manageRolePermissionsAction = ManageRolePermissionsAction.Remove;
                                await das.ManageRolePermissionsAsync(token, manageRolePermissionsAction, this.role.Name, row["Name"].ToString());
                            }
                        }
                    }


                }

                if (this.roleUsersChanged)
                {
                    ManageUserRolesAction manageUserRolesAction;
                    bool new_value;
                    bool old_value;
                    foreach (DataRow row in roleUsers.Rows)
                    {
                        if (row.RowState == DataRowState.Modified)
                        {
                            new_value = Convert.ToBoolean(row["IsChecked", DataRowVersion.Current]);
                            old_value = Convert.ToBoolean(row["IsChecked", DataRowVersion.Original]);
                            //проверяем, что данные действительно изменились
                            if (new_value != old_value)
                            {
                                User user = new User()
                                {
                                    ID = Convert.ToInt32(row["ID"]),
                                    Login = row["Login"].ToString(),
                                    Name = row["Name"].ToString(),
                                    Comment = row["Comment"].ToString(),
                                    IsAdmin = Convert.ToBoolean(row["IsAdmin"]),
                                    IsLocked = Convert.ToBoolean(row["IsLocked"])
                                };

                                if (new_value == true) manageUserRolesAction = ManageUserRolesAction.Add;
                                else manageUserRolesAction = ManageUserRolesAction.Remove;
                                await das.ManageUserRolesAsync(token, manageUserRolesAction, user, this.role.Name);
                            }
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
            return (this.rolePermissionsChanged || this.roleUsersChanged);
            //return (true);
        }


        #endregion
    }
}
