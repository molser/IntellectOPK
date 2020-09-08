using IntellectOPK.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Utilities
{
    public static class DataTablesHelper
    {

        private static DataTable listToDataTable<T>(IList<T> data, bool checkable)
        {
            PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(typeof(T));
            DataTable dt = new DataTable();

            foreach (PropertyDescriptor prop in properties)
            {
                dt.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            }
            if(checkable) dt.Columns.Add("IsChecked", typeof(Boolean));

            foreach (T item in data)
            {
                DataRow row = dt.NewRow();
                foreach (PropertyDescriptor pdt in properties)
                {
                    row[pdt.Name] = pdt.GetValue(item) ?? DBNull.Value;
                }
                if (checkable) row["IsChecked"] = false;
                dt.Rows.Add(row);
            }
            return dt;
        }

        public static DataTable CreatePermissionsTable()
        {
            DataTable table = new DataTable();

            DataColumn idColumn = new DataColumn("ID", typeof(Int32));
            idColumn.ReadOnly = true;
            idColumn.Unique = true;
            table.Columns.Add(idColumn);

            DataColumn nameColumn = new DataColumn("Name", Type.GetType("System.String"));
            nameColumn.ReadOnly = true;
            nameColumn.Unique = true;
            table.Columns.Add(nameColumn);

            DataColumn descriptionColumn = new DataColumn("Description", Type.GetType("System.String"));
            descriptionColumn.ReadOnly = true;
            descriptionColumn.Unique = false;
            table.Columns.Add(descriptionColumn);

            DataColumn isCheckedColumn = new DataColumn("IsChecked", typeof(Boolean));
            isCheckedColumn.ReadOnly = false;
            isCheckedColumn.Unique = false;
            isCheckedColumn.DefaultValue = false;
            table.Columns.Add(isCheckedColumn);

            // Make the ID column the primary key column.
            DataColumn[] PrimaryKeyColumns = new DataColumn[1];
            PrimaryKeyColumns[0] = table.Columns["ID"];
            table.PrimaryKey = PrimaryKeyColumns;
            //table.PrimaryKey = new DataColumn[] { table.Columns["ID"] };

            return table;
        }
        public static void FillUserRolesTable(DataTable table, List<Role> appRoles, List<Role> userRoles = null)
        {
            foreach (Role role in appRoles)
            {
                //table.Rows.Add(new object[] { role.ID, role.Name, role.Description });
                DataRow row = table.NewRow();
                row["ID"] = role.ID;
                row["Name"] = role.Name;
                row["Description"] = role.Description;
                if (userRoles != null) row["IsChecked"] = userRoles.Contains(role);
                table.Rows.Add(row);
            }
            table.AcceptChanges();
            //сортируем записи
            DataView dv = table.DefaultView;
            dv.Sort = "Description asc";
            DataTable dt = dv.ToTable();
            table = dt;

            
        }
        public static DataTable CreateRolesTable()
        {
            return DataTablesHelper.CreatePermissionsTable();
        }
        public static void FillPermissionsTable(DataTable table, List<Permission> appPermissions, List<Permission> onesPermissions = null)
        {
            foreach (Permission permission in appPermissions)
            {
                //table.Rows.Add(new object[] { role.ID, role.Name, role.Description });
                DataRow row = table.NewRow();
                row["ID"] = permission.ID;
                row["Name"] = permission.Name;
                row["Description"] = permission.Description;
                if (onesPermissions != null) row["IsChecked"] = onesPermissions.Contains(permission);
                table.Rows.Add(row);
            }
            table.AcceptChanges();
            //сортируем записи
            DataView dv = table.DefaultView;
            dv.Sort = "Description asc";
            DataTable dt = dv.ToTable();
            table = dt; 
        }
        public static DataTable CreateUsersTable()
        {
            DataTable table = new DataTable();

            DataColumn idColumn = new DataColumn("ID", typeof(Int32));
            idColumn.ReadOnly = true;
            idColumn.Unique = true;
            table.Columns.Add(idColumn);

            DataColumn loginColumn = new DataColumn("Login", Type.GetType("System.String"));
            loginColumn.ReadOnly = true;
            loginColumn.Unique = true;
            table.Columns.Add(loginColumn);

            DataColumn nameColumn = new DataColumn("Name", Type.GetType("System.String"));
            nameColumn.ReadOnly = true;
            nameColumn.Unique = false;
            table.Columns.Add(nameColumn);

            DataColumn commentColumn = new DataColumn("Comment", Type.GetType("System.String"));
            commentColumn.ReadOnly = true;
            commentColumn.Unique = false;
            table.Columns.Add(commentColumn);

            DataColumn isAdminColumn = new DataColumn("IsAdmin", typeof(Boolean));
            isAdminColumn.ReadOnly = true;
            isAdminColumn.Unique = false;
            isAdminColumn.DefaultValue = false;
            table.Columns.Add(isAdminColumn);

            DataColumn isLockedColumn = new DataColumn("IsLocked", typeof(Boolean));
            isLockedColumn.ReadOnly = true;
            isLockedColumn.Unique = false;
            isLockedColumn.DefaultValue = false;
            table.Columns.Add(isLockedColumn);

            DataColumn isCheckedColumn = new DataColumn("IsChecked", typeof(Boolean));
            isCheckedColumn.ReadOnly = false;
            isCheckedColumn.Unique = false;
            isCheckedColumn.DefaultValue = false;
            table.Columns.Add(isCheckedColumn);

            // Make the ID column the primary key column.
            DataColumn[] PrimaryKeyColumns = new DataColumn[1];
            PrimaryKeyColumns[0] = table.Columns["ID"];
            table.PrimaryKey = PrimaryKeyColumns;
            //table.PrimaryKey = new DataColumn[] { table.Columns["ID"] };

            return table;
        }
        public static void FillRoleUsersTable(DataTable table, List<User> appUsers, List<User> roleUsers = null)
        {
            foreach (User user in appUsers)
            {
                //table.Rows.Add(new object[] { role.ID, role.Name, role.Description });
                DataRow row = table.NewRow();
                row["ID"] = user.ID;
                row["Login"] = user.Login;
                row["Name"] = user.Name;
                row["Comment"] = user.Comment;
                row["IsAdmin"] = user.IsAdmin;
                row["IsLocked"] = user.IsLocked;
                if (roleUsers != null) row["IsChecked"] = roleUsers.Contains(user);
                table.Rows.Add(row);
            }
            table.AcceptChanges();

            //сортируем записи
            DataView dv = table.DefaultView;
            dv.Sort = "Login asc";
            DataTable dt = dv.ToTable();
            table = dt;
        }

        public static DataTable CreatePersonsTable()
        {
            DataTable table = new DataTable();

            table.Columns.Add("PersonKey", typeof(Int32));
            table.Columns.Add("ID", typeof(String));
            table.Columns.Add("Name", typeof(String));
            table.Columns.Add("Surname", typeof(String));
            table.Columns.Add("Patronymic", typeof(String));
            table.Columns.Add("Comment", typeof(String));
            table.Columns.Add("Guid", typeof(Guid));
            table.Columns.Add("Department", typeof(String));
            table.Columns.Add("ImagePath", typeof(String));
            table.Columns.Add("FullName", typeof(String));
            table.Columns.Add("IsChecked", typeof(Boolean));
            return table;
        }
        public static void FillPersonsTable(DataTable table, List<Person> persons)
        {
            foreach (Person person in persons)
            {
                //table.Rows.Add(new object[] { role.ID, role.Name, role.Description });
                DataRow row = table.NewRow();
                row["PersonKey"] = person.PersonKey;
                row["ID"] = person.Id;
                row["Name"] = person.Name;
                row["Surname"] = person.Surname;
                row["Patronymic"] = person.Patronymic;
                row["Comment"] = person.Comment;
                row["Guid"] = person.Guid;
                row["Department"] = person.Department;
                //row["ImagePath"] = person.ImagePath;
                row["FullName"] = person.FullName;
                row["IsChecked"] = false;
                table.Rows.Add(row);
            }
            table.AcceptChanges();
            //сортируем записи
            DataView dv = table.DefaultView;
            dv.Sort = "FullName asc";
            DataTable dt = dv.ToTable();
            table = dt;
        }

        //public static DataTable CreateAccessPointsTable()
        //{
        //    DataTable table = new DataTable();

        //    table.Columns.Add("Nc32kKey", typeof(Int32));
        //    table.Columns.Add("ID", typeof(String));
        //    table.Columns.Add("Name", typeof(String));
        //    table.Columns.Add("Guid", typeof(Guid));
        //    table.Columns.Add("IsChecked", typeof(Boolean));
        //    return table;
        //}


        public static DataTable GetDataTableFromList<T>(IList<T> data, bool checkable, string sorted_column = null)
        {
            DataTable table = listToDataTable(data, checkable);
            DataTable sorted_table = null;
            if (sorted_column != null)
            {
                DataView dv = table.DefaultView;
                dv.Sort = sorted_column;
                sorted_table = dv.ToTable();
                table.Dispose();
                table = sorted_table;
            }
            table.AcceptChanges();
            return table;
        }        

        public static void CheckUncheckAll(DataTable table, bool is_checked)
        {
            bool check_column_exists = false;
            foreach (DataColumn col in table.Columns)
            {
                if (col.DataType.Equals(typeof(Boolean)))
                {
                    if (col.ColumnName == "IsChecked")
                        check_column_exists = true;
                }
            }

            if (check_column_exists == true)
            {
                foreach (DataRow row in table.Rows)
                {
                    row["IsChecked"] = is_checked;
                }
            }
        }

        public static void CheckFromStringList(DataTable table, string string_list, string column_name, string validChars = null)
        {
            bool check_column_exists = false;
            bool target_column_exists = false;
            foreach (DataColumn col in table.Columns)
            {
                if (col.DataType.Equals(typeof(String)))
                {
                    if (col.ColumnName == column_name)
                        target_column_exists = true;
                }
                if (col.DataType.Equals(typeof(Boolean)))
                {
                    if (col.ColumnName == "IsChecked")
                        check_column_exists = true;
                }
            }

            if (check_column_exists == true && target_column_exists == true)
            {
                if (string_list != null)
                {
                    char[] delimiterChars = { ',' };
                    string[] values = string_list.Split(delimiterChars);

                    string cell_value = "";
                    foreach (DataRow row in table.Rows)
                    {
                        cell_value = StringHelper.RemoveUnnecessaryChars(row[column_name].ToString(), validChars);                        
                        if (values.Contains(cell_value)) row["IsChecked"] = true;
                    }
                }
            }
        }        
    }
}

