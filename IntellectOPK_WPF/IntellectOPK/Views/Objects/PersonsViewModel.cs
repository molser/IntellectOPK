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
using System.Threading.Tasks;
using System.Windows;
using Microsoft.Win32;
using System.Collections.ObjectModel;

namespace IntellectOPK.Views
{
    
    public class PersonsViewModel : ListViewModelBase
    {
        #region Member Data

        private ListView view;
        private List<Person> items;
        //private ObservableCollection<Person> items;
        private AppObjectBase[] itemsArray;        
        private IDataAccessService das = null;
        private Person selectedPerson;
        private List<string> departments;
        private RelayCommand showPersonViewCommand;
        private bool isPersonViewShowed = false;
        
        private Permissions appUserPermissions;
        private SettingsViewModel settings;
        private string departmentFilter;
        
        #endregion


        #region Constructor

        public PersonsViewModel(ListView view,
                                List<Person> items,
                                AppObjectBase[] selectedItems,                                                                
                                IDataAccessService das,
                                Permissions appUserPermissions,
                                SettingsViewModel settings)
            : base(view, das)
        {
            this.view = view;
            base.Title = "Сотрудники";
            this.das = das;
            this.settings = settings;
            this.appUserPermissions = appUserPermissions;
            this.items = items;
            //this.items = new ObservableCollection<Person>(items);
            this.itemsArray = this.items.ToArray();
            this.departments = new List<string>();
            if (items != null)
            {
                this.departments = items.Select(o => o.Department).Distinct().OrderBy(q => q).ToList();
            }
            this.departments.Insert(0,"Все отделы");
            this.departmentFilter = "Все отделы";

            base.ItemProperties.Add("IsChecked");
            base.ItemProperties.Add("PersonPhoto");
            base.ItemProperties.Add("PersonData");
            base.ItemProperties.Add("Id");

            base.CheckItems(selectedItems);
            base.SubscribeOnItemChanged();
            base.IsFilterListEnable = true;
        }

        #endregion

        #region Private Methods

        #endregion

        #region Public Methods

        #endregion

        #region ListViewModelBase

        public override string FilterListValue
        {
            get { return this.departmentFilter; }
            set
            {
                this.departmentFilter = value;
                this.OnPropertyChanged("FilterListValue");
            }
        }
        public override AppObjectBase[] ItemsArray
        {
            get
            {
                //Stopwatch stopWatch = new Stopwatch();
                //stopWatch.Start();
                //AppObjectBase[] array = this.persons.ToArray();
                //stopWatch.Stop();
                //TimeSpan ts = stopWatch.Elapsed;
                //string elapsedTime = String.Format("{0:0000}:{1:0000}:{2:0000}",
                //    ts.Seconds, ts.Milliseconds, ts.Ticks);
                //Debug.WriteLine("ItemsArrayGet-RunTime: " + elapsedTime);
                return this.itemsArray;
            }
        }        

        public override bool FilterFindPredicate(object obj)
        {
            bool result = false;
            if (String.IsNullOrEmpty(base.FilterFindValue))
                return true;

            Person person = obj as Person;
            if (person != null)
            {
                string value = StringHelper.RemoveUnnecessaryChars(person.FullName, Person.ValidCharsForFullName);
                string search = StringHelper.RemoveUnnecessaryChars(base.FilterFindValue, Person.ValidCharsForFullName);
                if (String.IsNullOrEmpty(search)) return false;
                return value.ToUpper().Contains(search.ToUpper());
            }
            return result;
        }

        public override bool FilterListPredicate(object obj)
        {
            bool result = true;
            if (!String.IsNullOrEmpty(this.departmentFilter))
            {
                if (this.departmentFilter == "Все отделы")
                    return result;
                Person person = obj as Person;
                return (person?.Department == this.departmentFilter);
            }
            return result;
        }

        public override DataTable ExportTable
        {
            get
            {
                HashSet<string> columsForExport = new HashSet<string>();
                columsForExport.Add("FullName");
                columsForExport.Add("Department");
                DataTable table = ExportHelper.ListToDataTable(this.items, columsForExport);
                return table;
            }
        }
        #endregion

        #region Properties

