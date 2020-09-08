using IntellectOPK.Commands;
using IntellectOPK.Model;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Net;
using System.Speech.Synthesis;
using System.Text;
using System.Windows.Input;

namespace IntellectOPK.Views
{
    public class SettingsViewModel : ViewModelBase , ICloneable
    {
        #region Member Data
        //private System.Windows.Window view;
        private string title;
        private bool useOperDB = true;
        private bool showFullAccessLevel = false;
        private bool isSoundDisabled;
        private bool isAlarmVoiceEngineUsed;
        private string intellectInstallDir;
        private string login;
        private int rowsCountLimit;
        private int voiceRate;
        private Permissions appUserPermissions;
        private Settings settingsFromDB;
        private IPAddress iidkHostIp;
        private RelayCommand confirmCommand;
        private RelayCommand setAlarmSoundFileCommand;
        private string alarmSoundFile;
        private List<string> voices;
        private string voiceName;

        #endregion

        #region Constructor

        public SettingsViewModel()
        {
            this.title = "Настройки";
            this.settingsFromDB = new Settings();
            this.iidkHostIp = null;
            //this.useOperDB = Properties.Settings.Default.UseOperDB;            
            this.intellectInstallDir = String.Empty;
            this.login = String.Empty;
            this.rowsCountLimit = -1;
            this.alarmSoundFile = String.Empty;
            this.isSoundDisabled = false;
        }
        public SettingsViewModel(Settings settingsFromDB)
        {
            //this.view = view;
            this.title = "Настройки";
            this.settingsFromDB = settingsFromDB;
            this.iidkHostIp = null;
            //this.useOperDB = Properties.Settings.Default.UseOperDB;            
            this.intellectInstallDir = Properties.Settings.Default.IntellectInstallDir;
            this.login = Properties.Settings.Default.Login;
            this.rowsCountLimit = Properties.Settings.Default.RowsCountLimit;
            this.alarmSoundFile = Properties.Settings.Default.AlarmSoundFile;
            this.isSoundDisabled = Properties.Settings.Default.IsSoundDisabled;
            this.isAlarmVoiceEngineUsed = Properties.Settings.Default.IsAlarmVoiceEngineUsed;
            this.voiceName = Properties.Settings.Default.VoiceEngineName;
            this.voiceRate = Properties.Settings.Default.VoiceRate;
            SpeechSynthesizer synthesizer = new SpeechSynthesizer();
            ReadOnlyCollection<InstalledVoice> voises = synthesizer.GetInstalledVoices();
            this.voices = new List<string>();
            if (voises != null)
            {
                foreach (InstalledVoice voice in voises)
                {
                    this.voices.Add(voice.VoiceInfo.Name);
                }
            }
            if(!String.IsNullOrEmpty(this.voiceName))
            {
                if(this.voices.Count > 0)
                {
                    if(this.voices.IndexOf(this.voiceName) == -1)
                    {
                        this.voiceName = String.Empty;
                    }
                }
            }
            RegistryKey regKey = Registry.LocalMachine;
#if WIN32
            regKey = regKey.OpenSubKey("SOFTWARE\\ITV\\INTELLECT");
#else
            regKey = regKey.OpenSubKey("SOFTWARE\\Wow6432Node\\ITV\\INTELLECT");
#endif            
            string ipString = null;
            if (regKey != null)
            {
                if (regKey.GetValue("Core IP Address") != null) ipString = regKey.GetValue("Core IP Address").ToString();
            }
            if (ipString != null)
            {
                IPAddress ip = null;
                IPAddress.TryParse(ipString, out ip);
                if (ip != null) this.iidkHostIp = ip;
            }
        }
        
        public SettingsViewModel(string intellectInstallDir,
                                 string login,
                                 int rowsCountLimit,
                                 bool useOperDB,
                                 bool showFullAccessLevel,
                                 Settings settingsFromDB,
                                 IPAddress iidkHostIp)
            :this(settingsFromDB)
        {
            this.useOperDB = useOperDB;
            this.intellectInstallDir = intellectInstallDir;
            this.login = login;
            this.rowsCountLimit = rowsCountLimit;
            this.showFullAccessLevel = showFullAccessLevel;
            this.settingsFromDB = settingsFromDB;
            this.iidkHostIp = iidkHostIp;
        }
        #endregion

        #region Properties
        public string Title
        {
            get { return this.title; }
        }
        public bool UseOperDB
        {
            get { return this.useOperDB; }
            set
            {
                this.useOperDB = value;
                this.OnPropertyChanged("UseOperDB");
            }
        }

        public bool ShowFullAccessLevel
        {
            get { return this.showFullAccessLevel; }
            set
            {
                this.showFullAccessLevel = value;
                this.OnPropertyChanged("ShowFullAccessLevel");
            }
        }
        public string IntellectInstallDir
        {
            get { return this.intellectInstallDir; }
            set
            {
                this.intellectInstallDir = value;
                this.OnPropertyChanged("IntellectInstallDir");
            }
        }
        public string Login
        {
            get { return this.login; }
            set
            {
                this.login = value;
                this.OnPropertyChanged("Login");
            }
        }
        public int RowsCountLimit
        {
            get { return this.rowsCountLimit; }
            set
            {
                this.rowsCountLimit = value;
                this.OnPropertyChanged("RowsCountLimit");
            }
        }

