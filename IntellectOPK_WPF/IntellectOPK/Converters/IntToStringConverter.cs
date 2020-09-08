using System;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(int), typeof(string))]
    public class IntToStringConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (null == value)
            {
                return String.Empty;
            }
            if (value is int)
            {
                if ((int)value == 0) 
                {
                    return String.Empty;
                }
                else if ((int)value < 99)
                {
                    return value.ToString();
                }
                else if((int)value > 99)
                {
                    return "+99";
                }
                else 
                {
                    return String.Empty;
                }
            }
            return String.Empty;
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
