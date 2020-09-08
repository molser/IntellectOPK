// Decompiled with JetBrains decompiler
// Type: ITV.Misc.React
// Assembly: iidk_client_test, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2267FBB2-CC74-406B-B422-631CFBF12B28
// Assembly location: M:\Projecs\IIDK\IIDK_C#\bin\x64\iidk_client_test_x64.exe

using System;

namespace IntellectOPK.IIDK.ITV.Misc
{
  public class React : Msg
  {
    protected static readonly string CORE_PARAM = "CORE";
    protected static readonly string CORE_ACTION = "DO_REACT";
    protected static readonly string CORE_ID = string.Empty;
    protected static readonly string SOURCE_TYPE_PARAM = "source_type";
    protected static readonly string SOURCE_ID_PARAM = "source_id";
    protected static readonly string SOURCE_ACTION_PARAM = "action";

    public React(string sourceType, int sourceId, string action)
      : base(sourceType, sourceId, action)
    {
    }

    public React(string sourceType, string sourceId, string action)
      : base(sourceType, sourceId, action)
    {
    }

    public React(string sourceType, int sourceId, string action, string prms)
      : base(sourceType, sourceId, action, prms)
    {
    }

    public React(string sourceType, string sourceId, string action, string prms)
      : base(sourceType, sourceId, action, prms)
    {
    }

    public React(string msg)
      : base(msg)
    {
    }

    public override string ToString(int trimLength)
    {
      Msg msg = this.Clone() as Msg;
      if (msg == null)
        throw new NullReferenceException();
      msg.SourceType = React.CORE_PARAM;
      msg.SourceId = React.CORE_ID;
      msg.Action = React.CORE_ACTION;
      msg.SetParam(React.SOURCE_TYPE_PARAM, this.SourceType);
      msg.SetParam(React.SOURCE_ID_PARAM, this.SourceId);
      msg.SetParam(React.SOURCE_ACTION_PARAM, this.Action);
      return msg.ToString(trimLength);
    }
  }
}
