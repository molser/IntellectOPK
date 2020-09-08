using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IntellectOPK.Commands;
using IntellectOPK.MessageService;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System.Data;
using System.Windows.Input;
using System.Diagnostics;
using System.Threading;

namespace IntellectOPK.Views
{
    
    public class LevelViewModel : ViewModelBase
    {
        #region Member Data
        private LevelView view;
        private ManageLevelAction action;
        private string title;
        private IDataAccessService das = null;
        private Level level;
        private Level oldLevel;
        private Permissions appUserPermissions;
        private RelayCommand confirmCommand;
        private bool useOperDb = false;
        private bool levelChanged = false;
        #endregion


        #region Constructor

        public LevelViewModel  (IDataAccessService dataService, 
                                LevelView view,
                                bool useOperDb,
                                Permissions appUserPermissions,
                                Level level)
            : base()
        {
            this.view = view;
            this.das = dataService;
            this.appUserPermissions = appUserPermissions;
            this.action = ManageLevelAction.Modify;
            this.useOperDb = useOperDb;

            this.title = "Уровень доступа";
            this.level = level;
            this.oldLevel = level.Clone();                
            this.level.PropertyChanged += Level_PropertyChanged;
            
        }

        #endregion

        #region Private Methods
        private void Level_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if(this.levelChanged != true)
                this.LevelChanged = true;
        }

        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }
        
        #endregion

        #region Public Methods


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

        public Level Level
        {
            get { return this.level; }
            set
            {
                this.level = value;
                this.OnPropertyChanged("Level");
            }

        }

        public Boolean LevelChanged
        {
            get { return this.levelChanged; }
            set
            {
                this.levelChanged = value;
                this.OnPropertyChanged("LevelChanged");
                this.raiseCanExecuteChanged();                
            }
        }

        public Permissions AppUserPermissions
        {
            get { return this.appUserPermissions; }
            set
            {
                this.appUserPermissions = value;
                this.OnPropertyChanged("AppUserPermissions");
                this.raiseCanExecuteChanged();
            }
        }

        #endregion


        #region Protected Methods

        #endregion


        #region Commands
        public ICommand ConfirmCommand
        {
            get
            {
                if (this.confirmCommand == null)
                {
                    this.confirmCommand = new RelayCommand(executeConfirmCommand, canExecuteConfirmCommand);
                }
                return this.confirmCommand;
            }
        }

        
        #endregion


        #region Helper Methods
        private async void executeConfirmCommand(object obj)
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;

            try
            {
                bool level_changed = true;

                if(this.level == this.oldLevel)
                {
                    //System.Windows.Forms.MessageBox.Show("Равны!");
                    level_changed = false;
                }
                    //else System.Windows.Forms.MessageBox.Show("Не равны!");
                
                if (level_changed)
                {
                    await das.ManageLevelAsync(token, this.action, this.level, false);
                    if(this.useOperDb == true)
                        await das.ManageLevelAsync(token, this.action, this.level, true);
                }
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }
            
            this.view.DialogResult = true;
        }
        private bool canExecuteConfirmCommand(object obj)
        {
            return this.levelChanged;
        }


        #endregion
    }
}
