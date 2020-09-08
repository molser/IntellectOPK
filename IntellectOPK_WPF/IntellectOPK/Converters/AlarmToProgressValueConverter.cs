using System;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(int), typeof(double))]
    public class AlarmToProgressValueConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value is int)
            {
                if ((int)value > 0) 
                {
                    return 1.0;
                }
                else 
                {
                    return 0.0;
                }
            }
            return 0.0;
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
