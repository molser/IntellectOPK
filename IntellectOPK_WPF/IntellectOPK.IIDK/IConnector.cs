using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace IntellectOPK.IIDK
{
    public interface IConnector
    {
        bool Connect(IntellectCallback func);

        bool SendMsg(string message);

        void Disconnect();

        bool IsConnected();

        string Info { get; }

        //event Action OnConnectionFailure;
    }
}
