using System.Globalization;
using System.Text.RegularExpressions;
using System.Windows.Controls;

namespace IntellectOPK.ValidationRules
{
    public class ProtocolQueryPersonNamesValidationRule : ValidationRule
    {
        public override ValidationResult Validate(object value, CultureInfo cultureInfo)
        {
            var regex = new Regex("^[а-яА-Яa-zA-Z, ]*$");
            if (regex.IsMatch(value.ToString()))
            {
                return ValidationResult.ValidResult;
            }
            return new ValidationResult(false, "Значение может содержать только буквы, пробел и знак \",\"");
        }
    }
}


