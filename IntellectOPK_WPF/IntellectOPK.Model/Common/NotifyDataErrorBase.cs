using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public class NotifyDataErrorBase : INotifyDataErrorInfo, INotifyPropertyChanged
    {
        #region Private Members

            private Dictionary<String, List<String>> errors = new Dictionary<string, List<string>>();

        #endregion

        #region Helper Methods

            // Adds the specified error to the errors collection if it is not 
            // already present, inserting it in the first position if isWarning is 
            // false. Raises the ErrorsChanged event if the collection changes. 
            public void AddError(string propertyName, string error, bool isWarning)
            {
                if (!errors.ContainsKey(propertyName))
                    errors[propertyName] = new List<string>();

                if (!errors[propertyName].Contains(error))
                {
                    if (isWarning) errors[propertyName].Add(error);
                    else errors[propertyName].Insert(0, error);
                    RaiseErrorsChanged(propertyName);
                }
            }

            // Removes the specified error from the errors collection if it is
            // present. Raises the ErrorsChanged event if the collection changes.
            public void RemoveError(string propertyName, string error)
            {
                if (errors.ContainsKey(propertyName) &&
                    errors[propertyName].Contains(error))
                {
                    errors[propertyName].Remove(error);
                    if (errors[propertyName].Count == 0) errors.Remove(propertyName);
                    RaiseErrorsChanged(propertyName);
                }
            }

            public void RaiseErrorsChanged(string propertyName)
            {
                if (ErrorsChanged != null)
                    ErrorsChanged(this, new DataErrorsChangedEventArgs(propertyName));
            }

        #endregion

        #region INotifyDataErrorInfo Members

        public event EventHandler<DataErrorsChangedEventArgs> ErrorsChanged;

        public System.Collections.IEnumerable GetErrors(string propertyName)
        {
            if (String.IsNullOrEmpty(propertyName) ||
                !errors.ContainsKey(propertyName)) return null;
            return errors[propertyName];
        }

        public bool HasErrors
        {
            get { return errors.Count > 0; }
        }

        #endregion

        #region INotifyPropertyChanged

        public event PropertyChangedEventHandler PropertyChanged;

        public virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChangedEventHandler handler = this.PropertyChanged;
            if (handler != null)
            {
                this.EnsureProperty(propertyName);
                handler.Invoke(this, new PropertyChangedEventArgs(propertyName));
            }
        }

        [Conditional("DEBUG")]
        private void EnsureProperty(string propertyName)
        {
            if (TypeDescriptor.GetProperties(this)[propertyName] == null)
            {
                throw new ArgumentException("Property does not exist.", "propertyName");
            }
        }
        #endregion

    }
}
