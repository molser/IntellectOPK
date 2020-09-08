using System;
using System.Drawing;
using System.IO;
using System.Runtime.InteropServices;

namespace IntellectOPK.IIDK
{
    public class Client : IDisposable
    {
        public delegate void CallbackConnected(IntPtr userData);
        public delegate void CallbackDisconnected(IntPtr userData);
        public delegate void CallbackMessage(IntPtr userData, [MarshalAs(UnmanagedType.LPWStr)] string message);
        public delegate void CallbackBitmap(IntPtr userData, int channel, [MarshalAs(UnmanagedType.LPWStr)] string fileId, long timestamp,
                                            int currentFrame, int totalFrames,
                                            [MarshalAs(UnmanagedType.LPWStr)] string titles,
                                            IntPtr image, int size);
        public delegate void CallbackFrame(IntPtr userData, int channel, [MarshalAs(UnmanagedType.LPWStr)] string fileId, long timestamp,
                                            int currentFrame, int totalFrames,
                                            [MarshalAs(UnmanagedType.LPWStr)] string titles,
                                            IntPtr pY, int widthY, int heightY, int strideY,
                                            IntPtr pU, IntPtr pV , int widthUv, int heightUv, int strideUv);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern uint CreateClient(string id, string ip, int port, IntPtr userData);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern void DestroyClient(uint objectPtr);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int RegisterConnectedHandler(uint objectPtr, CallbackConnected callback);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int RegisterDisconnectedHandler(uint objectPtr, CallbackDisconnected callback);

        public enum ResponceType
        {
            ResponceTypeRaw = 0,
            ResponceTypeJson
        }

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int RegisterMessageHandler(uint objectPtr, ResponceType type, CallbackMessage callback);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int RegisterBitmapHandler(uint objectPtr, CallbackBitmap callback);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int RegisterFrameHandler(uint objectPtr, CallbackFrame callback);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int Connect(uint objectPtr);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern int SendMsg(uint objectPtr, string message);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern void Disconnect(uint objectPtr);

#if WIN32
        [DllImport("iidk_client_x86.dll", CharSet = CharSet.Unicode)]
#else
        [DllImport("iidk_client_x64.dll", CharSet = CharSet.Unicode)]
#endif
        public static extern void Log(string message);

        private CallbackConnected _сallbackConnectedInstance;
        private CallbackDisconnected _callbackDisconnectedInstance;
        private CallbackMessage _callbackMessageInstance;
        private CallbackBitmap _callbackBitmapInstance;
        private CallbackFrame _callbackFrameInstance;

        public class MessageEventArgs : EventArgs
        {
            public string Message { get; set; }
        }

        public class BitmapEventArgs : EventArgs
        {
            public DateTime Timestamp { get; set; }
            public Bitmap Image { get; set; }
            public int Channel { get; set; }
            public string FileId { get; set; }

            public int CurrentFrame { get; set; }
            public int TotalFrames { get; set; }
            public string Titles { get; set; }
        }

        public class FrameEventArgs : EventArgs
        {
            public DateTime Timestamp { get; set; }
            public int Channel { get; set; }
            public string FileId { get; set; }

            public int CurrentFrame { get; set; }
            public int TotalFrames { get; set; }
            public string Titles { get; set; }

            public IntPtr YPtr { get; set; }
            public int WidthY { get; set; }
            public int HeightY { get; set; }
            public int StrideY { get; set; }

            public IntPtr UPtr { get; set; }
            public IntPtr VPtr { get; set; }

            public int WidthUV { get; set; }
            public int HeightUV { get; set; }
            public int StrideUV { get; set; }
        }

        public event EventHandler OnConnected;
        public event EventHandler OnDisconnected;
        public event EventHandler<MessageEventArgs> OnMessage;
        public event EventHandler<BitmapEventArgs> OnBitmap;
        public event EventHandler<FrameEventArgs> OnFrame;

        [StructLayout(LayoutKind.Sequential)]
        struct UserDataDummy
        {
        }

        private readonly UserDataDummy _userDataDummy = new UserDataDummy();
        private GCHandle _userHandle;
        private readonly IntPtr _userData;

        private uint _clientId;

        private object __isConnectedLock = new object();
        private bool _isConnected;
        
