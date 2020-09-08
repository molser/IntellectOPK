using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class AppObjectBase : NotifyDataErrorBase
    {
        private bool isChecked;        
        public bool IsChecked
        {
            get { return this.isChecked; }
            set
            {
                this.isChecked = value;
                this.OnPropertyChanged("IsChecked");
            }
        }
        public virtual string NameBase
        {
            get { return "BaseAppObject"; }
        }
        public virtual string Id
        {
            get { return "0"; }
            set { }
        }
    }
}
