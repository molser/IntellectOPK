﻿using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace IntellectOPK.Converters
{
    [ValueConversion(typeof(Nullable), typeof(Boolean))]
    class NullToBoolConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value == null ? false : true;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