        public Client(string id, string ip, int port, ResponceType responceType)
        {
            _userHandle = GCHandle.Alloc(_userDataDummy, GCHandleType.Pinned);
            _userData = _userHandle.AddrOfPinnedObject();
            _clientId = CreateClient(id, ip, port, _userData);

            _сallbackConnectedInstance = onConnect;
            _callbackDisconnectedInstance = onDisconnect;
            _callbackMessageInstance = onMessage;
            _callbackBitmapInstance = onBitmap;
            _callbackFrameInstance = onFrame;

            RegisterConnectedHandler(_clientId, _сallbackConnectedInstance);
            RegisterDisconnectedHandler(_clientId, _callbackDisconnectedInstance);
            RegisterMessageHandler(_clientId, responceType, _callbackMessageInstance);
            RegisterBitmapHandler(_clientId, _callbackBitmapInstance);
            RegisterFrameHandler(_clientId, _callbackFrameInstance);
        }

        public Object Tag { get; set; }

        public void Connect()
        {
            Connect(_clientId);
        }

        public void SendMsg(string message)
        {
            SendMsg(_clientId, message);
        }

        public void Disconnect()
        {
            Disconnect(_clientId);
        }

        private void onConnect(IntPtr userData)
        {
            IsConnected = true;
            if (_userData == userData)
            {
                Call(this, OnConnected);
            }
        }

        private void onDisconnect(IntPtr userData)
        {
            IsConnected = false;
            if (_userData == userData)
            {
                Call(this, OnDisconnected);
            }
        }

        private void onMessage(IntPtr userData, string message)
        {
            if (_userData == userData)
            {
                Call(this, OnMessage, new MessageEventArgs() {Message = message});
            }
        }

        public static DateTime ToDateTimeFromEpoch(long intDate)
        {
            return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(intDate);
        }

        private void onBitmap(IntPtr userData, int channel, string fileId, long timestamp,
                              int currentFrame, int totalFrames,
                              string titles, 
                              IntPtr image, int size)
        {
            if (userData == _userData && OnBitmap != null)
            {
                byte[] data = new byte[size];
                Marshal.Copy(image, data, 0, size);
                using (MemoryStream ms = new MemoryStream(data))
                {
                    BitmapEventArgs args = new BitmapEventArgs()
                    {
                        Image = new Bitmap(ms),
                        Timestamp = ToDateTimeFromEpoch(timestamp),
                        Channel = channel,
                        FileId = fileId,
                        CurrentFrame = currentFrame,
                        TotalFrames = totalFrames,
                        Titles = titles
                    };
                    OnBitmap(this, args);
                }
            }
        }

        private void onFrame(IntPtr userData, int channel, string fileId, long timestamp,
                             int currentFrame, int totalFrames,
                             string titles, 
                             IntPtr pY, int widthY, int heightY, int strideY,
                             IntPtr pU, IntPtr pV, int widthUv, int heightUv, int strideUv)
        {
            if (userData == _userData && OnFrame != null)
            {
                FrameEventArgs args = new FrameEventArgs()
                {                        
                    Timestamp = ToDateTimeFromEpoch(timestamp),
                    Channel = channel,
                    FileId = fileId,
                    CurrentFrame = currentFrame,
                    TotalFrames = totalFrames,
                    Titles = titles,
                    YPtr = pY,
                    WidthY = widthY,
                    HeightY = heightY,
                    StrideY = strideY,
                    UPtr = pU,
                    WidthUV = widthUv,
                    HeightUV = heightUv,
                    StrideUV = strideUv,
                    VPtr = pV
                };
                OnFrame(this, args);
            }
        }

        public static void Call(object sender, EventHandler handler, EventArgs argument)
        {
            if (handler != null)
            {
                handler(sender, argument);
            }
        }

        public static void Call(object sender, EventHandler handler)
        {
            Call(sender, handler, EventArgs.Empty);
        }

        public static void Call<T>(object sender, EventHandler<T> handler, T argument) where T : EventArgs
        {
            if (handler != null)
            {
                handler(sender, argument);
            }
        }

        public bool IsConnected
        {
            get
            {
                lock (__isConnectedLock)
                {
                    return _isConnected;
                }
            }
            set
            {
                lock (__isConnectedLock)
                {
                    _isConnected = value;
                }
            }
        }

        public void Dispose()
        {
            DestroyClient(_clientId);
            _clientId = 0;
            _userHandle.Free();
        }
    }
}
