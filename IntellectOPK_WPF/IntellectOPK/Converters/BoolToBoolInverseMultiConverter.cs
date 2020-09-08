﻿using System;
using System.Windows.Data;
using System.Linq;

namespace IntellectOPK.Converters
{
    class BoolToBoolInverseMultiConverter :  IMultiValueConverter
    {
        public object Convert(object[] values, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (targetType !=  typeof(bool))
                throw new InvalidOperationException("The target must be a Boolen");
            
            if (values != null)
            {
                for(int i=0; i < values.Count(); i++)
                {
                    if ((bool)values[i] == false)
                    {
                        return true;
                    }
                }
                return false;
            }           
            return true;
        }
        public object[] ConvertBack(object values, Type[] targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotSupportedException();
        }
    }
}