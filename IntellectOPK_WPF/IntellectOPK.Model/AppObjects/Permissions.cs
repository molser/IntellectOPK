using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class Permissions
    {
        private HashSet<String> permissions = new HashSet<String>();

        //private Dictionary<String, Boolean> permissions = new Dictionary<string, bool>();

        //public Dictionary<String, Boolean> GetAllPermissions()
        //{
        //    return this.permissions;        
        //}

        //public bool this[string permission]
        //{
        //    get
        //    {
        //        if (permissions.ContainsKey(permission) &&
        //            permissions[permission] == true) return true;
        //        else return false;
        //    }
        //    set
        //    {
        //       permissions[permission] = value;                
        //    }
        //}        

        public bool Add(string permission)
        {
            return permissions.Add(permission);
        }

        public bool this[string permission]
        {
            get
            {
                return permissions.Contains(permission);
            }            
        }
    }
}
