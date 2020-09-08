using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Windows.Threading;
using System.Xml.Serialization;

namespace IntellectOPK.Model
{
    [XmlRoot("Notification")]
    public class Notification : NotifyDataErrorBase, IEquatable<Notification>, IDisposable
    {

        private NotificationType type;
        private string id;
        private string name;
        private string sourceType;
        private string sourceId;
        private string sourceName;
        private DateTime date;
        private string information;
        private bool isDisabled;
        private bool isAlarming;
        private bool isUnconfirmed;        
        private int alarmDuration; //in seconds
        private const int ALARM_DURATION_DEFAULT = 16; //in seconds
        private DispatcherTimer timer;
        private object isUnconfirmedLocker = new object();

        public event EventHandler OnAlarmStart;
        public event EventHandler OnAlarmEnd;
        public event EventHandler OnConfirm;

        [XmlAttribute("Type")]
        public NotificationType Type
        {
            get { return this.type; }
            set { this.type = value; }
        }
        [XmlAttribute("Id")]
        public string Id
        {
            get { return this.id; }
            set { this.id = value; }
            
        }
        [XmlIgnore]
        public string Name
        {
            get { return this.name; }
            set { this.name=value; }

        }
        [XmlAttribute("SourceType")]
        public string SourceType
        {
            get { return this.sourceType; }
            set { this.sourceType = value; }
        }
        [XmlAttribute("SourceId")]
        public string SourceId
        {
            get { return this.sourceId; }
            set { this.sourceId = value; }
        }
        [XmlIgnore]
        public string SourceName
        {
            get { return this.sourceName; }
            set
            {
                this.sourceName = value;
                //this.OnPropertyChanged("SourceName");
            }
        }
        [XmlIgnore]
        public string Information
        {
            get  { return this.information; }
            set
            {
                this.information= value;
                this.OnPropertyChanged("Information");
            }
        }
        [XmlIgnore]
        public DateTime Date
        {
            get {  return this.date;  }
            set
            {
                this.date = value;
                this.OnPropertyChanged("Date");
            }
        }
        [XmlIgnore]
        public int AlarmDuration
        {
            get {   return this.alarmDuration; }
            set
            {
                this.alarmDuration = value;
                //this.OnPropertyChanged("AlarmDuration");
            }
        }
        [XmlAttribute("IsDisabled")]
        public bool IsDisabled
        {
            get { return this.isDisabled; }
            set
            {
                this.isDisabled = value;
                this.OnPropertyChanged("IsDisabled");
                if (value == true)
                {
                    if (this.isUnconfirmed == true) this.IsUnconfirmed = false;
                }                
            }
        }
        [XmlIgnore]
        public bool IsAlarming
        {
            get {  return this.isAlarming;   }
            set
            {
                this.killTimer();                
                if (!this.isDisabled)
                {
                    if (value == true)
                    {
                        if (this.alarmDuration > 0)
                        {
                            this.startTimer();
                        }
                        if(this.isAlarming == true) this.OnAlarmEnd?.Invoke(this, EventArgs.Empty);
                        this.OnAlarmStart?.Invoke(this, EventArgs.Empty);
                        if(this.isUnconfirmed == false) this.IsUnconfirmed = true;
                    }
                }
                if(value == false)
                {
                    if(this.isAlarming == true) this.OnAlarmEnd?.Invoke(this, EventArgs.Empty);
                }
                this.isAlarming = value;
                this.OnPropertyChanged("IsAlarming");

            }
        }
        [XmlIgnore]
        public bool IsUnconfirmed
        {
            get { return this.isUnconfirmed; }
            set
            {
                lock (this.isUnconfirmedLocker)
                {
                    if (value == false)
                    {
                        if (this.isUnconfirmed == true) this.OnConfirm?.Invoke(this, EventArgs.Empty);
                        if (this.isAlarming == true) this.IsAlarming = false;
                    }
                    this.isUnconfirmed = value;
                    this.OnPropertyChanged("IsUnconfirmed");
                }
            }
        }
        [XmlIgnore]
        public string Code
        {
            get {    return this.type.ToString() + this.id;  }            
        }

        public Notification()
            :this(NotificationType.None, "0")
        {}

        //public Notification(NotificationType type, string id)

        //{
        //    this.type = type;
        //    this.id = id;
        //    this.name = String.Empty;
        //    this.sourceType = String.Empty;
        //    this.sourceId = String.Empty;
        //    this.sourceName = String.Empty;
        //    this.information = String.Empty;
        //    this.date = new DateTime();
        //    this.alarmDuration = ALARM_DURATION_DEFAULT;
        //}


        public Notification(NotificationType type, string id, string name = "",
                            string sourceType = "", string sourceId = "",
                            string sourceName = "", string information = "",
                            DateTime date = new DateTime(),
                            int alarmDuration = ALARM_DURATION_DEFAULT)
        {
            this.type = type;
            this.id = id;
            this.name = name;
            this.sourceType = sourceType;
            this.sourceId = this.type == NotificationType.Person ? "" : sourceId;
            this.sourceName = sourceName;
            this.information = information;
            //if (date == new DateTime()) date = DateTime.Now;
            this.date = date;
            this.alarmDuration = alarmDuration;
        }

        
        protected Notification(Notification other)
        {
            this.type = other.type;
            this.id = other.id;
            this.sourceType = other.sourceType;
            this.sourceId = other.sourceId;
            this.sourceName = other.sourceName;
            this.information = other.information;
            this.date = other.date;
            this.alarmDuration = other.alarmDuration;
        }

        public Notification Clone()
        {
            return new Notification(this);
        }

        private void dispatcherTimer_Tick(object sender, EventArgs e)
        {
            this.killTimer();
            this.IsAlarming = false;
        }

        private void startTimer()
        {
            DispatcherTimer dispatcherTimer = new DispatcherTimer();
            dispatcherTimer.Tick += new EventHandler(dispatcherTimer_Tick);
            dispatcherTimer.Interval = new TimeSpan(0, 0, this.alarmDuration);
            this.timer = dispatcherTimer;
            this.timer.Start();
        }

        private void killTimer()
        {
            if(this.timer != null)
            {
                this.timer.Stop();
                this.timer.Tick -= new EventHandler(dispatcherTimer_Tick);
                this.timer = null;
            }            
        }

        #region IEquatable<Notification>

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Notification objAsPart = obj as Notification;
            if (objAsPart == null) return false;
            else
                return Equals(objAsPart);
        }
        public bool Equals(Notification other)
        {
            if (other == null) return false;
            if (this.type == other.type
                && this.id == other.id                
                )
                return true;
            else return false;
        }
        public override int GetHashCode()
        {
            return this.Code.GetHashCode();
        }

        public static bool operator ==(Notification u1, Notification u2)
        {
            if (object.ReferenceEquals(u1, null))
            {
                return object.ReferenceEquals(u2, null);
            }
            return u1.Equals(u2);
        }

        public static bool operator !=(Notification u1, Notification u2)
        {
            if (object.ReferenceEquals(u1, null))
            {
                return !object.ReferenceEquals(u2, null);
            }
            return !u1.Equals(u2);
        }
        #endregion

        #region IDisposable
        public void Dispose()
        {
            this.killTimer();            
        }

        #endregion
    }
}
