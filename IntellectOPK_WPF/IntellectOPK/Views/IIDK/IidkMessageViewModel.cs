using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using IntellectOPK.Commands;
using IntellectOPK.IIDK.ITV.Misc;

namespace IntellectOPK.Views
{
    public class IidkMessageViewModel : ViewModelBase
    {
        #region Member Data
        private IidkMessageView view;
        private string title;
        private RelayCommand confirmCommand;
        private DataTable paramsDataTable;
        private Msg msg;
        #endregion


        #region Constructor
        public IidkMessageViewModel(IidkMessageView view, string msgString)
            : base()
        {
            this.view = view;
            this.title = "IIDK сообщение";
            //this.messages = new ConcurrentQueue<Message>();
            this.msg = new Msg(msgString);
            this.paramsDataTable = new DataTable();
            iidkMsgParamsToDataTable(this.paramsDataTable, msg);
            raiseOnPropertyChanged();
        }
        #endregion

        #region Private Methods
        void raiseOnPropertyChanged()
        {
            this.OnPropertyChanged("SourceType");
            this.OnPropertyChanged("SourceId");
            this.OnPropertyChanged("SourceAction");
            this.OnPropertyChanged("Params");
        }
        void iidkMsgParamsToDataTable(DataTable table, Msg msg)
        {
            DataColumn nameColumn = new DataColumn("ParamName", Type.GetType("System.String"));
            //nameColumn.ReadOnly = true;
            //nameColumn.Unique = true;
            table.Columns.Add(nameColumn);

            DataColumn valueColumn = new DataColumn("ParamValue", Type.GetType("System.String"));
            //valueColumn.ReadOnly = true;
            //valueColumn.Unique = false;
            table.Columns.Add(valueColumn);


            foreach (KeyValuePair<string, string> keyValuePair in msg)
            {
                DataRow row = table.NewRow();
                row["ParamName"] = keyValuePair.Key;
                row["ParamValue"] = keyValuePair.Value;
                table.Rows.Add(row);
            }

            table.AcceptChanges();
            //сортируем записи
            DataView dv = table.DefaultView;
            dv.Sort = "ParamName asc";
            DataTable dt = dv.ToTable();
            table = dt;
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
        public string SourceType
        {
            get { return this.msg.SourceType; }
            set
            {
                this.msg.SourceType = value;
                this.OnPropertyChanged("SourceType");
            }
        }
        public string SourceId
        {
            get { return this.msg.SourceId; }
            set
            {
                this.msg.SourceId = value;
                this.OnPropertyChanged("SourceId");
            }
        }
        public string Action
        {
            get { return this.msg.Action; }
            set
            {
                this.msg.Action = value;
                this.OnPropertyChanged("Action");
            }
        }
        public DataTable Params
        {
            get { return this.paramsDataTable; }
            set
            {
                this.paramsDataTable = value;
                this.OnPropertyChanged("Params");
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
        private bool canExecuteConfirmCommand(object obj)
        {
            return true;
        }

        private void executeConfirmCommand(object obj)
        {
            this.view.Close();
        }
        #endregion
    }
}
