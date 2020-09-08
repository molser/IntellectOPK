using System;
using System.Windows;
using IntellectOPK.Views;
using IntellectOPK.Model;

namespace IntellectOPK
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
        }
        protected override void OnStartup(StartupEventArgs e)
        {
            //EventManager.RegisterClassHandler(typeof(Slider), Slider.MouseDoubleClickEvent,
            //        new MouseButtonEventHandler(SetSliderDefaulValue));
            base.OnStartup(e);
       

            string sqlServerName = IntellectOPK.Properties.Settings.Default.SqlServerName;
            string dataBaseName = IntellectOPK.Properties.Settings.Default.DataBaseName;
            string intellectDir = IntellectOPK.Properties.Settings.Default.IntellectInstallDir;
            MainWindow main_window = new MainWindow();
            DataAccessService dataService = new DataAccessService(sqlServerName, dataBaseName, intellectDir);
            main_window.DataContext = new MainWindowViewModel(dataService, main_window);
            main_window.ViewModel.LoginCommand.Execute("FirstRun");

        }

        //private void SetSliderDefaulValue(object sender, MouseButtonEventArgs e)
        //{
        //    Slider slider = sender as Slider;
        //    Thumb thumb = VisualHelper.GetParent<Thumb>(e.OriginalSource as DependencyObject);
        //    if (thumb != null)
        //    {
        //        slider.Value = (Math.Abs(slider.Maximum) - Math.Abs(slider.Minimum)) / 2;
        //    }
        //}
    }
}
