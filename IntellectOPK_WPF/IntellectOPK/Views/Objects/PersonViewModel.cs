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
using System.Windows.Media.Imaging;
using System.Threading.Tasks;
using System.Drawing;
using Microsoft.Win32;
using System.IO;
using System.Windows;

namespace IntellectOPK.Views
{
    
    public class PersonViewModel : ViewModelBase
    {
        #region Member Data
        private PersonView view;
        private IDataAccessService das;
        private int personPhotoKey;
        private string title;
        //private bool useOperDB = false;
        private bool isPersonHistoryAvailable = false;
        private bool isExtendedMode = false;
        private bool isPersonPhotoSaving = false;
        private bool isAccessPointsViewShowed = false;
        private Person person;
        private List<Person> persons;
        private Permissions appUserPermissions;
        private BitmapImage personPhoto;
        private Dictionary<int, BitmapImage> personPhotos;
        private NotifyTaskCompletion<Person> personPhotoSetter;        
        private RelayCommand exportPersonPhotoCommand;
        private RelayCommand showAccessPointsViewCommand;
        private SettingsViewModel settings;

        #endregion


        #region Constructor

        public PersonViewModel( PersonView view, 
                                IDataAccessService das,
                                SettingsViewModel settings,
                                Permissions appUserPermissions,
                                List<Person> persons)
            : base()
        {
            this.view = view;
            this.das = das;
            this.settings = settings;
            this.appUserPermissions = appUserPermissions;
           
            this.persons = persons;
            this.title = "Сотрудник";
            this.personPhotos = new Dictionary<int, BitmapImage>();
            this.personPhotoKey = -1;
            this.personPhotoSetter = new NotifyTaskCompletion<Person>(getNullPersonPhoto());
            if (this.persons.Count() != -1)
            {
                this.Person = this.persons[(this.persons.Count() - 1)];
            }
        }

        
        #endregion

        #region Private Methods

        private void raiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }

