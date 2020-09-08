using IntellectOPK.IIDK.ITV.Misc;
using System;
using System.Collections.Generic;
using System.Threading;

namespace IntellectOPK.IIDK
{
    public class IntellectAgent1 : IIntellectAgent, IDisposable
    {
        private Timer timer;
        private volatile bool isConnected;
        private const int RECONNECT_TIME_DELAY = 3000;
        private const int DEFAULT_TIMEOUT = 3000;
        private IidkConnector connector;
        private IntellectCallback intellectCallback;
        private object connectorLock;
        private object isConnectedLock;

        public IntellectAgent1(string id, string ip)      
        {
            this.connector = new IidkConnector(ip, id);
            this.intellectCallback = this.onMessage;
            this.connectorLock = new object();
            this.isConnectedLock = new object();
        }
        
        private void createTimer()
        {
            this.killTimer();
            this.timer = new Timer(this.checkConnection, null, 0, DEFAULT_TIMEOUT);
        }
        private void killTimer()
        {
            if (this.timer != null)
            {
                this.timer.Dispose();
                this.timer = null;
            }                        
        }

        private void checkConnection(Object stateInfo)
        {
            bool isConnected = this.connector.IsConnected();
            if (isConnected != this.isConnected)
            {
                if(this.isConnected == true)
                {
                    this.isConnected = false;
                    if (this.OnDisconnected != null)
                    {                        
                        this.OnDisconnected(this, EventArgs.Empty);                        
                    }                    
                }
                else
                {
                    this.isConnected = true;
                    if (this.OnConnected != null)
                    {
                        this.OnConnected(this, EventArgs.Empty);                        
                    }
                }                
            }
            if(!isConnected) this.Start();
        }


        private bool connect()
        {
            bool result = false;
            lock(this.connectorLock)
            {
                result = this.connector.Connect(this.intellectCallback);
            }
            return result;
        }

        private void onMessage(string msg)
        {
            if (this.OnMessage != null)
            {
                this.OnMessage(this, new MessageEventArgs() { Message = msg });
            }
        }
        public bool Start()
        {
            bool result = this.connect();
            this.isConnected = result;
            if (result)            
            {                
                if (this.OnConnected != null)
                {
                    this.OnConnected(this, EventArgs.Empty);
                }
            }
            if(this.timer == null) createTimer();
            return result;
         }

        public void Stop()
        {            
            lock (this.connectorLock)
            {
                this.connector.Disconnect();
            }                      
        }

        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize((object)this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                this.killTimer();
                this.Stop();                
            }
        }

        public event EventHandler OnConnected;
        public event EventHandler OnDisconnected;
        public event EventHandler<MessageEventArgs> OnMessage;

        public bool IsConnected
        {
            get
            {
                lock(this.isConnectedLock)
                {
                    return this.isConnected;
                }                
            }
        }

        public void SendMessage(string msgString)
        {
            lock(this.connectorLock)
            {
                if (!this.connector.SendMsg(msgString))
                {
                    this.checkConnection(null);
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
            this.connector.SendMsg(msgString);

        }
        public void ShowEventOnMonitor(DateTime date, string monId, string objType, string objId, 
                                              string slave, int delay = 0)
        {
            Msg msg = new Msg("MONITOR", monId, "SHOW_EVENT");
            msg.SetParam("obj_type", objType);
            msg.SetParam("obj_id", objId);
            msg.SetParam("date", date.ToString("dd'-'MM'-'yy"));
            msg.SetParam("time", date.ToString("HH':'mm':'ss"));
            msg.SetParam("managed_slave_id", slave);
            msg.SetParam("core_global", "0");

            string msgString = msg.ToString();
            this.connector.SendMsg(msgString);
        }
    }
}
