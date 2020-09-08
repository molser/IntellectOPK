using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Text;
using System.Text.RegularExpressions;
using IntellectOPK.IIDK.ITV.Misc;
using IntellectOPK.Model;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Threading;
using System.Xml.Serialization;
using System.IO;
using IntellectOPK.Views;
using System.Media;
using System.Linq;
using System.Speech.Synthesis;
using System.Collections.Concurrent;

namespace IntellectOPK
{
    public class NotificationsManager: INotifyPropertyChanged, IDisposable
    {
        //private Dictionary<string, int> notificationsDic = new Dictionary<string, int>();
        private Dictionary<string, AccessPoint> accessPointsDic = new Dictionary<string, AccessPoint>();
        //private ObservableCollection<Notification> notifications = new ObservableCollection<Notification>();
        private List<Notification> notifications = new List<Notification>();
        private int count;
        private int alarmedCount;
        private int unconfirmedCount;
        private bool isAlarming;
        //private bool isSoundPlaying;
        private object notificationsLocker = new object();
        //private object notificationsDicLocker = new object();
        private object alarmedCountLocker = new object();
        private object unconfirmedCountLocker = new object();
        private object isAlarmingLocker = new object();
        private object notificationLocker = new object();
        //private object synthesizersLocker = new object();
        //private object textToSpeechListLocker = new object();
        //private object alarmSoundLocker = new object();
        private SettingsViewModel appSettings;
        //private List<SpeechSynthesizer> synthesizers = new List<SpeechSynthesizer>();
        //private List<string> textToSpeechList = new List<string>();
        SoundPlayer player = new SoundPlayer();
        private SpeechSynthesizer synthesizer = new SpeechSynthesizer();
        private ConcurrentQueue<string> textToSpeechQueue = new ConcurrentQueue<string>();

        
        public NotificationsManager()
        {
            this.synthesizer.SpeakCompleted += synthesizer_SpeakCompleted;               
        }
        

        private Dictionary<string, string> events = new Dictionary<string, string>
        {
            { "EVENTA1", "В доступе отказано (режим блокировки)" },
            { "EVENTA2", "В доступе отказано (нет ключа в БД контроллера)" },
            { "EVENTA3", "В доступе отказано (режим охраны)" },
            { "EVENTA4", "В доступе на вход отказано (APB)" },
            { "EVENTA5", "В доступе на выход отказано (APB)" },
            { "EVENTA6", "В доступе отказано (временной профиль)" },
            { "ACCESS_IN", "Вход" },
            { "ACCESS_OUT1", "Выход" },
            { "EVENTC2", "Выход вне временного профиля" },
            { "EVENT81", "Взлом двери" },
            { "EVENT86", "Аварийное открывание двери" },
            { "EVENTE2", "Дверь открыта с ПК" },
            { "EVENTE3", "Дверь закрыта с ПК" },
            { "EVENTCA", "Фактический выход по DRTE" },
            { "EVENTEB", "Фактический выход по RTE" }
            //"EVENTD7" // Запрос на проход
        };

        private HashSet<string> personEvents = new HashSet<string>()
        {
            "EVENTA1", //"В доступе отказано (режим блокировки)" },
            "EVENTA2", //"В доступе отказано (нет ключа в БД контроллера)" },
            "EVENTA3", //"В доступе отказано (режим охраны)" },
            "EVENTA4", //"В доступе на вход отказано (APB)" },
            "EVENTA5", //"В доступе на выход отказано (APB)" },
            "EVENTA6", //"В доступе отказано (временной профиль)" },
            "ACCESS_IN", //"Вход" },
            "ACCESS_OUT1", //"Выход" },
            "EVENTC2", //"Выход вне временного профиля" },
            "EVENT81", //"Взлом двери" },
            "EVENT86", //"Аварийное открывание двери" },
            "EVENTE2", //"Дверь открыта с ПК" },
            "EVENTE3", //"Дверь закрыта с ПК" },
            "EVENTCA", //"Фактический выход по DRTE" },
            "EVENTEB", //"Фактический выход по RTE" }
            //"EVENTD7" // Запрос на проход
        };

