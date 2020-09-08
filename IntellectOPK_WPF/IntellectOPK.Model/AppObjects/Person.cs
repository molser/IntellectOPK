using IntellectOPK.Model.Utilities;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace IntellectOPK.Model
{
    public class Person : AppObjectBase,  IEquatable<Person>
    //public class Person : NotifyDataErrorBase, IEquatable<Person>
    {
        #region Private Members
        private int personKey;
        private int photoKey;
        private string id;
        private Guid guid;
        private string levelId;
        private string departmentLevelId;

        private string name;
        private string surname;
        private string patronymic;
        private string post;
        private string department;

        private string externalId;
        private string card;
        private string facilityCode;
        private string comment;
        private bool isApb;
        private string passport;
        private string phone;
        private string pin;
        private string tabnum;
        private string whoCard;
        private string whoLevel;
        private bool pnet3Alarm;
        private bool pnet3Block;
        private bool pnet3Guard;

        DateTime expired;
        DateTime startedAt;
        DateTime validFrom;
        DateTime validTo;
        bool isLocked;
        bool isDeleted;
        
        private BitmapImage photo;
        private List<Level> levels;
        private List<Level> departmentLevels;
        //private bool isPhotoFromDB;
        //private int photoWidth;
        //private IDataAccessService das;
        
        private const string NAME_ERROR = "Значение может содержать только буквы и пробел";

        #endregion

        #region Constructor
        public Person()
        {
            personKey = 0;
            id = "";
            name = "";
            surname = "";
            patronymic = "";
            comment = "";
            guid = new Guid("00000000-0000-0000-0000-000000000000");
            department = "";
            //photoWidth = 60;
        }

        public Person(int person_key,
                      string id,
                      Guid guid,
                      string name,
                      string surname = null,
                      string patronimic = null,
                      string comment = null,
                      string department = null)
                      //int photoWidth = 60)
        //bool must_change_password = false)
        {
            this.personKey = person_key;
            this.id = id;
            this.guid = guid;
            this.name = name;
            this.surname = surname;
            this.name = name;
            this.comment = comment;
            this.department = department;
            //this.photoWidth = photoWidth;          
                        
        }


        #endregion

        #region Private Methods


        #endregion


        #region Properties

        public override string NameBase
        {
            get
            {
                return this.FullName;
            }
        }

        public static string ValidCharsForFullName
        {
            get { return @"а-яА-Яa-zA-ZёЁ "; }
        }

        public int PersonKey
        {
            get { return this.personKey; }
            set
            {
                this.personKey = value;
                this.OnPropertyChanged("PersonKey");
            }
        }

        public override string Id
        {
            get { return this.id; }
            set
            {
                this.id = value;
                this.OnPropertyChanged("Id");
            }
        }

        public Guid Guid
        {
            get { return this.guid; }
            set
            {
                this.guid = value;
                this.OnPropertyChanged("Guid");
            }
        }

        public string Name
        {
            get { return this.name; }
            set
            {
                this.name = value;
                this.OnPropertyChanged("Name");
            }
        }
        public string Surname
        {
            get { return this.surname; }
            set
            {
                this.surname = value;
                this.OnPropertyChanged("Surname");
            }
        }
        public string Patronymic
        {
            get { return this.patronymic; }
            set
            {
                this.patronymic = value;
                this.OnPropertyChanged("Patronymic");
            }
        }
        public string FullName
        {
            get { return this.name + " " + this.surname + " " + this.patronymic; }
        }

        public string Post
        {
            get { return this.post; }
            set
            {
                this.post = value;
                this.OnPropertyChanged("Post");
            }
        }

        public string Department
        {
            get { return this.department; }
            set
            {
                this.department = value;
                this.OnPropertyChanged("Department");
            }
        }
        public string ExternalId
        {
            get { return this.externalId; }
            set
            {
                this.externalId = value;
                this.OnPropertyChanged("ExternalId");
            }
        }

        public string Card
        {
            get { return this.card; }
            set
            {
                this.card = value;
                this.OnPropertyChanged("Card");
            }
        }

        public string FacilityCode
        {
            get { return this.facilityCode; }
            set
            {
                this.facilityCode = value;
                this.OnPropertyChanged("FacilityCode");
            }
        }

        public string CardFull
        {
            get
            {
                int facilityCode;
                int card;
                Int32.TryParse(this.facilityCode, out facilityCode);
                Int32.TryParse(this.card, out card);
                return (facilityCode*(65536) + card).ToString();
            }
        }

        public string Passport
        {
            get { return this.passport; }
            set
            {
                this.passport = value;
                this.OnPropertyChanged("Passport");
            }
        }

        public string Phone
        {
            get { return this.phone; }
            set
            {
                this.phone = value;
                this.OnPropertyChanged("Phone");
            }
        }

        public string Pin
        {
            get { return this.pin; }
            set
            {
                this.pin = value;
                this.OnPropertyChanged("Pin");
            }
        }

        public string Tabnum
        {
            get { return this.tabnum; }
            set
            {
                this.tabnum = value;
                this.OnPropertyChanged("Tabnum");
            }
        }

        public string WhoCard
        {
            get { return this.whoCard; }
            set
            {
                this.whoCard = value;
                this.OnPropertyChanged("WhoCard");
            }
        }
        public string WhoLevel
        {
            get { return this.whoLevel; }
            set
            {
                this.whoLevel = value;
                this.OnPropertyChanged("WhoLevel");
            }
        }


        public DateTime StartedAt
        {
            get { return this.startedAt; }
            set
            {
                this.startedAt = value;
                this.OnPropertyChanged("StartedAt");
            }
        }

        public bool IsLocked
        {
            get { return this.isLocked; }
            set
            {
                this.isLocked = value;
                this.OnPropertyChanged("IsLocked");
            }
        }
        public DateTime Expired
        {
            get { return this.expired; }
            set
            {
                this.expired = value;
                this.OnPropertyChanged("Expired");
            }
        }

        public bool IsApb
        {
            get { return this.isApb; }
            set
            {
                this.isApb = value;
                this.OnPropertyChanged("IsApb");
            }
        }

        public string Comment
        {
            get { return this.comment; }
            set
            {
                this.comment = value;
                this.OnPropertyChanged("Comment");
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

        public string DepartmentLevelId
        {
            get { return this.departmentLevelId; }
            set
            {
                this.departmentLevelId = value;
                this.OnPropertyChanged("DepartmentLevelId");
            }
        }


        public DateTime ValidFrom
        {
            get { return this.validFrom; }
            set
            {
                this.validFrom = value;
                this.OnPropertyChanged("ValidFrom");
            }
        }
        public DateTime ValidTo
        {
            get { return this.validTo; }
            set
            {
                this.validTo = value;
                this.OnPropertyChanged("ValidTo");
            }
        }
        
        public bool IsDeleted
        {
            get { return this.isDeleted; }
            set
            {
                this.isDeleted = value;
                this.OnPropertyChanged("IsDeleted");
            }
        }

        public int PhotoKey
        {
            get { return this.photoKey; }
            set
            {
                this.photoKey = value;
                this.OnPropertyChanged("PhotoKey");
            }
        }
        public BitmapImage Photo
        {
            get { return this.photo; }
            set
            {
                this.photo = value;
                this.OnPropertyChanged("Photo");
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

        public List<Level> DepartmentLevels
        {
            get { return this.departmentLevels; }
            set
            {
                this.departmentLevels = value;
                this.OnPropertyChanged("DepartmentLevels");
            }
        }

        public bool Pnet3Alarm
        {
            get { return this.pnet3Alarm; }
            set
            {
                this.pnet3Alarm = value;
                this.OnPropertyChanged("Pnet3Alarm");
            }
        }

        public bool Pnet3Block
        {
            get { return this.pnet3Block; }
            set
            {
                this.pnet3Block = value;
                this.OnPropertyChanged("Pnet3Block");
            }
        }
        public bool Pnet3Guard
        {
            get { return this.pnet3Guard; }
            set
            {
                this.pnet3Guard = value;
                this.OnPropertyChanged("Pnet3Guard");
            }
        }        

        #endregion

        #region Validation

        public bool IsFullNameValid(string value)
        {
            if (value == null) return true;
            bool isValid = true;

            var regex = new Regex("^[а-яА-Яa-zA-Z ]*$");
            if (!regex.IsMatch(value))
            {
                AddError("Name", NAME_ERROR, false);
                isValid = false;
            }
            else RemoveError("Name", NAME_ERROR);

            return isValid;
        }

        #endregion

        #region IEquatable<Person>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Person objAsPart = obj as Person;
            if (objAsPart == null) return false;
            else return Equals(objAsPart);
        }
        public override int GetHashCode()
        {
            return (this.personKey.ToString() + this.id).GetHashCode();
        }
        public bool Equals(Person other)
        {
            if (other == null) return false;
            return this.guid == other.guid
                    && this.personKey == other.personKey
                    && this.id == other.id;
            //if (!result)
            //{
            //    return false;
            //}
            //else if (this.personKey > 0)
            //{
            //    result = this.validFrom == other.validFrom;
            //}
            //return result;
        }


        #endregion

    }
}
