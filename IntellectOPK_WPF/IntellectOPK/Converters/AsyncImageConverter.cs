using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Data;
using System.Windows.Markup;
using System.Windows.Media.Imaging;

namespace IntellectOPK.Converters
{
    public class AsyncImageConverter : MarkupExtension, IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value == null)
                return null;

            int person_key = 0;
            string person_id = "";
            int imageWidth = 60;

            if(parameter != null)
            {
                if (parameter.ToString() == "FullScale")
                    imageWidth = 0;
            }

            if (value is DataRowView)
            {
                DataRow row = (value as DataRowView).Row;
                if(row["PersonKey"] != null)
                    person_key = System.Convert.ToInt32(row["PersonKey"]);
                if(row["ID"] != null)
                    person_id = System.Convert.ToString(row["ID"]);
            }
            else if (value is Person)
            {
                Person person = value as Person;
                person_key = person.PersonKey;
                person_id = person.Id;
            }

            
            if (person_key == 0)
            {
                if (person_id != "")
                {
                    //string image_path = Properties.Settings.Default.IntellectInstallDir + "\\bmp\\Person\\" + person_id + ".bmp";
                    //return new NotifyTaskCompletion<BitmapImage>(ImageHelper.GetImageFromFileAsync(image_path, imageWidth));
                    return new NotifyTaskCompletion<BitmapImage>(DataAccessService.GetPersonPhotoFromFileStaticAsync(person_id, imageWidth));
                }
                return null;
            }
            else
            {
                return new NotifyTaskCompletion<BitmapImage>(DataAccessService.GetPersonPhotoFromDBStaticAsync(CancellationToken.None,person_key, imageWidth));
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return null;
        }

        public override object ProvideValue(IServiceProvider serviceProvider)
        {
            return this;
        }

        //private async Task<BitmapImage> getImageFromSqlAsync(int person_key, int imageWidth)
        //{
        //    byte[] array = await DataAccessService.GetPersonPhotoStaticAsync(CancellationToken.None, person_key);
        //    BitmapImage bitmap = ImageHelper.GetImageFromArray(array, imageWidth);
        //    return bitmap;
        //}
    }
}