        public Permissions AppUserPermissions
        {
            get { return this.appUserPermissions; }
            set
            {
                this.appUserPermissions = value;
                this.OnPropertyChanged("AppUserPermissions");                
            }
        }

        public Settings SettingsFromDB
        {
            get { return this.settingsFromDB; }
            set
            {
                this.settingsFromDB = value;
                this.OnPropertyChanged("SettingsFromDB");
            }
        }
        public IPAddress IidkHostIp
        {
            get { return this.iidkHostIp; }
            set
            {
                this.iidkHostIp = value;
                this.OnPropertyChanged("IidkHostIp");
            }
        }
        public string IidkMap
        {
            get { return this.settingsFromDB.IidkMap; }
            set
            {
                this.settingsFromDB.IidkMap = value;
                this.OnPropertyChanged("IidkMap");
            }
        }
        public string IidkMonitor
        {
            get { return this.settingsFromDB.IidkMonitor; }
            set
            {
                this.settingsFromDB.IidkMonitor = value;
                this.OnPropertyChanged("IidkMonitor");
            }
        }
        public string AlarmSoundFile
        {
            get { return this.alarmSoundFile; }
            set
            {
                this.alarmSoundFile = value;
                this.OnPropertyChanged("AlarmSoundFile");
            }
        }
        public bool IsSoundDisabled
        {
            get { return this.isSoundDisabled; }
            set
            {
                this.isSoundDisabled = value;
                this.OnPropertyChanged("IsSoundDisabled");
            }
        }

        public bool IsAlarmVoiceEngineUsed
        {
            get { return this.isAlarmVoiceEngineUsed; }
            set
            {
                this.isAlarmVoiceEngineUsed = value;
                this.OnPropertyChanged("IsAlarmVoiceEngineUsed");
            }
        }
        public List<string> Voices
        {
            get { return this.voices; }
            set
            {
                this.voices = value;
                this.OnPropertyChanged("InstalledVoices");
            }
        }

        public string VoiceName
        {
            get { return this.voiceName; }
            set
            {
                this.voiceName = value;
                this.OnPropertyChanged("VoiceName");
            }
        }
        public int VoiceRate
        {
            get { return this.voiceRate; }
            set
            {
                this.voiceRate = value;
                this.OnPropertyChanged("VoiceRate");
            }
        }

        #endregion

        #region Private Methods

        #endregion

        #region Public Methods

        public void Save()
        {
            Properties.Settings.Default.AlarmSoundFile = this.alarmSoundFile;
            Properties.Settings.Default.IsSoundDisabled = this.isSoundDisabled;
            Properties.Settings.Default.IsAlarmVoiceEngineUsed = this.isAlarmVoiceEngineUsed;
            Properties.Settings.Default.VoiceEngineName = this.voiceName;
            Properties.Settings.Default.VoiceRate = this.voiceRate;
            Properties.Settings.Default.Save();
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
                    this.confirmCommand = new RelayCommand(executeConfirmCommand);
                }
                return this.confirmCommand;
            }
        }
        public ICommand SetAlarmSoundFileCommand
        {
            get
            {
                if (this.setAlarmSoundFileCommand == null)
                {
                    this.setAlarmSoundFileCommand = new RelayCommand(executeSetAlarmSoundFileCommand);
                }
                return this.setAlarmSoundFileCommand;
            }
        }

        #endregion

        #region Helper Methods
        private void executeConfirmCommand(object obj)
        {
            throw new NotImplementedException();
            //Properties.Settings.Default.UseOperDB = this.useOperDB;
            //Properties.Settings.Default.Save();
        }

        private void executeSetAlarmSoundFileCommand(object obj)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "(*.wav)|*.wav";

            // Show save file dialog box
            Nullable<bool> result = dlg.ShowDialog();

            // Process save file dialog box results
            if (result == true)
            {
                this.AlarmSoundFile = dlg.FileName;
            }
        }

        #endregion

        #region IClonable

        // Реализация метода интерфейса ICloneable.
        public object Clone()
        {
            SettingsViewModel newSettings = new SettingsViewModel(this.settingsFromDB);
            newSettings.intellectInstallDir = this.intellectInstallDir;
            newSettings.login = this.login;
            newSettings.rowsCountLimit = this.rowsCountLimit;
            newSettings.useOperDB = this.useOperDB;
            newSettings.showFullAccessLevel = this.showFullAccessLevel;
            newSettings.iidkHostIp = this.iidkHostIp;
            newSettings.alarmSoundFile = this.alarmSoundFile;
            newSettings.isSoundDisabled = this.isSoundDisabled;
            newSettings.isAlarmVoiceEngineUsed = this.isAlarmVoiceEngineUsed;
            newSettings.voiceName = this.voiceName;
            newSettings.voiceRate = this.voiceRate;

            return newSettings;

            //return new SettingsViewModel(this.intellectInstallDir,
            //                             this.login,
            //                             this.rowsCountLimit,
            //                             this.useOperDB,
            //                             this.showFullAccessLevel,
            //                             this.settingsFromDB,
            //                             this.iidkHostIp) as object;
        }

        #endregion

    }
}
