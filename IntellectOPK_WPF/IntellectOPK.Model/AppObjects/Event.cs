using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace IntellectOPK.Model
{
    public class Event : AppObjectBase,  IEquatable<Event>
    {
        #region Private Members
        private string objtype;
        private string action;
        private string description;
        
        //private const string NAME_ERROR = @"Значение может содержать только буквы, цифры, пробел и знаки: ._ /\()-";

        #endregion

        #region Constructor
        public Event()
        {
            objtype = "";
            action = "";
            description = "";
        }

        public Event(string objtype,
                     string action,
                     string description
                      )
        //bool must_change_password = false)
        {
            this.objtype = objtype;
            this.action = action;
            this.description = description;
           
        }


        #endregion


        #region Properties
        public override string NameBase
        {
            get
            {
                return this.description;
            }
        }

        public override string Id
        {
            get { return this.action; }
            set
            {
                this.action = value;
                this.OnPropertyChanged("Id");
            }
        }
        public string Objtype
        {
            get { return this.objtype; }
            set
            {
                this.objtype = value;
                this.OnPropertyChanged("Objtype");
            }
        }

        public string Action
        {
            get { return this.action; }
            set
            {
                this.action = value;
                this.OnPropertyChanged("Action");
            }
        }

        public string Description
        {
            get { return this.description; }
            set
            {
                this.description = value;
                this.OnPropertyChanged("Description");
            }
        }

        #endregion

        #region Validation

        

        #endregion

        #region IEquatable<User>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Event objAsPart = obj as Event;
            if (objAsPart == null) return false;
            else return Equals(objAsPart);
        }
        public override int GetHashCode()
        {
            return (this.objtype+this.action).GetHashCode();
        }
        public bool Equals(Event other)
        {
            if (other == null) return false;
            return ((this.objtype + this.action).Equals(other.objtype + other.action));
        }


        #endregion

    }
}
