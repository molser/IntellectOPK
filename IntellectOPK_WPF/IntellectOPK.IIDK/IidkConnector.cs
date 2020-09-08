using System;
using System.Runtime.InteropServices;
using System.Threading;

namespace IntellectOPK.IIDK
{
    public class IidkConnector : IDisposable
    {
        private const string IIDK_PORT = "1030";
        private const string VIDEO_PORT = "900";
        private string ip;
        private string id;       

        [DllImport("iidk.dll")]
        private static extern int Connect(string ip, string port, string id, IntellectCallback func);

        [DllImport("iidk.dll")]
        private static extern void Disconnect(string id);

        [DllImport("iidk.dll")]
        private static extern int IsConnected(string id);

        [DllImport("iidk.dll")]
        private static extern int SendMsg(string id, string msg);

        [DllImport("iidk.dll")]
        private static extern int DoReact(string id, string msg);

        public IidkConnector(string ip, string id)
        {
            if (string.IsNullOrEmpty(ip))
                throw new ArgumentNullException(nameof(ip), "ip not specified");
            if (string.IsNullOrEmpty(id))
                throw new ArgumentNullException(nameof(id), "id not specified");
            this.ip = ip;
            this.id = id;
        }        

        public bool Connect(IntellectCallback func)
        {
            this.Disconnect();
            return (Connect(this.ip, IIDK_PORT, this.id, func) != 0);
            
        }
        public bool SendMsg(string message)
        {
            return SendMsg(this.id, message) != 0;                
        }

        public void Disconnect()
        {
            if (this.IsConnected())
            {
                Disconnect(this.id);
            }
        }

        public bool IsConnected()
        {
            try
            {
                return IsConnected(this.id) != 0;
            }
            catch
            {
                return false;
            }
            
        }

        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize((object)this);
        }

        protected void Dispose(bool disposing)
        {
            if (disposing)
            {
                this.Disconnect();
            }            
            
        }
    }
}
