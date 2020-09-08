using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace IntellectOPK.ControlLibrary
{
    public static class VisualHelper
    {
        public static T GetParent<T>(DependencyObject d) where T : class
        {
            while (d != null && !(d is T))
            {
                d = System.Windows.Media.VisualTreeHelper.GetParent(d);
            }
            return d as T;
        }
    }
}
