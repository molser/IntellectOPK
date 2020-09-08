using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.Model
{
    public enum ManageUserAction
    {
        Add,
        Modify,
        Remove,
        ResetPassword
    }

    public enum ManageLevelAction
    {
        Modify
    }

    public enum ManageUserRolesAction
    {
        Add,
        Remove
    }
    public enum ManageRolePermissionsAction
    {
        Add,
        Remove
    }
    public enum AccessEventsMode
    {
        ByName,
        ByID
    }
    public enum NotificationType
    {
        None,
        Person,
        AccessPoint
    }
}
