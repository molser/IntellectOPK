using IntellectOPK.Model.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class MainQueryParams : NotifyDataErrorBase, ICloneable
    {
        #region Private Members

        private string name;
        private string persons;
        private string accessPoints;
        private string events;
        private string departments;
        private string levels;
        private AccessEventsMode mode = AccessEventsMode.ByName;
        private DateTime startDate;
        private DateTime endDate;
        private string facilityCod;
        private string cardPartParsec;
        private string personId;
        private bool onlyLast10eventsForDay;
        private bool onlyWorked;
        private bool useOperDB;
        //private string appBuild;

        private string person;
        private string nc32kId;
        private string levelId;
        bool showFullAccessLevel;
        bool showPersonHistory;
        bool hideTempPersons;
        bool isDepartmentLevels;


        AppObjectBase[] personsArray;
        AppObjectBase[] departmentsArray;
        AppObjectBase[] accessPointsArray;
        AppObjectBase[] eventsArray;
        AppObjectBase[] levelsArray;

        private const string PERSON_ERROR = "Значение может содержать только буквы и пробел";
        private const string PERSONS_ERROR = "Значение может содержать только буквы, пробел и знак \",\"";
        private const string ACCESS_POINTS_ERROR = "Значение может содержать только буквы, цифры, пробел и знаки \",_ /\\.()-\"";
        //private const string PERSON_ID_ERROR = "Значение может содержать только цифры";
        private const string START_DATE_ERROR = "Начальная дата не может быть позже конечной";
        private const string END_DATE_ERROR = "Конечная дата не может быть раньше начальной";
        private const string PARAM_LENGTH_ERROR = "Превышено допустимое количество параметров";
        private const uint intMax24Bits = 16777216;
        private const uint intMax16Bits = 65536;
        private const uint intMax8Bits = 256;
        private const uint SQL_PARAM_MAX_LENGTH = 8000;
        //private const string END_DATE_FUTURE_ERROR = "Конечная дата не может быть позже сегодня";

        //private Dictionary<String, List<String>> errors =  new Dictionary<string, List<string>>();

        #endregion

        #region Constructor

        public MainQueryParams()
        {
        }

        public MainQueryParams( string name,
                                AccessEventsMode mode,
                                string persons,
                                string access_points,
                                string events,
                                string departments,
                                string facilityCod,
                                string cardPartParsec,
                                string personId,
                                DateTime startDate,
                                DateTime endDate,
                                Boolean onlyLast20eventsForDay,
                                string person,
                                string nc32kId,
                                string levelId,
                                bool showFullAccessLevel,
                                bool showPersonHistory,
                                bool hideTempPersons,
                                bool isDepartmentLevels)
        {
            this.name = name;
            this.mode = mode;
            this.persons = persons;
            this.accessPoints = access_points;
            this.events = events;
            this.departments = departments;
            this.facilityCod = facilityCod;
            this.cardPartParsec = cardPartParsec;
            this.personId = personId;
            this.startDate = startDate;
            this.endDate = endDate;
            this.onlyLast10eventsForDay = onlyLast20eventsForDay;

            this.person = person;
            this.nc32kId = nc32kId;
            this.levelId = levelId;
            this.showFullAccessLevel = showFullAccessLevel;
            this.showPersonHistory = showPersonHistory;
            this.hideTempPersons = hideTempPersons;
            this.isDepartmentLevels = isDepartmentLevels;
        }


        #endregion
        #region Private Methods
        private string getAppObjectBaseIdsStringFromArray(AppObjectBase[] array)
        {
            string result = String.Empty;
            if (array == null || array.Count() == 0)
                return result;
            else
            {
                SortedSet<string> itemsSet = new SortedSet<string>();
                foreach (AppObjectBase item in array)
                {
                    itemsSet.Add(item.Id);
                }
                bool isFirst = true;
                foreach (string str in itemsSet)
                {
                    if (isFirst)
                    {
                        isFirst = false;
                        result = str;
                    }
                    else
                    { 
                        result += "," + str;
                    }
                }
                //result = StringHelper.RemoveUnnecessaryChars(result);
            }
            return result;
        }
        #endregion

        #region Public Members

        //public string AppBuild
        //{
        //    get { return this.appBuild; }
        //    set
        //    {
        //        this.appBuild = value;
        //        this.OnPropertyChanged("AppBuild");
        //    }
        //}
        public string Name
        {
            get { return this.name; }
            set
            {
                this.name = value;
                this.OnPropertyChanged("Name");
            }
        }
        public AccessEventsMode Mode
        {
            get { return this.mode; }
            set 
            {
                this.mode = value;
                this.OnPropertyChanged("Mode");
            }
        }

        public string Persons
        {
            get { return persons; }
            set
            {
                //if (IsPersonsValid(value) && persons != value) persons = value;
                IsPersonsValid(value);
                persons = value;
                this.OnPropertyChanged("Persons");
            }
        }

         public string PersonId
        {
            get { return this.personId; }
            set
            {
                if (value == "")
                {
                    this.personId = value;
                    this.OnPropertyChanged("PersonId");
                }
                else
                {
                    uint num;
                    if (uint.TryParse(value, out num))
                    {
                        if (num <= 100000)
                        {
                            this.personId = value;
                            this.OnPropertyChanged("PersonId");
                        }
                    }
                }
            }
        }
        public string AccessPoints
        {
            get { return this.accessPoints; }
            set
            {
                //if (IsPersonsValid(value) && persons != value) persons = value;
                IsAccessPointsValid(value);
                this.accessPoints = value;
                this.OnPropertyChanged("AccessPoints");
            }
        }

        public string Events
        {
            get { return this.events; }
            set
            {
                IsEventsValid(value);
                this.events = value;
                this.OnPropertyChanged("Events");
            }
        }

        public string Levels
        {
            get { return this.levels; }
            set
            {
                IsLevelsValid(value);
                this.levels = value;
                this.OnPropertyChanged("Levels");
            }
        }
        public string Departments
        {
            get { return this.departments; }
            set
            {
                IsDepartmentsValid(value);
                this.departments = value;
                this.OnPropertyChanged("Departments");
            }
        }

        public DateTime StartDate
        {
            get { return startDate; }
            //set { if (IsStartDateValid(value) && startDate != value) startDate = value; }
            set 
            {
                IsStartDateValid(value);
                if (startDate != value)
                {
                    startDate = value;
                    IsEndDateValid(this.endDate);
                }
                else startDate = value;
                this.OnPropertyChanged("StartDate");
            }
        }

        public DateTime EndDate
        {
            get { return endDate; }
            //set { if (IsEndDateValid(value) && endDate != value) endDate = value; }
            set 
            {
                IsEndDateValid(value);
                if (endDate != value)
                {
                    endDate = value; 
                    IsStartDateValid(this.startDate);
                }
                else endDate = value;
                this.OnPropertyChanged("EndDate");
            }
        }

        public bool OnlyLast10EventsForDay
        {
            get { return this.onlyLast10eventsForDay; }
            set
            {
                this.StartDate = DateTime.Today;
                this.EndDate = DateTime.Today.Add(new TimeSpan(23, 59, 59));
                this.onlyLast10eventsForDay = value;
                this.OnPropertyChanged("OnlyLast10EventsForDay");
            }
        }

        public string FacilityCod
        {
            get { return this.facilityCod; }
            set
            {
                if (value == "")
                {
                    this.facilityCod = value;
                    this.OnPropertyChanged("FacilityCod");
                }
                else
                {
                    uint num;
                    if (uint.TryParse(value, out num))
                    {
                        if (num <= intMax8Bits)
                        {
                            this.facilityCod = value;
                            this.OnPropertyChanged("FacilityCod");
                        }
                    }
                }
            }
        }

        public string CardPartParsec
        {
            get { return this.cardPartParsec; }
            set
            {
                if (value == "")
                {
                    this.cardPartParsec = value;
                    this.OnPropertyChanged("CardPartParsec");
                }
                else
                {
                    uint num;
                    if (uint.TryParse(value, out num))
                    {
                        if (num <= intMax16Bits)
                        {
                            this.cardPartParsec = value;
                            this.OnPropertyChanged("CardPartParsec");
                        }
                    }
                }
            }
        }


        public string Person
        {
            get { return person; }
            set
            {
                IsPersonValid(value);
                this.person = value;
                this.OnPropertyChanged("Person");
            }
        }

        public string Nc32kId
        {
            get { return this.nc32kId; }
            set
            {
                this.nc32kId = value;
                this.OnPropertyChanged("Nc32kId");
            }
        }

        public string LevelId
        {
            get { return this.levelId; }
            set
            {
                this.levelId = value;
                this.OnPropertyChanged("LevelId");
            }
        }

        public bool ShowFullAccessLevel
        {
            get { return this.showFullAccessLevel; }
            set
            {
                this.showFullAccessLevel = value;
                this.OnPropertyChanged("ShowFullAccessLevel");
            }
        }

        public bool ShowPersonHistory
        {
            get { return this.showPersonHistory; }
            set
            {
                this.showPersonHistory = value;
                this.OnPropertyChanged("ShowPersonHistory");
            }
        }

        public bool HideTempPersons
        {
            get { return this.hideTempPersons; }
            set
            {
                this.hideTempPersons = value;
                this.OnPropertyChanged("HideTempPersons");
            }
        }

        public bool OnlyWorked
        {
            get { return this.onlyWorked; }
            set
            {
                this.onlyWorked = value;
                this.OnPropertyChanged("OnlyWorked");
            }
        }

        public bool UseOperDB
        {
            get { return this.useOperDB; }
            set
            {
                this.useOperDB = value;
                this.OnPropertyChanged("UseOperDB");
            }
        }
        public bool IsDepartmentLevels
        {
            get { return this.isDepartmentLevels; }
            set
            {
                this.isDepartmentLevels = value;
                this.OnPropertyChanged("IsDepartmentLevels");
            }
        }
        public AppObjectBase[] PersonsArray
        {
            get { return this.personsArray; }
            set
            {
                this.personsArray = value;
                if (this.personsArray == null || this.personsArray.Count() == 0)
                    this.Persons = String.Empty;
                else
                {
                    SortedSet<string> personsSet = new SortedSet<string>();
                    foreach (Person person in this.personsArray)
                    {
                        personsSet.Add(StringHelper.RemoveUnnecessaryChars(person.FullName, Model.Person.ValidCharsForFullName));
                    }
                    string persons = "";
                    bool isFirst = true;
                    foreach (string str in personsSet)
                    {
                        if (isFirst)
                        {
                            isFirst = false;
                            persons = str;
                        }
                        else
                        { persons += "," + str; }
                    }
                    //persons = StringHelper.RemoveUnnecessaryChars(persons);
                    this.Persons = persons;

                }
            }
        }
        public AppObjectBase[] DepartmentsArray
        {
            get { return this.departmentsArray; }
            set
            {
                this.departmentsArray = value;
                if (this.departmentsArray == null || this.departmentsArray.Count() == 0)
                    this.Departments = String.Empty;
                else
                {
                    SortedSet<string> itemsSet = new SortedSet<string>();
                    foreach (Department item in this.departmentsArray)
                    {
                        itemsSet.Add(item.Name);
                    }
                    string items = "";
                    bool isFirst = true;
                    foreach (string str in itemsSet)
                    {
                        if (isFirst)
                        {
                            isFirst = false;
                            items = str;
                        }
                        else
                        {
                            items += "," + str;
                        }
                    }
                    //if (items.Length > SQL_PARAM_MAX_LENGTH)
                    //{
                    //    throw new Exception("Превышено допустимое количество объектов!");
                    //}
                    //items = StringHelper.RemoveUnnecessaryChars(items);
                    this.Departments = items;
                }
            }
        }

        public AppObjectBase[] AccessPointsArray
        {
            get { return this.accessPointsArray; }
            set
            {
                this.accessPointsArray = value;
                string accessPoints = getAppObjectBaseIdsStringFromArray(this.accessPointsArray);
                //if (accessPoints.Length > SQL_PARAM_MAX_LENGTH)
                //{
                //    throw new Exception("Превышено допустимое количество объектов!");
                //}
                this.AccessPoints = accessPoints;
            }
        }

        public AppObjectBase[] EventsArray
        {
            get { return this.eventsArray; }
            set
            {
                this.eventsArray = value;
                this.Events = getAppObjectBaseIdsStringFromArray(this.eventsArray);
            }
        }

        public AppObjectBase[] LevelsArray
        {
            get { return this.levelsArray; }
            set
            {
                this.levelsArray = value;
                this.Levels = getAppObjectBaseIdsStringFromArray(this.levelsArray);
            }
        }


        #endregion

        #region Validation

        // Validates the Name property, updating the errors collection as needed.
        private bool isSqlParamValid(string propertyName, string value)
        {
            bool isValid = true;
            if (value.Length > SQL_PARAM_MAX_LENGTH)
            {
                AddError(propertyName, PARAM_LENGTH_ERROR, false);
                isValid = false;
            }
            else RemoveError(propertyName, PARAM_LENGTH_ERROR);
            return isValid;
        }
        public bool IsPersonValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            var regex = new Regex("^[" + IntellectOPK.Model.Person.ValidCharsForFullName + "]*$");
            if (!regex.IsMatch(value))
            {
                AddError("Person", PERSON_ERROR, false);
                isValid = false;
            }
            else RemoveError("Person", PERSON_ERROR);

            bool isSqlValid = this.isSqlParamValid("Person", value);
            isValid = isValid == true ? isSqlValid : false;

            return isValid;
        }

        public bool IsPersonsValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            var regex = new Regex("^[" + IntellectOPK.Model.Person.ValidCharsForFullName + ",]*$");
            if (!regex.IsMatch(value))
            {
                AddError("Persons", PERSONS_ERROR, false);
                isValid = false;
            }
            else RemoveError("Persons", PERSONS_ERROR);

            bool isSqlValid = this.isSqlParamValid("Persons", value);
            isValid = isValid == true ? isSqlValid : false;

            return isValid;
        }

        public bool IsDepartmentsValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            bool isSqlValid = this.isSqlParamValid("Departments", value);
            isValid = isValid == true ? isSqlValid : false;

            return isValid;
        }

        public bool IsEventsValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            bool isSqlValid = this.isSqlParamValid("Events", value);
            isValid = isValid == true ? isSqlValid : false;

            return isValid;
        }

        public bool IsLevelsValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            bool isSqlValid = this.isSqlParamValid("Levels", value);
            isValid = isValid == true ? isSqlValid : false;

            return isValid;
        }

        public bool IsAccessPointsValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            //var regex = new Regex(@"^[а-яА-Яa-zA-Z0-9() \-./\\]*$");
            var regex = new Regex("^[" + AccessPoint.ValidCharsForName + ",]*$");
            if (!regex.IsMatch(value))
            {
                AddError("AccessPoints", ACCESS_POINTS_ERROR, false);
                isValid = false;
            }
            else RemoveError("AccessPoints", ACCESS_POINTS_ERROR);

            bool isSqlValid = this.isSqlParamValid("AccessPoints", value);
            isValid = isValid == true ? isSqlValid : false;

            return isValid;
        }        

        public bool IsStartDateValid(DateTime value)
        {
            bool isValid = true;

            if (value > endDate)
            {
                AddError("StartDate", START_DATE_ERROR, false);
                isValid = false;
            }
            else
            { 
                RemoveError("StartDate", START_DATE_ERROR);
                
            } 

            return isValid;
        }

        public bool IsEndDateValid(DateTime value)
        {
            bool isValid = true;

            if (value < startDate)
            {
                AddError("EndDate", END_DATE_ERROR, false);
                isValid = false;
            }
            else
            {
                RemoveError("EndDate", END_DATE_ERROR);
                
            }

            /*
            if (value.Date > DateTime.Today)
            {
                AddError("EndDate", END_DATE_FUTURE_ERROR, false);
                isValid = false;
            }
            else
            {
                RemoveError("EndDate", END_DATE_FUTURE_ERROR);

            }
            */

            return isValid;
        }

        #endregion

        #region IClonable

        // Реализация метода интерфейса ICloneable.
        public object Clone()
        {
            return new MainQueryParams( this.name,
                                        this.mode,
                                        this.persons,
                                        this.accessPoints, 
                                        this.events,
                                        this.departments,
                                        this.facilityCod,
                                        this.cardPartParsec,
                                        this.personId,
                                        this.startDate,
                                        this.endDate,
                                        this.onlyLast10eventsForDay,
                                        this.person,                                        
                                        this.nc32kId,
                                        this.levelId,
                                        this.showFullAccessLevel,
                                        this.showPersonHistory,
                                        this.hideTempPersons,
                                        this.isDepartmentLevels) as object;
        }

        #endregion


    }
}
