using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class LoginParams //: NotifyDataErrorBase
    {
        #region Private Members

        private User user = new User();
        
        #endregion

        #region Public Members

        public User User
        {
            get { return this.user; }
            set { this.user = value; }
        }

        #endregion      

    }
}
