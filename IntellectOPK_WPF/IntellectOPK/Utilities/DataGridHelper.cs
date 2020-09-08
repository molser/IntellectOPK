using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Media;

namespace IntellectOPK.Utilities
{
    public static class DataGridHelper
    {
        public static void OneClickCheckBoxEdit(object sender, RoutedEventArgs e)
        {
            //изменение чекбокса по одному клику мыши
            if (e.OriginalSource.GetType() == typeof(DataGridCell))
            {
                DataGrid dg = (DataGrid)sender;
                DataGridCell cell = e.OriginalSource as DataGridCell;
                if (cell != null && cell.Column is DataGridCheckBoxColumn && !cell.IsReadOnly)
                {
                    dg.BeginEdit();
                    CheckBox chkBox = cell.Content as CheckBox;
                    if (chkBox != null)
                    {
                        chkBox.IsChecked = !chkBox.IsChecked;
                    }
                }
            }
        }

        public static void CheckUnCheckAll(object sender, RoutedEventArgs e)
        {
            //SelectAll CheckBoxes in Column             
            CheckBox chkSelectAll = ((CheckBox)sender);
            if (chkSelectAll == null)
                return;
            var columnHeader = GetParent<DataGridColumnHeader>(e.OriginalSource as DependencyObject);

            if (columnHeader != null && columnHeader.Column.IsReadOnly == false)
            {
                DataGrid dg = GetParent<DataGrid>(e.OriginalSource as DependencyObject);
                if (dg != null)
                {
                    var rows = GetDataGridRows(dg);
                    foreach (DataGridRow row in rows)
                    {
                        Visual visualParent = columnHeader.Column.GetCellContent(row);
                        CheckBox cb = null;
                        if ((visualParent is CheckBox) == true)
                        {
                            cb = visualParent as CheckBox;
                        }
                        else
                        {
                            IEnumerable<CheckBox> checkBoxes = FindVisualChildren<CheckBox>(row);
                            if (checkBoxes.Count() != 0)
                            {
                                cb = checkBoxes.First();
                            }
                        }
                        if (cb != null) cb.IsChecked = chkSelectAll.IsChecked;
                    }
                    //var firstCol1 = dg.Columns.OfType<DataGridCheckBoxColumn>().FirstOrDefault(c => c.DisplayIndex == 0);
                    //var firstCol2 = dg.Columns.OfType<DataGridTemplateColumn>().FirstOrDefault(c => c.DisplayIndex == 0);
                    //if (firstCol1 == null && firstCol2 == null)
                    //    return; 
                    //foreach (var item in dg.Items)
                    //{
                    //    CheckBox chBx = null;
                    //    if (firstCol1 != null)
                    //        chBx = firstCol1.GetCellContent(item) as CheckBox;
                    //    else if(firstCol2 != null)
                    //        chBx = firstCol2.GetCellContent(item) as CheckBox;
                    //    if (chBx == null)
                    //    {
                    //        continue;
                    //    }
                    //    chBx.IsChecked = chkSelectAll.IsChecked;
                    //}
                }
            }



            //if ((visualParent is CheckBox) == true)
            //{
            //    cb = visualParent as CheckBox;
            //}
            //else
            //{
            //    int count = VisualTreeHelper.GetChildrenCount(visualParent);
            //    for (int i = 0; i < count; i++)
            //    {
            //        Visual childVisual = (Visual)VisualTreeHelper.GetChild(visualParent, i);
            //        if (childVisual is CheckBox)
            //        {
            //            cb = childVisual as CheckBox;
            //        }
            //    }
            //}
            //if (cb != null) cb.IsChecked = chkSelectAll.IsChecked;




            //DataRowView rowView = (DataRowView)row.Item;
            //foreach (DataGridColumn column in dg.Columns)
            //{

            //if (columnHeader.Column.GetCellContent(row) is CheckBox)
            //{
            //    //TextBlock cellContent = column.GetCellContent(row) as TextBlock;
            //    //MessageBox.Show(cellContent.Text);
            //    CheckBox cb = columnHeader.Column.GetCellContent(row) as CheckBox;
            //    if (cb != null) cb.IsChecked = chkSelectAll.IsChecked;
            //}
            //}


            //if (columnHeader.Column.IsReadOnly == false)
            //{
            //    for (int i = 0; i < dg.Items.Count; i++)
            //    {
            //        DataGridRow row = (DataGridRow)dg.ItemContainerGenerator.ContainerFromIndex(i);
            //        CheckBox cb = columnHeader.Column.GetCellContent(row) as CheckBox;
            //        if (cb != null) cb.IsChecked = chkSelectAll.IsChecked;
            //    }
            //}





            //if (chkSelectAll.IsChecked == true)
            //{
            //    UserRoles.Items.OfType<CheckBox>().ToList().ForEach(x => x.IsChecked = true);
            //}
            //else
            //{
            //    UserRoles.Items.OfType<CheckBox>().ToList().ForEach(x => x.IsChecked = false);
            //}





        }

        private static T GetParent<T>(DependencyObject d) where T : class
        {
            while (d != null && !(d is T))
            {
                d = System.Windows.Media.VisualTreeHelper.GetParent(d);
            }
            return d as T;
        }

        public static IEnumerable<T> FindVisualChildren<T>(DependencyObject depObj) where T : DependencyObject
        {
            if (depObj != null)
            {
                for (int i = 0; i < VisualTreeHelper.GetChildrenCount(depObj); i++)
                {
                    DependencyObject child = VisualTreeHelper.GetChild(depObj, i);
                    if (child != null && child is T)
                    {
                        yield return (T)child;
                    }

                    foreach (T childOfChild in FindVisualChildren<T>(child))
                    {
                        yield return childOfChild;
                    }
                }
            }
        }

        private static IEnumerable<DataGridRow> GetDataGridRows(DataGrid grid)
        {
            var itemsSource = grid.ItemsSource as IEnumerable;
            if (null == itemsSource) yield return null;
            foreach (var item in itemsSource)
            {
                var row = grid.ItemContainerGenerator.ContainerFromItem(item) as DataGridRow;
                if (null != row) yield return row;
            }
        }

    }
}
