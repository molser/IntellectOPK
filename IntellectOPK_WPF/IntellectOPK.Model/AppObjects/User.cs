using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace IntellectOPK.Model
{
    public class User : NotifyDataErrorBase,  IEquatable<User>
    {
        #region Private Members
        private int id;
        private string login;
        private string name;
        private string comment;
        private bool is_admin;
        //private bool is_security_admin;
        private bool is_locked;
        private const string LOGIN_ERROR = "Значение может содержать только буквы, цифры, пробел и знак \"_\"";

        #endregion

        #region Constructor
        public User()
        {
            id = 0;
            login = "";
            name = "";
            comment = "";
            is_admin = false;
            //is_security_admin = false;
            is_locked = false;
        }

        public User(int id,
                    string login,
                    string name = null,
                    string comment = null,
                    bool is_admin = false,
                    //bool is_securityadmin = false,
                    bool is_locked = false)
        {
            this.id = id;
            this.login = login;
            this.name = name;
            this.comment = comment;
            this.is_admin = is_admin;
            //this.is_security_admin = is_securityadmin;
            this.is_locked = is_locked;
        }
        protected User(User other)
        {
            this.id = other.id;
            this.login = other.login;
            this.name = other.name;
            this.comment = other.comment;
            this.is_admin = other.is_admin;
            //this.is_security_admin = is_securityadmin;
            this.is_locked = other.is_locked;
        }

        #endregion

        #region Properties
        public int ID
        {
            get { return this.id; }
            set
            {
                this.id = value;
                this.OnPropertyChanged("ID");
            }
        }
        public string Login
        {
            get { return this.login; }
            set
            {
                //if (IsPersonsValid(value) && persons != value) persons = value;
                IsLoginValid(value);
                login = value;
                this.OnPropertyChanged("Login");
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
        public string Comment
        {
            get { return this.comment; }
            set
            {
                this.comment = value;
                this.OnPropertyChanged("Comment");
            }
        }

        public bool IsAdmin
        {
            get { return this.is_admin; }
            set
            {
                this.is_admin = value;
                this.OnPropertyChanged("IsAdmin");
            }
        }
        //public bool IsSecurityAdmin
        //{
        //    get { return this.is_security_admin; }
        //    set
        //    {
        //        this.is_security_admin = value;
        //        this.OnPropertyChanged("IsSecurityAdmin");
        //    }
        //}
        public bool IsLocked
        {
            get { return this.is_locked; }
            set
            {
                this.is_locked = value;
                this.OnPropertyChanged("IsLocked");
            }
        }
        //public bool MustChangePassword { set; get; }
        #endregion

        #region Public Methods

        public User Clone()
        {
            return new User(this);
        }


        #endregion

        #region Validation

        public bool IsLoginValid(string value)
        {
            bool isValid = true;

            var regex = new Regex("^[а-яА-Яa-zA-Z0-9_ ]*$");
            if (!regex.IsMatch(value))
            {
                AddError("Login", LOGIN_ERROR, false);
                isValid = false;
            }
            else RemoveError("Login", LOGIN_ERROR);

            return isValid;
        }

        #endregion


        #region IEquatable<User>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            User objAsPart = obj as User;
            if (objAsPart == null) return false;
            else
                return Equals(objAsPart);
        }
        public bool Equals(User other)
        {
            if (other == null) return false;
            if (this.ID == other.ID
                && this.Login == other.Login
                && this.Name == other.Name
                && this.Comment == other.Comment
                && this.IsAdmin == other.IsAdmin
                && this.IsLocked == other.IsLocked
                )
                return true;
            else return false;
        }
        public override int GetHashCode()
        {
            return this.Login.GetHashCode();
        }

        public static bool operator == (User u1, User u2)
        {
            if (object.ReferenceEquals(u1, null))
            {
                return object.ReferenceEquals(u2, null);
            }
            return u1.Equals(u2);
        }

        public static bool operator != (User u1, User u2)
        {
            if (object.ReferenceEquals(u1, null))
            {
                return !object.ReferenceEquals(u2, null);
            }
            return !u1.Equals(u2);
        }


        #endregion

    }
}
