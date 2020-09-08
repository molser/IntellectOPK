using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Data;
using System.Windows.Media.Imaging;

namespace IntellectOPK.Converters
{
    class ImageConverter : IValueConverter
    {
        public object  Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null && parameter == null)
                return null;

            int person_key = 0;
            string person_id = "";
            //bool use_file = System.Convert.ToBoolean(parameter);
            //System.Windows.Media.ImageSource result = null;

            switch (parameter.ToString())
            {
                case "table":
                    DataRow row = (value as DataRowView).Row;
                    person_key = System.Convert.ToInt32(row["PersonKey"]);
                    person_id = System.Convert.ToString(row["ID"]);
                    break;
                case "list":
                    Person person = value as Person;
                    person_key = person.PersonKey;
                    person_id = person.ID;
                    break;
            }



            if (person_key == 0)
            {
                if(person_id != "")
                {
                    string image_path = Properties.Settings.Default.IntellectInstallDir + "\\bmp\\Person\\" + person_id + ".bmp";
                    //result = ImageHelper.GetImageFromFile(image_path, 60);
                    try
                    {
                        return  ImageHelper.GetImageFromFile(image_path, 60);
                    }
                    catch
                    {
                        return null;
                    }
                }              
            }
            else
            {                
                try
                {

                    byte[] array = DataAccessService.GetPersonPhotoStatic(person_key);
                    BitmapImage bitmap = ImageHelper.GetImageFromArray(array, 60);
                    return bitmap;

                    //Thread.Sleep(5000);
                    //return "Закончено!";

                }
                catch 
                {
                    return null;
                }
            }
            return null;
        }
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
