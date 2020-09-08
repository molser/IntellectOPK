using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class Permission : IEquatable<Permission>
    {
        public int ID { set; get; }
        public string Name { set; get; }
        public string Description { set; get; }
        //public bool Grant { set; get; }
        public Permission()
        {
            ID = 0;
            Name = "";
            Description = "";
        }

        public Permission(int id,
                            string name,
                            string description)
        {
            ID = id;
            Name = name;
            Description = description;
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Permission objAsPart = obj as Permission;
            if (objAsPart == null) return false;
            else return Equals(objAsPart);
        }
        public override int GetHashCode()
        {
            return this.Name.GetHashCode();
        }
        public bool Equals(Permission other)
        {
            if (other == null) return false;
            return (this.Name.Equals(other.Name));
        }
    }
}
