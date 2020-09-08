using IntellectOPK.Commands;
using IntellectOPK.MessageService;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace IntellectOPK.Views
{
    public class RoleNode
    {
        public Role Role { get; set; }
        //public ObservableCollection<RoleNode> Nodes { get; set; }
        public List<RoleNode> Nodes { get; set; }
    }
    public class UsersViewModel : ViewModelBase
    {
        #region Member Data
        private UsersView view;
        private string title;

        private IDataAccessService das = null;
        //private ObservableCollection<RoleNode> roleNodes;
        private List<RoleNode> roleNodes;
        //private ObservableCollection<User> users;
        private List<User> users;
        private RoleNode currentRole;
        private User currentUser;
        private bool userIsSecurityAdmin;
        private Permissions appUserPermissions;
        private RelayCommand createUserCommand;
        private RelayCommand modifyUserCommand;
        private RelayCommand deleteUserCommand;
        private RelayCommand resetUserPasswordCommand;
        private RelayCommand modifyRoleCommand;

        #endregion


        #region Constructor

        public UsersViewModel(IDataAccessService dataService, UsersView view, bool userIsSecurityAdmin, Permissions appUserPermissions)
            : base()
        {
            this.das = dataService;
            this.view = view;
            this.title = "Пользователи"; //+ " " + AssemlyInfoHelper.AssemblyTitle;
            this.userIsSecurityAdmin = userIsSecurityAdmin;
            this.appUserPermissions = appUserPermissions;
        }

        #endregion


        #region Properties
        public string Title
        {
            get {return this.title;}
            set
            {
                this.title = value;
                this.OnPropertyChanged("Title");
            }
            
        }

        public bool UserIsSecurityAdmin
        {
            get { return this.userIsSecurityAdmin; }
            set
            {
                this.userIsSecurityAdmin = value;
                this.OnPropertyChanged("UserIsSecurityAdmin");
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

        //public ObservableCollection<RoleNode> Roles
        public List<RoleNode> Roles
        {
            get
            {
                return this.roleNodes;
            }
            set
            {
                this.roleNodes = value;
                this.OnPropertyChanged("Roles");
            }
        }
        //public ObservableCollection<User> Users
        public List<User> Users
        {
            get
            {
                return this.users;
            }
            set
            {
                this.users = value;
                if (this.users != null)
                {
                    if(this.users.Count == 0) this.users = null;
                }
                this.OnPropertyChanged("Users");
            }
        }


        public RoleNode CurrentRole
        {
            set
            {
                this.currentRole = value;
                
                string role_name = null;
                if (this.currentRole.Role.Name != "root")
                {
                    role_name = this.currentRole.Role.Name;
                } 
                
                setUsersAsync(CancellationToken.None, role_name);
                //setPermissions(token, role_name);
                this.CurrentUser = null;
            }

        }

        public User CurrentUser
        {
            get { return this.currentUser; }
            set
            {
                this.currentUser = value;
                this.OnPropertyChanged("CurrentUser");
                this.raiseCanExecuteChanged();
            }

        }

        #endregion

        #region Private Methods
                
        
        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }

        private async Task setRoles(CancellationToken token)
        {
            try
            {
                List<Role> roles = await das.GetRolesAsync(token);
                roles.Sort((x, y) => x.Description.CompareTo(y.Description));

                //ObservableCollection<RoleNode> nodes = new ObservableCollection<RoleNode>();
                List<RoleNode> nodes = new List<RoleNode>();
                foreach (Role role in roles)
                {
                    nodes.Add(new RoleNode { Role = role });
                }

                //this.Roles = new ObservableCollection<RoleNode>
                this.Roles = new List<RoleNode>
                {
                    new RoleNode
                    {
                        Role = new Role(0,"root","Все пользователи"),
                        Nodes = nodes
                    }
                };
            }
            catch (Exception ex)
            {               
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

        }

        private async Task setUsersAsync(CancellationToken token, string role_name = null)
        {
            try
            {
                List<User> users = await das.GetUsersAsync(token, role_name);
                users.Sort((x, y) => x.Login.CompareTo(y.Login));
                this.Users = users;
                //this.Users = new ObservableCollection<User>(users);
            }
            catch (Exception ex)
            {
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
        }

        #endregion

        #region Public Methods

        public async void Initialize()
        {
            await setRoles(CancellationToken.None);
            await setUsersAsync(CancellationToken.None);
        }

        #endregion


        #region Protected Methods

        #endregion


        #region Commands

        public ICommand CreateUserCommand
        {
            get
            {
                if (this.createUserCommand == null)
                {
                    this.createUserCommand = new RelayCommand(executeCreateUserCommand);
                }
                return this.createUserCommand;
            }
        }

        public ICommand ModifyUserCommand
        {
            get
            {
                if (this.modifyUserCommand == null)
                {
                    this.modifyUserCommand = new RelayCommand(executeModifyUserCommand, canExecuteModifyUserCommand);
                }
                return this.modifyUserCommand;
            }
        }
        public ICommand DeleteUserCommand
        {
            get
            {
                if (this.deleteUserCommand == null)
                {
                    this.deleteUserCommand = new RelayCommand(executeDeleteUserCommand, canExecuteModifyUserCommand);
                }
                return this.deleteUserCommand;
            }
        }
        public ICommand ResetUserPasswordCommand
        {
            get
            {
                if (this.resetUserPasswordCommand == null)
                {
                    this.resetUserPasswordCommand = new RelayCommand(executeResetUserPasswordCommand, canExecuteModifyUserCommand);
                }
                return this.resetUserPasswordCommand;
            }
        }
        public ICommand ModifyRoleCommand
        {
            get
            {
                if (this.modifyRoleCommand == null)
                {
                    this.modifyRoleCommand = new RelayCommand(executeModifyRoleCommand, canExecuteModifyRoleCommand);
                }
                return this.modifyRoleCommand;
            }
        }

        #endregion


        #region Helper Methods

        private bool canExecuteModifyUserCommand(object obj)
        {
            if (this.currentUser != null)
            {
                return (this.appUserPermissions["SeeUsers"]);
            }
            return false;
            //if(this.currentUser != null)
            //{
            //    if (this.userIsSecurityAdmin)
            //        return true;
            //    else
            //    {
            //        if (this.appUserPermissions["ManageAdminUsers"])
            //        {
            //            if (!this.currentUser.IsSecurityAdmin)
            //                return true;
            //        }
            //        else
            //        {
            //            if (this.appUserPermissions["ManageUsers"])
            //            {
            //                if (!this.currentUser.IsSecurityAdmin && !this.currentUser.IsAdmin)
            //                    return true;
            //            }
            //        }       
            //    } 
            //}
            //return false;
        }

        private async void executeModifyUserCommand(object obj)
        {
            UserView userView = new UserView();
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                List<Role> appRoles = await das.GetRolesAsync(token);
                //appRoles.Sort((x, y) => x.Name.CompareTo(y.Name));
                List<Role> userRoles = await das.GetRolesAsync(token, this.currentUser.Login);
                //userRoles.Sort((x, y) => x.Name.CompareTo(y.Name));
                List<Permission> appPermissions = await das.GetPermissionsAsync(token, false);
                //appPermissions.Sort((x, y) => x.Name.CompareTo(y.Name));
                List<RolePermission> rolesPermissions = await das.GetRolesPermissionsAsync(token);
                User user = new User()
                {
                    ID = this.currentUser.ID,
                    Login = this.currentUser.Login,
                    Name = this.currentUser.Name,
                    Comment = this.currentUser.Comment,
                    IsAdmin = this.currentUser.IsAdmin,
                    IsLocked = this.currentUser.IsLocked
                };

                userView.ViewModel = new UserViewModel(this.das,
                                                        userView,
                                                        ManageUserAction.Modify,
                                                        this.appUserPermissions,
                                                        appRoles, 
                                                        appPermissions, 
                                                        rolesPermissions, 
                                                        user,
                                                        userRoles);
                userView.Owner = this.view;
                userView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                userView.ShowInTaskbar = false;
                if (userView.ShowDialog() == true)
                {
                    await setUsersAsync(token, (this.currentRole == null ? null : this.currentRole.Role.Name));
                }
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                if (userView != null)
                {
                    userView.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
        }

        private async void executeDeleteUserCommand(object obj)
        {
            string text = "Вы действительно хотите удалить пользователя " + this.currentUser.Login + "?";
            if (Message.ShowDialogExclamation(text, "Внимание", this.view) == MessageBoxResult.Yes)
            {
                CancellationTokenSource CTS = new CancellationTokenSource();
                CancellationToken token = CTS.Token;
                try
                {
                    await das.ManageUserAsync(token, ManageUserAction.Remove, this.currentUser);
                    await setUsersAsync(token, (this.currentRole == null ? null : this.currentRole.Role.Name));
                }
                catch (Exception ex)
                {
                    CTS.Cancel();
                    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                }
            }
        }
        private async void executeResetUserPasswordCommand(object obj)
        {
            string text = "Вы действительно хотите сбросить пароль у пользователя " + this.currentUser.Login + "?";
            if (Message.ShowDialogExclamation(text, "Внимание", this.view) == MessageBoxResult.Yes)
            {
                CancellationTokenSource CTS = new CancellationTokenSource();
                CancellationToken token = CTS.Token;
                try
                {
                    await das.ManageUserAsync(token, ManageUserAction.ResetPassword, this.currentUser);
                    Message.ShowMessage("Пароль успешно сброшен", "Сброс пароля", this.view);
                }
                catch (Exception ex)
                {
                    CTS.Cancel();
                    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                }
            }
        }       

        private async void executeCreateUserCommand(object obj)
        {
            UserView userView = new UserView();
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {                
                List<Role> appRoles = await das.GetRolesAsync(token);
                List<Permission> appPermissions = await das.GetPermissionsAsync(token, false);
                List<RolePermission> rolesPermissions = await das.GetRolesPermissionsAsync(token);
                userView.ViewModel = new UserViewModel(this.das, 
                                                        userView, 
                                                        ManageUserAction.Add, 
                                                        appUserPermissions,
                                                        appRoles, 
                                                        appPermissions, 
                                                        rolesPermissions);
                userView.Owner = this.view;
                userView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                userView.ShowInTaskbar = false;
                if (userView.ShowDialog() == true)
                {                    
                    await setUsersAsync(token, (this.currentRole == null ? null : this.currentRole.Role.Name));                                    
                }
            }
            catch (Exception ex)
            {
                CTS.Cancel();

                if (userView != null)
                {
                    userView.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
        }

        private bool canExecuteModifyRoleCommand(object obj)
        {
            if (this.currentRole != null)
            {
                if(this.currentRole.Role.Name != "root")
                    return (this.appUserPermissions["SeeUsers"]);
            }
            return false;
        }

        private async void executeModifyRoleCommand(object obj)
        {
            RoleView roleView = new RoleView();
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                List<Permission> appPermissions = await das.GetPermissionsAsync(token, false);
                //appPermissions.Sort((x, y) => x.Name.CompareTo(y.Name));
                List<Permission> rolePermissions = await das.GetPermissionsAsync(token, false, role_name: this.currentRole.Role.Name);
                List<User> appUsers = await das.GetUsersAsync(token);
                List<User> roleUsers = await das.GetUsersAsync(token, role_name: this.currentRole.Role.Name);
                roleView.ViewModel = new RoleViewModel(this.das,  roleView, this.appUserPermissions, this.currentRole.Role,  appPermissions, rolePermissions, appUsers, roleUsers);
                roleView.Owner = this.view;
                roleView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                roleView.ShowInTaskbar = false;
                if (roleView.ShowDialog() == true)
                {
                    await setUsersAsync(token, (this.currentRole == null ? null : this.currentRole.Role.Name));
                }
            }
            catch (Exception ex)
            {
                CTS.Cancel();

                if (roleView != null)
                {
                    roleView.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
        }

        #endregion
    }
}
