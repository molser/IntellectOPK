using System;
using System.Windows.Data;
using System.Linq;

namespace IntellectOPK.Converters
{
    class BoolToUIVisibilityMultiConverter :  IMultiValueConverter
    {
        public object Convert(object[] values, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (targetType != typeof(System.Windows.Visibility))
                throw new InvalidOperationException("The target must be a Visibility");
            
            if (values != null)
            {
                for(int i=0; i < values.Count(); i++)
                {
                    if(values[i] is Boolean)
                    {
                        if ((bool)values[i] == false)
                        {
                            return System.Windows.Visibility.Collapsed;
                        }
                    }                    
                }
            }           
            return System.Windows.Visibility.Visible;
        }
        public object[] ConvertBack(object values, Type[] targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
