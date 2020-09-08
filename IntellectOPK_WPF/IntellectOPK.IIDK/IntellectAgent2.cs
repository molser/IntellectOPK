using IntellectOPK.IIDK.ITV.Misc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.IIDK
{
    public class IntellectAgent2 : IIntellectAgent, IDisposable
    {
        private Client iidkConnector;
        private readonly object iidkConnectorLock;

        public event EventHandler OnConnected;
        public event EventHandler OnDisconnected;
        public event EventHandler<MessageEventArgs> OnMessage;

        public IntellectAgent2 (string hostName, string ip)
        {
            this.iidkConnector = new Client(hostName, ip, 1030, Client.ResponceType.ResponceTypeRaw);
            this.iidkConnectorLock = new object();
            this.iidkConnector.OnConnected += new EventHandler(this.iidkConnector_OnConnected);
            this.iidkConnector.OnDisconnected += new EventHandler(this.iidkConnector_OnDisconnected);
            this.iidkConnector.OnMessage += new EventHandler<Client.MessageEventArgs>(this.iidkConnector_OnMessage);
        }

        public bool IsConnected
        {
            get { return this.iidkConnector.IsConnected; }
        }

        public bool Start()
        {
            this.iidkConnector.Connect();
            return true;
        }

        public void SendMessage(string msgString)
        {
            if (this.iidkConnector.IsConnected)
            {
                lock (this.iidkConnectorLock)
                {
                    this.iidkConnector.SendMsg(msgString);
                }
            }
        }
        public void ShowObjectOnMap(string mapId, string objType, string objId, string slave)
        {
            Msg msg = new Msg("MAP", mapId, "FIND_OBJECT");
            msg.SetParam("obj_type", objType);
            msg.SetParam("obj_id", objId);
            msg.SetParam("managed_slave_id", slave);
            msg.SetParam("core_global", "0");
            string msgString = msg.ToString();
            this.SendMessage(msgString);

        }
        public void ShowEventOnMonitor(DateTime date, string monId, string objType, 
                                              string objId, string slave, int delay = 0)
        {
            Msg msg = new Msg("MONITOR", monId, "SHOW_EVENT");
            //msg.SetParam("cam", camId);
            msg.SetParam("obj_type", objType);
            msg.SetParam("obj_id", objId);
            msg.SetParam("date", date.ToString("dd'-'MM'-'yy"));
            msg.SetParam("time", date.ToString("HH':'mm':'ss"));
            msg.SetParam("managed_slave_id", slave);
            msg.SetParam("core_global", "0");

            string msgString = msg.ToString();

            this.SendMessage(msgString);
        }
        public void Dispose()
        {
            this.iidkConnector.OnConnected -= new EventHandler(this.iidkConnector_OnConnected);
            this.iidkConnector.OnDisconnected -= new EventHandler(this.iidkConnector_OnDisconnected);
            this.iidkConnector.OnMessage -= new EventHandler<Client.MessageEventArgs>(this.iidkConnector_OnMessage);
            this.iidkConnector.Dispose();
        }

        private void iidkConnector_OnConnected(object sender, EventArgs e)
        {
            if(this.OnConnected != null)
            {
                this.OnConnected(this, e);
            }
            
        }
        private void iidkConnector_OnDisconnected(object sender, EventArgs e)
        {
            if (this.OnDisconnected != null)
            {
                this.OnDisconnected(this, e);
            }
        }

        private void iidkConnector_OnMessage(object sender, Client.MessageEventArgs e)
        {
            if(this.OnMessage != null)
            {
                MessageEventArgs args = new MessageEventArgs() { Message = e.Message };
                this.OnMessage(this, args);
            }            
        }
    }
}
