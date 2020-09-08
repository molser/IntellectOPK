using System;
using System.Globalization;
using System.Windows.Controls;

namespace IntellectOPK.ValidationRules
{
    public class DateValidationRule : ValidationRule
    {
        public override ValidationResult Validate(object value, CultureInfo cultureInfo)
        {
            DateTime result;
            if ((true == DateTime.TryParse(value.ToString(), out result)))
            {
                return ValidationResult.ValidResult;
            }
            return new ValidationResult(false, "Значение должно быть датой");
        }
    }
}


