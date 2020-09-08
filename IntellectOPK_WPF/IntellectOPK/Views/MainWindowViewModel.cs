//using IIDK;
using IntellectOPK.IIDK;
using IntellectOPK.Commands;
using IntellectOPK.MessageService;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Media;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using System.Windows.Threading;
using System.IO;

namespace IntellectOPK.Views
{
    enum AppTaskName
    {
        GetAccessEvents,
        GetPersons,
        GetAccessPoints,
        GetLevels,
        Login,
        ChangePassword,
        GetSettings,
        Notifications
    }

    public class MainWindowViewModel : ViewModelBase
    {

        #region Member Data

        private IDataAccessService das = null;
        private MainWindow view;
        private WaitView waitView;
        private CardConverterView cardConverterView;
        private string title;
        private string currentUserLogin;
        private string appBuild;
        private string pcName;
        private string iidkStatus;
        private bool isMainViewShowed = false;
        private bool isLoginViewShowed = false;
        private bool isPersonsViewShowed = false;
        //private bool isPersonViewShowed = false;
        private bool isAccessPointsViewShowed = false;
        private bool isLevelsViewShowed = false;
        private bool isLevelViewShowed = false;
        private bool isEventsViewShowed = false;
        private bool isDepartmentsViewShowed = false;
        private bool isChangePasswordViewShowed = false;
        private bool isCardConverterViewShowed = false;
        private bool isIidkDebugViewShowed = false;
        private bool isGettingAccessEvents = false;
        private bool isGettingPersons = false;
        private bool isGettingAccessPoints = false;
        private bool isGettingLevels = false;
        private bool isGettingSettings = false;
        private bool isUpdating = false;
        private bool userIsSecurityAdmin = false;
        private bool isApplyAefEvents = false;
        private bool isApplyAefAccessPoints = false;
        private bool isIidkConnected = false;        
        private bool isImportNotificationsExecuted = false;
        private List<ProtocolItem> accessEvents;
        private List<Person> persons;
        private List<AccessPoint> accessPoints;
        private List<Level> levels;
        private List<string> departments;
        private RelayCommand runTaskCommand;
        private RelayCommand cancelTaskCommand;
        private RelayCommand loginCommand;
        private RelayCommand changePasswordCommand;
        private RelayCommand updateCommand;
        private RelayCommand cardConverterCommand;
        private RelayCommand aboutCommand;
        private RelayCommand closeCommand;
        private RelayCommand showUsersViewCommand;
        private RelayCommand showSettingsViewCommand;
        private RelayCommand showPersonsViewCommand;
        private RelayCommand showInfoCommand;
        private RelayCommand showLevelsViewCommand;
        private RelayCommand showLevelViewCommand;
        private RelayCommand showAccessPointsViewCommand;
        private RelayCommand showEventsViewCommand;
        private RelayCommand showDepartmentsViewCommand;
        private RelayCommand showIidkDebugViewCommand;
        private RelayCommand exportToMSExcelCommand;
        private RelayCommand iidkShowObjectOnMapCommand;
        private RelayCommand iidkShowEventOnCamCommand;
        private RelayCommand addNotificationsCommand;
        private RelayCommand removeNotificationCommand;
        private RelayCommand removeAllNotificationsCommand;
        private RelayCommand exportNotificationsCommand;
        private RelayCommand importNotificationsCommand;
        private RelayCommand confirmAllNotificationsCommand;
        private AppTaskName? currentTask;
        private ProtocolItem currentProtocolItem;
        private Person currentPerson;
        private Level currentLevel;
        private AccessPoint currentAccessPoint;        
        private Dictionary<AppTaskName, CancellationTokenSource> runningTasks;

        private MainQueryParams accessEventsFilter;
        private MainQueryParams accessPointsFilter;
        private MainQueryParams personsFilter;
        private MainQueryParams levelsFilter;
        private MainQueryParams eventsFilter;
        private SettingsViewModel settings;

        private Permissions userPermissions;
        private ObservableCollection<string> aefPersonsHistory;
        private const int historyListDepth = 10; //количетво элементов в списке истории запросов

        private IidkDebugView iidkDebugView;
        private IIntellectAgent intellectAgent;
        private NotificationsManager notificationsManager;
        private Notification currentNotification;
        private List<Notification> notificationsFilter;

        #endregion

        #region Constructor
        public MainWindowViewModel(IDataAccessService dataService, MainWindow view)
            : base()
        {
            this.das = dataService;
            this.view = view;
            //this.view.DataContext = this;
            this.title = AssemlyInfoHelper.AssemblyTitle;
            this.appBuild = AssemlyInfoHelper.AssemblyVersion;
            this.currentUserLogin = Properties.Settings.Default.Login;
            
            this.accessEventsFilter = new MainQueryParams();
            this.accessEventsFilter.Persons = "";
            //this.accessEventsFilter.AccessPoints = "";
            this.accessEventsFilter.StartDate = DateTime.Today;
            this.accessEventsFilter.EndDate = DateTime.Today.Add(new TimeSpan(23, 59, 59));
            this.accessPointsFilter = new MainQueryParams();
            this.personsFilter = new MainQueryParams();
            this.levelsFilter = new MainQueryParams();
            this.eventsFilter = new MainQueryParams();            
            //this.accessEventsFilter.EndDate = DateTime.Today.AddDays(1);
            this.runningTasks = new Dictionary<AppTaskName, CancellationTokenSource>();
            //this.cardConverter = new CardConverterViewModel();
            //this.isMsExcelInstalled = this.checkIfMsExcelInstalled();
            this.pcName = System.Environment.MachineName;            
            //this.personsFilterList = new HashSet<string>();
            this.aefPersonsHistory = new ObservableCollection<string>();
            //this.settings = new SettingsViewModel();
            this.notificationsManager = new NotificationsManager();
            this.notificationsFilter = new List<Notification>();
        }

        #endregion

        #region Private Methods


        private void iidkAgent_OnMessage(object sender, MessageEventArgs e)
        {
            if(this.notificationsManager.Count > 0)
            {
                this.notificationsManager.Check(e.Message);
                //if (this.notificationsManager.Check(e.Message))
                //{
                //    this.IsAlarming = true;
                //}
            }
        }
        private void iidkAgent_OnConnected(object sender, EventArgs e)
        {
            //this.IsIidkLinkLost = false;
            this.IsIidkConnected = true;
            this.IidkStatus = "Подключено к серверу Интеллект " + this.settings.IidkHostIp.ToString();
            raiseCanExecuteChanged();

        }
        private void iidkAgent_OnDisconnected(object sender, EventArgs e)
        {
            //this.IsIidkLinkLost = true;
            this.IsIidkConnected = false;
            if(!this.settings.IsSoundDisabled)
            {
                string path = Environment.CurrentDirectory + "\\Resources\\Media\\LinkLost.wav";
                SoundPlayer player = new SoundPlayer(path);
                try
                {
                    player.Load();
                    player.Play();
                }
                catch { }                
            }
            this.IidkStatus = "Нет соединения с сервером Интеллект " + this.settings.IidkHostIp.ToString();
            raiseCanExecuteChanged();
        }

        private void createIidkAgent()
        {
            this.IidkStatus = "Нет соединения с сервером Интеллект " + this.settings.IidkHostIp.ToString();
            this.intellectAgent = new IntellectAgent2(this.settings.SettingsFromDB.HostName,
                                            this.settings.IidkHostIp.ToString());
            this.intellectAgent.OnConnected += new EventHandler(this.iidkAgent_OnConnected);
            this.intellectAgent.OnDisconnected += new EventHandler(this.iidkAgent_OnDisconnected);
            this.intellectAgent.OnMessage += new EventHandler<MessageEventArgs>(this.iidkAgent_OnMessage);
            this.intellectAgent.Start();
            //this.IsConnecting = true;
            
        }
        private void destroyIidkAgent()
        {            
            if (this.intellectAgent != null)
            {
                this.intellectAgent.OnConnected -= new EventHandler(this.iidkAgent_OnConnected);
                this.intellectAgent.OnDisconnected -= new EventHandler(this.iidkAgent_OnDisconnected);
                this.intellectAgent.OnMessage -= new EventHandler<MessageEventArgs>(this.iidkAgent_OnMessage);
                this.intellectAgent.Dispose();
                this.intellectAgent = null;
            }           
        }
        private async Task<SettingsViewModel> getSettingsAsync()
        {
            Settings settingsFromDB = new Settings();
            if (this.isGettingSettings == false)
            {
                CancellationTokenSource CTS = new CancellationTokenSource();
                CancellationToken token = CTS.Token;
                try
                {
                    startAppTask(AppTaskName.GetSettings, CTS);
                    settingsFromDB = await das.GetSettingsAsync(token, this.pcName);
                }
                catch (Exception e)
                {
                    if (e is TaskCanceledException)
                    {
                    }
                    else
                    {
                        Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                    }
                }
                finally
                {
                    stopAppTask(AppTaskName.GetSettings);
                }
            }

            SettingsViewModel settings = new SettingsViewModel(settingsFromDB);
            return settings;
        }
        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }

        private bool checkIfMsExcelInstalled()
        {
            Type officeType = Type.GetTypeFromProgID("Excel.Application");
            if (officeType == null)
            {
                //no Excel installed
                return false;
            }
            else
            {
                //Excel installed
                return true;
            }
        }

        private async Task showPersonView(int personKey, 
                                          string personId, 
                                          Guid personGuid, 
                                          DateTime date, 
                                          bool showPersonHistory,
                                          bool isExtendedMode)
        {
            //this.isPersonViewShowed = true;
            Mouse.OverrideCursor = Cursors.Wait;
            PersonView view = null;
            List<Person> personList = null;
            List<Person> personListOperDB = null;
            List<Person> personListDwDB = null;
            
            bool useOperDB = this.settings.UseOperDB;
            if (personKey > 0)
                useOperDB = false;

            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                if(showPersonHistory || !useOperDB)
                {
                    personListDwDB = await das.GetPersonAsync(token,
                                                        personKey,
                                                        personId,
                                                        personGuid,
                                                        date,
                                                        showPersonHistory,
                                                        use_oper_db: false);
                }
                if(useOperDB)
                {
                    personListOperDB = await das.GetPersonAsync(token,
                                                        personKey,
                                                        personId,
                                                        personGuid,
                                                        date,
                                                        show_person_history: false,
                                                        use_oper_db: true);
                }
            }
            catch (Exception ex)
            {
                Mouse.OverrideCursor = null;
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

            if (personListDwDB != null)
            {
                personListDwDB = personListDwDB.OrderBy(p => p.ValidFrom).ToList();
                personList = personListDwDB;
            }

            if (personListOperDB != null)
            {
                if (personList != null)
                {
                    personList.AddRange(personListOperDB);
                }
                else
                {
                    personList = personListOperDB;
                }

            }

            if (personList != null)
            {
                if (this.userPermissions["SeeLevels"])
                {
                    try
                    {
                        foreach (Person historyPerson in personList)
                        {
                            if (this.settings.UseOperDB == true && historyPerson.PersonKey == 0)
                                useOperDB = true;
                            else
                                useOperDB = false;
                            MainQueryParams levelsParams = new MainQueryParams();
                            levelsParams.UseOperDB = useOperDB;
                            levelsParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
                            levelsParams.Levels = historyPerson.LevelId;
                            levelsParams.StartDate = historyPerson.ValidFrom;

                            //historyPerson.Levels = await das.GetLevelsAsync(CancellationToken.None, useOperDB, null, this.settings.ShowFullAccessLevel, historyPerson.LevelId, historyPerson.ValidFrom);
                            historyPerson.Levels = await das.GetLevelsAsync(CancellationToken.None, levelsParams);
                            if (historyPerson.Levels != null)
                                historyPerson.Levels.Sort((x, y) => x.Num.CompareTo(y.Num));

                            levelsParams.Levels = historyPerson.DepartmentLevelId;
                            levelsParams.IsDepartmentLevels = true;
                            //historyPerson.DepartmentLevels = await das.GetLevelsAsync(CancellationToken.None, useOperDB, null, this.settings.ShowFullAccessLevel, historyPerson.DepartmentLevelId, historyPerson.ValidFrom, true);
                            historyPerson.DepartmentLevels = await das.GetLevelsAsync(CancellationToken.None, levelsParams);
                            if (historyPerson.DepartmentLevels != null)
                                historyPerson.DepartmentLevels.Sort((x, y) => x.Num.CompareTo(y.Num));
                        }

                    }
                    catch (Exception ex)
                    {
                        Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                    }
                }

                view = new PersonView();
                view.ViewModel = new PersonViewModel(view, this.das, this.settings, this.userPermissions, personList);
                if(showPersonHistory)
                {
                    view.ViewModel.IsPersonHistoryAvailable = true;                    
                }
                if(isExtendedMode)
                {
                    view.ViewModel.IsExtendedMode = true;
                }
                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                //view.ShowInTaskbar = false;
                Mouse.OverrideCursor = null;
                view.Show();
            }
            //this.isPersonViewShowed = false;
        }

