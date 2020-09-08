using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Windows.Documents;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Threading;
using System.Security;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Collections.ObjectModel;
using System.Windows.Media.Imaging;
using System.Windows.Media;
using System.IO;
using IntellectOPK.Model.Utilities;

namespace IntellectOPK.Model
{
    public enum SqlLoginResult
    {
        OK,
        NeededChangePassword,
        Error
    }

    public class DataAccessService : IDataAccessService //, IDisposable
    {
        #region MemberData

        private string sql_server_name;
        private static string sql_server_name_static;
        private string data_base_name;
        private string intellect_dir;
        private static string intellect_dir_static;
        private static string data_base_name_static;
        private SqlCredential sql_credentials;
        private static SqlCredential sql_credentials_static;
        //private bool disposed = false;

        #endregion

        #region Constructor
        public DataAccessService(string sql_server_name, string data_base_name, string intellect_dir)
        {
            this.sql_server_name = sql_server_name;
            this.data_base_name = data_base_name;
            sql_server_name_static = sql_server_name;
            data_base_name_static = data_base_name;
            this.intellect_dir = intellect_dir;
            intellect_dir_static = intellect_dir;
        }
        #endregion

        #region PrivateMethods
 
        private string getSqlConnectionString()
        {
            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
            builder["Data Source"] = this.sql_server_name;
            builder["Initial Catalog"] = this.data_base_name;
            builder["Integrated Security"] = false;
            //builder["ContextConnection"] = false;
            //builder["User ID"] = this.user_login;
            //builder["Password"] = this.user_password;
            //builder["integrated Security"] = true;
            return builder.ConnectionString;
        }

        private static string getSqlConnectionStringStatic()
        {
            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
            builder["Data Source"] = sql_server_name_static;
            builder["Initial Catalog"] = data_base_name_static;
            builder["Integrated Security"] = false;
            //builder["ContextConnection"] = false;
            //builder["User ID"] = this.user_login;
            //builder["Password"] = this.user_password;
            //builder["integrated Security"] = true;
            return builder.ConnectionString;
        }

        private static object exequteScalar(SqlCommand command)
        {
            using (SqlConnection conn = new SqlConnection(getSqlConnectionStringStatic(), sql_credentials_static))
            {
                conn.Open();
                command.Connection = conn;
                return command.ExecuteScalar();
            }
        }

        private async  static Task<object> exequteScalarStaticAsync(CancellationToken token, SqlCommand command)
        {
            using (SqlConnection conn = new SqlConnection(getSqlConnectionStringStatic(), sql_credentials_static))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                command.Connection = conn;
                return await command.ExecuteScalarAsync(token).ConfigureAwait(false);
                //await conn.OpenAsync(token);
                //command.Connection = conn;
                //return await command.ExecuteScalarAsync(token);
            }
        }

