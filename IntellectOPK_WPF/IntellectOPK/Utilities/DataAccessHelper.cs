using IntellectOPK.MessageService;
using IntellectOPK.Model;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace IntellectOPK.Utilities
{
    public static class DataAccessHelper
    {
        public static async void LogAuditEvent(IDataAccessService das, System.Windows.Window view, string audit_group, string audit_action, string computer_name = null, string appBuild = null, string extension = null)
        {
            CancellationTokenSource CTS = new CancellationTokenSource();
            CancellationToken token = CTS.Token;

            try
            {
                await das.LogAuditEventAsync(token, audit_group, audit_action, computer_name, appBuild, extension);
            }
            catch (Exception e)
            {
                if (e is TaskCanceledException)
                {
                }
                else
                {
                    CTS.Cancel();
                    Message.ShowError(e.Message, e.GetType().ToString(), view);
                }
            }

        }
    }
}