        private HashSet<string> accessPointEvents = new HashSet<string>
        {
            "EVENTA1", //"В доступе отказано (режим блокировки)" },
            "EVENTA2", //"В доступе отказано (нет ключа в БД контроллера)" },
            "EVENTA3", //"В доступе отказано (режим охраны)" },
            "EVENTA4", //"В доступе на вход отказано (APB)" },
            "EVENTA5", //"В доступе на выход отказано (APB)" },
            "EVENTA6", //"В доступе отказано (временной профиль)" },
            "ACCESS_IN", //"Вход" },
            "ACCESS_OUT1", //"Выход" },
            "EVENTC2", //"Выход вне временного профиля" },
            "EVENT81", //"Взлом двери" },
            "EVENT86", //"Аварийное открывание двери" },
            "EVENTE2", //"Дверь открыта с ПК" },
            "EVENTE3", //"Дверь закрыта с ПК" },
            "EVENTCA", //"Фактический выход по DRTE" },
            "EVENTEB", //"Фактический выход по RTE" }
            //"EVENTD7" // Запрос на проход
        };

        private void subscribeNotification(Notification notification)
        {
            notification.OnAlarmEnd += this.onNotificationAlarmEnd;
            notification.OnConfirm += this.onNotificationConfirm;
        }
        private void unsubscribeNotification(Notification notification)
        {
            notification.OnAlarmEnd -= this.onNotificationAlarmEnd;
            notification.OnConfirm -= this.onNotificationConfirm;
        }
        //private void subscribeNotifications(ObservableCollection<Notification> notifications)
        private void subscribeNotifications(List<Notification> notifications)
        {
            foreach(Notification notification in notifications)
            {
                notification.OnAlarmEnd += this.onNotificationAlarmEnd;
                notification.OnConfirm += this.onNotificationConfirm;
            }
        }
        //private void unsubscribeNotifications(ObservableCollection<Notification> notifications)
        private void unsubscribeNotifications(List<Notification> notifications)
        {
            foreach (Notification notification in notifications)
            {
                notification.OnAlarmEnd -= this.onNotificationAlarmEnd;
                notification.OnConfirm -= this.onNotificationConfirm;
            }
        }
        private void onNotificationAlarmEnd(object sender, EventArgs e)
        {
            lock(this.alarmedCountLocker)
            {
                this.AlarmedCount--;
                if(this.alarmedCount == 0)
                {
                    lock(this.isAlarmingLocker)
                    {
                        this.IsAlarming = false;
                    }
                }
            }
        }
        private void onNotificationConfirm(object sender, EventArgs e)
        {
            lock (this.unconfirmedCountLocker)
            {
                this.UnconfirmedCount--;
            }
        }

