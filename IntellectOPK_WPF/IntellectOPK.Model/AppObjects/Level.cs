using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace IntellectOPK.Model
{
    public class Level: AppObjectBase, IEquatable<Level>
    {

        private string id;
        private int num;
        private string name;
        private string description;
        private string type;
        private float rank;
        //private const string NUMERIC_ERROR = "Значение должно быть числовым";

        public override string NameBase
        {
            get
            {
                return this.name;
            }
        }

        public override string Id
        {
            get
            {
                return this.id;
            }
            set
            {
                this.id = value;
                this.OnPropertyChanged("Id");
            }
        }
        public int Num
        {
            get
            {
                return this.num;
            }
            set
            {
                this.num = value;
                this.OnPropertyChanged("Num");
            }
        }
        public string Name
        {
            get
            {
                return this.name;
            }
            set
            {
                this.name = value; 
                this.OnPropertyChanged("Name");
            }
        }
        public string Description
        {
            get
            {
                return this.description;
            }
            set
            {
                this.description= value;
                this.OnPropertyChanged("Description");
            }
        }
        public string Type
        {
            get
            {
                return this.type;
            }
            set
            {
                this.type = value;
                this.OnPropertyChanged("Type");
            }
        }
        public float Rank
        {
            get
            {
                return this.rank;
            }
            set
            {
                this.rank = value;
                this.OnPropertyChanged("Rank");
            }
        }


        public Level() { }

        public Level(string id,
                    int num,
                    string name,
                    string description,
                    string type,
                    float rank)
        {
            Id = id;
            Num = num;
            Name = name;
            Description = description;
            Type = type;
            Rank = rank;
            
        }

        protected Level(Level other)
        {
            this.Id = other.Id;
            this.Num = other.Num;
            this.Name = other.Name;
            this.Description = other.Description;
            this.Type = other.Type;
            this.Rank = other.Rank;
        }

        public Level Clone()
        {
            return new Level(this);
        }


        #region IEquatable<Level>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Level objAsPart = obj as Level;
            if (objAsPart == null) return false;
            else
                return Equals(objAsPart);
        }
        public bool Equals(Level other)
        {
            if (other == null) return false;
            if (this.Id == other.Id
                && this.Num == other.Num
                && this.Name == other.Name
                && this.Description == other.Description
                && this.Type == other.Type
                && this.Rank == other.Rank
                )
                return true;
            else return false;
        }
        public override int GetHashCode()
        {
            return this.Id.GetHashCode();
        }

        public static bool operator ==(Level u1, Level u2)
        {
            if (object.ReferenceEquals(u1, null))
            {
                return object.ReferenceEquals(u2, null);
            }
            return u1.Equals(u2);
        }

        public static bool operator !=(Level u1, Level u2)
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