        private async Task<object> exequteScalarAsync(CancellationToken token, SqlCommand command)
        {
            using (SqlConnection conn = new SqlConnection(getSqlConnectionStringStatic(), sql_credentials_static))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                command.Connection = conn;
                return await command.ExecuteScalarAsync(token).ConfigureAwait(false);
            }
        }

        private async Task exequteReaderAsync(CancellationToken token, SqlCommand command, Action<SqlDataReader> action)
        {
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                command.Connection = conn;
                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {
                    while (await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        action(reader);
                    }
                }
            }
        }

        private async static Task exequteReaderStaticAsync(CancellationToken token, SqlCommand command, Action<SqlDataReader> action)
        {
            using (SqlConnection conn = new SqlConnection(getSqlConnectionStringStatic(), sql_credentials_static))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                command.Connection = conn;
                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {
                    while (await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        action(reader);
                    }
                }
            }
        }

        #endregion

        #region Properties
        //public string UserLogin
        //{
        //    get 
        //    {
        //        if (this.sql_credentials != null)
        //        {
        //            return this.sql_credentials.UserId;
        //        }
        //        else return null;
        //    }            

        //}
        #endregion


        #region IDataAccessService  Members


        public async Task<SqlLoginResult> LoginAsync(CancellationToken token, string login, SecureString password, string computer_name = null, string appBuild = null)
        {

            password.MakeReadOnly();
            this.sql_credentials = new SqlCredential(login, password);
            sql_credentials_static = new SqlCredential(login, password);
            //}            
            //using (SqlConnection conn = new SqlConnection("Data Source=192.168.3.108; Initial Catalog = Intellect; User ID = intellect_reader; Password = 1"))
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                SqlCommand command = conn.CreateCommand();
                command.CommandText = "usp_Login";
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@app_build", appBuild);
                if (computer_name != null) command.Parameters.AddWithValue("@computer_name", computer_name);
                command.Parameters.Add("@result", SqlDbType.VarChar, 255);
                command.Parameters["@result"].Direction = ParameterDirection.Output;
                
                await conn.OpenAsync(token).ConfigureAwait(false);
                await command.ExecuteNonQueryAsync(token).ConfigureAwait(false);
                
                string sql_result_str = command.Parameters["@result"].Value.ToString();

                SqlLoginResult result;

                switch (sql_result_str)
                {
                    case "ok":
                        result = SqlLoginResult.OK;
                        break;
                    case "needed_change_password":
                        result = SqlLoginResult.NeededChangePassword;
                        break;
                    default:
                        result = SqlLoginResult.Error;
                        break;
                }

                return result;
            }            
        }

        public async Task<string> CheckOperDbConnectionAsync(CancellationToken token)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_CheckOperDbConnection";
#if DEBUG
            command.CommandTimeout = 5;