        private void playAlarm(Notification notification)
        {
            if(this.appSettings != null)
            {
                if (!this.appSettings.IsSoundDisabled)
                {
                    if(this.appSettings.IsAlarmVoiceEngineUsed)
                    {
                        if(!String.IsNullOrEmpty(this.appSettings.VoiceName))
                        {
                            string pattern = @"ТД\d-\d+_*\d*.";
                            Regex regex = new Regex(pattern);
                            string textToSpeech = regex.Replace((notification.Name + " - " + notification.Information), String.Empty);
                            pattern = @"[+]+";
                            regex = new Regex(pattern);
                            textToSpeech = regex.Replace(textToSpeech, String.Empty);
                            pattern = @"Фактический выход по [D]*RTE";
                            regex = new Regex(pattern);
                            textToSpeech = regex.Replace(textToSpeech, "Выход по кнопке");
                            Debug.WriteLine("TextToSpeech: " + textToSpeech);
                            try
                            {
                                //SpeechSynthesizer synthesizer = new SpeechSynthesizer();
                                //lock (this.synthesizersLocker)
                                //{
                                //    this.synthesizers.Add(synthesizer);
                                //}
                                //lock (this.textToSpeechListLocker)
                                //{
                                //    this.textToSpeechList.Add(textToSpeech);
                                //}
                                //synthesizer.SpeakCompleted += Synthesizer_SpeakCompleted;
                                //var voises =  synthesizer.GetInstalledVoices();
                                //synthesizer.SelectVoice("Alyona (Russian) SAPI5");
                                this.synthesizer.SelectVoice(this.appSettings.VoiceName);
                                //synthesizer.SelectVoice("Alyona (Russian) SAPI5");
                                this.synthesizer.Rate = this.appSettings.VoiceRate;
                                this.synthesizer.Volume = 100;
                                //PromptBuilder prompt = new PromptBuilder();
                                //prompt.AppendText(notification.Name);
                                //PromptStyle style = new PromptStyle();
                                //style.Rate = PromptRate.Slow;
                                //prompt.StartStyle(style);
                                //prompt.AppendText(notification.Information);
                                //prompt.EndStyle();
                                //synthesizer.SpeakAsync(prompt);
                                //lock(alarmSoundLocker)
                                //{
                                //    if (!this.isSoundPlaying)
                                //    {
                                //        this.isSoundPlaying = true;
                                //        synthesizer.SpeakAsync(textToSpeech);
                                //    }
                                //}

                                //Debug.WriteLine("#playAlarm");
                                //Debug.WriteLine("#textToSpeechQueue.Count: " + this.textToSpeechQueue.Count.ToString());
                                //Debug.WriteLine("#synthesizer.State: " + synthesizer.State.ToString());
                                if (this.synthesizer.State == SynthesizerState.Ready)
                                {
                                    this.synthesizer.SpeakAsync(textToSpeech);
                                }
                                else
                                {
                                    this.textToSpeechQueue.Enqueue(textToSpeech);
                                }                                
                            }
                            catch { }
                        }
                    }
                    else
                    {
                        string path = Environment.CurrentDirectory + "\\Resources\\Media\\ElectronicAlarm.wav";
                        if (!String.IsNullOrEmpty(this.appSettings.AlarmSoundFile))
                        {
                            path = this.appSettings.AlarmSoundFile;
                        }

                        this.player.SoundLocation = path;
                        try
                        {
                            //player.Load();
                            this.player.Play();
                        }
                        catch { }
                    }                    
                }
            }
        }

        private void synthesizer_SpeakCompleted(object sender, SpeakCompletedEventArgs e)
        {
            //lock (this.synthesizersLocker)
            //{
            //    //this.synthesizers.Remove(sender as SpeechSynthesizer);
            //    int index = this.synthesizers.IndexOf(sender as SpeechSynthesizer);
            //    this.synthesizers.RemoveAt(index);
            //    Debug.WriteLine("Synthesizers.Count: " + synthesizers.Count);
            //    lock (this.textToSpeechListLocker)
            //    {
            //        this.textToSpeechList.RemoveAt(index);
            //        Debug.WriteLine("TextToSpeechList: " + this.textToSpeechList.Count);
            //    }

            //    if (this.synthesizers.Count > 0)
            //    {
            //        this.synthesizers[0].SpeakAsync(this.textToSpeechList[0]);
            //    }
            //    else
            //    {
            //        lock (alarmSoundLocker)
            //        {
            //            this.isSoundPlaying = false;                        
            //        }
            //    }                    
            //}

            //Debug.WriteLine("#synthesizer_SpeakCompleted");
            //Debug.WriteLine("#textToSpeechQueue.Count: " + this.textToSpeechQueue.Count.ToString());
            //Debug.WriteLine("#synthesizer.State: " + synthesizer.State.ToString());
            if (this.textToSpeechQueue.Count > 0)
            {
                string textToSpeach = String.Empty;
                do
                {
                    this.textToSpeechQueue.TryDequeue(out textToSpeach);
                    if(textToSpeach != String.Empty)
                    {
                        this.synthesizer.SpeakAsync(textToSpeach);
                    }
                }
                while (this.textToSpeechQueue.Count > 0 
                        && textToSpeach == String.Empty);
            }            
        }

