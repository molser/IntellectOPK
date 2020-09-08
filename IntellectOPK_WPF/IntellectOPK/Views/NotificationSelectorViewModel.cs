using IntellectOPK.Commands;
using IntellectOPK.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace IntellectOPK.Views
{
    public class NotificationSelectorViewModel: ViewModelBase
    {
        #region Member Data
        private string title = "Выберите тип оповещения";
        private NotificationType notificationType;
        private RelayCommand selectCommand;
        private NotificationSelector view;
        #endregion


        #region Constructor
        public NotificationSelectorViewModel(NotificationSelector view)
        {
            this.view = view;
        }
        #endregion


        #region Properties
        public string Title
        {
            get { return this.title; }
            set
            {
                this.title = value;
                this.OnPropertyChanged("Title");
            }
        }

        public NotificationType NotificationType
        {
            get { return this.notificationType; }            
        }
        #endregion


        #region Protected Methods

        #endregion


        #region Commands
        public ICommand SelectCommand
        {
            get
            {
                if (this.selectCommand == null)
                {
                    this.selectCommand = new RelayCommand(executeSelectCommand);
                }
                return this.selectCommand;
            }
        }
        #endregion


        #region Helper Methods
        private void executeSelectCommand(object obj)
        {
            if (obj != null)
            {
                switch (obj.ToString())
                {
                    case "Person":
                        this.notificationType = NotificationType.Person;
                        break;
                    case "AccessPoint":
                        this.notificationType = NotificationType.AccessPoint;
                        break;
                }
            }
            this.view.DialogResult = true;
        }
        #endregion
    }
}
