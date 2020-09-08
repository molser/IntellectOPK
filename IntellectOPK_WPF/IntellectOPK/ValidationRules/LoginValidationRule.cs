using System;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Windows.Controls;

namespace IntellectOPK.ValidationRules
{
    public class LoginValidationRule : ValidationRule
    {
        public override ValidationResult Validate(object value, CultureInfo cultureInfo)
        {
            //string str = value as string;
            //if (str != null)
            //{
            //    var regex = new Regex("^[а-яА-Яa-zA-Z0-9_]*$");
            //}

            var regex = new Regex("^[а-яА-Яa-zA-Z0-9_ ]*$");
            if (regex.IsMatch(value.ToString()))
            {
                return ValidationResult.ValidResult;
            } 
            return new ValidationResult(false, "Значение может содержать только буквы, цифры, пробел и знак \"_\"");
        }
    }
}
