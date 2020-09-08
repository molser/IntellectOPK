using IntellectOPK.Model;
using System;
using System.Data;
using System.Globalization;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    public class DataBaseIconVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value == null)
                return null;

            int person_key = 0;
            
            if (value is DataRowView)
            {
                DataRow row = (value as DataRowView).Row;
                if (row["PersonKey"] != null)
                    person_key = System.Convert.ToInt32(row["PersonKey"]);
            }
            else if (value is Person)
            {
                Person person = value as Person;
                person_key = person.PersonKey;
            }

            
            if (person_key != 0) 
            {
                return System.Windows.Visibility.Visible;
            }
            else 
            {
                return System.Windows.Visibility.Collapsed;
            }
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
