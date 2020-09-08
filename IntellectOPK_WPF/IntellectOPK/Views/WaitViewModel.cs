using IntellectOPK.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Input;

namespace IntellectOPK.Views
{
    public class WaitViewModel : ViewModelBase
    {
        #region Member Data
        private string title;
        private string text;
        private RelayCommand cancelCommand;

        #endregion


        #region Constructor
        public WaitViewModel()
        {
            this.title = "Подождите...";
            //this.text = "Идет соединение с базой данных..." + "\n" +
            //            @"Очень длинный текст для проверки как будет изменен размер окна в зависимости от того насколько длинным окажется данный текст";
            //this.cancelCommand = cancelCommand;
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

        public string Text
        {
            get { return this.text; }
            set 
            { 
                this.text = value;
                this.OnPropertyChanged("Text");
            }
        }

        #endregion


        #region Protected Methods

        #endregion


        #region Commands

        public ICommand Cancel
        {
            get { return this.cancelCommand; }
            set { this.cancelCommand = (RelayCommand)value; }
        }

        #endregion


        #region Helper Methods

        #endregion
    }
}
