using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IntellectOPK.Model
{
    public class RolePermission
    {
        public int ID { set; get; }
        public string RoleName { set; get; }
        public string PermissionName { set; get; }
        public RolePermission()
        {
            ID = 0;
            RoleName = "";
            PermissionName = "";
        }

        public RolePermission(int id,
                    string role_name,
                    string permission_name)
        {
            ID = id;
            RoleName = role_name;
            PermissionName = permission_name;
        }
        
    }
}