        public List<Person> Items
        //public ObservableCollection<Person> Items
        {
            get { return this.items; }
            set
            {
                this.items = value;
                this.OnPropertyChanged("Items");
            }
        }
        public Person SelectedItem
        {
            get { return this.selectedPerson; }
            set
            {
                this.selectedPerson = value;
                this.OnPropertyChanged("SelectedItem");
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



        #endregion


        #region Protected Methods

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }

        #endregion


        #region Commands
        public ICommand ShowPersonViewCommand
        {
            get
            {
                if (this.showPersonViewCommand == null)
                {
                    this.showPersonViewCommand = new RelayCommand(executeShowPersonViewCommand, canExecuteShowPersonViewCommand);
                }
                return this.showPersonViewCommand;
            }
        }

        #endregion


        #region Helper Methods
       
        private bool canExecuteShowPersonViewCommand(object obj)
        {
            if (!this.isPersonViewShowed)
            {
                if (this.selectedPerson != null)
                    {
                        return true;
                    }
            }
            return false;
        }
        private async void executeShowPersonViewCommand(object obj)
        {
            if (this.selectedPerson != null)
            {
                this.isPersonViewShowed = true;
                bool showPersonHistory = false;
                if (this.appUserPermissions["SeePersonHistory"])
                {
                    showPersonHistory = true;
                }
                bool useOperDB = this.settings.UseOperDB;

                PersonView view = null;
                List<Person> personList = null;
                List<Person> personListOperDB = null;
                List<Person> personListDwDB = null;

                CancellationTokenSource CTS = new CancellationTokenSource();
                CancellationToken token = CTS.Token;

                try
                {
                    personListDwDB = await das.GetPersonAsync(token,
                                                            this.selectedPerson.PersonKey,
                                                            this.selectedPerson.Id,
                                                            this.selectedPerson.Guid,
                                                            new DateTime(9999,1,1),
                                                            showPersonHistory,
                                                            use_oper_db: false);
                    if (useOperDB)
                    {
                        personListOperDB = await das.GetPersonAsync(token,
                                                            this.selectedPerson.PersonKey,
                                                            this.selectedPerson.Id,
                                                            this.selectedPerson.Guid,
                                                            new DateTime(9999, 1, 1),
                                                            show_person_history: false,
                                                            use_oper_db: true);
                    }


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
                    if (this.appUserPermissions["SeeLevels"])
                    {
                        try
                        {
                            foreach (Person person in personList)
                            {
                                if (this.settings.UseOperDB == true && person.PersonKey == 0)
                                    useOperDB = true;
                                else
                                    useOperDB = false;
                                MainQueryParams levelsParams = new MainQueryParams();
                                levelsParams.UseOperDB = useOperDB;
                                levelsParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
                                levelsParams.Levels = person.LevelId;
                                levelsParams.StartDate = person.ValidFrom;

                                //person.Levels = await das.GetLevelsAsync(CancellationToken.None, useOperDB, null, this.settings.ShowFullAccessLevel, person.LevelId, person.ValidFrom);
                                person.Levels = await das.GetLevelsAsync(CancellationToken.None, levelsParams);
                                if (person.Levels != null)
                                    person.Levels.Sort((x, y) => x.Num.CompareTo(y.Num));

                                levelsParams.Levels = person.DepartmentLevelId;
                                levelsParams.IsDepartmentLevels = true;
                                //person.DepartmentLevels = await das.GetLevelsAsync(CancellationToken.None, useOperDB, null, this.settings.ShowFullAccessLevel, person.DepartmentLevelId, person.ValidFrom,true);
                                person.DepartmentLevels = await das.GetLevelsAsync(CancellationToken.None, levelsParams);
                                if (person.DepartmentLevels != null)
                                    person.DepartmentLevels.Sort((x, y) => x.Num.CompareTo(y.Num));
                            }

                        }
                        catch (Exception ex)
                        {
                            Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                        }
                    }

                    view = new PersonView();
                    view.ViewModel = new PersonViewModel(view, this.das, this.settings, this.appUserPermissions, personList);
                    if (showPersonHistory)
                    {
                        view.ViewModel.IsPersonHistoryAvailable = true;
                    }
                    view.ViewModel.IsExtendedMode = true;
                    view.Owner = this.view;
                    view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                    //view.ShowInTaskbar = false;
                    view.Show();
                }            
                this.isPersonViewShowed = false;
            }
        }

        #endregion
    }
}