        private async Task showPersonsView(string source)
        {
            this.isPersonsViewShowed = true;
            Mouse.OverrideCursor = Cursors.Wait;
            ListView view = new ListView();
            //PersonsView view = new PersonsView();
            List<Person> personList = null;
            bool isExportEnable = false;
            bool isStatisticHidden = !this.userPermissions["SeeStatistics"];

            MainQueryParams personParams = new MainQueryParams();
            personParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
            personParams.Nc32kId = null;

            if (source == "FromAccessEvents" || source == "FromNotifications")
            {
                personParams.HideTempPersons = true;
            }

            if (source == "FromAccessPoints")
            {
                if (this.currentAccessPoint != null)
                {
                    personParams.Nc32kId = this.currentAccessPoint.Id;
                    //if (this.isMsExcelInstalled && this.userPermissions["ExportData"])
                    if (this.userPermissions["ExportData"])
                        isExportEnable = true;
                }
            }
            personParams.LevelId = null;
            if (source == "FromLevels")
            {
                if (this.currentLevel != null)
                {
                    personParams.LevelId = this.currentLevel.Id;
                }
            }
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {                
                personList = await das.GetPersonsAsync(token, personParams, this.settings.UseOperDB);                
            }
            catch (Exception ex)
            {
                Mouse.OverrideCursor = null;
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

            if (personList != null)
            {
                personList.Sort((x, y) => x.FullName.CompareTo(y.FullName));
                //string personsFilter = this.accessEventsFilter.Persons;
                AppObjectBase[] selectedItems = null; 
                if (source == "FromAccessEvents")
                {                    
                    selectedItems = this.accessEventsFilter.PersonsArray;
                }
                
                
                view.ViewModel = new PersonsViewModel(view, personList, selectedItems, this.das, this.userPermissions, this.settings);
                //view.ViewModel = new PersonsViewModel(view, person_list, this.settings, personsFilter, this.das, this.userPermissions, isExportEnable);
                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                view.ShowInTaskbar = false;
                view.ViewModel.IsSelectableMode = true;
                view.ViewModel.IsFilterListEnable = true;
                view.ViewModel.IsStatisticsHidden = isStatisticHidden;
                Mouse.OverrideCursor = null;
                if (personParams.Nc32kId != null)
                {
                    view.ViewModel.Title = "Сотрудники, имеющие доступ в " + this.currentAccessPoint.Name;
                    view.ViewModel.IsExportEnable = isExportEnable;
                    view.ViewModel.IsSelectableMode = false;
                    view.Show();
                }
                else if (personParams.LevelId != null)
                {
                    view.ViewModel.Title = "Сотрудники, имеющие " + this.currentLevel.Name;
                    if (!String.IsNullOrEmpty(this.currentLevel.Description)) view.ViewModel.Title += " (" + this.currentLevel.Description + ")";
                    view.ViewModel.IsExportEnable = isExportEnable;
                    view.ViewModel.IsSelectableMode = false;
                    view.Show();
                }
                else if (view.ShowDialog() == true)
                {
                    Mouse.OverrideCursor = Cursors.Wait;
                    selectedItems = view.ViewModel.SelectedItems;
                    if (source == "FromAccessEvents")
                    {
                         this.accessEventsFilter.PersonsArray = selectedItems;
                    }
                    else if (source == "FromNotifications")
                    {
                        string persons = "";
                        foreach (Person person in selectedItems)
                        {
                            Notification notification = new Notification(NotificationType.Person, person.Id, person.FullName, "PNET3_NC32K");
                            this.notificationsFilter.Add(notification);
                            persons += "," + person.FullName;
                        }
                        
                        if(persons != "")
                        {
                            persons = StringHelper.RemoveUnnecessaryChars(persons);
                            this.logAuditEvent("others", "add_notifications", this.pcName, null, null,null,null,new DateTime(),persons);
                        }
                    }
                    Mouse.OverrideCursor = null;
                }
                if (view.ViewModel != null)
                {
                    view.ViewModel.Dispose();
                }
            }
            this.isPersonsViewShowed = false;            
        }

        private async Task showAccessPointsView(string source)
        {
            this.isAccessPointsViewShowed = true;
            Mouse.OverrideCursor = Cursors.Wait;
            //bool onlyWorked = true;
            MainQueryParams accessPointsParams = new MainQueryParams();
            //bool isExportEnable;
            if (this.userPermissions["ExportData"])
                //isExportEnable = true;
                accessPointsParams.OnlyWorked = true;
                //string levelId = null;
            if (source == "FromLevels")
            {
                if (this.currentLevel != null)
                {
                    accessPointsParams.LevelId = this.currentLevel.Id;
                }
            }
            else if (source == "FromAccessEvents")
            {
                accessPointsParams.AccessPointsArray = this.accessEventsFilter.AccessPointsArray;                                 
            }
            //else if (source == "FromNotifications")
            //{
                
            //}

            accessPointsParams.UseOperDB = this.settings.UseOperDB;
            accessPointsParams.StartDate = new DateTime(9999, 1, 1);
            //AccessPointsView view = new AccessPointsView();
            ListView view = new ListView();
            List<AccessPoint> accessPointsList = null;
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                //accessPointsList = await das.GetAccessPointsAsync(token, new DateTime(9999, 1, 1), this.settings.UseOperDB, onlyWorked, levelId);
                accessPointsList = await das.GetAccessPointsAsync(token, accessPointsParams);
            }
            catch (Exception ex)
            {
                Mouse.OverrideCursor = null;
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
            Mouse.OverrideCursor = null;
            if (accessPointsList != null)
            {
                accessPointsList.Sort((x, y) => x.Name.CompareTo(y.Name));
                //view.ViewModel = new AccessPointsViewModel(view,
                //                                            this.das,
                //                                            this.userPermissions,
                //                                            access_points_list,
                //                                            this.settings.UseOperDB,
                //                                            selectedAccessPointsString);
                view.ViewModel = new AccessPointsViewModel(view,
                                                            accessPointsList,
                                                            accessPointsParams.AccessPointsArray,
                                                            this.das);
                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                view.ShowInTaskbar = false;
                view.ViewModel.IsSelectableMode = true;
                view.ViewModel.IsStatisticsHidden = !this.userPermissions["SeeStatistics"];

                //если запускаем из вкладки уровней доступа
                //if (levelId != null)
                if (accessPointsParams.LevelId != null)
                {
                    view.ViewModel.Title = "Точки доступа, включенные в " + this.currentLevel.Name;
                    if (!String.IsNullOrEmpty(this.currentLevel.Description)) view.ViewModel.Title += " (" + this.currentLevel.Description + ")";
                    view.ViewModel.IsSelectableMode = false;
                    view.ViewModel.IsExportEnable = true;
                    view.Show();
                }
                else if (view.ShowDialog() == true)
                {
                    Mouse.OverrideCursor = Cursors.Wait;
                    AppObjectBase[] selectedItems = view.ViewModel.SelectedItems;
                    if (source == "FromAccessEvents")
                    {
                        //SortedSet<string> selectedAccessPointsSet = new SortedSet<string>();
                        //foreach (AccessPoint accessPoint in view.ViewModel.SelectedAccessPoints)
                        //{
                        //    selectedAccessPointsSet.Add(accessPoint.Id);
                        //}
                        //selectedAccessPointsString = "";
                        //foreach (string str in selectedAccessPointsSet)
                        //{
                        //    selectedAccessPointsString = selectedAccessPointsString + "," + str;
                        //}
                        //selectedAccessPointsString = StringHelper.RemoveUnnecessaryChars(selectedAccessPointsString);
                        //this.accessEventsFilterAccessPoints = selectedAccessPointsString;
                        //try
                        //{
                        this.accessEventsFilter.AccessPointsArray = selectedItems;
                        this.IsApplyAefAccessPoints = true;
                        //}
                        //catch (Exception ex)
                        //{
                        //    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                        //}

                    }
                    else if (source == "FromNotifications")
                    {
                        string accessPoints = "";
                        if(selectedItems != null)
                        {
                            foreach (AccessPoint accessPoint in selectedItems)
                            {
                                Notification notification = new Notification(NotificationType.AccessPoint, accessPoint.Id);
                                notification.Name = accessPoint.Name;
                                notification.SourceType = "PNET3_NC32K";
                                notification.SourceId = accessPoint.Id;
                                this.notificationsFilter.Add(notification);
                                accessPoints += "," + accessPoint.Id;
                            }
                        }                        
                        if (accessPoints != "")
                        {
                            accessPoints = StringHelper.RemoveUnnecessaryChars(accessPoints);
                            this.logAuditEvent("others", "add_notifications", this.pcName, null,null, accessPoints);
                        }
                    }
                    Mouse.OverrideCursor = null;
                }
                else
                {
                    if (source == "FromAccessEvents")
                    {
                        this.IsApplyAefAccessPoints = false;
                    }  
                }                               
            }
            this.isAccessPointsViewShowed = false;
        }

        private int showChangePasswordDialog()
        {
            this.isChangePasswordViewShowed = true;
            ChangePasswordView changePasswordView = new ChangePasswordView();

            if (this.isMainViewShowed)
            {
                changePasswordView.Icon = null;
                changePasswordView.ShowInTaskbar = false;
                changePasswordView.Owner = Application.Current.MainWindow;
                changePasswordView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                changePasswordView.ViewModel.Title = "Изменение пароля";
            }

            int result = 0;

            if (changePasswordView.ShowDialog().Value == true)
            {
                try
                {
                    CancellationTokenSource CTS = new CancellationTokenSource();
                    CancellationToken token = CTS.Token;

                    startAppTask(AppTaskName.ChangePassword, CTS);
                    //result = await das.ChangePassword(changePasswordView.ViewModel.Password.Copy(), token);
                    das.ChangePassword(changePasswordView.ViewModel.Password.Copy());
                    result = 1;
                    Message.ShowMessage("Пароль успешно изменен!", "Сообщение");
                }
                catch (Exception ex)
                {

                    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                }

            }
            if (changePasswordView != null)
            {
                changePasswordView.ViewModel.Dispose();
                changePasswordView.Close();
            }
            stopAppTask(AppTaskName.ChangePassword);
            this.isChangePasswordViewShowed = false;
            return result;
        }

        private void startAppTask(AppTaskName appTask, CancellationTokenSource tokenSourse)
        {
            //string str_task = appTask.ToString();
            if (!this.runningTasks.ContainsKey(appTask))
            {
                this.runningTasks[appTask] = tokenSourse;
                switch (appTask)
                {
                    case AppTaskName.GetAccessEvents:
                        this.IsGettingAccessEvents = true;
                        break;
                    case AppTaskName.GetPersons:
                        this.IsGettingPersons = true;
                        break;
                    case AppTaskName.GetAccessPoints:
                        this.IsGettingAccessPoints = true;
                        break;
                    case AppTaskName.GetLevels:
                        this.IsGettingLevels = true;
                        break;
                    case AppTaskName.Login:
                        this.isLoginViewShowed = true;
                        break;
                    case AppTaskName.ChangePassword:
                        this.isChangePasswordViewShowed = true;
                        break;
                    case AppTaskName.GetSettings:
                        this.isGettingSettings = true;
                        break;
                }
                Debug.WriteLine("Добавил задачу " + appTask.ToString());
            }
            else Debug.WriteLine("Задача " + appTask.ToString() + " уже добавлена!");  //throw new NotImplementedException();

        }
        private void stopAppTask(AppTaskName appTask)
        {
            //string str_task = appTask.ToString();
            if (this.runningTasks.ContainsKey(appTask))
            {
                if (this.runningTasks[appTask] != null)
                {
                    this.runningTasks[appTask].Cancel();
                    this.runningTasks[appTask].Dispose();
                }
                this.runningTasks.Remove(appTask);
                switch (appTask)
                {
                    case AppTaskName.GetAccessEvents:
                        this.IsGettingAccessEvents = false;
                        break;
                    case AppTaskName.GetPersons:
                        this.IsGettingPersons = false;
                        break;
                    case AppTaskName.GetAccessPoints:
                        this.IsGettingAccessPoints = false;
                        break;
                    case AppTaskName.GetLevels:
                        this.IsGettingLevels = false;
                        break;
                    case AppTaskName.Login:
                        this.isLoginViewShowed = false;
                        break;
                    case AppTaskName.ChangePassword:
                        this.isChangePasswordViewShowed = false;
                        break;
                    case AppTaskName.GetSettings:
                        this.isGettingSettings = false;
                        break;
                }
                Debug.WriteLine("Удалил задачу " + appTask.ToString());
            }
            else Debug.WriteLine("Задача " + appTask.ToString() + " уже удалена!");  //throw new NotImplementedException();
        }

        private void addValueToHistoryList(ObservableCollection<string> list, string value)
        {
            int index = list.IndexOf(value);
            if (index == -1)
            {
                list.Insert(0, value);
                if (list.Count() > historyListDepth)
                {
                    list.RemoveAt(this.aefPersonsHistory.Count - 1);
                }
            }
            else
            {
                if (index != 0) list.Move(index, 0);
            }
        }

        private async Task getAccessEventsAsync()
        {
            
            string str = StringHelper.RemoveUnnecessaryChars(this.accessEventsFilter.Persons);
            this.accessEventsFilter.Persons = str;
            if (str!="") this.addValueToHistoryList(this.aefPersonsHistory, str);

            str = StringHelper.RemoveUnnecessaryChars(this.accessEventsFilter.Departments);
            this.accessEventsFilter.Departments = str;

            MainQueryParams filter = this.accessEventsFilter.Clone() as MainQueryParams;

            if (!this.isApplyAefAccessPoints)
                filter.AccessPoints = null;

            if (!this.isApplyAefEvents)
                filter.Events = null;


            List <ProtocolItem> operDB_protocolList = null;
            List<ProtocolItem> dwDB_protocolList = null;

            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            
            //*
            try
            {
                startAppTask(AppTaskName.GetAccessEvents, CTS);

                if (filter.OnlyLast10EventsForDay == true)
                {
                    filter.StartDate = DateTime.Today;
                    filter.EndDate = DateTime.Today.Add(new TimeSpan(23, 59, 59));
                }

                DateTime now = DateTime.Now;
                TimeSpan timeNow = now.TimeOfDay;
                //filter.EndDate = filter.EndDate.Add(new TimeSpan(23, 59, 59));


                //Debug.WriteLine("----REGION1----");
                //Debug.WriteLine("StartDate: " + filter.StartDate);
                //Debug.WriteLine("EndtDate: " + filter.EndDate);

                //если требуются самые актуальные данные
                if (    (this.settings.UseOperDB == true) 
                     && (filter.EndDate >= now.AddDays(-1)))
                {                    
                    if (filter.StartDate <= now.AddDays(-1))
                    {
                        //получем данные из хранилища данных за вычетом суток

                        filter.EndDate = now.Date.AddDays(-1).Add(timeNow);
                        dwDB_protocolList = await das.GetAccessEventsAsync(token, filter, false, this.pcName);

                        filter.StartDate = now.Date.AddDays(-1).Add(timeNow);
                        //filter.EndDate = now.Date.AddDays(1).Add(new TimeSpan(23, 59, 59));
                        filter.EndDate = this.accessEventsFilter.EndDate;
                        
                    }
                    //получаем данные из оперативной базы за последние сутки 
                    operDB_protocolList = await das.GetAccessEventsAsync(token, filter,  true, this.pcName);
                }
                else
                {
                    //получем данные только из хранилища данных
                    dwDB_protocolList = await das.GetAccessEventsAsync(token, filter, false, this.pcName);
                }


                bool rowCountLimitExceeded = false;
                if (dwDB_protocolList != null)
                {
                    if (dwDB_protocolList.Count == this.settings.RowsCountLimit)
                        rowCountLimitExceeded = true;
                }
                if (operDB_protocolList != null)
                {
                    if (operDB_protocolList.Count == this.settings.RowsCountLimit)
                        rowCountLimitExceeded = true;
                }

                if(rowCountLimitExceeded)
                {
                    Message.ShowExclamation("Результат ограничен допустимым пределом количеcтва строк."
                                            + " Для получения всех данных, попробуйте уменьшить диапазон даты"
                                            + ", или добавить в запрос фильтры.", "Внимание",this.view);
                }


                this.AccessEvents = null;
                if (dwDB_protocolList != null)
                {
                    if (operDB_protocolList != null)
                    {
                        dwDB_protocolList.AddRange(operDB_protocolList);
                    }
                    this.AccessEvents = dwDB_protocolList;
                }
                else if (operDB_protocolList != null)
                {
                    this.AccessEvents = operDB_protocolList;
                }                

                //stopAppTask(AppTaskName.GetAccessEvents);
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    //stopAppTask(AppTaskName.GetAccessEvents);
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }
            finally
            {
                stopAppTask(AppTaskName.GetAccessEvents);
                //this.IsGettingAccessEvents = false;                
                //raiseCanExecuteChanged();
            }
            //*/
            //this.RowsCount = this.accessEvents == null ? 0 : this.accessEvents.Count;
        }

        private async Task getPersonsAsync()
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;

            try
            {
                this.IsGettingPersons = true;
                startAppTask(AppTaskName.GetPersons, CTS);
                this.Persons = await das.GetPersonsAsync(token, this.personsFilter, this.settings.UseOperDB);
                List<string> departments = new List<string>();
                if (this.persons != null)
                {                    
                    departments.Add("Все отделы");
                    //List<string> departments2 = this.persons.Select(o => o.Department).Distinct().OrderBy(q => q).ToList();
                    departments.AddRange(this.persons.Select(o => o.Department).Distinct().OrderBy(q => q).ToList());                    
                }
                this.Departments = departments;
                //Искуственная задержка!!!
                //await Task.Delay(TimeSpan.FromSeconds(10), token);
                stopAppTask(AppTaskName.GetPersons);
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }
            finally
            {
                stopAppTask(AppTaskName.GetPersons);
                this.IsGettingPersons = false;
                raiseCanExecuteChanged();
            }
            //this.RowsCount = this.persons == null ? 0 : this.persons.Count;
        }

