using System;
using System.Windows.Data;
using System.Linq;

namespace IntellectOPK.Converters
{
    class EmptyStringToBoolMultiConverter :  IMultiValueConverter
    {
        public object Convert(object[] values, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (targetType != typeof(Boolean))
                throw new InvalidOperationException("The target must be a Boolean");
            
            if (values != null)
            {
                for(int i=0; i < values.Count(); i++)
                {
                    if(values[i] is String)
                    {
                        if (!String.IsNullOrEmpty(values[i].ToString()))
                        {
                            return false;
                        }
                    }                    
                }
            }           
            return true;
        }
        public object[] ConvertBack(object values, Type[] targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
