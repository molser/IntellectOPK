using System;
using IntellectOPK.MessageService;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IntellectOPK.Commands;
using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System.Windows.Input;
using System.Collections.Concurrent;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Threading;
using IntellectOPK.IIDK;
using IntellectOPK.IIDK.ITV.Misc;

namespace IntellectOPK.Views
{
    public class IidkDebugViewModel : ViewModelBase
    {
        #region Member Data
        private IidkDebugView view;
        private string title;
        private RelayCommand startCommand;
        private RelayCommand stopCommand;
        private RelayCommand confirmCommand;
        private RelayCommand connectCommand;
        private RelayCommand disconnectCommand;
        private RelayCommand showIidkMessageViewCommand;
        private RelayCommand testCommand;
        private RelayCommand clearMessagesCommand;
        private RelayCommand newMessageCommand;
        private bool isServiceRunning = false;
        private bool isConnecting = false;
        private bool isConnected = false;
        //private ConcurrentQueue<Message> messages;
        private ObservableCollection<Message> messages;
        private Message currentMessage;
        private IIntellectAgent intellectAgent;
        //максимальное количество отображаемых сообщений
        private const int LINES_MAX = 10000;
        #endregion


        #region Constructor
        public IidkDebugViewModel(IidkDebugView view, IIntellectAgent intellectAgent)
            : base()
        {
            this.view = view;
            this.title = "Отладочное окно";
            //this.messages = new ConcurrentQueue<Message>();
            this.messages = new ObservableCollection<Message>();
            this.currentMessage = new Message();
            this.intellectAgent = intellectAgent;
            this.intellectAgent.OnConnected += new EventHandler(this.iidkAgent_OnConnected);
            this.intellectAgent.OnDisconnected += new EventHandler(this.iidkAgent_OnDisconnected);
        }
        #endregion

        #region Private Methods
        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
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

        public ObservableCollection<Message> Messages
        {
            get { return this.messages; }
            set
            {
                this.messages = value;
                this.OnPropertyChanged("Messages");
            }
        }
        public Message CurrentMessage
        {
            get { return this.currentMessage; }
            set
            {
                this.currentMessage = value;
                this.OnPropertyChanged("CurrentMessage");
            }
        }
        public bool IsConnecting
        {
            get { return this.isConnecting; }
            set
            {
                this.isConnecting = value;
                this.OnPropertyChanged("IsConnecting");
            }
        }
        public bool IsConnected
        {
            get
            {
                if (this.intellectAgent != null) return this.intellectAgent.IsConnected;
                return this.isConnected;
            }
            set
            {
                this.isConnected = value;
                this.OnPropertyChanged("IsConnected");
            }
        }
        public bool IsServiceRunning
        {
            get { return this.isServiceRunning; }
            set
            {
                this.isServiceRunning = value;
                this.OnPropertyChanged("IsServiceRunning");
            }
        }

        #endregion


        #region Protected Methods
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);