        private async Task getAccessPointsAsync()
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                startAppTask(AppTaskName.GetAccessPoints, CTS);
                MainQueryParams accessPointsParams = this.accessPointsFilter;
                accessPointsParams.StartDate = new DateTime(9999, 1, 1);
                accessPointsParams.UseOperDB = this.settings.UseOperDB;
                accessPointsParams.OnlyWorked = true;
                List<AccessPoint> list = await das.GetAccessPointsAsync(token, accessPointsParams);
                list.Sort((x, y) => x.Name.CompareTo(y.Name));
                this.AccessPoints = list;
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }
            finally
            {
                stopAppTask(AppTaskName.GetAccessPoints);
                //raiseCanExecuteChanged();
            }
            //this.RowsCount = this.accessPoints == null ? 0 : this.accessPoints.Count;
        }

        private async Task getLevelsAsync()
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                startAppTask(AppTaskName.GetLevels, CTS);
                //Искуственная задержка!!!

                MainQueryParams levelsParams = this.levelsFilter;
                levelsParams.UseOperDB = this.settings.UseOperDB;
                levelsParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
                levelsParams.StartDate = new DateTime(1753, 01, 01);

                //levels = await das.GetLevelsAsync(token, this.settings.UseOperDB, null, this.settings.ShowFullAccessLevel,null, new DateTime(1753, 01, 01));
                levels = await das.GetLevelsAsync(token, levelsParams);
                //levels.Sort((x, y) => x.Num.CompareTo(y.Num));
                if (levels != null)
                {
                    levels = levels.OrderBy(l => l.Num).ThenBy(l => l.Name).ToList();
                }                
                this.Levels = levels;                
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }
            finally
            {
                stopAppTask(AppTaskName.GetLevels);
                //raiseCanExecuteChanged();
            }
            //this.RowsCount = this.levels == null ? 0 : this.levels.Count;
        }

        private async void logAuditEvent(string audit_group, string audit_action, 
                                         string computer_name = null, string appBuild = null, 
                                         string extension = null, string access_points = null,
                                         string cams = null, DateTime cam_date = new DateTime(), string persons = null)
        {
            try
            {
                //startAppTask(AppTaskName.GetAccessEvents, CTS);

                await das.LogAuditEventAsync(CancellationToken.None, audit_group, audit_action, computer_name, appBuild, extension
                                             ,access_points, cams, cam_date, persons);
                //stopAppTask(AppTaskName.GetAccessEvents);
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    //stopAppTask(AppTaskName.GetAccessEvents);
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }
            finally
            {

                //raiseCanExecuteChanged();
            }
        }        

        #endregion

        #region Properties

        public Boolean UserIsSecurityAdmin
        {
            get { return this.userIsSecurityAdmin; }
            set
            {
                this.userIsSecurityAdmin = value;
                this.OnPropertyChanged("UserIsSecurityAdmin");
                raiseCanExecuteChanged();
            }
        }
        public Permissions UserPermissions
        {
            get { return this.userPermissions; }
            set 
            {
                this.userPermissions = value;
                this.OnPropertyChanged("UserPermissions");
                raiseCanExecuteChanged();
            }
        }

        public string Title
        {
            get 
            {
                if (this.currentUserLogin != null)
                {
                    return this.title + " - " + this.CurrentUserLogin;
                }
                return this.title;
            }
            set
            {
                this.title = value;
                this.OnPropertyChanged("Title");
            }
        }
        public string CurrentUserLogin
        {
            get { return this.currentUserLogin; }
            set
            {
                this.currentUserLogin = value;
                this.OnPropertyChanged("CurrentUserLogin");
            }
        }

        public string IidkStatus
        {
            get { return this.iidkStatus; }
            set
            {
                this.iidkStatus = value;
                this.OnPropertyChanged("IidkStatus");
            }
        }

        public bool IsGettingAccessEvents
        {
            get { return this.isGettingAccessEvents; }
            set
            {
                this.isGettingAccessEvents = value;
                this.OnPropertyChanged("IsGettingAccessEvents");
                raiseCanExecuteChanged();
            }
        }

        public bool IsGettingPersons
        {
            get { return this.isGettingPersons; }
            set
            {
                this.isGettingPersons = value;
                this.OnPropertyChanged("IsGettingPersons");
                raiseCanExecuteChanged();
            }
        }

        public bool IsGettingAccessPoints
        {
            get { return this.isGettingAccessPoints; }
            set
            {
                this.isGettingAccessPoints = value;
                this.OnPropertyChanged("IsGettingAccessPoints");
                raiseCanExecuteChanged();
            }
        }

        public bool IsGettingLevels
        {
            get { return this.isGettingLevels; }
            set
            {
                this.isGettingLevels = value;
                this.OnPropertyChanged("IsGettingLevels");
                raiseCanExecuteChanged();
            }
        }

        public bool IsUpdating
        {
            get { return this.isUpdating; }
            set
            {
                this.isUpdating = value;
                this.OnPropertyChanged("IsUpdating");
                raiseCanExecuteChanged();
            }
        }

        public string CurrentTask
        {
            set
            {
                switch (value)
                {
                    case "AccessEvents":
                        this.currentTask = AppTaskName.GetAccessEvents;                        
                        break;
                    case "Persons":
                        this.currentTask = AppTaskName.GetPersons;                        
                        break;
                    case "AccessPoints":
                        this.currentTask = AppTaskName.GetAccessPoints;                        
                        break;
                    case "Levels":
                        this.currentTask = AppTaskName.GetLevels;                        
                        break;
                    case "Notifications":
                        this.currentTask = AppTaskName.Notifications;                        
                        break;
                    default:
                        this.currentTask = null;
                        break;
                }
                raiseCanExecuteChanged();
            }
        }

        public MainQueryParams AccessEventsFilter
        {
            get { return this.accessEventsFilter; }
            set
            {
                this.accessEventsFilter = value;
            }
        }

        public MainQueryParams PersonsFilter
        {
            get { return this.personsFilter; }
            set
            {
                this.personsFilter = value;
            }
        }

        public MainQueryParams AccessPointsFilter
        {
            get { return this.accessPointsFilter; }
            set
            {
                this.accessPointsFilter = value;
            }
        }
        public MainQueryParams LevelsFilter
        {
            get { return this.levelsFilter; }
            set
            {
                this.levelsFilter = value;
            }
        }

        public List<ProtocolItem> AccessEvents
        {
            get { return this.accessEvents; }
            set
            {
                this.accessEvents = value;
                if (this.accessEvents != null)
                {
                    if (this.accessEvents.Count == 0)
                        this.accessEvents = null;
                    else
                        this.accessEvents.Sort((x, y) => x.Date.CompareTo(y.Date));
                }
                this.OnPropertyChanged("AccessEvents");
            }
        }

        public List<Person> Persons
        {
            get { return this.persons; }
            set
            {
                this.persons = value;
                if (this.persons != null)
                {
                    if (this.persons.Count == 0)
                        this.persons = null;
                    else
                    {
                        //this.persons.Sort((x, y) => x.FullName.CompareTo(y.FullName));
                        this.persons = this.persons.OrderBy(p => p.FullName).ThenBy(p => p.ValidFrom).ToList();                        
                    }
                }
                this.OnPropertyChanged("Persons");
            }
        }

        public ObservableCollection<string> AefPersonsHistory
        {
            get { return this.aefPersonsHistory; }
            set
            {
                this.aefPersonsHistory = value;
                this.OnPropertyChanged("AefPersonsHistory");
            }
        }

        public List<AccessPoint> AccessPoints
        {
            get { return this.accessPoints; }
            set
            {
                this.accessPoints = value;
                this.OnPropertyChanged("AccessPoints");
            }
        }

        public List<Level> Levels
        {
            get { return this.levels; }
            set
            {
                this.levels = value;
                this.OnPropertyChanged("Levels");
            }
        }

        public List<string> Departments
        {
            get { return this.departments; }
            set
            {
                this.departments = value;
                this.OnPropertyChanged("Departments");
            }
        }

        public ProtocolItem CurrentProtocolItem
        {
            get { return this.currentProtocolItem; }
            set
            {
                this.currentProtocolItem = value;
                this.OnPropertyChanged("CurrentProtocolItem");
            }
        }
        public Level CurrentLevel
        {
            get { return this.currentLevel; }
            set
            {
                this.currentLevel = value;
                this.OnPropertyChanged("CurrentLevel");
            }
        }

        public Person CurrentPerson
        {
            get { return this.currentPerson; }
            set
            {
                this.currentPerson = value;
                this.OnPropertyChanged("CurrentPerson");
            }
        }

        public AccessPoint CurrentAccessPoint
        {
            get { return this.currentAccessPoint; }
            set
            {
                this.currentAccessPoint = value;
                this.OnPropertyChanged("CurrentAccessPoint");
            }
        }

        public SettingsViewModel Settings
        {
            get { return this.settings; }
            set
            {
                this.settings = value;
                //this.IsOperDatabaseUsed = value.UseOperDB;
                this.OnPropertyChanged("Settings");
                this.OnPropertyChanged("IsIidkEnabled");
                this.OnPropertyChanged("IsIidkDebugEnabled");
                this.notificationsManager.AppSettings = this.settings;
            }
        }

        public bool CanCloseApplication
        {
            get 
            { 
                return (this.runningTasks.Count == 0); 
            }
            
        }

        public bool IsCardConverterShowed
        {
            get { return this.isCardConverterViewShowed; }
            set
            {
                this.isCardConverterViewShowed = value;
                this.OnPropertyChanged("IsCardConverterShowed");
            }
        }

        public bool IsApplyAefAccessPoints
        {
            get { return this.isApplyAefAccessPoints; }
            set
            {
                this.isApplyAefAccessPoints = value;
                this.OnPropertyChanged("IsApplyAefAccessPoints");
            }
        }

        public bool IsApplyAefEvents
        {
            get { return this.isApplyAefEvents; } 
            set
            {
                this.isApplyAefEvents = value;
                this.OnPropertyChanged("IsApplyAefEvents");
            }
        }

        //public bool IsOperDatabaseUsed
        //{
        //    get { return this.isOperDatabaseUsed; }
        //    set
        //    {
        //        this.isOperDatabaseUsed = value;
        //        this.OnPropertyChanged("IsOperDatabaseUsed");
        //    }
        //}
        public bool IsIidkEnabled
        {
            get
            {
                if (this.settings == null) return false;
                if (this.settings.IidkHostIp == null) return false;
                if (this.settings.SettingsFromDB == null) return false;
                if (String.IsNullOrEmpty(this.settings.SettingsFromDB.HostName)) return false;
                if (String.IsNullOrEmpty(this.settings.SettingsFromDB.IidkManagedSlave)) return false;
                if (!this.settings.SettingsFromDB.IsIidkEnable)
                {
                    return false;
                }
                else
                {
                    return true; 
                }                
            }            
        }
        public bool IsIidkDebugEnabled
        {
            get
            {
                if (!this.IsIidkEnabled) return false;
                if (!this.userPermissions["RunIidkDebug"])
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }
        public bool IsIidkConnected
        {
            get { return this.isIidkConnected; }
            set
            {
                this.isIidkConnected = value;
                this.OnPropertyChanged("IsIidkConnected");
            }
        }
        //public bool IsIidkLinkLost
        //{
        //    get { return this.isIidkLinkLost; }
        //    set
        //    {
        //        this.isIidkLinkLost = value;
        //        this.OnPropertyChanged("IsIidkLinkLost");
        //    }
        //}

        //public int RowsCount
        //{
        //    get { return this.rowsCount; }
        //    set
        //    {
        //        this.rowsCount = value;
        //        this.OnPropertyChanged("RowsCount");
        //    }
        //}
        public NotificationsManager NotificationsManager
        {
            get { return this.notificationsManager; }
            //set { this.notificationsManager = value; }
        }

        public Notification CurrentNotification
        {
            get { return this.currentNotification; }
            set
            {
                this.currentNotification = value;
                this.OnPropertyChanged("CurrentNotification");
            }
        }

        #endregion

        #region Public Methods         

        #endregion

        #region Protected Methods
        protected void onCloseIidkView()
        {
            this.isIidkDebugViewShowed = false;
            raiseCanExecuteChanged();
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            if(this.notificationsManager != null)
            {
                this.notificationsManager.Dispose();
            }
            if (this.das != null)
            {
                this.das.ServiceDispose();
            }
            this.destroyIidkAgent();        
        }
        #endregion

        #region Commands
        public ICommand RunQueryCommand
        {
            get
            {
                if (this.runTaskCommand == null)
                {
                    this.runTaskCommand = new RelayCommand(executeRunTaskCommand, canExecuteRunTaskCommand);
                    
                }
                return this.runTaskCommand;
            }
        }

        public ICommand CancelQueryCommand
        {
            get
            {
                if (this.cancelTaskCommand == null)
                {
                    this.cancelTaskCommand = new RelayCommand(executeCancelTaskCommand, canExecuteCancelTaskCommand);
                }
                return this.cancelTaskCommand;
            }
        }
        public ICommand LoginCommand
        {
            get
            {
                if (this.loginCommand == null)
                {
                    this.loginCommand = new RelayCommand(executeLoginCommand, canExecuteLoginCommand);
                }
                return this.loginCommand;
            }
        }

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

        public ICommand UpdateCommand
        {
            get
            {
                if (this.updateCommand == null)
                {
                    this.updateCommand = new RelayCommand(executeUpdateCommand, canExecuteUpdateCommand);
                }
                return this.updateCommand;
            }
        }        

        public ICommand AboutCommand
        {
            get
            {
                if (this.aboutCommand == null)
                {
                    this.aboutCommand = new RelayCommand(executeAboutCommand, canExecuteAboutCommand);
                }
                return this.aboutCommand;
            }
        }
        public ICommand CloseCommand
        {
            get
            {
                if (this.closeCommand == null)
                {
                    this.closeCommand = new RelayCommand(executeCloseCommand, canExecuteCloseCommand);
                }
                return this.closeCommand;
            }
        }

        public ICommand CardConverterCommand
        {
            get
            {
                if (this.cardConverterCommand == null)
                {
                    this.cardConverterCommand = new RelayCommand(executeCardConverterCommand);//, canExecuteCardConverterCommand);
                }
                return this.cardConverterCommand;
            }
        }

        public ICommand ShowUsersViewCommand
        {
            get
            {
                if (this.showUsersViewCommand == null)
                {
                    this.showUsersViewCommand = new RelayCommand(executeShowUsersViewCommand);//, canExecuteCardConverterCommand);
                }
                return this.showUsersViewCommand;
            }
        }

        public ICommand ShowSettingsViewCommand
        {
            get
            {
                if (this.showSettingsViewCommand == null)
                {
                    this.showSettingsViewCommand = new RelayCommand(executeShowSettingsViewCommand);
                }
                return this.showSettingsViewCommand;
            }
        }

        public ICommand ShowPersonsViewCommand
        {
            get
            {
                if (this.showPersonsViewCommand == null)
                {
                    this.showPersonsViewCommand = new RelayCommand(executeShowPersonsViewCommand, canExecuteShowPersonsViewCommand);
                }
                return this.showPersonsViewCommand;
            }
        }

        public ICommand ShowInfoCommand
        {
            get
            {
                if (this.showInfoCommand == null)
                {
                    this.showInfoCommand = new RelayCommand(executeShowInfoCommand, canExecuteShowInfoCommand);
                }
                return this.showInfoCommand;
            }
        }

        public ICommand ShowLevelsViewCommand
        {
            get
            {
                if (this.showLevelsViewCommand == null)
                {
                    this.showLevelsViewCommand = new RelayCommand(executeShowLevelsViewCommand, canExecuteShowLevelsViewCommand);
                }
                return this.showLevelsViewCommand;
            }
        }
        public ICommand ShowLevelViewCommand
        {
            get
            {
                if (this.showLevelViewCommand == null)
                {
                    this.showLevelViewCommand = new RelayCommand(executeShowLevelViewCommand, canExecuteShowLevelViewCommand);
                }
                return this.showLevelViewCommand;
            }
        }

        public ICommand ShowAccessPointsViewCommand
        {
            get
            {
                if (this.showAccessPointsViewCommand == null)
                {
                    this.showAccessPointsViewCommand = new RelayCommand(executeShowAccessPointsViewCommand, canExecuteShowAccessPointsViewCommand);
                }
                return this.showAccessPointsViewCommand;
            }
        }

        public ICommand ShowEventsViewCommand
        {
            get
            {
                if (this.showEventsViewCommand == null)
                {
                    this.showEventsViewCommand = new RelayCommand(executeShowEventsViewCommand, canExecuteShowEventsViewCommand);
                }
                return this.showEventsViewCommand;
            }
        }

        public ICommand ShowDepartmentsViewCommand
        {
            get
            {
                if (this.showDepartmentsViewCommand == null)
                {
                    this.showDepartmentsViewCommand = new RelayCommand(executeShowDepartmentsViewCommand, canExecuteShowDepartmentsViewCommand);
                }
                return this.showDepartmentsViewCommand;
            }
        }
        public ICommand ShowIidkDebugViewCommand
        {
            get
            {
                if (this.showIidkDebugViewCommand == null)
                {
                    this.showIidkDebugViewCommand = new RelayCommand(executeShowIidkDebugViewCommand, canExecuteShowIidkDebugViewCommand);
                }
                return this.showIidkDebugViewCommand;
            }
        }

        public ICommand ExportToMSExcelCommand
        {
            get
            {
                if (this.exportToMSExcelCommand == null)
                {
                    this.exportToMSExcelCommand = new RelayCommand(executeExportToMSExcelCommand, canExecuteExportToMSExcelCommandCommand);
                }
                return this.exportToMSExcelCommand;
            }
        }
        public ICommand IidkShowObjectOnMapCommand
        {
            get
            {
                if (this.iidkShowObjectOnMapCommand == null)
                {
                    this.iidkShowObjectOnMapCommand = new RelayCommand(executeIidkShowObjectOnMapCommand, canExecuteIidkShowObjectOnMapCommand);
                }
                return this.iidkShowObjectOnMapCommand;
            }
        }

        public ICommand IidkShowEventOnCamCommand
        {
            get
            {
                if (this.iidkShowEventOnCamCommand == null)
                {
                    this.iidkShowEventOnCamCommand = new RelayCommand(executeIidkShowEventOnCamCommand, canExecuteIidkShowEventOnCamCommand);
                }
                return this.iidkShowEventOnCamCommand;
            }
        }

        public ICommand AddNotificationsCommand
        {
            get
            {
                if (this.addNotificationsCommand == null)
                {
                    this.addNotificationsCommand = new RelayCommand(executeAddNotificationsCommand, canExecuteAddNotificationsCommand);
                }
                return this.addNotificationsCommand;
            }
        }
               
        public ICommand RemoveNotificationCommand
        {
            get
            {
                if (this.removeNotificationCommand == null)
                {
                    this.removeNotificationCommand = new RelayCommand(executeRemoveNotificationCommand, canExecuteRemoveNotificationCommand);
                }
                return this.removeNotificationCommand;
            }
        }


        public ICommand RemoveAllNotificationsCommand
        {
            get
            {
                if (this.removeAllNotificationsCommand == null)
                {
                    this.removeAllNotificationsCommand = new RelayCommand(executeRemoveAllNotificationsCommand, canExecuteRemoveAllNotificationsCommand);
                }
                return this.removeAllNotificationsCommand;
            }
        }
        public ICommand ExportNotificationsCommand
        {
            get
            {
                if (this.exportNotificationsCommand == null)
                {
                    this.exportNotificationsCommand = new RelayCommand(executeExportNotificationsCommand, canExecuteExportNotificationsCommand);
                }
                return this.exportNotificationsCommand;
            }
        }
        public ICommand ImportNotificationsCommand
        {
            get
            {
                if (this.importNotificationsCommand == null)
                {
                    this.importNotificationsCommand = new RelayCommand(executeImportNotificationsCommand, canExecuteImportNotificationsCommand);
                }
                return this.importNotificationsCommand;
            }
        }

        public ICommand ConfirmAllNotificationsCommand
        {
            get
            {
                if (this.confirmAllNotificationsCommand == null)
                {
                    this.confirmAllNotificationsCommand = new RelayCommand(executeConfirmAllNotificationsCommand, canExecuteConfirmAllNotificationsCommand);
                }
                return this.confirmAllNotificationsCommand;
            }
        }

        #endregion

        #region Helper Methods

        private bool canExecuteConfirmAllNotificationsCommand(object obj)
        {
            return this.notificationsManager.UnconfirmedCount > 0;
        }
        private void executeConfirmAllNotificationsCommand(object obj)
        {
            //MessageBoxResult result = Message.ShowDialogExclamation("Подтвердить все тревоги?!", "Подтверждение",this.view);
            //if (result == MessageBoxResult.Yes)
            //{
                this.notificationsManager.ConfirmAll();
            //}
        }
        private bool canExecuteImportNotificationsCommand(object obj)
        {
            return !this.isImportNotificationsExecuted;
        }
        private async void executeImportNotificationsCommand(object obj)
        {
            if (this.isImportNotificationsExecuted) return;
            this.isImportNotificationsExecuted = true;
            try
            {
                OpenFileDialog dlg = new OpenFileDialog();
                //dlg.FileName = "Оповещения"; // Default file name
                //dlg.DefaultExt = ".txt"; // Default file extension
                dlg.Filter = "(*.xml)|*.xml|All files(*.*)|*.*";

                // Show save file dialog box
                Nullable<bool> result = dlg.ShowDialog();

                // Process save file dialog box results
                if (result == true)
                {
                    Notification[] notifications = this.notificationsManager.GetNotificationsFromFile(dlg.FileName);
                    if(notifications == null || notifications.Count() == 0)
                    {
                        Message.ShowError("Список оповещений пустой", "Ошибка", this.view);
                        this.isImportNotificationsExecuted = false;
                        return;
                    }

                    MainQueryParams personParams = new MainQueryParams();
                    personParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
                    personParams.Nc32kId = null;
                    personParams.HideTempPersons = true;
                    personParams.LevelId = null;

                    string persons = "";
                    List<Person> personList;
                    Dictionary<string, Person> personsDic = new Dictionary<string, Person>();
                    Mouse.OverrideCursor = Cursors.Wait;
                    personList = await das.GetPersonsAsync(CancellationToken.None, personParams, this.settings.UseOperDB);
                    
                    string accessPoints = "";
                    List<AccessPoint> accessPointsList;
                    Dictionary<string, AccessPoint> accessPointsDic = new Dictionary<string, AccessPoint>();

                    //accessPointsList = await das.GetAccessPointsAsync(CancellationToken.None, new DateTime(9999, 1, 1), this.settings.UseOperDB, true, null);
                    MainQueryParams accessPointsParams = new MainQueryParams();
                    accessPointsParams.StartDate = new DateTime(9999, 1, 1);
                    accessPointsParams.UseOperDB = this.settings.UseOperDB;
                    accessPointsParams.OnlyWorked = true;
                    accessPointsList = await das.GetAccessPointsAsync(CancellationToken.None, accessPointsParams);
                    if (personList != null)
                    {                        
                        foreach(Person person in personList)
                        {
                            personsDic[person.Id] = person;
                        }
                        
                    }                    
                    if(accessPointsList != null && accessPointsList.Count != 0)
                    {                        
                        foreach (AccessPoint accessPoint in accessPointsList)
                        {
                            accessPointsDic[accessPoint.Id] = accessPoint;
                        }                        
                    }
                    foreach (Notification notification in notifications)
                    {
                        if (notification.Type == NotificationType.Person)
                        {
                            if (personsDic.ContainsKey(notification.Id))
                            {
                                notification.Name = personsDic[notification.Id].FullName;
                                persons += "," + notification.Name;
                            }
                        }
                        else if(notification.Type == NotificationType.AccessPoint)
                        {
                            if (accessPointsDic.ContainsKey(notification.Id))
                            {
                                notification.Name = accessPointsDic[notification.Id].Name;
                            }
                            accessPoints += "," + notification.Id;
                        }
                    }
                    persons = StringHelper.RemoveUnnecessaryChars(persons);
                    accessPoints = StringHelper.RemoveUnnecessaryChars(accessPoints);

                    this.notificationsManager.AccessPoints = accessPointsList;
                    List<Notification> notificationsList = new List<Notification>(notifications);
                    this.notificationsManager.RemoveAll();
                    this.notificationsManager.Add(notificationsList);
                    this.logAuditEvent("others", "add_notifications", this.pcName, null, null,
                                        accessPoints == "" ? null : accessPoints, null, new DateTime(), persons == "" ? null : persons);
                    Mouse.OverrideCursor = null;
                }
            }
            catch (Exception ex)
            {
                Mouse.OverrideCursor = null;
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
            this.isImportNotificationsExecuted = false;            
        }
        private bool canExecuteExportNotificationsCommand(object obj)
        {
            return this.NotificationsManager.Count > 0;
        }
        private void executeExportNotificationsCommand(object obj)
        {
            try
            {
                SaveFileDialog saveDialog = new SaveFileDialog();
                saveDialog.FileName = "Оповещения";
                saveDialog.OverwritePrompt = true;
                saveDialog.Filter = "(*.xml)|*.xml|All files(*.*)|*.*";
                if (saveDialog.ShowDialog() == true)
                {
                    //this.logAuditEvent("others", "export_photo", null, null, "person_name=" + personName);
                    //File.WriteAllBytes(saveDialog.FileName, imageArray);
                    this.NotificationsManager.SaveNotificationsToFile(saveDialog.FileName);
                    //Message.ShowMessage("Файл успешно сохранен", "Информация", this.view);
                }
                //this.view.Owner.Activate();                        
            }
            catch (Exception ex)
            {
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
        }
        private bool canExecuteAddNotificationsCommand(object obj)
        {
            return this.canExecuteShowPersonsViewCommand(null);
        }
        private async void executeAddNotificationsCommand(object obj)
        {
            NotificationSelector view = new NotificationSelector();
            NotificationSelectorViewModel viewModel = new NotificationSelectorViewModel(view);
            view.ViewModel = viewModel;
            view.Owner = this.view;
            view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            view.ShowInTaskbar = false;
            if(view.ShowDialog()==true)
            {
                this.notificationsFilter.Clear();
                switch (viewModel.NotificationType)
                {
                    case NotificationType.Person:
                        await this.showPersonsView("FromNotifications");
                        break;
                    case NotificationType.AccessPoint:
                        await this.showAccessPointsView("FromNotifications");
                        break;
                }
                if (this.notificationsFilter.Count != 0)
                {
                    try
                    {
                        Mouse.OverrideCursor = Cursors.Wait;
                        MainQueryParams accessPointsParams = new MainQueryParams();
                        accessPointsParams.StartDate = new DateTime(9999, 1, 1);
                        accessPointsParams.UseOperDB = this.settings.UseOperDB;
                        accessPointsParams.OnlyWorked = false;
                        this.notificationsManager.AccessPoints = await das.GetAccessPointsAsync(CancellationToken.None, accessPointsParams);
                        this.notificationsManager.Add(this.notificationsFilter);
                        Mouse.OverrideCursor = null;
                    }
                    catch (Exception e)
                    {
                        Mouse.OverrideCursor = null;
                        Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                    }                                        
                }
            }                
        }
        private bool canExecuteRemoveNotificationCommand(object obj)
        {
            if (this.currentNotification == null) return false;
            return this.notificationsManager.Count > 0;
        }
        private void executeRemoveNotificationCommand(object obj)
        {
            MessageBoxResult result = Message.ShowDialogExclamation("Удалить оповещение " + currentNotification.Name + "?", "Подтверждение");
            if (result == MessageBoxResult.Yes)
            {
                this.notificationsManager.Remove(this.currentNotification);
            }
        }
        private bool canExecuteRemoveAllNotificationsCommand(object obj)
        {
            return this.notificationsManager.Count > 0;
        }
        private void executeRemoveAllNotificationsCommand(object obj)
        {
            MessageBoxResult result = Message.ShowDialogExclamation("Удалить все оповещения?!", "Подтверждение", this.view);
            if (result == MessageBoxResult.Yes)
            {
                this.notificationsManager.RemoveAll();
            }
        }
        private bool canExecuteIidkCommand()
        {
            if (!this.IsIidkEnabled) return false;
            if (this.intellectAgent == null) return false;
            if (!this.intellectAgent.IsConnected) return false;
            
            return true;
        }
        private bool canExecuteIidkShowEventOnCamCommand(object obj)
        {
            if (!this.canExecuteIidkCommand()) return false;
            if (String.IsNullOrEmpty(this.settings.SettingsFromDB.IidkMonitor)) return false;
            if (this.currentTask != null)
            {
                switch (this.currentTask)
                {
                    case AppTaskName.GetAccessEvents:
                        if (this.currentProtocolItem != null)
                        {
                            if (!String.IsNullOrEmpty(this.currentProtocolItem.Nc32kId))
                            {
                                return true;
                            }
                        }
                        break;
                    case AppTaskName.Notifications:
                        if (this.currentNotification != null)
                        {
                            if (String.IsNullOrEmpty(this.currentNotification.SourceType))
                                return false;
                            if (String.IsNullOrEmpty(this.currentNotification.SourceId))
                                return false;
                            if (this.currentNotification.Date == new DateTime())
                                return false;
                            return true;                            
                        }
                        break;
                }
            }
            return false;
        }
        private  void executeIidkShowEventOnCamCommand(object obj)
        {
            if (this.currentTask != null)
            {
                switch (this.currentTask)
                {
                    case AppTaskName.GetAccessEvents:
                        if (this.currentProtocolItem != null)
                        {
                            if (!String.IsNullOrEmpty(this.currentProtocolItem.Nc32kId))
                            {                              

                                this.intellectAgent.ShowEventOnMonitor(this.currentProtocolItem.Date, this.settings.SettingsFromDB.IidkMonitor, 
                                                                  "PNET3_NC32K", this.currentProtocolItem.Nc32kId,
                                                                   this.settings.SettingsFromDB.IidkManagedSlave);
                                this.logAuditEvent("video", "video_play", this.pcName, null, "IIDK", this.currentProtocolItem.Nc32kId,null, this.currentProtocolItem.Date);
                            }
                        }
                        break;
                    case AppTaskName.Notifications:
                        if (this.currentNotification != null)
                        {
                                this.intellectAgent.ShowEventOnMonitor(this.currentNotification.Date, this.settings.SettingsFromDB.IidkMonitor,
                                                                  this.currentNotification.SourceType, this.currentNotification.SourceId,
                                                                   this.settings.SettingsFromDB.IidkManagedSlave);
                                this.logAuditEvent("video", "video_play", this.pcName, null, "IIDK", this.currentNotification.SourceId, null, this.currentNotification.Date);
                            
                        }
                        break;
                }
            }            
        }
        private bool canExecuteIidkShowObjectOnMapCommand(object obj)
        {
            if (!this.canExecuteIidkCommand()) return false;
            if (String.IsNullOrEmpty(this.settings.SettingsFromDB.IidkMap)) return false;
            if (this.currentTask != null)
            {
                switch (this.currentTask)
                {
                    case AppTaskName.GetAccessEvents:
                        if (this.currentProtocolItem != null)
                        {
                            if (!String.IsNullOrEmpty(this.currentProtocolItem.Nc32kId))
                            {
                                return true;
                            }
                        }
                        break;
                    case AppTaskName.GetAccessPoints:
                        if (this.currentAccessPoint != null)
                        {
                            return true;
                        }
                        break;
                    case AppTaskName.Notifications:
                        if (this.currentNotification != null)
                        {
                            if (String.IsNullOrEmpty(this.currentNotification.SourceType))
                                return false;
                            if (String.IsNullOrEmpty(this.currentNotification.SourceId))
                                return false;
                            return true;                            
                        }
                        break;
                }
            }
            return false;           
        }
        private void executeIidkShowObjectOnMapCommand(object obj)
        {
            if (this.currentTask != null)
            {
                switch (this.currentTask)
                {
                    case AppTaskName.GetAccessEvents:
                        if (this.currentProtocolItem != null)
                        {
                            if (!String.IsNullOrEmpty(this.currentProtocolItem.Nc32kId))
                            {
                                this.intellectAgent.ShowObjectOnMap(this.settings.SettingsFromDB.IidkMap, "PNET3_NC32K",
                                                               this.currentProtocolItem.Nc32kId, this.settings.SettingsFromDB.IidkManagedSlave);
                            }
                        }
                        break;
                    case AppTaskName.GetAccessPoints:
                        if (this.currentAccessPoint != null)
                        {
                            this.intellectAgent.ShowObjectOnMap(this.settings.SettingsFromDB.IidkMap, "PNET3_NC32K",
                                                           this.currentAccessPoint.Id, this.settings.SettingsFromDB.IidkManagedSlave);                           
                        }
                        break;
                    case AppTaskName.Notifications:
                        if (this.currentNotification != null)
                        {
                            this.intellectAgent.ShowObjectOnMap(this.settings.SettingsFromDB.IidkMap, this.currentNotification.SourceType,
                                                           this.currentNotification.SourceId, this.settings.SettingsFromDB.IidkManagedSlave);
                        }
                        break;
                }
            }
        }
        private bool canExecuteShowIidkDebugViewCommand(object obj)
        {
            return !this.isIidkDebugViewShowed;
        }
        private void executeShowIidkDebugViewCommand(object obj)
        {
            if(!this.isIidkDebugViewShowed)
            {
                this.isIidkDebugViewShowed = true;
                raiseCanExecuteChanged();
                this.iidkDebugView = new IidkDebugView(onCloseIidkView);
                this.iidkDebugView.ViewModel = new IidkDebugViewModel(this.iidkDebugView, this.intellectAgent);
                this.iidkDebugView.Owner = this.view;
                this.iidkDebugView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                this.iidkDebugView.ShowInTaskbar = true;
                this.iidkDebugView.Show();                
            }    
        }
        private bool canExecuteShowLevelViewCommand(object obj)
        {
            if (!this.isLevelViewShowed)
            {
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {                        
                        case AppTaskName.GetLevels:
                            
                            return (this.currentLevel != null 
                                   && this.currentLevel.Id != "*"
                                   && this.currentLevel.Id != "-"
                                   && this.currentLevel.Id != "");
                    }
                }
            }
            return false;
        }
        private async void executeShowLevelViewCommand(object obj)
        {
            this.isLevelViewShowed = true;
            LevelView levelView = new LevelView();
            Level level = this.currentLevel.Clone();
            levelView.ViewModel = new LevelViewModel(this.das,
                                                    levelView,
                                                    this.settings.UseOperDB,
                                                    this.UserPermissions,
                                                    level);
            levelView.Owner = this.view;
            levelView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            levelView.ShowInTaskbar = false;
            if (levelView.ShowDialog() == true)
            {
                await getLevelsAsync();
            }
            this.isLevelViewShowed = false;
        }
        private bool canExecuteShowDepartmentsViewCommand(object obj)
        {
            return !this.isDepartmentsViewShowed;
        }
        private async void executeShowDepartmentsViewCommand(object obj)
        {
            this.isDepartmentsViewShowed = true;
            //DepartmentsView view = new DepartmentsView();
            ListView view = new ListView();
            List<Department> departmentsList = null;
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;

            bool isExportEnable = false;
            if (this.userPermissions["ExportData"])
                isExportEnable = true;

            //string selected_departmets = null;
            AppObjectBase[] selectedItems = null;
            if (obj != null)
            {
                switch (obj.ToString())
                {
                    case "FromAccessEvents":
                        selectedItems = this.AccessEventsFilter.DepartmentsArray;
                        break;
                    case "FromPersons":
                        selectedItems = this.PersonsFilter.DepartmentsArray;
                        break;
                }                
            }

            try
            {
                departmentsList = await das.GetDepartmentsAsync(token,this.Settings.UseOperDB);
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

            if (departmentsList != null)
            {
                departmentsList.Sort((x, y) => x.Name.CompareTo(y.Name));
                //view.ViewModel = new DepartmentsViewModel(view, this.das, this.userPermissions, departments_list, selected_departmets);
                view.ViewModel = new DepartmentsViewModel(view, departmentsList, selectedItems, this.das);
                view.ViewModel.IsExportEnable = isExportEnable;
                view.ViewModel.IsSelectableMode = true;
                view.ViewModel.IsStatisticsHidden = !this.userPermissions["SeeStatistics"];
                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                view.ShowInTaskbar = false;
                
                if (view.ShowDialog() == true)
                {
                    Mouse.OverrideCursor = Cursors.Wait;
                    selectedItems = view.ViewModel.SelectedItems;
                    if (obj != null)
                    {
                        switch (obj.ToString())
                        {
                            case "FromAccessEvents":
                                //try
                                //{
                                    this.AccessEventsFilter.DepartmentsArray = selectedItems;
                                //}
                                //catch (Exception ex)
                                //{
                                //    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                                //}                                
                                break;
                            case "FromPersons":
                                //try
                                //{
                                    this.PersonsFilter.DepartmentsArray = selectedItems;
                                //}
                                //catch (Exception ex)
                                //{
                                //    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                                //}                                
                                break;
                        }
                    }
                    Mouse.OverrideCursor = null;
                }
            }
            this.isDepartmentsViewShowed = false;
        }
        private bool canExecuteShowEventsViewCommand(object obj)
        {
            if (!this.isEventsViewShowed)
            {
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {
                        case AppTaskName.GetAccessEvents:
                            return true;
                            //return this.isApplyAefEvents;
                    }
                }
            }
            return false;
        }
        private async void executeShowEventsViewCommand(object obj)
        {
            this.isEventsViewShowed = true;
            //EventsView view = new EventsView();
            ListView view = new ListView();
            List<Event> eventsList = null;
            AppObjectBase[] selectedItems = this.AccessEventsFilter.EventsArray;

            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                eventsList = await das.GetEventsAsync(token, "PNET3_NC32K");
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }


            if (eventsList != null)
            {
                eventsList.Sort((x, y) => x.Description.CompareTo(y.Description));
                //view.ViewModel = new EventsViewModel(view, EventsList, this.accessEventsFilterEvents);
                view.ViewModel = new EventsViewModel(view, eventsList, selectedItems, this.das);
                view.ViewModel.IsSelectableMode = true;
                view.ViewModel.IsStatisticsHidden = !this.userPermissions["SeeStatistics"];
                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                view.ShowInTaskbar = false;
                if (view.ShowDialog() == true)
                {
                    Mouse.OverrideCursor = Cursors.Wait;
                    selectedItems = view.ViewModel.SelectedItems;
                    this.accessEventsFilter.EventsArray = selectedItems;
                    this.IsApplyAefEvents = true;
                    Mouse.OverrideCursor = null;
                }
                else
                {
                    this.IsApplyAefEvents = false;
                }

            }
            this.isEventsViewShowed = false;
        }
        private bool canExecuteShowAccessPointsViewCommand(object obj)
        {
            if (!this.isAccessPointsViewShowed)
            {
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {
                        case AppTaskName.GetAccessEvents:
                            return true;
                            //return this.isApplyAefAccessPoints;
                        case AppTaskName.GetLevels:
                            return (this.currentLevel != null 
                                    && this.currentLevel.Id != "*"
                                    && this.currentLevel.Id != "-"
                                    && this.currentLevel.Id != "");
                    }
                }
            }
            return false;
        }
        private async void executeShowAccessPointsViewCommand(object obj)
        {
            string source = "";
            if (obj != null) source = obj.ToString();
            await this.showAccessPointsView(source);            
        }
        private bool canExecuteShowLevelsViewCommand(object obj)
        {
            if (!this.isLevelsViewShowed)
            {
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {                        
                        case AppTaskName.GetAccessPoints:
                            return (this.currentAccessPoint != null);
                    }
                }
            }
            return false;
        }
        private async void executeShowLevelsViewCommand(object obj)
        {
            this.isLevelsViewShowed = true;
            //LevelsView view = new LevelsView();
            ListView view = new ListView();
            List<Level> levels = null;

            string accessPointId = null;
            if (obj != null && obj.ToString() == "FromAccessPoints")
            {
                if (this.currentAccessPoint != null)
                {
                    accessPointId = this.currentAccessPoint.Id;
                }
            }
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                MainQueryParams levelsParams = new MainQueryParams();
                levelsParams.UseOperDB = this.settings.UseOperDB;
                levelsParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
                levelsParams.Nc32kId = accessPointId;
                levelsParams.ShowFullAccessLevel = false;
                levelsParams.StartDate = new DateTime(1753, 01, 01);
                //levels = await das.GetLevelsAsync(token, this.settings.UseOperDB, accessPointId, false,null,new DateTime(1753, 01, 01));
                levels = await das.GetLevelsAsync(token, levelsParams);
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

            if (levels != null)
            {
                //levels.Sort((x, y) => x.Num.CompareTo(y.Num));

                levels = levels.OrderBy(l => l.Num).ThenBy(l => l.Name).ToList();
                //string levelsFilter = String.Empty;
                //view.ViewModel = new LevelsViewModel(view, levels, levelsFilter);
                view.ViewModel = new LevelsViewModel(view, levels, null, this.das);
                if (accessPointId != null)
                {
                    view.ViewModel.Title = "Уровни доступа, содержащие " + this.currentAccessPoint.Name;
                    view.ViewModel.IsSelectableMode = false;
                }

                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                view.ShowInTaskbar = false;
                view.Show();
            }
            this.isLevelsViewShowed = false;
        }
        private bool canExecuteShowPersonsViewCommand(object obj)
        {
            if (!this.isPersonsViewShowed)
            {
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {
                        case AppTaskName.GetAccessEvents:
                            return true;
                        case AppTaskName.GetAccessPoints:
                            return (this.currentAccessPoint != null);
                        case AppTaskName.GetLevels:
                            return (this.currentLevel != null);
                        case AppTaskName.Notifications:
                            return true;
                    }
                }
            }
            return false;
        }
        private async void executeShowPersonsViewCommand(object obj)
        {
            string source = "";
            if (obj != null) source = obj.ToString();
            await this.showPersonsView(source);            
        }
        private bool canExecuteShowInfoCommand(object obj)
        {
            //if (!this.isPersonViewShowed)
            //{
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {
                        case AppTaskName.GetPersons:
                            if (this.currentPerson != null)
                            {
                                return true;
                            }
                            break;
                        case AppTaskName.GetAccessEvents:
                            if (this.currentProtocolItem != null)
                            {
                                if (this.currentProtocolItem.PersonKey != -1)
                                {
                                    return true;
                                }
                            }
                            break;
                        case AppTaskName.Notifications:
                            if (this.currentNotification != null)
                            {
                                if (this.currentNotification.Type == NotificationType.Person)
                                {
                                    return true;
                                }
                            }
                            break;
                    }
                }                
            //}
            return false;
        }
        private async void executeShowInfoCommand(object obj)
        {
            bool showPersonHistory = false;
            bool useOperDB = this.settings.UseOperDB;

            if (this.currentTask != null)
            {
                switch (this.currentTask)
                {
                    case AppTaskName.GetPersons:
                        if (this.currentPerson != null)
                        {
                            if (this.userPermissions["SeePersonHistory"])
                            {
                                showPersonHistory = true;
                            }
                            await this.showPersonView(this.currentPerson.PersonKey,
                                                      this.currentPerson.Id,
                                                      this.currentPerson.Guid,
                                                      new DateTime(9999, 1, 1), 
                                                      showPersonHistory,
                                                      true);
                            
                        }
                        break;
                    case AppTaskName.GetAccessEvents:
                        if (this.currentProtocolItem != null)
                        {
                            if (this.currentProtocolItem.PersonKey != -1)
                            {
                                await this.showPersonView(this.currentProtocolItem.PersonKey,
                                                          this.currentProtocolItem.PersonID,
                                                          Guid.Empty,
                                                          this.currentProtocolItem.Date,
                                                          showPersonHistory,
                                                          false);                                
                            }
                        }
                        break;
                    case AppTaskName.Notifications:
                        if (this.currentNotification != null)
                        {
                            if(this.currentNotification.Type == NotificationType.Person)
                            {
                                await this.showPersonView(0,
                                                          this.currentNotification.Id,
                                                          Guid.Empty,
                                                          new DateTime(9999, 1, 1),
                                                          showPersonHistory,
                                                          false);
                            }
                        }
                        break;
                }
            }
            
            //this.isPersonViewShowed = false;
        }
        private void executeShowSettingsViewCommand(object obj)
        {
            SettingsView view = new SettingsView();
            SettingsViewModel newSettings = this.settings.Clone() as SettingsViewModel;
            newSettings.AppUserPermissions = this.userPermissions;
            view.ViewModel = newSettings;
            view.Owner = this.view;
            view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            view.ShowInTaskbar = false;
            if(view.ShowDialog()==true)
            {
                //Properties.Settings.Default.UseOperDB = new_settings.UseOperDB;
                //Properties.Settings.Default.Save();
                this.Settings = newSettings;                
            }
        }
        protected bool canExecuteExportToMSExcelCommandCommand(object obj)
        {
            bool result = false;
            
            if (this.currentTask != null)
            {
                if(!this.isChangePasswordViewShowed  && !this.isLoginViewShowed)
                {
                    switch (this.currentTask)
                    {
                        case AppTaskName.GetAccessEvents:
                            if (!this.isGettingAccessEvents)
                            {
                                if (this.accessEvents != null)
                                {
                                    if (this.accessEvents.Count() != 0)
                                        result = true;
                                }
                            }
                            break;

                        case AppTaskName.GetPersons:
                            if(!this.isGettingPersons)
                            {
                                if(this.persons != null)
                                {
                                    if (this.persons.Count() != 0)
                                        result = true;
                                }                                    
                            }
                            break;
                        case AppTaskName.GetAccessPoints:
                            if (!this.isGettingAccessPoints)
                            {
                                if (this.accessPoints != null)
                                {
                                    if (this.accessPoints.Count() != 0)
                                        result = true;
                                }
                            }
                            break;
                        case AppTaskName.GetLevels:
                            if (!this.isGettingLevels)
                            {
                                if (this.levels != null)
                                {
                                    if (this.levels.Count() != 0)
                                        result = true;
                                }
                            }
                            break;
                    }
                }
            }
                       
            return result;
        }
        protected void executeExportToMSExcelCommand(object obj)
        {
            HashSet<string> outputColums  = new HashSet<string>(); ;
            DataTable table = new DataTable();
            //int maxCount = 10000;
            SaveFileDialog saveDialog = new SaveFileDialog();
            saveDialog.OverwritePrompt = true;
            saveDialog.Filter = "Microsoft Excel(*.xlsx)|*.xlsx|All files(*.*)|*.*";
            string extensionInfo = String.Empty;

            switch (this.currentTask)
            {
                case AppTaskName.GetAccessEvents:
                    
                    //if (this.accessEvents.Count() > maxCount)
                    //{
                    //    MessageBoxResult result = Message.ShowDialogExclamation(
                    //        "Отчет содержит большое количество строк.\n"
                    //        + "Процесс может занять длительное время.\n"
                    //        + "Продолжить?", "Подтверждение");
                    //    if (result == MessageBoxResult.No)
                    //    {
                    //        return;
                    //    }
                    //}
                    
                    outputColums.Add("Date");
                    outputColums.Add("Event");
                    outputColums.Add("Nc32kName");
                    outputColums.Add("Information");
                    outputColums.Add("Department");
                    extensionInfo = "data=AccessEvents";

                    table = ExportHelper.ListToDataTable(this.accessEvents);

                    //table = ExportHelper.ListToDataTable(this.accessEvents);
                    //ExcelExportHelper.GenerateExcelCOM(table, null, outputColums);

                    saveDialog.FileName = "События доступа";
                    //if (saveDialog.ShowDialog() == true)
                    //{
                    //    this.logAuditEvent("others", "export_data_to_excel", null, null, "data=AccessEvents");
                    //    table = ExportHelper.ListToDataTable(this.accessEvents);

                    //    try
                    //    {
                    //        ExportHelper.GenerateExcelToFile(saveDialog.FileName, table, outputColums);
                    //        //ExportHelper.GenerateCsvFile(saveDialog.FileName, table, null, outputColums);
                    //        Message.ShowMessage("Файл успешно сохранен", "Информация", this.view);
                    //    }
                    //    catch (Exception e)
                    //    {
                    //        Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                    //    }
                    //}
                    break;

                case AppTaskName.GetPersons:
                                                        
                    outputColums = new HashSet<string>();
                    outputColums.Add("FullName");
                    outputColums.Add("Department");
                    outputColums.Add("CardFull");
                    outputColums.Add("Expired");
                    outputColums.Add("IsLocked");
                    outputColums.Add("IsApb");

                    extensionInfo = "data=Persons";
                    table = ExportHelper.ListToDataTable(this.persons);

                    saveDialog.FileName = "Сотрудники";
                    break;

                case AppTaskName.GetAccessPoints:

                    outputColums = new HashSet<string>();
                    outputColums.Add("Name");                    
                    outputColums.Add("ID");

                    extensionInfo = "data=AccessPoints";
                    table = ExportHelper.ListToDataTable(this.accessPoints);

                    saveDialog.FileName = "Точки доступа";
                    break;

                case AppTaskName.GetLevels:

                    outputColums = new HashSet<string>();
                    outputColums.Add("Name");
                    outputColums.Add("Description");
                    outputColums.Add("Type");
                    outputColums.Add("ID");

                    extensionInfo = "data=AccessLevels";
                    table = ExportHelper.ListToDataTable(this.levels);

                    saveDialog.FileName = "Уровни доступа";
                    break;
            }
            if (saveDialog.ShowDialog() == true)
            {
                Mouse.OverrideCursor = Cursors.Wait;
                this.logAuditEvent("others", "export_data_to_excel", this.pcName, null, extensionInfo);
                try
                {
                    ExportHelper.GenerateExcelToFile(saveDialog.FileName, table, outputColums);
                    //Message.ShowMessage("Файл успешно сохранен", "Информация", this.view);
                    Mouse.OverrideCursor = null;
                }
                catch (Exception e)
                {
                    Mouse.OverrideCursor = null;
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }
        }
        protected void executeShowUsersViewCommand(object obj)
        {
            UsersView usersView = new UsersView();
            try
            {
                usersView.ViewModel = new UsersViewModel(this.das, usersView, this.userIsSecurityAdmin, this.userPermissions);
                usersView.ViewModel.Initialize();
                usersView.Owner = this.view;
                usersView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                usersView.ShowInTaskbar = false;
                usersView.ShowDialog();
            }
            catch (Exception ex)
            {
                if (usersView != null)
                {
                    usersView.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

        }
        protected async void executeUpdateCommand(object obj)
        {
            this.IsUpdating = true; 
            //Искуственная задержка!!!
            await Task.Delay(TimeSpan.FromSeconds(5), CancellationToken.None);
            this.IsUpdating = false;
            //raiseCanExecuteChanged();
        }
        protected bool canExecuteUpdateCommand(object obj)
        {
            return !this.isUpdating;
        }
        protected void onCloseCardConverter()
        {
            this.IsCardConverterShowed = false;
        }
        protected void executeCardConverterCommand(object obj)
        {
            //Message.ShowMessage("canSosison: " + this.UserRights["canSosison"], "Test1");
            //Message.ShowMessage("canRunCardConverter: " + this.UserRights["canRunCardConverter"], "Test2");
            
            if(this.isCardConverterViewShowed == false)
            {
                CardConverterView cardConverterView = new CardConverterView(onCloseCardConverter);
                cardConverterView.Icon = null;
                //cardConverterView.ShowInTaskbar = false;
                cardConverterView.Owner = Application.Current.MainWindow;
                cardConverterView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                
                this.cardConverterView = cardConverterView;
                this.IsCardConverterShowed = true;
                cardConverterView.Show();
            }
            else if(this.cardConverterView != null)
            {
                this.cardConverterView.Close();
                this.cardConverterView = null;
            }            
        }
        protected void executeCloseCommand(object obj)
        {
            if(this.runningTasks.Count > 0)
            {
                MessageBoxResult result = Message.ShowDialogExclamation("Имеются незавершенные задачи.\n Вы уверены, что хотите закрыть программу?", "Подтверждение");
                if (result == MessageBoxResult.Yes)
                {
                    List<AppTaskName> list = this.runningTasks.Keys.ToList<AppTaskName>();
                    foreach (AppTaskName appTask in list)
                    {                                     
                        stopAppTask(appTask);
                    }
                    if (this.Settings != null)
                        this.Settings.Save();
                    Application.Current.Shutdown();
                }
            }
            else
            {
                this.Settings.Save();
                Application.Current.Shutdown();
            }
        }
        protected bool canExecuteCloseCommand(object obj)
        {
            return (this.runningTasks.Count == 0);
        }
        protected bool canExecuteChangePasswordCommand(object obj)
        {
            return (this.runningTasks.Count == 0);
        }
        protected void executeChangePasswordCommand(object obj)
        {
            this.showChangePasswordDialog();            
        }
        protected async void executeLoginCommand(object param)
        {
            this.isLoginViewShowed = true;
            string str_param = param as string;
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            LoginView loginView = new LoginView();
            if (str_param != "ChangingUser") loginView.ViewModel.LoginParams.User.Login = this.currentUserLogin;
            //loginView.Owner = Application.Current.MainWindow;
            if (loginView.ShowDialog().Value == true)
            {
                this.waitView = new WaitView(CTS);
                //this.waitView.Owner = this.view;
                waitView.ViewModel.Text = "Запрос к базе данных...";
                waitView.Show();
                try
                {   
                    startAppTask(AppTaskName.Login, CTS);
                    SqlLoginResult result;
                    result = await das.LoginAsync(token, loginView.ViewModel.LoginParams.User.Login, loginView.ViewModel.Password.Copy(), this.pcName, this.appBuild);

                    List<Permission> permissions = await das.GetPermissionsAsync(token, true);
                    Permissions userPermissions = new Permissions();
                    foreach (Permission permission in permissions)
                    {
                        userPermissions.Add(permission.Name); 
                    }
                    this.UserPermissions = userPermissions;

                    this.UserIsSecurityAdmin = await das.CheckUserForSecurityAdminAsync(token);
                    //this.UserPermissions["RunCardConverter"] = true;
                    //this.OnPropertyChanged("UserPermissions");
                    
                    //искуственная задержка
                    //await Task.Delay(TimeSpan.FromSeconds(5));

                    //получаем настройки программы
                    this.Settings = await this.getSettingsAsync();

                    //проверяем подключение к оперативной базе
                    /*
                    if (this.Settings.UseOperDB == true)
                    {
                        string operDbConnectionResult = null;
                        try
                        {
                            operDbConnectionResult = await das.CheckOperDbConnectionAsync(token);
                        }                        
                        catch (Exception ex)
                        {
                            if (ex is TaskCanceledException)
                            {
                            }
                            else
                            {
                                Message.ShowError(ex.Message, ex.GetType().ToString(), waitView);
                            }                            
                        }
                        if (operDbConnectionResult == null)
                            this.Settings.UseOperDB = false;
                    }
                    

                    //Заполняем списки
                    await this.getAccessPoints();
                    if (this.userPermissions["SeeLevels"])
                    {
                        await this.getLevels();
                    }
                    */

                    //сохраняем текущий логин
                    this.CurrentUserLogin = loginView.ViewModel.LoginParams.User.Login;
                    this.OnPropertyChanged("Title");
                    Properties.Settings.Default.Login = this.currentUserLogin;
                    Properties.Settings.Default.Save();

                    //запускаем IIDK
                    if (this.IsIidkEnabled && this.intellectAgent == null)
                    {
                        this.createIidkAgent();
                    }

                    stopAppTask(AppTaskName.Login);

                    if (this.waitView != null)
                    {
                        this.waitView.ViewModel.Dispose();
                        this.waitView.Close();
                    }

                    switch (result)
                    {                        
                        case SqlLoginResult.NeededChangePassword:
                            Message.ShowExclamation("Вам необходимо изменить пароль", "Внимание");
                            if (this.showChangePasswordDialog() == 1)
                            {
                                //для сохранения лога удачной авторизации
                                //await das.Login(token, this.appBuild, null, null);
                                this.logAuditEvent("autorisation", "login_in", this.pcName, this.appBuild, null);
                                
                            }
                            else
                            {
                                this.executeLoginCommand(null);
                            }
                            break;                        
                    }

                    if (!this.isMainViewShowed)
                    {
                        this.view.Show();
                        this.isMainViewShowed = true;
                    }
                }

                catch (Exception ex)
                {
                    if (this.waitView != null)
                    {
                        this.waitView.ViewModel.Dispose();
                        this.waitView.Close();
                    }
                    stopAppTask(AppTaskName.Login);
                    if (ex is TaskCanceledException)
                    {
                    }
                    else
                    {
                        Message.ShowError(ex.Message, ex.GetType().ToString(), waitView ?? null);
                    }                    
                    this.executeLoginCommand(null);

                }
            }
            else
            {
                if (loginView != null)
                {
                    loginView.ViewModel.Dispose();
                    loginView.Close();
                }             
                if(str_param != "ChangingUser") Application.Current.Shutdown();
            }
            if (loginView != null)
            {
                loginView.ViewModel.Dispose();
                loginView.Close();
            }
            //this.isLoginExecuting = false;            
        }
        protected bool canExecuteLoginCommand(object param)
        {
            return (!this.isLoginViewShowed) && (this.runningTasks.Count == 0); 
        }
        protected void executeAboutCommand(object param)
        {
            //AboutView aboutView = new AboutView(this.onClosingAboutView);
            AboutView aboutView = new AboutView();
            aboutView.ShowInTaskbar = false;
            aboutView.Owner = Application.Current.MainWindow;
            aboutView.ShowDialog();
        }
        protected bool canExecuteAboutCommand(object param)
        {
            return true;
        }
        protected async void executeRunTaskCommand(object param)
        {
            switch (this.currentTask)
            {
                case AppTaskName.GetAccessEvents:                    
                    await getAccessEventsAsync();
                    return;
                case AppTaskName.GetPersons:
                    await getPersonsAsync();
                    return;
                case AppTaskName.GetAccessPoints:
                    await getAccessPointsAsync();
                    return;
                case AppTaskName.GetLevels:
                    await getLevelsAsync();
                    return;
            }       
        }
        protected bool canExecuteRunTaskCommand(object param)
        {
            if (   !this.isChangePasswordViewShowed
                && !this.isLoginViewShowed)
            {
                if (this.currentTask != null)
                {
                    switch (this.currentTask)
                    {
                        case AppTaskName.GetAccessEvents:
                            return (!this.isGettingAccessEvents && !this.accessEventsFilter.HasErrors);
                        case AppTaskName.GetPersons:
                            return (!this.isGettingPersons && !this.personsFilter.HasErrors);
                        case AppTaskName.GetAccessPoints:
                            return !this.isGettingAccessPoints;
                        case AppTaskName.GetLevels:
                            return !this.isGettingLevels;
                    }
                }
            }
            return false;
        }
        protected void executeCancelTaskCommand(object param)
        {
            switch (this.currentTask)
            {
                case AppTaskName.GetAccessEvents:
                    this.stopAppTask(AppTaskName.GetAccessEvents);
                    return;                    
                case AppTaskName.GetPersons:
                    this.stopAppTask(AppTaskName.GetPersons);
                    return;
                case AppTaskName.GetAccessPoints:
                    this.stopAppTask(AppTaskName.GetAccessPoints);
                    return;
                case AppTaskName.GetLevels:
                    this.stopAppTask(AppTaskName.GetLevels);
                    return;
            }            
        }
        protected bool canExecuteCancelTaskCommand(object param)
        {
            if (this.currentTask != null)
                return (this.runningTasks.ContainsKey((AppTaskName)this.currentTask));
            else
                return false;
            
        }        

        #endregion   
    }
}
