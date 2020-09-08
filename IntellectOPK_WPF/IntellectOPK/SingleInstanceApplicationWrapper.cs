using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;

namespace IntellectOPK
{
    public class StartupClass
    {
        [STAThread]
        static void Main(string[] args)
        {
            SingleInstanceApplicationWrapper startWrapper = new SingleInstanceApplicationWrapper();
            startWrapper.Run(args);
        }
    }

    // WindowsFormsApplicationBase из псборки Microsoft.VisualBasic
    public class SingleInstanceApplicationWrapper : Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase
    {
        //private WpfApplication _app;
        private App _app;

        public SingleInstanceApplicationWrapper()
        {
            // Включаем режим single-instance.
            this.IsSingleInstance = true;
        }

        // Первый запуск приложения.
        protected override bool OnStartup(Microsoft.VisualBasic.ApplicationServices.StartupEventArgs eventArgs)
        {
            //_app = new WpfApplication();
            _app = new App();
            _app.Run();

            return false;
        }

        // Метод срабатывает при последующих запусках приложения.
        protected override void OnStartupNextInstance(Microsoft.VisualBasic.ApplicationServices.StartupNextInstanceEventArgs eventArgs)
        {
            //if (eventArgs.CommandLine.Count > 0)
            //{
            //    (Application.Current.MainWindow as MainWindow).ShowFileText(eventArgs.CommandLine[0]);
            //}
            //Application.Current.MainWindow.Activate();
            
            //Application.Current.Windows.OfType<Window>().SingleOrDefault(x => x.IsActive).Topmost = true;
            
            foreach (Window window in Application.Current.Windows)
            {
                if (window.IsVisible == true)
                {
                    window.WindowState = WindowState.Normal;
                    window.Topmost = true;
                    window.Topmost = false;
                    return;
                }
            }
        }
    }
}
