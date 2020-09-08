using IntellectOPK.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace IntellectOPK.TemplateSelectors
{
    class CheckedCellTemplateSelector : DataTemplateSelector
    {
        public DataTemplate StandardCheckedCellDataTemplate { get; set; }
        public DataTemplate PersonCheckedCellDataTemplate { get; set; }

        public override DataTemplate SelectTemplate(object item, DependencyObject container)
        {
            if (item == null)
            {
                return base.SelectTemplate(item, container);
            };

            if (item is Person)
            {
                return PersonCheckedCellDataTemplate;
            }
            else
            {
                return StandardCheckedCellDataTemplate;
            }
        }
    }
}
