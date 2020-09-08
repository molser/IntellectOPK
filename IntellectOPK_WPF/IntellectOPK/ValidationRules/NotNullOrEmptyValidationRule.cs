using System.Globalization;
using System.Windows.Controls;

namespace IntellectOPK.ValidationRules
{
    public class NotNullOrEmptyValidationRule : ValidationRule
    {
        public override ValidationResult Validate(object value, CultureInfo cultureInfo)
        {
            if (true == string.IsNullOrWhiteSpace(value as string))
            {
                return new ValidationResult(false, "Это поле должно быть заполнено");
            }
            return ValidationResult.ValidResult;
        }
    }
}
