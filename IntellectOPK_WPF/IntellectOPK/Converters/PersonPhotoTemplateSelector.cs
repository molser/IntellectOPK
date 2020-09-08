using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace IntellectOPK.Converters
{
    public class PersonPhotoTemplateSelector: DataTemplateSelector
    {
        public DataTemplate PhotoFromFileTemplate { get; set; }
        public DataTemplate PhotoFromSqlTemplate { get; set; }

        public override DataTemplate SelectTemplate(object item, DependencyObject container)
        {
            bool? use_oper_db = item as bool?;

            if (use_oper_db == null)
            {
                return base.SelectTemplate(item, container);
            };

            if (use_oper_db == true)
            {
                return PhotoFromFileTemplate;
            }
            else
            {
                return PhotoFromSqlTemplate;
            }
        }
    }
}
