using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    class StringToBoolConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null) return false;
            if (value is string)
            {
                bool result = !String.IsNullOrEmpty((string)value);
                return result;
            }
            return false;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