            if (this.intellectAgent != null)
            {
                this.intellectAgent.OnConnected -= new EventHandler(this.iidkAgent_OnConnected);
                this.intellectAgent.OnDisconnected -= new EventHandler(this.iidkAgent_OnDisconnected);
                this.intellectAgent.OnMessage -= new EventHandler<MessageEventArgs>(this.iidkAgent_OnMessage);
                //this.releaseConnector();
            }
        }

        #endregion


        #region Commands
        public ICommand StartCommand
        {
            get
            {
                if (this.startCommand == null)
                {
                    this.startCommand = new RelayCommand(executeStartCommand, canExecuteStartCommand);
                }
                return this.startCommand;
            }
        }

        public ICommand StopCommand
        {
            get
            {
                if (this.stopCommand == null)
                {
                    this.stopCommand = new RelayCommand(executeStopCommand, canExecuteStopCommand);
                }
                return this.stopCommand;
            }
        }        

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
        public ICommand ConnectCommand
        {
            get
            {
                if (this.connectCommand == null)
                {
                    this.connectCommand = new RelayCommand(executeConnectCommand, canExecuteConnectCommand);
                }
                return this.connectCommand;
            }
        }

        public ICommand DisconnectCommand
        {
            get
            {
                if (this.disconnectCommand == null)
                {
                    this.disconnectCommand = new RelayCommand(executeDisconnectCommand, canExecuteDisconnectCommand);
                }
                return this.disconnectCommand;
            }
        }
        public ICommand ShowIidkMessageViewCommand
        {
            get
            {
                if (this.showIidkMessageViewCommand == null)
                {
                    this.showIidkMessageViewCommand = new RelayCommand(executeShowIidkMessageViewCommand);
                }
                return this.showIidkMessageViewCommand;
            }
        }
        public ICommand ClearMessagesCommand
        {
            get
            {
                if (this.clearMessagesCommand == null)
                {
                    this.clearMessagesCommand = new RelayCommand(executeClearMessagesCommand);
                }
                return this.clearMessagesCommand;
            }
        }

        public ICommand TestCommand
        {
            get
            {
                if (this.testCommand == null)
                {
                    this.testCommand = new RelayCommand(executeTestCommand, canExecuteTestCommand);
                }
                return this.testCommand;
            }
        }
        public ICommand NewMessageCommand
        {
            get
            {
                if (this.newMessageCommand == null)
                {
                    this.newMessageCommand = new RelayCommand(executeNewMessageCommand, canExecuteNewMessageCommand);
                }
                return this.newMessageCommand;
            }
        }

        #endregion


        #region Helper Methods

        private bool canExecuteNewMessageCommand(object obj)
        {
            return this.IsConnected;
        }

        private void executeNewMessageCommand(object obj)
        {
            string msgString = Clipboard.GetText();
            if(msgString == null)
            {
                IntellectOPK.MessageService.Message.ShowError("Нет данных в буфере обмена", "Ошибка", this.view);
            }
            else
            {
                //IntellectOPK.MessageService.Message.ShowMessage(msgString, "Данные буфера обмена", this.view);
                IidkMessageView iidkMessageView = new IidkMessageView();
                iidkMessageView.ViewModel = new IidkMessageViewModel(iidkMessageView, msgString);
                iidkMessageView.Owner = this.view;
                iidkMessageView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                iidkMessageView.ShowInTaskbar = false;
                iidkMessageView.Show();
            }
            //Message.ShowError(e.Message, e.GetType().ToString(), this.view);
            //Message.ShowExclamation("Предупреждаю", "Внимание", this.view);
            //Message.ShowMessage("Файл успешно сохранен", "Информация", this.view);
        }

        private bool canExecuteTestCommand(object obj)
        {
            return this.IsConnected;
        }
        private void executeTestCommand(object obj)
        {
            React react = new React("MONITOR", "106", "ARCH_FRAME_TIME");
            react.SetParam("cam", "252");
            react.SetParam("date", "18-11-19");
            react.SetParam("time", "16:05:44");
            react.SetParam("__slave_id", "DOM2ARMVIDEO08");

            string msgString = react.ToString();
            msgString = Msg.ConvertReactToCoreEvent(react).ToString();
            this.intellectAgent.SendMessage(msgString); 
        }

        private void executeClearMessagesCommand(object obj)
        {
            lock (this.messages)
            {
                this.messages.Clear();
            }
        }

        private bool canExecuteStopCommand(object obj)
        {
            return this.isServiceRunning;
        }

        private void executeStopCommand(object obj)
        {
            this.intellectAgent.OnMessage -= new EventHandler<MessageEventArgs>(this.iidkAgent_OnMessage);
            this.IsServiceRunning = false;
        }

        private bool canExecuteStartCommand(object obj)
        {
            return !this.isServiceRunning;
        }

        private void executeStartCommand(object obj)
        {
            this.IsServiceRunning = true;
            this.intellectAgent.OnMessage += new EventHandler<MessageEventArgs>(this.iidkAgent_OnMessage);
            raiseCanExecuteChanged();
        }
        protected void executeShowIidkMessageViewCommand(object obj)
        {
            IidkMessageView iidkMessageView = new IidkMessageView();
            iidkMessageView.ViewModel = new IidkMessageViewModel(iidkMessageView,currentMessage.Value);
            iidkMessageView.Owner = this.view;
            iidkMessageView.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            iidkMessageView.ShowInTaskbar = false;
            iidkMessageView.Show();
        }

        private bool canExecuteDisconnectCommand(object obj)
        {
            return this.isConnected || this.isConnecting;
        }

        private void executeDisconnectCommand(object obj)
        {
            this.IsConnecting = false;
            this.destroyIidkAgent();
            this.IsConnected = false;
        }

        private bool canExecuteConnectCommand(object obj)
        {
            return !this.isConnecting && !this.isConnected;
        }

        private void executeConnectCommand(object obj)
        {
            /*
            lock (this.connectorLock)
            {
                this.connector = new Client("DOM2SERVERSKUD", "127.0.0.1", 1030, Client.ResponceType.ResponceTypeRaw);
                this.connector.OnConnected += new EventHandler(this.iidkAgent_OnConnected);
                this.connector.OnDisconnected += new EventHandler(this.iidkAgent_OnDisconnected);
                this.connector.OnMessage += new EventHandler<Client.MessageEventArgs>(this.iidkAgent_OnMessage);
                //this.connector.OnBitmap += new EventHandler<Client.BitmapEventArgs>(this.iidkAgent_OnBitmap);
                this.connector.Connect();
                this.IsConnecting = true;
            }
            */
            //string path = Environment.GetEnvironmentVariable("SystemRoot") + "Media\\Windows Hardware Fail.wav"
            //SoundPlayer player = new SoundPlayer(path);
            //Uri uri = new Uri(@"pack://application:,,,/Resources/Media/LinkLost.wav", UriKind.Absolute);
            //Uri uri = new Uri("Resources/Media/LinkLost.wav", UriKind.Relative);
        }
        private bool canExecuteConfirmCommand(object obj)
        {
            return true;
        }

        private void executeConfirmCommand(object obj)
        {
            this.view.Close();
        }


        private void destroyIidkAgent()
        {            
            if (this.intellectAgent != null)
            {
                this.intellectAgent.Dispose();
                this.intellectAgent = null;
            }            
        }
        private void iidkAgent_OnConnected(object sender, EventArgs e)
        {
            //this.IsConnecting = false;
            this.IsConnected = true;                    
        }

        private void iidkAgent_OnDisconnected(object sender, EventArgs e)
        {
            this.IsConnected = false;
        }

        private void iidkAgent_OnMessage(object sender, MessageEventArgs e)
        {
            lock (this.Messages)
            {
                Application.Current.Dispatcher.BeginInvoke(DispatcherPriority.Background,
                                                            new Action(() =>
                     {
                         while (this.messages.Count > LINES_MAX)
                             this.Messages.RemoveAt(0);

                         this.Messages.Add(new Message()
                         {
                             Timestamp = DateTime.Now,
                             Value = e.Message
                         });
                         //this.OnPropertyChanged("Messages");
                     }
                 ));

            }
        }


        #endregion

        public class Message
        {
            public DateTime Timestamp { get; set; }

            public string Value { get; set; }
        }
    }
}

