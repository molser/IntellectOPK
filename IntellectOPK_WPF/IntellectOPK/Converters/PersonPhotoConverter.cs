using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using System.Windows.Markup;

namespace IntellectOPK.Converters
{
    public class PersonPhotoConverter : DependencyObject, IValueConverter //: ConvertorBase<PersonPhotoConverter>
    {
        /// Format for converting DateTime to string.
        /// </summary>
        public string Source { set; private get; }
        public int PersonKey { set; private get; }
        public string PersonID { set; private get; }

        public static DependencyProperty DasProperty;
        public IDataAccessService DAS
        {
            set
            {
                SetValue(DasProperty, value);
            }
            get
            {
                return (IDataAccessService)GetValue(DasProperty);
            }
        }

        /// <summary>
        /// Date of what calendar current instance is representing.
        /// </summary>

        static PersonPhotoConverter()
        {
            DasProperty = DependencyProperty.Register("DAS", typeof(IDataAccessService), typeof(PersonPhotoConverter));
        }

        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
           if (Source == null)
                return null;

            if (Source == "file")
            {
                if (PersonID == null) return null;
                string image_path = Properties.Settings.Default.IntellectInstallDir + "\\bmp\\Person\\" + PersonID + ".bmp";
                return ImageHelper.GetImageFromFile(image_path, 60);
            }
            else if (Source == "sql")
            {
                if (DAS == null) return null;
                if(PersonKey == 0) return null;
                //return DAS.GetPersonPhoto(PersonKey, 60);
            }
                       
            return null;

        }
        public object ConvertBack(object value, Type targetType, object parameter,
            CultureInfo culture)
        {
            throw new NotImplementedException();
        }

        public object ProvideValue(IServiceProvider serviceProvider)
        {
            return this;
        }
    }

}
