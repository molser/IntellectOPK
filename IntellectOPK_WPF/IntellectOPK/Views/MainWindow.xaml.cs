using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Diagnostics;
using IntellectOPK.Model;
using System.Data;
using System.ComponentModel;
using System.Collections.Specialized;
using System.Windows.Controls.Primitives;

namespace IntellectOPK.Views
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        //public DataView AccessPointsTableView { get; private set; }
        //public ICollectionView AccessPointsListView { get; private set; }
        public bool IsMinimizeButtonHidden { get { return false; } }
        public string currentTab = "";
        public MainWindow()
        {
            //this.ViewModel = new MainWindowViewModel(this);
            InitializeComponent();
        }

        public MainWindowViewModel ViewModel
        {
            get { return this.DataContext as MainWindowViewModel; }
            set
            {
                this.DataContext = value;
                //this.AccessPointsListView = CollectionViewSource.GetDefaultView(this.ViewModel.AccessPoints);
            }
        }


        
        private void tabControl_OnSelectionChanged(Object sender, SelectionChangedEventArgs args)
        {
            if (args.Source is TabControl)
            {
                var tc = sender as TabControl; //The sender is a type of TabControl...

                if (tc != null)
                {
                    TabItem item = (TabItem)tc.SelectedItem;

                    this.ViewModel.CurrentTask = item.Name;
                    //Debug.WriteLine("TabItemChanged.Item.Name: " + item.Name);

                    this.currentTab = item.Name;                    
                   
                }
            }
            updateRowsCount();
        }

        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            if (this.ViewModel.CanCloseApplication == false)
            {
                e.Cancel = true;
                this.ViewModel.CloseCommand.Execute(null);
            }
            else
            {
                if(this.ViewModel.Settings != null)
                    this.ViewModel.Settings.Save();
                base.OnClosing(e);
                this.ViewModel.Dispose();
            }            
        }

        private void dataGrid_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }

        
        private void SelectivelyIgnoreMouseButton(object sender,  MouseButtonEventArgs e)
        {
            TextBox tb = (sender as TextBox);
            if (tb != null)
            {
                if (!tb.IsKeyboardFocusWithin)
                {
                    e.Handled = true;
                    tb.Focus();
                }
            }
        }       

        private void SelectAllTextBox_PreviewMouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ClickCount == 3)
            {
                if(sender is TextBox)
                {
                    (sender as TextBox).SelectAll();
                }
                else if (sender is ComboBox)
                {
                    ComboBox cb = sender as ComboBox;
                    TextBox tb = (cb.Template.FindName("PART_EditableTextBox", cb) as TextBox);
                    if(tb != null)
                    {
                        tb.SelectAll();
                    }
                }
            }
            else
            {
                TextBox tb = (sender as TextBox);
                if (tb != null)
                {
                    if (!tb.IsKeyboardFocusWithin)
                    {
                        e.Handled = true;
                        tb.Focus();
                    }
                }
            }
        }

        private void levelsDataGrid_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            this.dataGrid_LoadingRow(sender, e);            
        }

        private void personsDataGrid_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            this.dataGrid_LoadingRow(sender, e);
            Person person = (Person)e.Row.DataContext;
            switch (person.IsDeleted)
            {
                case true:
                    //e.Row.Background = new SolidColorBrush(Colors.LightGreen);
                    //e.Row.Background.Opacity = 0.4;
                    e.Row.Foreground = new SolidColorBrush(Colors.Gray);
                    break;
                //case false:
                //    //e.Row.Background = new SolidColorBrush(Colors.LightPink);
                //    //e.Row.Background.Opacity = 0.4;
                //    e.Row.Foreground = new SolidColorBrush(Colors.Black);
                //    break;
                default:
                    //e.Row.Background = new SolidColorBrush(Colors.White);
                    //e.Row.Background.Opacity = 1;
                    e.Row.Foreground = new SolidColorBrush(Colors.Black);
                    break;
            }
        }

        private void FindCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
        {
            switch (Convert.ToString(e.Parameter))
            {
                case "FromAccessPoints":
                    e.CanExecute = (this.ViewModel.AccessPoints != null ? true : false);
                    break;
                case "FromLevels":
                    e.CanExecute = (this.ViewModel.Levels != null ? true : false);
                    break;
            }
        }

        //private void FindCommand_Executed(object sender, ExecutedRoutedEventArgs e)
        //{
        //    switch(Convert.ToString(e.Parameter))
        //    {
        //        case "FromAccessPoints":
        //            findAccessPoints();
        //            break;
        //        case "FromLevels":
        //            findLevels();
        //            break;
        //    }            
        //}
        //private void findLevels()
        //{
        //    if (this.ViewModel.Levels != null)
        //    {
        //        ICollectionView view = CollectionViewSource.GetDefaultView(this.ViewModel.Levels);

        //        if (String.IsNullOrEmpty(this.LevelsFindTextBox.Text))
        //        {
        //            view.Filter = null;
        //        }
        //        else
        //        {
        //            string value = this.LevelsFindTextBox.Text;
        //            view.Filter = item =>
        //            {
        //                Level vitem = item as Level;
        //                if (vitem == null) return false;
        //                return (vitem.Name.ToUpper().Contains(value.ToUpper())
        //                        || vitem.Description.ToUpper().Contains(value.ToUpper()));
        //            };
        //        }
        //    }
        //    updateRowsCount();
        //}

        //private void findAccessPoints()
        //{
        //    if (this.ViewModel.AccessPoints != null)
        //    {
        //        ICollectionView view = CollectionViewSource.GetDefaultView(this.ViewModel.AccessPoints);
        //        //this.AccessPointsListView = CollectionViewSource.GetDefaultView(this.ViewModel.AccessPoints);

        //        if (String.IsNullOrEmpty(this.AccessPointsFindTextBox.Text))
        //        {
        //            view.Filter = null;
        //        }
        //        else
        //        {
        //            //view.Filter = o => ((AccessPoint)o).Name == this.AccessPointsFindTextBox.Text;
        //            view.Filter = item =>
        //            {
        //                AccessPoint vitem = item as AccessPoint;
        //                if (vitem == null) return false;
        //                return vitem.Name.ToUpper().Contains(this.AccessPointsFindTextBox.Text.ToUpper());
        //            };
        //        }
        //    }
        //    updateRowsCount();
        //}

        private void cbDepartmentFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(this.ViewModel.Persons != null)
            {
                string department = (sender as ComboBox).SelectedItem as string;
                if(department != null)
                {
                    ICollectionView view = CollectionViewSource.GetDefaultView(this.ViewModel.Persons);
                    if (department == "Все отделы")
                    {
                        view.Filter = null;
                    }
                    else
                    {
                        view.Filter = item =>
                        {
                            Person vitem = item as Person;
                            if (vitem == null) return false;
                            return vitem.Department.ToUpper().Contains(department.ToUpper());
                        };
                    }
                }                
            }            
        }

        private void cbDepartmentFilter_TargetUpdated(object sender, DataTransferEventArgs e)
        {
            ComboBox cb = sender as ComboBox;
            if (cb != null)
                cb.SelectedIndex = 0;
        }

        private void updateRowsCount()
        {
            if (this.currentTab == null) return;
            DataGrid dg = null;
            switch (this.currentTab)
            {
                case "AccessEvents":
                    dg = this.accessEvenetsDataGrid;
                    break;
                case "Persons":
                    dg = this.personsDataGrid;
                    break;
                case "AccessPoints":
                    dg = this.accessPointsDataGrid;
                    break;
                case "Levels":
                    dg = this.levelsDataGrid;
                    break;
                case "Notifications":
                    dg = this.notificationsDataGrid;
                    break;
                default:
                    //this.currentTask = null;
                    break;
            }

            if (dg != null)
            {
                if (dg.Items.Count > 0)
                {
                    this.rowsCountStackPanel.Visibility = Visibility.Visible;
                    this.rowsCountTextBox.Text = dg.Items.Count.ToString();
                    return;
                }
                this.rowsCountStackPanel.Visibility = Visibility.Collapsed;
            } 
        }

        private void DataGrid_TargetUpdated(object sender, DataTransferEventArgs e)
        {
            updateRowsCount();
        }

        private void accessPointsDataGrid_TargetUpdated(object sender, DataTransferEventArgs e)
        {
            //this.AccessPointsFindTextBox.Text = "";
            updateRowsCount();
        }

        private void levelsDataGrid_TargetUpdated(object sender, DataTransferEventArgs e)
        {
            //this.LevelsFindTextBox.Text = "";
            updateRowsCount();
        }

        private void notificationsDataGrid_TargetUpdated(object sender, DataTransferEventArgs e)
        {
            updateRowsCount();

            //return;

            DataGrid dg = this.notificationsDataGrid;
            ICollectionView dataView = CollectionViewSource.GetDefaultView(dg.ItemsSource);
            if (dataView != null)
            {
                dataView.Refresh();
            }

        }

        private void Notification_Click(object sender, RoutedEventArgs e)
        {
            ToggleButton button = sender as ToggleButton;
            DataGridRow row = button.BindingGroup.Owner as DataGridRow;            
            if (row != null)
            {
                Notification notification = row.Item as Notification;
                if (notification != null)
                {                    
                    if (notification.IsUnconfirmed)
                    {
                        notification.IsUnconfirmed = false;
                    }
                    else
                    {
                        if(notification.IsDisabled)
                        {
                            notification.IsDisabled = false;
                            //button.IsChecked = false;
                        }
                        else if(!notification.IsDisabled)
                        {
                            notification.IsDisabled = true;
                            //button.IsChecked = true;
                        }                        
                    }
                    //button.IsChecked = notification.IsDisabled;
                }
            }
            e.Handled = true;
        }

        private void AeEventsButton_Checked(object sender, RoutedEventArgs e)
        {
            this.ViewModel.ShowEventsViewCommand.Execute(null);
        }

        private void AeAccessPointsButton_Checked(object sender, RoutedEventArgs e)
        {
            this.ViewModel.ShowAccessPointsViewCommand.Execute("FromAccessEvents");
        }

        private void ClearPersonsAEFButton_Click(object sender, RoutedEventArgs e)
        {
            this.PersonsAEF.Text = String.Empty;
        }

        private void operDbUse_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            var viewBox = sender as Viewbox;
            if (viewBox != null)
            {
                // Why is button.ContextMenu.DataContext null? ... when right click is O.K. but leftdown is N.G.
                viewBox.ContextMenu.DataContext = viewBox.DataContext;
                viewBox.ContextMenu.IsOpen = true;
            }
        }
    }    
}