        private void stopAlarmPlaying()
        {
            //lock (this.synthesizersLocker)
            //{
            //    if (this.synthesizers.Count > 0)
            //    {
            //        for (int i = 0; i < this.synthesizers.Count; i++)
            //        {
            //            if (this.synthesizers[i].State == SynthesizerState.Speaking)
            //            {
            //                this.synthesizers[i].Dispose();
            //            }
            //        }
            //        this.synthesizers.Clear();
            //        lock (this.textToSpeechListLocker)
            //        {
            //            this.textToSpeechList.Clear();
            //            Debug.WriteLine("TextToSpeechList: " + this.textToSpeechList.Count);
            //        }
            //    }
            //    Debug.WriteLine("Synthesizers.Count: " + synthesizers.Count);
            //}
            //lock (alarmSoundLocker)
            //{
            //    this.isSoundPlaying = false;
            //}
            
            if (this.textToSpeechQueue.Count > 0)
            {
                this.textToSpeechQueue = null;
                this.textToSpeechQueue = new ConcurrentQueue<string>();
            }
            if (this.synthesizer.State == SynthesizerState.Speaking)
            {
                this.synthesizer.SpeakCompleted -= synthesizer_SpeakCompleted;
                this.synthesizer.Dispose();
                this.synthesizer = new SpeechSynthesizer();
                this.synthesizer.SpeakCompleted += synthesizer_SpeakCompleted;
            }
            this.player.Stop();
        }

        private void onNotificationsChanged()
        {
            lock (this.notificationsLocker)
            {
                List<Notification> notifications = this.notifications;
                this.Notifications = null;
                this.Notifications = notifications;
            }
        }