#endif
            object resultObj = await (exequteScalarAsync(token, command));
            return resultObj.ToString();
        }

        public void ChangePassword(SecureString newPassword)
        {            
            string user_name = this.sql_credentials.UserId;            
            newPassword.MakeReadOnly();
            try
            {
                using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
                {                
                    conn.Open();                                
                    SqlCommand command = new SqlCommand();
                    command.Connection = conn;                                
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "usp_ChangeUserPassword";
                    command.Parameters.AddWithValue("@user_login", this.sql_credentials.UserId);
                    command.ExecuteNonQuery();
                }
                SqlConnection.ChangePassword(this.getSqlConnectionString(), this.sql_credentials, newPassword);
                this.sql_credentials = new SqlCredential(user_name, newPassword);
                sql_credentials_static = new SqlCredential(user_name, newPassword);
            }
            catch (Exception ex)
            {
                newPassword.Dispose();
                newPassword = null;
                throw ex;
            }            
        }

        public async Task<List<ProtocolItem>> GetAccessEventsAsync(CancellationToken token, MainQueryParams query_params, bool use_oper_db = false, string computer_name = null)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetAccessEvents";
            command.Parameters.AddWithValue("@persons", query_params.Persons);
            command.Parameters.AddWithValue("@access_points", query_params.AccessPoints);
            command.Parameters.AddWithValue("@events", query_params.Events);
            command.Parameters.AddWithValue("@departments", query_params.Departments);
            command.Parameters.AddWithValue("@facility_code", query_params.FacilityCod);
            command.Parameters.AddWithValue("@card", query_params.CardPartParsec);
            command.Parameters.AddWithValue("@person_id", query_params.PersonId);
            command.Parameters.AddWithValue("@date_start", query_params.StartDate);
            command.Parameters.AddWithValue("@date_end", query_params.EndDate);
            command.Parameters.AddWithValue("@only_last_10_events_for_day", query_params.OnlyLast10EventsForDay);
            command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
            if (computer_name != null) command.Parameters.AddWithValue("@computer_name", computer_name);
            //command.Parameters.AddWithValue("@app_build", "1.0.0.0");
            //command.Parameters.AddWithValue("@mode", "ByName");
            //таймаут, по истечении которого будет прерван неоконченный запрос
            command.CommandTimeout = 4 * 60; //240 seconds

            List<ProtocolItem> protocol = new List<ProtocolItem>();

            await this.exequteReaderAsync
                (token, command, reader =>
                     {
                         ProtocolItem protocol_item = new ProtocolItem()
                         {
                             Date = Convert.ToDateTime(reader["date"]),
                             Event = reader["event"].ToString(),
                             Information = reader["person"].ToString(),
                             Department = reader["department"].ToString(),
                             Nc32kId = reader["nc32k_id"].ToString(),
                             Nc32kName = reader["nc32k"].ToString(),
                             PersonKey = Convert.ToInt32(reader["person_key"]),
                             PersonID = reader["person_id"].ToString(),
                             Card = reader["card"].ToString()
                         };
                         protocol.Add(protocol_item);
                     }
                );
            return protocol;
        }

        //public async Task<List<AccessPoint>> GetAccessPointsAsync(CancellationToken token, DateTime valid_date, bool use_oper_db = false, bool only_worked = false, string level_id = null, string person_id = null, bool show_full_access_level = false)
        public async Task<List<AccessPoint>> GetAccessPointsAsync(CancellationToken token, MainQueryParams accessPointsParams)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetAccessPoints";
            command.Parameters.AddWithValue("@valid_date", accessPointsParams.StartDate);
            command.Parameters.AddWithValue("@use_oper_db", accessPointsParams.UseOperDB);
            command.Parameters.AddWithValue("@only_worked", accessPointsParams.OnlyWorked);
            command.Parameters.AddWithValue("@level_id", accessPointsParams.LevelId);
            command.Parameters.AddWithValue("@person_id", accessPointsParams.PersonId);
            command.Parameters.AddWithValue("@show_full_access_level", accessPointsParams.ShowFullAccessLevel);
            command.Parameters.AddWithValue("@name", accessPointsParams.Name);
            //command.CommandTimeout = 4 * 60; //240 seconds

            List<AccessPoint> items = new List<AccessPoint>();

            await this.exequteReaderAsync
                (token, command, reader =>
                {
                    AccessPoint item = new AccessPoint()
                    {
                        Nc32kKey = Convert.ToInt32(reader["nc32k_key"]),
                        Id = reader["id"].ToString(),
                        Name = reader["name"].ToString(),
                        Guid = new Guid(reader["guid"].ToString())
                    };
                    items.Add(item);
                }
                );
            return items;
        }

        public async Task<List<Department>> GetDepartmentsAsync(CancellationToken token, bool use_oper_db = false, bool only_exists = true)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetDepartments";
            command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
            command.Parameters.AddWithValue("@only_exists", only_exists);

            //command.CommandTimeout = 4 * 60; //240 seconds

            List<Department> items = new List<Department>();

            await this.exequteReaderAsync
                (token, command, reader =>
                {
                    Department item = new Department()
                    {
                        DeptKey = Convert.ToInt32(reader["dept_key"]),
                        Id = reader["id"].ToString(),
                        Name = reader["name"].ToString(),
                        Guid = new Guid(reader["guid"].ToString())
                    };
                    items.Add(item);
                }
                );
            return items;
        }

        public async Task<List<Event>> GetEventsAsync(CancellationToken token, string objtype)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetEvents";
            command.Parameters.AddWithValue("@objtype", objtype);

            List<Event> items = new List<Event>();

            await this.exequteReaderAsync
                (token, command, reader =>
                {
                    Event item = new Event()
                    {
                        Objtype = reader["objtype"].ToString(),
                        Action = reader["action"].ToString(),
                        Description = reader["description"].ToString()
                    };
                    items.Add(item);
                }
                );
            return items;
        }

        //public async Task<List<Level>> GetLevelsAsync(CancellationToken token, bool use_oper_db = false, string nc32k_id = null, bool show_full_access_level = false, string levels = null, DateTime valid_from = default(DateTime), bool isDepartmentLevels = false)
        public async Task<List<Level>> GetLevelsAsync(CancellationToken token, MainQueryParams levelsParams)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetLevels";
            //command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
            //command.Parameters.AddWithValue("@nc32k_id", nc32k_id);
            //command.Parameters.AddWithValue("@show_full_access_level", show_full_access_level);
            //command.Parameters.AddWithValue("@levels", levels);
            //command.Parameters.AddWithValue("@valid_from", valid_from);
            //command.Parameters.AddWithValue("@is_department_levels", isDepartmentLevels);
            command.Parameters.AddWithValue("@use_oper_db", levelsParams.UseOperDB);
            command.Parameters.AddWithValue("@nc32k_id", levelsParams.Nc32kId);
            command.Parameters.AddWithValue("@show_full_access_level", levelsParams.ShowFullAccessLevel);
            command.Parameters.AddWithValue("@levels", levelsParams.Levels);
            command.Parameters.AddWithValue("@valid_from", levelsParams.StartDate);
            command.Parameters.AddWithValue("@is_department_levels", levelsParams.IsDepartmentLevels);
            command.Parameters.AddWithValue("@name", levelsParams.Name);

            List<Level> items = new List<Level>();
            int num;
            float rank;
            await this.exequteReaderAsync
                (token, command, reader =>
                    {
                        num = 999;
                        rank = 999;
                        if (!reader.IsDBNull(reader.GetOrdinal("num")))
                            int.TryParse(reader["num"].ToString(), out num);
                        if (!reader.IsDBNull(reader.GetOrdinal("rank")))
                            float.TryParse(reader["rank"].ToString(), out rank);
                        Level item = new Level()
                        {
                            Id = reader["id"].ToString(),
                            Name = reader["name"].ToString(),
                            Description = reader["description"].ToString(),
                            Type = reader["type"].ToString(),
                            Rank = rank,
                            Num = num
                         };
                        items.Add(item);
                    }
                );
            return items;
        }

        public async Task ManageLevelAsync(CancellationToken token, ManageLevelAction action, Level level, bool use_oper_db)
        {
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                SqlCommand command = conn.CreateCommand();
                command.CommandText = "usp_ManageLevel";
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
                command.Parameters.AddWithValue("@action", action.ToString());
                command.Parameters.AddWithValue("@level_id", level.Id);
                command.Parameters.AddWithValue("@level_num", level.Num);
                command.Parameters.AddWithValue("@description", level.Description);
                command.Parameters.AddWithValue("@type", level.Type);
                command.Parameters.AddWithValue("@rank", level.Rank);

                await conn.OpenAsync().ConfigureAwait(false);
                await command.ExecuteNonQueryAsync().ConfigureAwait(false);
            }            
        }
        public async Task<int> ManageUserAsync(CancellationToken token, ManageUserAction action, User user,  User old_user = null)
        {
            int new_user_id = 0;
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                SqlCommand command = conn.CreateCommand();
                command.CommandText = "usp_ManageUser";
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@action", action.ToString());
                command.Parameters.AddWithValue("@managed_user_login", user.Login);
                command.Parameters.AddWithValue("@managed_user_name", user.Name);
                command.Parameters.AddWithValue("@managed_user_comment", user.Comment);
                command.Parameters.AddWithValue("@managed_user_is_admin", user.IsAdmin);
                command.Parameters.AddWithValue("@managed_user_is_locked", user.IsLocked);
                if (old_user != null) command.Parameters.AddWithValue("@old_managed_user_login", old_user.Login);
                command.Parameters.Add("@new_user_id", SqlDbType.Int);
                command.Parameters["@new_user_id"].Direction = ParameterDirection.Output;

                await conn.OpenAsync().ConfigureAwait(false);
                await command.ExecuteNonQueryAsync().ConfigureAwait(false);

                Int32.TryParse(command.Parameters["@new_user_id"].Value.ToString(), out new_user_id);
                
            }
            return new_user_id;
        }

        public async Task ManageUserRolesAsync(CancellationToken token, ManageUserRolesAction action, User user,  string role_name)
        {
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                SqlCommand command = conn.CreateCommand();
                command.CommandText = "usp_ManageUserRoles";
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@action", action.ToString());
                command.Parameters.AddWithValue("@managed_user_login", user.Login);
                command.Parameters.AddWithValue("@role_name", role_name);
                
                await conn.OpenAsync(token).ConfigureAwait(false);
                await command.ExecuteNonQueryAsync(token).ConfigureAwait(false);
                
            }
        }

        public async Task ManageRolePermissionsAsync(CancellationToken token, ManageRolePermissionsAction action, string role_name, string permission_name)
        {
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_ManageRolePermissions";
                command.Parameters.AddWithValue("@action", action.ToString());
                command.Parameters.AddWithValue("@role_name", role_name);
                command.Parameters.AddWithValue("@permission_name", permission_name);

                await conn.OpenAsync(token).ConfigureAwait(false);
                await command.ExecuteNonQueryAsync(token).ConfigureAwait(false);

            }
        }

        public async Task LogAuditEventAsync(CancellationToken token, string audit_group, string audit_action, string computer_name = null, 
                                             string appBuild = null, string extension = null, string access_points = null,
                                             string cams = null, DateTime cam_date = new DateTime(), string persons = null)
        {
            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_LogAuditEvent";
                command.Parameters.AddWithValue("@group", audit_group);
                command.Parameters.AddWithValue("@action", audit_action);
                if (computer_name != null) command.Parameters.AddWithValue("@computer_name", computer_name);
                if (appBuild != null) command.Parameters.AddWithValue("@app_build", appBuild);
                if (extension != null) command.Parameters.AddWithValue("@extension", extension);
                if (access_points != null) command.Parameters.AddWithValue("@access_points", access_points);
                if (cams != null) command.Parameters.AddWithValue("@cams", cams);
                if (cam_date != new DateTime()) command.Parameters.AddWithValue("@cam_date", cam_date);
                if (persons != null) command.Parameters.AddWithValue("@persons", persons);

                await conn.OpenAsync(token).ConfigureAwait(false);
                await command.ExecuteNonQueryAsync(token).ConfigureAwait(false);

            }
        }

        public async Task<List<User>> GetUsersAsync(CancellationToken token, string role_name = null)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetUsers";
            if (role_name != null) command.Parameters.AddWithValue("@role_name", role_name);
            List<User> users = new List<User>();
            await this.exequteReaderAsync
                (token, command, reader =>
                    {
                        User user = new User()
                        {
                            ID = Convert.ToInt32(reader["id"]),
                            Login = reader["login"].ToString(),
                            Name = reader["name"].ToString(),
                            Comment = reader["comment"].ToString(),
                            IsAdmin = Convert.ToBoolean(reader["is_admin"]),
                            IsLocked = Convert.ToBoolean(reader["is_locked"])
                            //IsSecurityAdmin = Convert.ToBoolean(reader["is_security_admin"])
                        };
                        users.Add(user);
                    }
                );
            return users;
        }

        public async Task<List<Person>> GetPersonsAsync(CancellationToken token, MainQueryParams personParams, bool use_oper_db = false)
        {
            List<Person> person_list = new List<Person>();

            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_GetPersons";
                command.Parameters.AddWithValue("@person", personParams.Person);
                command.Parameters.AddWithValue("@departments", personParams.Departments);
                command.Parameters.AddWithValue("@nc32k_id", personParams.Nc32kId);
                command.Parameters.AddWithValue("@level_id", personParams.LevelId);
                command.Parameters.AddWithValue("@show_person_history", personParams.ShowPersonHistory);
                command.Parameters.AddWithValue("@show_full_access_level", personParams.ShowFullAccessLevel);
                command.Parameters.AddWithValue("@hide_temp_persons", personParams.HideTempPersons);
                command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
                command.Parameters.AddWithValue("@person_id", personParams.PersonId);
                command.Parameters.AddWithValue("@facility_code", personParams.FacilityCod);
                command.Parameters.AddWithValue("@card", personParams.CardPartParsec);

                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {

                    while (await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        Person person = new Person()
                        {
                            PersonKey= Convert.ToInt32(reader["person_key"]),
                            Id = reader["id"].ToString(),
                            Name = reader["name"].ToString(),
                            Surname = reader["surname"].ToString(),
                            Patronymic = reader["patronymic"].ToString(),
                            Guid = new Guid(reader["guid"].ToString()),                            
                            Department = reader["department"].ToString(),
                            FacilityCode = reader["facility_code"].ToString(),
                            Card = reader["card"].ToString(),
                            Expired = Convert.ToDateTime(reader["expired"]),
                            IsLocked = Convert.ToBoolean(reader["is_locked"]),
                            IsApb = Convert.ToBoolean(reader["is_apb"]),
                            IsDeleted = Convert.ToBoolean(reader["is_deleted"]),
                            ValidFrom = Convert.ToDateTime(reader["valid_from"]),
                            ValidTo = Convert.ToDateTime(reader["valid_to"])
                        };
                        person_list.Add(person);
                    }
                }
            }
            return person_list;
        }        

        public async Task<List<Person>> GetPersonAsync(CancellationToken token, int person_key, string person_id, Guid guid, DateTime valid_date, bool show_person_history = false, bool use_oper_db = false)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetPerson";
            command.Parameters.AddWithValue("@person_key", person_key);
            command.Parameters.AddWithValue("@person_id", person_id);
            command.Parameters.AddWithValue("@guid", guid);
            command.Parameters.AddWithValue("@valid_date", valid_date);
            command.Parameters.AddWithValue("@show_person_history", show_person_history);
            command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
            
            List<Person> person_list = new List<Person>();
            await this.exequteReaderAsync
                (token, command, reader =>
                    {
                        Person person = new Person()
                        {
                            PersonKey = Convert.ToInt32(reader["person_key"]),
                            PhotoKey = Convert.ToInt32(reader["photo_key"]),
                            Id = reader["id"].ToString(),
                            Name = reader["name"].ToString(),
                            Surname = reader["surname"].ToString(),
                            Patronymic = reader["patronymic"].ToString(),
                            Guid = new Guid(reader["guid"].ToString()),
                            Post = reader["post"].ToString(),
                            Department = reader["department"].ToString(),
                            
                            Tabnum = reader["tabnum"].ToString(),
                            Passport = reader["passport"].ToString(),
                            Pin = reader["pin"].ToString(),
                            FacilityCode = reader["facility_code"].ToString(),
                            Card = reader["card"].ToString(),
                            LevelId = reader["level_id"].ToString(),
                            DepartmentLevelId = reader["department_level_id"].ToString(),
                            StartedAt = Convert.ToDateTime(reader["started_at"]),
                            Expired = Convert.ToDateTime(reader["expired"]),
                            IsApb = Convert.ToBoolean(reader["is_apb"]),
                            IsLocked = Convert.ToBoolean(reader["is_locked"]),
                            Pnet3Alarm = Convert.ToBoolean(reader["pnet3_alarm"]),
                            Pnet3Block = Convert.ToBoolean(reader["pnet3_block"]),
                            Pnet3Guard = Convert.ToBoolean(reader["pnet3_guard"]),

                            WhoCard = reader["who_card"].ToString(),
                            WhoLevel = reader["who_level"].ToString(),
                            
                            ValidFrom = reader.GetDateTime(reader.GetOrdinal("valid_from")),
                            ValidTo = reader.GetDateTime(reader.GetOrdinal("valid_to"))
                            
                        };
                        person_list.Add(person);
                    }
                );
            return person_list;
        }

        public async Task<List<Role>> GetRolesAsync(CancellationToken token, string user_login = null)
        {
            List<Role> roles = new List<Role>();

            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_GetRoles";
                if (user_login != null) command.Parameters.AddWithValue("@user_login", user_login);

                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {

                    while (await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        Role role = new Role()
                        {
                            ID = Convert.ToInt32(reader["id"]),
                            Name = reader["name"].ToString(),
                            Description = reader["description"].ToString()
                        };
                        roles.Add(role);
                    }
                }
            }
            return roles;
        }

        public async Task<List<Permission>> GetPermissionsAsync(CancellationToken token, bool for_current_user, string managed_user_login = null, string role_name = null)
        {
            List<Permission> permissions = new List<Permission>();

            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_GetPermissions";
                command.Parameters.AddWithValue("@for_current_user", for_current_user);
                if (role_name != null) command.Parameters.AddWithValue("@managed_user_login", managed_user_login);
                if (role_name != null) command.Parameters.AddWithValue("@role_name", role_name);
                
                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {

                    while (await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        Permission permission = new Permission()
                        {
                            ID = Convert.ToInt32(reader["id"]),
                            Name = reader["name"].ToString(),
                            Description = reader["description"].ToString()
                        };
                        permissions.Add(permission);
                    }
                }
            }
            return permissions;
        }

        public async Task<List<RolePermission>> GetRolesPermissionsAsync(CancellationToken token)
        {
            List<RolePermission> rolesPermissions = new List<RolePermission>();

            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_GetRolesPermissions";
                
                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {

                    while (await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        RolePermission rolePermission = new RolePermission()
                        {
                            ID = Convert.ToInt32(reader["ID"]),
                            RoleName = reader["RoleName"].ToString(),
                            PermissionName = reader["PermissionName"].ToString()
                        };
                        rolesPermissions.Add(rolePermission);
                    }
                }
            }
            return rolesPermissions;
        }

        public async Task<Boolean> CheckUserForSecurityAdminAsync(CancellationToken token)
        {
            bool result = false;

            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.Text;
                command.CommandText = "SELECT app.ufn_CheckUserForSecurityAdmin()";

                result = (bool)await command.ExecuteScalarAsync().ConfigureAwait(false);

            }
            return result;
        }

        //public static byte[] GetPersonPhotoStatic(int person_key)
        //{
        //    SqlCommand command = new SqlCommand();
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.CommandText = "usp_GetPersonPhoto";
        //    command.Parameters.AddWithValue("@person_key", person_key);

        //    return (byte[])exequteScalar(command);
        //}

        //public async static Task<byte[]> GetPersonPhotoStaticAsync(CancellationToken token, int person_key)
        //{
        //    SqlCommand command = new SqlCommand();
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.CommandText = "usp_GetPersonPhoto";
        //    command.Parameters.AddWithValue("@person_key", person_key);
        //    byte[] array = await (exequteScalarStaticAsync(token, command)) as byte[];
        //    return array;
        //}        

        //public BitmapImage GetPersonPhotoFromDB(int person_key, int photo_width)
        //{
        //    SqlCommand command = new SqlCommand();
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.CommandText = "usp_GetPersonPhoto";
        //    command.Parameters.AddWithValue("@person_key", person_key);
        //    byte[] array = (exequteScalar(command)) as byte[];
        //    BitmapImage bitmap = ImageHelper.GetImageFromArray(array, photo_width);
        //    return bitmap;
        //}

        public async Task<byte[]> GetPersonPhotoFromDBAsync(CancellationToken token, int person_key)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetPersonPhoto";
            command.Parameters.AddWithValue("@person_key", person_key);
            byte[] array = await (exequteScalarAsync(token, command)) as byte[];
            return array;
        }

        public async Task<BitmapImage> GetPersonPhotoFromDBAsync(CancellationToken token, int person_key, int photo_width = 0, int photo_height = 0)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetPersonPhoto";
            command.Parameters.AddWithValue("@person_key", person_key);
            byte[] array = await (exequteScalarAsync(token, command)) as byte[];
            BitmapImage bitmap = ImageHelper.GetImageFromArray(array, photo_width, photo_height);
            return bitmap;
        }

        public static async Task<BitmapImage> GetPersonPhotoFromDBStaticAsync(CancellationToken token, int person_key, int photo_width=0, int photo_height=0)
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetPersonPhoto";
            command.Parameters.AddWithValue("@person_key", person_key);
            byte[] array = await (exequteScalarStaticAsync(token, command)) as byte[];
            BitmapImage bitmap = ImageHelper.GetImageFromArray(array, photo_width, photo_height);
            return bitmap;
        }

        public async Task<BitmapImage> GetPersonPhotoFromFileAsync(string person_id, int photo_width = 0, int photo_height = 0)
        {
            string image_path = intellect_dir + "\\bmp\\Person\\" + person_id + ".bmp";
            BitmapImage bitmap = await ImageHelper.GetImageFromFileAsync(image_path, photo_width, photo_height);
            return bitmap;
        }

        public async Task<byte[]> GetPersonPhotoFromFileAsync(string person_id)
        {
            string image_path = intellect_dir + "\\bmp\\Person\\" + person_id + ".bmp";
            byte[] array = await ImageHelper.GetArrayFromFileAsync(image_path);
            return array;
        }
        public static async Task<BitmapImage> GetPersonPhotoFromFileStaticAsync(string person_id, int photo_width = 0, int photo_height = 0)
        {
            string image_path = intellect_dir_static + "\\bmp\\Person\\" + person_id + ".bmp";
            BitmapImage bitmap = await ImageHelper.GetImageFromFileAsync(image_path, photo_width, photo_height);
            return bitmap;
        }


        public async Task<Settings> GetSettingsAsync(CancellationToken token, string host_name)
        {
            Settings settings = new Settings();

            using (SqlConnection conn = new SqlConnection(this.getSqlConnectionString(), this.sql_credentials))
            {
                await conn.OpenAsync(token).ConfigureAwait(false);
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "usp_GetSettings";
                command.Parameters.AddWithValue("@host_name", host_name);
                
                using (SqlDataReader reader = await command.ExecuteReaderAsync(token).ConfigureAwait(false))
                {
                    while(await reader.ReadAsync(token).ConfigureAwait(false))
                    {
                        settings.HostName = reader["host_name"].ToString();
                        settings.IsIidkEnable = Convert.ToBoolean(reader["is_iidk_enable"]);
                        settings.IidkManagedSlave = reader["iidk_managed_slave"].ToString();
                        settings.IidkMap = reader["iidk_map"].ToString();
                        settings.IidkMonitor = reader["iidk_monitor"].ToString();
                        break;
                    }                    
                }
            }
            return settings;
        }

        //public async Task<List<string>> GetMicrophonesAsync(CancellationToken token, string cam_id, bool use_oper_db = false)
        //{
        //    SqlCommand command = new SqlCommand();
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.CommandText = "usp_GetMicrophones";
        //    command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
        //    command.Parameters.AddWithValue("@cam_id", cam_id);

        //    List<string> items = new  List<string>();
            
        //    await this.exequteReaderAsync
        //        (token, command, reader =>
        //            {
        //                string item = reader["mic_id"].ToString();                    
        //                items.Add(item);
        //            }
        //        );
        //    return items;
        //}

        //public async Task<List<string>> GetCamsAsync(CancellationToken token, string obj_type, string obj_id, bool use_oper_db = false)
        //{
        //    SqlCommand command = new SqlCommand();
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.CommandText = "usp_GetCams";
        //    command.Parameters.AddWithValue("@use_oper_db", use_oper_db);
        //    command.Parameters.AddWithValue("@obj_type", obj_type);
        //    command.Parameters.AddWithValue("@obj_id", obj_id);

        //    List<string> items = new List<string>();

        //    await this.exequteReaderAsync
        //        (token, command, reader =>
        //        {
        //            string item = reader["cam_id"].ToString();
        //            items.Add(item);
        //        }
        //        );
        //    return items;
        //}

        public void ServiceDispose()
        {
            //if (this.password != null)
            //{
            //    password.Dispose();
            //}
        }

        
        #endregion

        #region ProtectedMethods
        
        #endregion

        #region IDisposable Member
        /*
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                
                if (disposing)
                {
                    //dispose managed resources
                    if (this.password != null)
                    {
                        password.Dispose();
                    }
                }
                //clean up unmanaged resoursces hear
            }
        }
         */
        #endregion

    }
}
