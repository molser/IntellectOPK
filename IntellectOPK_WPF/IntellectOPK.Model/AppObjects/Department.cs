using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace IntellectOPK.Model
{
    public class Department : AppObjectBase,  IEquatable<Department>
    {
        #region Private Members
        private int deptKey;
        private string id;
        private string name;
        private Guid guid;

        //private const string NAME_ERROR = @"Значение может содержать только буквы, цифры, пробел и знаки: ._ /\()-";

        #endregion

        #region Constructor
        public Department()
        {
            deptKey = 0;
            id = "";
            name = "";
            guid = new Guid("00000000-0000-0000-0000-000000000000");
        }

        public Department(int dept_key,
                      string id,
                      Guid guid,
                      string name
                      )
        //bool must_change_password = false)
        {
            this.deptKey = dept_key;
            this.id = id;
            this.guid = guid;
            this.name = name;
        }


        #endregion


        #region Properties
        //public static string ValidCharsForName
        //{
        //    get { return @"а-яА-Яa-zA-Z0-9() _\-./\\"; }
        //}
        public override string NameBase
        {
            get
            {
                return this.name;
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

        public int DeptKey
        {
            get { return this.deptKey; }
            set
            {
                this.deptKey = value;
                this.OnPropertyChanged("DeptKey");
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
                //IsNameValid(value);
                this.name = value;
                this.OnPropertyChanged("Name");
            }
        }

        #endregion

        #region Validation

        //public bool IsNameValid(string value)
        //{
        //    bool isValid = true;


        //    var regex = new Regex("^[а-яА-Яa-zA-Z0-9 _ /\\.]*$");
        //    if (!regex.IsMatch(value))
        //    {
        //        AddError("Name", NAME_ERROR, false);
        //        isValid = false;
        //    }
        //    else RemoveError("Name", NAME_ERROR);


        //    return isValid;
        //}

        #endregion

        #region IEquatable<User>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Department objAsPart = obj as Department;
            if (objAsPart == null) return false;
            else return Equals(objAsPart);
        }
        public override int GetHashCode()
        {
            return this.name.GetHashCode();
        }
        public bool Equals(Department other)
        {
            if (other == null) return false;
            return (this.name.Equals(other.name));
        }


        #endregion

    }
}
