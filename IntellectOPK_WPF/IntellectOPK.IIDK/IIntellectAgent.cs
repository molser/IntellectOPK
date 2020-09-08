using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntellectOPK.IIDK
{
    public interface IIntellectAgent
    {
        event EventHandler OnConnected;
        event EventHandler OnDisconnected;
        event EventHandler<MessageEventArgs> OnMessage;

        bool IsConnected { get; }
        bool Start();
        void SendMessage(string msgString);
        void ShowObjectOnMap(string mapId, string objType, string objId, string slave);
        void ShowEventOnMonitor(DateTime date, string monId, string objType,
                                              string objId, string slave, int delay = 0);
        void Dispose();
    }
}
