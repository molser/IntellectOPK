using System;
using System.Globalization;
using System.Windows.Controls;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(Boolean), typeof(DataGridHeadersVisibility))]
    public class BoolToHeadersVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (targetType != typeof(DataGridHeadersVisibility))
                throw new InvalidOperationException("The target must be a DataGridHeadersVisibility");

            if (value is Boolean)
            {
                if ((Boolean)value == true) 
                {
                    return DataGridHeadersVisibility.Column;
                }                
            }
            return DataGridHeadersVisibility.All;
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
