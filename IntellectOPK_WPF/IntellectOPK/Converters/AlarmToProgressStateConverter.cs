using System;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(int), typeof(System.Windows.Shell.TaskbarItemProgressState))]
    public class AlarmToProgressStateConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (null == value)
            {
                return System.Windows.Shell.TaskbarItemProgressState.None;
            }
            if (value is int)
            {
                if ((int)value > 0) 
                {
                    return System.Windows.Shell.TaskbarItemProgressState.Error;
                }
                else 
                {
                    return System.Windows.Shell.TaskbarItemProgressState.None;
                }
            }
            return System.Windows.Shell.TaskbarItemProgressState.None;
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
