using System;
using System.Data;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    public class ObjectToObjectConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value is DataTable)
            {
                return value as DataTable;
            }
            return value;
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
            //if(null == value)
            //{
            //    return null;
            //}
            //DateTime resultDateTime = new DateTime();
            //if (value is String)
            //{                
            //    if(DateTime.TryParse(value.ToString(), out resultDateTime))
            //    {
            //        return resultDateTime;
            //    }
            //}
            //return resultDateTime;
        }
    }
}
