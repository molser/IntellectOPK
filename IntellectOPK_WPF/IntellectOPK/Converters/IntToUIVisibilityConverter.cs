using System;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(int), typeof(System.Windows.Visibility))]
    public class IntToUIVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (null == value)
            {
                return System.Windows.Visibility.Collapsed;
            }
            if (value is int)
            {
                if ((int)value != 0) 
                {
                    return System.Windows.Visibility.Visible;
                }
                else 
                {
                    return System.Windows.Visibility.Collapsed;
                }
            }
            return System.Windows.Visibility.Collapsed;
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
