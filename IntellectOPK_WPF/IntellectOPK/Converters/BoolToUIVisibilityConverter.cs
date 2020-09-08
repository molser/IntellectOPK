using System;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(Boolean), typeof(System.Windows.Visibility))]
    public class BoolToUIVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (null == value)
            {
                return System.Windows.Visibility.Collapsed;
            }
            if (value is Boolean)
            {
                if ((Boolean)value == true) 
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
