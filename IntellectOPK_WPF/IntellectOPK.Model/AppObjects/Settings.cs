using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace IntellectOPK.Model
{
    public class Settings : NotifyDataErrorBase,  IEquatable<Settings>
    {
        #region Private Members
        private string hostName;
        private bool isIidkEnable;
        private string iidkManagedSlave;
        private string iidkMap;
        private string iidkMonitor;
        
        private const string HOST_NAME_ERROR = "Значение может содержать только буквы, цифры, и знак \"_\"";

        #endregion

        #region Constructor
        public Settings()
        {
            hostName = "";
            isIidkEnable = false;
            iidkManagedSlave = "";
            iidkMap = "";
            iidkMonitor = "";
        }

        public Settings(
                        string hostName = "",
                        bool isIidkEnable = false,
                        string iidkManagedSlave = "",
                        string iidkMap = "",
                        string iidkMonitor = "")
        {
            this.hostName = hostName;
            this.isIidkEnable = isIidkEnable;
            this.iidkManagedSlave = iidkManagedSlave;
            this.iidkMap = iidkMap;
            this.iidkMonitor = iidkMonitor;
        }
        protected Settings(Settings other)
        {
            this.hostName = other.hostName;
            this.isIidkEnable = other.isIidkEnable;
            this.iidkManagedSlave = other.iidkManagedSlave;
            this.iidkMap = other.iidkMap;
            this.iidkMonitor = other.iidkMonitor;
        }

        #endregion

        #region Properties
        public string HostName
        {
            get { return this.hostName; }
            set
            {
                IsHostNameValid(value);
                this.hostName = value;
                this.OnPropertyChanged("HostName");
            }
        }
        public bool IsIidkEnable
        {
            get { return this.isIidkEnable; }
            set
            {
                this.isIidkEnable = value;
                this.OnPropertyChanged("IsIidkEnable");
            }
        }
        public string IidkManagedSlave
        {
            get { return this.iidkManagedSlave; }
            set
            {
                IsHostNameValid(value);
                this.iidkManagedSlave = value;
                this.OnPropertyChanged("IidkManagedSlave");
            }
        }
        public string IidkMap
        {
            get { return this.iidkMap; }
            set
            {
                this.iidkMap = value;
                this.OnPropertyChanged("IidkMap");
            }
        }
        public string IidkMonitor
        {
            get { return this.iidkMonitor; }
            set
            {
                this.iidkMonitor = value;
                this.OnPropertyChanged("IidkMonitor");
            }
        }

        #endregion

        #region Public Methods

        public Settings Clone()
        {
            return new Settings(this);
        }


        #endregion

        #region Validation

        public bool IsHostNameValid(string value)
        {
            bool isValid = true;

            var regex = new Regex("^[а-яА-Яa-zA-Z0-9_]*$");
            if (!regex.IsMatch(value))
            {
                AddError("HostName", HOST_NAME_ERROR, false);
                isValid = false;
            }
            else RemoveError("HostName", HOST_NAME_ERROR);

            return isValid;
        }

        #endregion


        #region IEquatable<Settings>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Settings objAsPart = obj as Settings;
            if (objAsPart == null) return false;
            else
                return Equals(objAsPart);
        }
        public bool Equals(Settings other)
        {
            if (other == null) return false;
            if (this.HostName == other.HostName
                && this.IsIidkEnable == other.IsIidkEnable
                && this.IidkManagedSlave == other.IidkManagedSlave
                && this.IidkMap == other.IidkMap
                && this.IidkMonitor == other.IidkMonitor
                )
                return true;
            else return false;
        }
        public override int GetHashCode()
        {
            return this.HostName.GetHashCode();
        }

        public static bool operator == (Settings obj1, Settings obj2)
        {
            if (object.ReferenceEquals(obj1, null))
            {
                return object.ReferenceEquals(obj2, null);
            }
            return obj1.Equals(obj2);
        }

        public static bool operator != (Settings obj1, Settings obj2)
        {
            if (object.ReferenceEquals(obj1, null))
            {
                return !object.ReferenceEquals(obj2, null);
            }
            return !obj1.Equals(obj2);
        }


        #endregion

    }
}