        private void PersonImage_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (this.personPhotoKey != person.PhotoKey)
            {
                NotifyTaskCompletion<Person> notifyTaskCompletion = sender as NotifyTaskCompletion<Person>;
                if (notifyTaskCompletion.IsCompleted == true)
                {
                    if (this.personPhotoKey != person.PhotoKey)
                    {
                        if (notifyTaskCompletion.Result != null)
                        {
                            Person person = notifyTaskCompletion.Result;
                            if (!personPhotos.ContainsKey(person.PhotoKey))
                                personPhotos[person.PhotoKey] = person.Photo;
                            this.PersonPhoto = person.Photo;
                            this.personPhotoKey = person.PhotoKey;
                        }
                    }
                }
            }
        }

        private void setPersonPhoto(Person person)
        {
            if (this.personPhotoKey == person.PhotoKey)
            {
                return;
            }
            else
            {
                if (personPhotos.ContainsKey(person.PhotoKey))
                {
                    this.PersonPhoto = personPhotos[person.PhotoKey];
                    this.personPhotoKey = person.PhotoKey;
                    
                    return;
                }
            }
            this.PersonPhoto = null;
            if (person.PersonKey == 0)
            {
                if (person.Id != "")
                {
                    this.PersonPhotoSetter = new NotifyTaskCompletion<Person>(this.getPersonPhotoFromFileAsync(person));
                    this.personPhotoSetter.PropertyChanged += PersonImage_PropertyChanged;
                }
            }
            else if (person.PhotoKey != -1)
            {
                this.PersonPhotoSetter = new NotifyTaskCompletion<Person>(this.getPersonPhotoFromSqlAsync(person));
                this.personPhotoSetter.PropertyChanged += PersonImage_PropertyChanged;
            }
            else
            {
                this.PersonPhoto = null;
                this.personPhotoKey = -1;
            }
        }

        private async Task<Person> getPersonPhotoFromSqlAsync(Person person)
        {
            //byte[] array = await DataAccessService.GetPersonPhotoStaticAsync(CancellationToken.None, person.PersonKey);
            BitmapImage bitmap = await this.das.GetPersonPhotoFromDBAsync(CancellationToken.None, person.PersonKey, photo_height: 1080, photo_width: 0);
            //ImageHelper.GetImageFromArray(array, imageWidth: 0, imageHeight: 1080);
            person.Photo = bitmap;
            return person;
        }

        private async Task<Person> getPersonPhotoFromFileAsync(Person person)
        {
            //string imagePath = Properties.Settings.Default.IntellectInstallDir + "\\bmp\\Person\\" + person.ID + ".bmp";
            //BitmapImage bitmap = await ImageHelper.GetImageFromFileAsync(imagePath, imageWidth: 0, imageHeight: 1080);
            BitmapImage bitmap = await this.das.GetPersonPhotoFromFileAsync(person.Id, photo_height: 1080, photo_width: 0);
            person.Photo = bitmap;
            return person;
        }

        private async Task<Person> getNullPersonPhoto()
        {
            await Task.Delay(1);
            return null;
        }

        private async void logAuditEvent(string auditGroup, string auditAction, string computerName = null, string appBuild = null, string extension = null)
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;

            try
            {
                await this.das.LogAuditEventAsync(token, auditGroup, auditAction, computerName, appBuild, extension);
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    CTS.Cancel();
                    Message.ShowError(e.Message, e.GetType().ToString(), this.view);
                }
            }

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

        public Person Person
        {
            get { return this.person; }
            set
            {
                this.person = value;
                this.OnPropertyChanged("Person");
                this.setPersonPhoto(value);
            }
        }

        public List<Person> Persons
        {
            get { return this.persons; }
            set
            {
                this.persons = value;
                this.OnPropertyChanged("Persons");
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

        public NotifyTaskCompletion<Person> PersonPhotoSetter
        {
            get { return this.personPhotoSetter; }
            private set
            {
                this.personPhotoSetter = value;
                this.OnPropertyChanged("PersonPhotoSetter");
            }
        }

        public BitmapImage PersonPhoto
        {
            get { return this.personPhoto; }
            private set
            {
                this.personPhoto = value;
                this.OnPropertyChanged("PersonPhoto");
            }
        }
        public bool IsPersonHistoryAvailable
        {
            get { return this.isPersonHistoryAvailable; }
            set
            {
                this.isPersonHistoryAvailable = value;
                this.OnPropertyChanged("IsPersonHistoryAvailable");
            }
        }

        public bool IsExtendedMode
        {
            get { return this.isExtendedMode; }
            set
            {
                this.isExtendedMode = value;
                this.OnPropertyChanged("IsExtendedMode");
            }
        }

        #endregion


        #region Protected Methods

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }


        #endregion


        #region Commands
        public ICommand ExportPersonPhotoCommand
        {
            get
            {
                if (this.exportPersonPhotoCommand == null)
                {
                    this.exportPersonPhotoCommand = new RelayCommand(executeExportPersonPhotoCommand, canExecuteExportPersonPhotoCommand);
                }
                return this.exportPersonPhotoCommand;
            }
        }

        public ICommand ShowAccessPointsViewCommand
        {
            get
            {
                if (this.showAccessPointsViewCommand == null)
                {
                    this.showAccessPointsViewCommand = new RelayCommand(executeShowAccessPointsViewCommand, canExecuteShowAccessPointsViewCommand);
                }
                return this.showAccessPointsViewCommand;
            }
        }

        #endregion


        #region Helper Methods
        private bool canExecuteExportPersonPhotoCommand(object obj)
        {
            if(!this.isPersonPhotoSaving)
            {
                return (this.personPhotoKey != -1);
            }
            return false;
        }

        private async void executeExportPersonPhotoCommand(object obj)
        {
            if (!this.isPersonPhotoSaving && this.personPhotoKey != -1)
            {
                this.isPersonPhotoSaving = true;
                Mouse.OverrideCursor = Cursors.Wait;
                try
                {
                    
                    byte[] imageArray = null;

                    if (this.personPhotoKey == 0)
                    {
                        //string imagePath = Properties.Settings.Default.IntellectInstallDir + "\\bmp\\Person\\" + person.ID + ".bmp";
                        //imageArray = ImageHelper.GetArrayFromFile(imagePath);
                        imageArray = await this.das.GetPersonPhotoFromFileAsync(person.Id);
                    }
                    else
                    {
                        imageArray = await this.das.GetPersonPhotoFromDBAsync(CancellationToken.None, this.person.PersonKey);                        
                    } 
                                       
                    if(imageArray != null)
                    {
                        Image image = IntellectOPK.Model.Utilities.ImageHelper.GetImageFromArray(imageArray);
                        string ext = IntellectOPK.Model.Utilities.ImageHelper.GetImageFileExtension(image);
                        if (String.IsNullOrEmpty(ext))
                            ext = "";
                        string personName = StringHelper.RemoveUnnecessaryChars(this.person.FullName, Model.Person.ValidCharsForFullName);

                        SaveFileDialog saveDialog = new SaveFileDialog();
                        //saveDialog.Title = "Сохранение фото сотрудника";
                        //if(ext != "")
                        //{
                        //    saveDialog.DefaultExt = ext;
                        //    saveDialog.AddExtension = true;
                        //}
                        saveDialog.FileName = personName;
                        saveDialog.OverwritePrompt = true;
                        //saveDialog.Filter = "Text files(*.txt)|*.txt|All files(*.*)|*.*";
                        saveDialog.Filter = "(*."+ ext + ")|*." + ext + "|All files(*.*)|*.*";
                        if (saveDialog.ShowDialog() ==true)
                        {
                            this.logAuditEvent("others", "export_photo", null, null, "person_name=" + personName);
                            File.WriteAllBytes(saveDialog.FileName, imageArray);
                            //Message.ShowMessage(ext, "Тип картинки", this.view);
                            //Message.ShowMessage("Файл успешно сохранен", "Информация", this.view);                            
                        }
                        Mouse.OverrideCursor = null;
                        //this.view.Owner.Activate();                        
                    }
                }
                catch (Exception ex)
                {
                    Mouse.OverrideCursor = null;
                    Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
                }
                this.isPersonPhotoSaving = false;
            }
        }

        private bool canExecuteShowAccessPointsViewCommand(object obj)
        {
            if (!this.isAccessPointsViewShowed)
            {
                if (this.person != null)
                {
                    return true;
                    //if(this.person.PersonKey == 0 && this.useOperDB == true)
                    //{
                    //    return true;
                    //}
                    //else 
                    //{
                    //    if (this.person.ValidTo == new DateTime(9999,1,1))
                    //    {
                    //        return true;
                    //    }
                    //}
                }
            }
            return false;
        }
        private async void executeShowAccessPointsViewCommand(object obj)
        {
            this.isAccessPointsViewShowed = true;

            //bool useOperDB;
            MainQueryParams accessPointsParams = new MainQueryParams();
            //AccessPointsView view = new AccessPointsView();
            ListView view = new ListView();
            List<AccessPoint> accessPointsList = null;
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;
            try
            {
                if (this.settings.UseOperDB == true && this.person.PersonKey == 0)
                    accessPointsParams.UseOperDB = true;
                else
                    accessPointsParams.UseOperDB = false;
                accessPointsParams.StartDate = this.person.ValidFrom;
                accessPointsParams.OnlyWorked = true;
                accessPointsParams.PersonId = this.person.Id;
                accessPointsParams.ShowFullAccessLevel = this.settings.ShowFullAccessLevel;
                //access_points_list = await das.GetAccessPointsAsync(token, this.person.ValidFrom, useOperDB, true, null, this.person.Id, this.settings.ShowFullAccessLevel);
                accessPointsList = await das.GetAccessPointsAsync(token, accessPointsParams);
            }
            catch (Exception ex)
            {
                CTS.Cancel();
                if (view != null)
                {
                    view.Close();
                }
                Message.ShowError(ex.Message, ex.GetType().ToString(), this.view);
            }

            if (accessPointsList != null)
            {
                accessPointsList.Sort((x, y) => x.Name.CompareTo(y.Name));
                //view.ViewModel = new AccessPointsViewModel(view, 
                //                                            this.das, 
                //                                            this.appUserPermissions,
                //                                            accessPointsList, 
                //                                            this.settings.UseOperDB, 
                //                                            String.Empty);
                view.ViewModel = new AccessPointsViewModel(view,
                                                            accessPointsList,
                                                            accessPointsParams.AccessPointsArray,
                                                            this.das);
                view.Owner = this.view;
                view.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                view.ShowInTaskbar = false;
                                
                view.ViewModel.Title = "Разрешенные точки доступа у " + this.person.FullName;
                view.ViewModel.IsSelectableMode = false;
                view.ViewModel.IsExportEnable = true;

                view.Show();
            }
            this.isAccessPointsViewShowed = false;
        }


        #endregion
    }
}
