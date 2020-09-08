using IntellectOPK.Model;
using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Data;
using System.Windows.Markup;
using System.Windows.Media.Imaging;

namespace IntellectOPK.Converters
{
    class AsyncLevelsConverter : MarkupExtension, IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null)
                return null;

            bool useOperDB = false;
            int personKey = -1;
            string levelId = null;

            if (value is DataRowView)
            {
                DataRow row = (value as DataRowView).Row;
                if (row["LevelId"] != null)
                    levelId = row["LevelId"].ToString();
                if (row["PersonKey"] != null)
                    personKey = System.Convert.ToInt32(row["PersonKey"]);
            }
            else if (value is Person)
            {
                Person person = value as Person;
                levelId = person.LevelId;
                personKey = person.PersonKey;
            }

            if (levelId == null)
                return null;

            if (personKey == -1)
                return null;

            if (personKey == 0)
                useOperDB = true;

            return new NotifyTaskCompletion<List<Level>>(this.getLevelsFromSqlAsync(levelId, useOperDB));

            //return this.getLevelsFromSqlAsync(levelId, useOperDB);
        }
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
        public override object ProvideValue(IServiceProvider serviceProvider)
        {
            return this;
        }

        private async Task<List<Level>> getLevelsFromSqlAsync(string levelId, bool useOperBD)
        {
            List<Level> levels = await DataAccessService.GetLevelsStaticAsync(CancellationToken.None, useOperBD, null, true, levelId);
            return levels;
        }
    }
}
