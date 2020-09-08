using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Input;
using IntellectOPK.Commands;
using IntellectOPK.Utilities;

namespace IntellectOPK.Views
{
    public class AboutViewModel: ViewModelBase
    {
        #region Member Data
        
            private System.Windows.Window view;
            private string version;
            private string description;
            private string copyright;
            private string developers;
            private RelayCommand closeCommand;

        #endregion
        
        
        #region Constructor

        public AboutViewModel(System.Windows.Window view)
        {
            this.view = view;
            this.version = "ver. " + AssemlyInfoHelper.AssemblyVersion;
            this.description = AssemlyInfoHelper.AssemblyName;
            this.copyright = AssemlyInfoHelper.AssemblyCopyright;
            this.developers = "разработчики:"
                              + Environment.NewLine + "Молотков С.А";
        }

        #endregion

        
        #region Properties

        public string Version
        {
            get { return this.version; }
        }

        public string Description
        {
            get { return this.description; }
        }

        public string Copyright
        {
            get { return this.copyright; }
        }
        public string Developers
        {
            get { return this.developers; }
        }

        #endregion


        #region Protected Methods
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);            
        }
        #endregion
        
       
        #region Commands
        public ICommand CloseCommand
        {
            get
            {
                if (this.closeCommand == null)
                {
                    this.closeCommand = new RelayCommand(ExecuteCloseCommand,null);
                }
                return this.closeCommand;
            }
        }
        #endregion

        
        #region Helper Methods
        protected void ExecuteCloseCommand(object param)
        {
            this.view.DialogResult = true;
            //закрываем окно
            //if (UserInterfaceUtilities.ValidateVisualTree(this.view) == true)
            //{
            //this.view.Close();
            //}
        }
        #endregion
    }
}
