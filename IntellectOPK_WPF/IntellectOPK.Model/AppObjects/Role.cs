using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IntellectOPK.Model
{
    public class Role : IEquatable<Role>
    {
        public int ID { set; get; }
        public string Name { set; get; }
        public string Description { set; get; }

        //public List<Permission> Permissions { set; get; }
        public Role()
        {
            ID = 0;
            Name = "";
            Description = "";
        }

        public Role(int id,
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
            Role objAsPart = obj as Role;
            if (objAsPart == null) return false;
            else return Equals(objAsPart);
        }
        public override int GetHashCode()
        {
            return this.Name.GetHashCode();
        }
        public bool Equals(Role other)
        {
            if (other == null) return false;
            return (this.Name.Equals(other.Name));
        }
    }
}
