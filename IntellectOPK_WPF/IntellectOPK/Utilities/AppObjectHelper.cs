using IntellectOPK.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace IntellectOPK.Utilities
{
    public static class AppObjectHelper
    {
        public static void CheckItems(AppObjectBase[] destination, AppObjectBase[] itemsToCheck)
        {
            if (destination == null || itemsToCheck == null)
                return;
            for (int i = 0; i < destination.Count(); i++)
            {
                for (int j = 0; j < itemsToCheck.Count(); j++)
                {
                    if (destination[i].GetHashCode() == itemsToCheck[j].GetHashCode())
                    {
                        destination[i].IsChecked = true;
                        continue;
                    }
                }                
            }
        }    
    }
}