        private void appSettings_PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "IsSoundDisabled")
            {
                if (this.appSettings.IsSoundDisabled == true)
                {
                    this.stopAlarmPlaying();
                }
            }
        }

        public SettingsViewModel AppSettings
        {
            set
            {
                if(this.appSettings != null)
                {
                    this.appSettings.PropertyChanged -= appSettings_PropertyChanged;
                }                
                this.appSettings = value;
                this.appSettings.PropertyChanged += appSettings_PropertyChanged;
            }
        }
        
        public Notification[] GetNotificationsFromFile(string filePath)
        {
            using (var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                XmlSerializer serializer = new XmlSerializer(typeof(Notification[]));
                // Восстанавливаем объект из XML-файла.
                Notification[] array = serializer.Deserialize(stream) as Notification[];
                //lock (this.notifications)
                //{
                //    this.notifications = list.Notifications;
                //}
                //return list.Notifications;
                return array;
                //this.Text = "Объект Десериализован!";
            }
        }
        public void SaveNotificationsToFile(string filePath)
        {
            
            using (var stream = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.Read))
            {
                XmlSerializer serializer = new XmlSerializer(typeof(Notification[]));
                // Восстанавливаем объект из XML-файла.

                lock (this.notificationsLocker)
                {
                    Notification[] array = new Notification[this.notifications.Count];
                    for (int i = 0; i < this.notifications.Count; i++)
                    {
                        array[i] = this.notifications[i];
                    }
                    //Notification[] array = this.notifications.ToArray();
                    serializer.Serialize(stream, array);
                    //Message.ShowMessage("Файл успешно сохранен", "Сообщение");
                }                    
            }            
        }         
        public List<AccessPoint> AccessPoints
        {
            set
            {
                if(value!=null)
                {
                    lock (this.accessPointsDic)
                    {

                        this.accessPointsDic = new Dictionary<string, AccessPoint>();
                        foreach(AccessPoint accessPoint in value)
                        {
                            this.accessPointsDic[accessPoint.Id] = accessPoint;
                        }
                    }
                }                
            }
        }        
        //public ObservableCollection<Notification> Notifications
        public List<Notification> Notifications
        {
            get
            {
                lock(this.notificationsLocker)
                {
                    return this.notifications;
                }
            }
            private set
            {
                //this.RemoveAll();
                //lock (this.notifications)
                //{
                    this.notifications = value;
                    //this.subscribeNotifications(this.notifications);
                    //this.Count = this.notifications.Count;
                //}
                this.OnPropertyChanged("Notifications");
            }
        }
        public bool IsAlarming
        {
            get { return this.isAlarming; }
            private set
            {
                this.isAlarming = value;
                this.OnPropertyChanged("IsAlarming");
            }
        }
        public int Count
        {
            get { return this.count;  }
            private set
            {
                this.count = value;
                this.OnPropertyChanged("Count");
            }
        }
        public int AlarmedCount
        {
            get { return this.alarmedCount; }
            private set
            {
                this.alarmedCount = value;
                this.OnPropertyChanged("AlarmedCount");
                if (this.alarmedCount == 1)
                {
                    lock (this.isAlarmingLocker)
                    {
                        this.IsAlarming = true;
                    }
                }
            }
        }
        public int UnconfirmedCount
        {
            get { return this.unconfirmedCount; }
            private set
            {
                this.unconfirmedCount = value;
                this.OnPropertyChanged("UnconfirmedCount");
            }
        }
        public Boolean EnabledDisabledAll
        {
            set
            {
                lock(this.notificationsLocker)
                {
                    if(this.notifications.Count > 0)
                    {
                        foreach(Notification notification in this.notifications)
                        {
                            lock (this.notificationLocker)
                            {
                                if (value == true && notification.IsDisabled == false)
                                    notification.IsDisabled = true;
                                else if (value == false && notification.IsDisabled == true)
                                    notification.IsDisabled = false;
                            }                                
                        }
                    }
                }                
            }
        }
        public void Add(Notification notification)
        {
            if (notification == null) return;

            lock (this.notificationsLocker)
            {
                if(!this.notifications.Contains(notification))
                {
                    this.notifications.Add(notification);
                }
                this.Count = this.notifications.Count;
            }
            //this.OnPropertyChanged("Notifications");
            this.onNotificationsChanged();
        }
        public void Add(List<Notification> notifications)
        {
            if (notifications == null) return;

            lock (this.notificationsLocker)
            {
                foreach (Notification notification in notifications)
                {
                    if (!this.notifications.Contains(notification))
                    {
                        this.notifications.Add(notification);
                        this.subscribeNotification(notification);                        
                    }
                }
                this.Count = this.notifications.Count;
            }
            //this.OnPropertyChanged("Notifications");
            this.onNotificationsChanged();
        }
        public void Remove(Notification notification)
        {
            if (notification == null)
            {
                throw new Exception("Нет элемента для удаления");
            }
            notification.IsUnconfirmed = false;

            lock (this.notificationsLocker)
            {
                this.unsubscribeNotification(notification);
                this.notifications.Remove(notification);
                this.Count = this.notifications.Count;
            }
            //this.OnPropertyChanged("Notifications");
            this.onNotificationsChanged();
        }
        public void RemoveAll()
        {
            lock (this.notificationsLocker)
            {
                this.unsubscribeNotifications(this.notifications);
                this.notifications.Clear();
                this.Count = this.notifications.Count;
                this.AlarmedCount = 0;
                this.UnconfirmedCount = 0;
                this.IsAlarming = false;
            }
            this.stopAlarmPlaying();
            //this.OnPropertyChanged("Notifications");
            this.onNotificationsChanged();
        }
        public void ConfirmAll()
        {
            lock (this.notificationsLocker)
            {
                if (this.notifications.Count > 0)
                {
                    foreach (Notification notification in this.notifications)
                    {
                        lock (this.notificationLocker)
                        {
                            if (notification.IsUnconfirmed == true)
                                notification.IsUnconfirmed = false;
                        }
                    }
                }
            }
            this.stopAlarmPlaying();
        }
        public bool Check(string intellectMsgString)
        {
            bool result = false;
            if (String.IsNullOrEmpty(intellectMsgString)) return result;
            Msg msg = new Msg(intellectMsgString);
            if (msg == null) return result;
            
            List<Notification> notifications = new List<Notification>();
            
            if(msg.SourceType == "PNET3_NC32K")
            {
                //if (!msg.IsExists("param1")) return result;

                string param1 = msg.GetParam("param1");
                bool isNotificationEvent = false;
                bool isPersonNotification = false;
                bool isAccessPointNotification = false;
                
                lock(this.personEvents)
                {
                    if (param1 != "" && this.personEvents.Contains(msg.Action))
                    {
                        isNotificationEvent = true;
                        isPersonNotification = true;
                    }
                }
                lock(this.accessPointEvents)
                {
                    if (this.accessPointEvents.Contains(msg.Action))
                    {
                        isNotificationEvent = true;
                        isAccessPointNotification = true;
                    }
                }

                if (isNotificationEvent)
                {
                    string param0 = msg.GetParam("param0");
                    string dateStr = msg.GetParam("date");
                    string timeStr = msg.GetParam("time");
                    string action = events[msg.Action];
                    DateTime date = new DateTime();
                    DateTime.TryParse(dateStr + " " + timeStr, out date);

                    string accessPointName = String.Empty;
                    if (this.accessPointsDic.ContainsKey(msg.SourceId))
                    {
                        accessPointName = this.accessPointsDic[msg.SourceId].Name;
                    }

                    if (isPersonNotification)
                    {
                        Notification notification = new Notification(NotificationType.Person, param1);
                        notification.Date = date;
                        notification.SourceId = msg.SourceId;
                        if (!String.IsNullOrEmpty(accessPointName)) notification.Information = accessPointName + " - ";
                        notification.Information += action;
                        notifications.Add(notification);                                                      
                    }
                    if(isAccessPointNotification)
                    {
                        Notification notification = new Notification(NotificationType.AccessPoint, msg.SourceId);
                        notification.Date = date;
                        notification.Information = action;
                        if (!String.IsNullOrEmpty(param0)) notification.Information = param0 + " - " + notification.Information;
                        notifications.Add(notification);                            
                    }                        
                }                    
            }

            lock(this.notificationsLocker)
            {
                foreach (Notification notification in notifications)
                {
                    //Notification updatedNotification = null;
                    //Stopwatch stopWatch = new Stopwatch();
                    //stopWatch.Start();

                    int index = this.notifications.IndexOf(notification);
                    if (index == -1)
                        continue;
                    Notification updatedNotification = this.notifications[index];

                    //updatedNotification = this.notifications.SingleOrDefault(i => i.Code == notification.Code);

                    //stopWatch.Stop();
                    //TimeSpan ts = stopWatch.Elapsed;
                    //string elapsedTime = String.Format("{0:0000}:{1:0000}:{2:0000}",
                    //    ts.Seconds, ts.Milliseconds, ts.Ticks);
                    //Debug.WriteLine(notification.Code + " - RunTime: " + elapsedTime);

                    //if (updatedNotification == null)
                    //    continue;
                    Application.Current.Dispatcher.BeginInvoke(DispatcherPriority.Background,
                        new Action(() =>
                                        {
                                            lock(this.notificationLocker)
                                            {
                                                updatedNotification.Date = notification.Date;
                                                if(updatedNotification.Type == NotificationType.Person)
                                                    updatedNotification.SourceId = notification.SourceId;
                                                updatedNotification.Information = notification.Information;
                                                if (!updatedNotification.IsDisabled)
                                                {
                                                    if(!updatedNotification.IsUnconfirmed)
                                                    lock (this.unconfirmedCountLocker)
                                                    {
                                                        this.UnconfirmedCount++;
                                                    }
                                                    updatedNotification.IsAlarming = true;
                                                    lock (this.alarmedCountLocker)
                                                    {
                                                        this.AlarmedCount++;                                                                            
                                                    }
                                                    this.playAlarm(updatedNotification);
                                                }                                                                 
                                            }                                                                
                                        }
                                    ));
                    result = true;
                }
            }
            
            if(result ==true)
            {
                this.onNotificationsChanged();
                //this.OnPropertyChanged("Notifications");
            }
            return result;
        }
                
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

        #region IDisposable
        public void Dispose()
        {
            this.unsubscribeNotifications(this.notifications);
            this.synthesizer.Dispose();
            //Debug.WriteLine("#EnterToDispose");
            //Debug.WriteLine("#this.synthesizers.Count: " + this.synthesizers.Count);
            //if (this.synthesizers.Count > 0)
            //{
            //    for(int i = 0; i < this.synthesizers.Count; i++)
            //    {
            //        this.synthesizers[i].Dispose();
            //        //Debug.WriteLine("#synthesizers[" + i + "] disposed");
            //    }
            //}
        }
        #endregion
    }
}


