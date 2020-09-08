using IntellectOPK.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Security;
using System.Windows.Media.Imaging;

namespace IntellectOPK.Model
{
    public interface IDataAccessService
    {
        //string UserLogin {get;}
        //void SetSqlCredential(string user_name, SecureString password);
        Task<SqlLoginResult> LoginAsync(CancellationToken token, string login, SecureString password, string computer_name = null, string appBuild = null);
        Task<string> CheckOperDbConnectionAsync (CancellationToken token);
        void ChangePassword(SecureString newPassword);
        Task<List<ProtocolItem>> GetAccessEventsAsync(CancellationToken token, MainQueryParams query_params, bool use_oper_db = false, string computer_name = null);
        Task<List<User>> GetUsersAsync(CancellationToken token, string role_name = null);
        Task<List<Person>> GetPersonsAsync(CancellationToken token, MainQueryParams personsParams, bool use_oper_db = false);
        Task<List<Person>> GetPersonAsync(CancellationToken token, int person_key, string person_id, Guid guid, DateTime valid_date, bool show_person_history=false, bool use_oper_db = false);
        Task<List<Role>> GetRolesAsync(CancellationToken token, string user_login = null);
        Task<List<Permission>> GetPermissionsAsync(CancellationToken token, bool for_current_user, string managed_user_login = null, string role_name = null);
        Task<List<RolePermission>> GetRolesPermissionsAsync(CancellationToken token);
        //Task<List<AccessPoint>> GetAccessPointsAsync(CancellationToken token, DateTime valid_date, bool use_oper_db = false, bool only_worked = false, string level_id = null, string person_id = null, bool show_full_access_level = false);
        Task<List<AccessPoint>> GetAccessPointsAsync(CancellationToken token, MainQueryParams accessPointsParams);
        Task<List<Department>> GetDepartmentsAsync(CancellationToken token, bool use_oper_db = false, bool only_exists = true);
        Task<List<Event>> GetEventsAsync(CancellationToken token, string objtype);
        //Task<List<Level>> GetLevelsAsync(CancellationToken token, bool use_oper_db = false, string nc32k_id = null, bool show_full_access_level = false, string levels = null, DateTime valid_from = default(DateTime), bool isDepartmentLevels = false);
        Task<List<Level>> GetLevelsAsync(CancellationToken token, MainQueryParams levelsParams);
        Task<Boolean> CheckUserForSecurityAdminAsync(CancellationToken token);
        Task ManageLevelAsync(CancellationToken token, ManageLevelAction action, Level level, bool use_oper_db);
        Task<int> ManageUserAsync(CancellationToken token, ManageUserAction action, User user, User old_user = null);
        Task ManageUserRolesAsync(CancellationToken token, ManageUserRolesAction action, User user,  string role_name);
        Task ManageRolePermissionsAsync(CancellationToken token, ManageRolePermissionsAction action, string role_name, string permission_name);
        Task LogAuditEventAsync(CancellationToken token, string audit_group, string audit_action, string computer_name = null, string appBuild = null, 
                                string extension = null, string access_points = null, string cams=null, DateTime cam_date = new DateTime(), string persons = null);
        Task<Settings> GetSettingsAsync(CancellationToken token, string host_name);

        //BitmapImage GetPersonPhotoFromDB(int person_key, int photo_width);
        Task<byte[]> GetPersonPhotoFromDBAsync(CancellationToken token, int person_key);
        Task<BitmapImage> GetPersonPhotoFromDBAsync(CancellationToken token, int person_key, int photo_width = 0, int photo_height = 0);
        Task<BitmapImage> GetPersonPhotoFromFileAsync(string person_id, int photo_width = 0, int photo_height = 0);
        Task<byte[]> GetPersonPhotoFromFileAsync(string person_id);
        //Task<List<string>> GetMicrophonesAsync(CancellationToken token, string cam_id, bool use_oper_db = false);
        //Task<List<string>> GetCamsAsync(CancellationToken token, string obj_type, string obj_id, bool use_oper_db = false);
        void ServiceDispose();
    }
}
