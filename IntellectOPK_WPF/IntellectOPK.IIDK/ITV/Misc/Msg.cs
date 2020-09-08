// Decompiled with JetBrains decompiler
// Type: ITV.Misc.Msg
// Assembly: iidk_client_test, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2267FBB2-CC74-406B-B422-631CFBF12B28
// Assembly location: M:\Projecs\IIDK\IIDK_C#\bin\x64\iidk_client_test_x64.exe

using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace IntellectOPK.IIDK.ITV.Misc
{
  public class Msg : IEnumerable<KeyValuePair<string, string>>, IEnumerable, ICloneable
  {
    public static readonly char[] FORBIDDEN_CHARACTERS = new char[2]
    {
      '<',
      '>'
    };
    private static readonly string REGEX_SOURCE_TYPE = string.Format("(?<{0}>[^|]*)", (object) "sourceType");
    private static readonly string REGEX_SOURCE_ID = string.Format("(?<{0}>[^|]*)", (object) "sourceId");
    private static readonly string REGEX_ACTION = string.Format("(?<{0}>[^|]*)", (object) "action");
    private static readonly string REGEX_PARAM_VALUE = string.Format("(?<{0}>[^<\\s]+)<(?<{1}>[^>]*)>", (object) "paramName", (object) "paramValue");
    private static readonly string REGEX_TEXT = string.Format("\\A{0}\\|{1}\\|{2}(\\|({3}(,(?!\\z)|\\z))+|\\z)\\z", (object) Msg.REGEX_SOURCE_TYPE, (object) Msg.REGEX_SOURCE_ID, (object) Msg.REGEX_ACTION, (object) Msg.REGEX_PARAM_VALUE);
    private static readonly Regex _regex = new Regex(Msg.REGEX_TEXT, RegexOptions.ExplicitCapture | RegexOptions.Compiled);
    private string _sourceType = string.Empty;
    private string _sourceId = string.Empty;
    private string _action = string.Empty;
    private Dictionary<string, string> _params = new Dictionary<string, string>();
    private const string SOURCE_TYPE = "sourceType";
    private const string SOURCE_ID = "sourceId";
    private const string ACTION = "action";
    private const string COUNT_SUFFIX = "count";
    private const string PARAM_NAME = "paramName";
    private const string PARAM_VALUE = "paramValue";
    private const string PARAM_INDEX = "paramIndex";
    private const string PARAM_SOURCE_GUID = "source_guid";
    private const string INVALID_PARAMETER = "Invalid {0} parameter";
    private const string PARAM_NAME_FORMAT = "{0}.{1}.{2}";
    private const string REGEX_UNION_PARAM_FORMAT = "\\A{0}\\.(?<paramName>[^|]*)\\.(?<paramIndex>[0-9]{{1,3}}|count)\\z";
    private const string CORE_OBJECT = "CORE";
    private const string DO_REACT_ACTION = "DO_REACT";
    private const string SOURCE_TYPE_PARAM = "source_type";
    private const string SOURCE_ID_PARAM = "source_id";
    private const string ACTION_PARAM = "action";
    private const string CORE_PARAM_NAME_FORMAT = "param{0}_name";
    private const string CORE_PARAM_VALUE_FORMAT = "param{0}_val";
    private const string CORE_PARAM_COUNT = "params";
    private const string COUNT_FORMAT = "{0}.count";
    private const string REGEX_SOURCE_FORMAT = "(?<{0}>[^|]*)";
    private const string REGEX_FMT = "\\A{0}\\|{1}\\|{2}(\\|({3}(,(?!\\z)|\\z))+|\\z)\\z";

    public Guid SourceGuid
    {
      get
      {
        try
        {
          string g = this.GetParam("source_guid");
          if (!string.IsNullOrEmpty(g))
            return new Guid(g);
        }
        catch (Exception ex)
        {
          Trace.WriteLine(ex.Message);
        }
        return Guid.Empty;
      }
      set
      {
        try
        {
          if (value.CompareTo(Guid.Empty) == 0)
            this._params.Remove("source_guid");
          else
            this._params["source_guid"] = value.ToString();
        }
        catch (Exception ex)
        {
          Trace.WriteLine(ex.Message);
        }
      }
    }

    public string SourceType
    {
      get
      {
        return this._sourceType;
      }
      set
      {
        this._sourceType = value;
      }
    }

    public string SourceId
    {
      get
      {
        return this._sourceId;
      }
      set
      {
        this._sourceId = value;
      }
    }

    public int SourceIdAsInt32
    {
      get
      {
        return Convert.ToInt32(this._sourceId);
      }
      set
      {
        this._sourceId = Convert.ToString(value);
      }
    }

    public string Action
    {
      get
      {
        return this._action;
      }
      set
      {
        this._action = value;
      }
    }

    public Msg(string sourceType, int sourceId, string action)
      : this(sourceType, sourceId.ToString(), action, (string) null)
    {
    }

    public Msg(string sourceType, string sourceId, string action)
      : this(sourceType, sourceId, action, (string) null)
    {
    }

    public Msg(string sourceType, int sourceId, string action, string prms)
      : this(sourceType, sourceId.ToString(), action, prms)
    {
    }

    public Msg(string sourceType, string sourceId, string action, string prms)
    {
      if (!string.IsNullOrEmpty(prms))
      {
        this.parseMessage(this.header(sourceType, sourceId, action) + "|" + prms);
      }
      else
      {
        this._sourceType = sourceType;
        this._sourceId = sourceId;
        this._action = action;
      }
      this.SourceGuid = Guid.NewGuid();
    }

    public Msg(string msg)
    {
      this.parseMessage(msg);
    }

    public IEnumerable<string> GetParamNames()
    {
      return (IEnumerable<string>) this._params.Keys;
    }

    public string GetParam(string name)
    {
      string str;
      if (this._params.TryGetValue(name, out str))
        return str;
      this.error("Invalid parameter name", name, (string) null);
      return string.Empty;
    }

    public string GetParam(string type, string name, int index)
    {
      return this.GetParam(Msg.ParamName(type, name, index));
    }

    public int GetCount(string type)
    {
      return this.GetParamAsInt32(Msg.CountParamName(type));
    }

    public int GetParamAsInt32(string name)
    {
      return this.GetParamAs<int>(name, new Converter<string, int>(Convert.ToInt32));
    }

    public byte GetParamAsByte(string name)
    {
      return this.GetParamAs<byte>(name, new Converter<string, byte>(Convert.ToByte));
    }

    public bool GetParamAsBool(string name)
    {
      return this.GetParamAsInt32(name) == 1;
    }

    public double GetParamAsDouble(string name)
    {
      return this.GetParamAs<double>(name, new Converter<string, double>(this.string2Double));
    }

    public DateTime GetParamAsDate(string name)
    {
      return this.GetParamAs<DateTime>(name, new Converter<string, DateTime>(Convert.ToDateTime));
    }

    public Guid GetParamAsGuid(string name)
    {
      return this.GetParamAs<Guid>(name, (Converter<string, Guid>) (param => new Guid(param)));
    }

    public byte[] GetParamAsByteArray(string name)
    {
      return this.GetParamAs<byte[]>(name, new Converter<string, byte[]>(Convert.FromBase64String));
    }

    public string GetParamFromBase64(string name)
    {
      string empty = string.Empty;
      if (this.ContainsParam(name))
        empty = Encoding.Unicode.GetString(Convert.FromBase64String(this.GetParam(name)));
      return empty;
    }

    public void SetParamToBase64(string name, string value)
    {
      byte[] bytes = Encoding.Unicode.GetBytes(value);
      this.SetParam(name, Convert.ToBase64String(bytes));
    }

    public T GetParamAs<T>(string name, Converter<string, T> converter)
    {
      string input = this.GetParam(name);
      if (!string.IsNullOrEmpty(input))
      {
        try
        {
          return converter(input);
        }
        catch
        {
        }
      }
      this.error(string.Format("Invalid {0} parameter", (object) typeof (T).Name), name, input);
      return default (T);
    }

    public T GetParamAs<T>(string type, string name, int index, Converter<string, T> converter)
    {
      return this.GetParamAs<T>(Msg.ParamName(type, name, index), converter);
    }

    public bool IsExists(string name)
    {
      return this._params.ContainsKey(name);
    }

    public IEnumerable<Msg> GetUnion(string name)
    {
      Dictionary<int, Msg> dictionary = new Dictionary<int, Msg>();
      Regex regex = new Regex(string.Format("\\A{0}\\.(?<paramName>[^|]*)\\.(?<paramIndex>[0-9]{{1,3}}|count)\\z", (object) name), RegexOptions.ExplicitCapture | RegexOptions.Compiled);
      foreach (KeyValuePair<string, string> keyValuePair in this._params)
      {
        Match match = regex.Match(keyValuePair.Key);
        if (match.Success)
        {
          string name1 = match.Groups["paramName"].Value;
          if (!(match.Groups["paramIndex"].Value == "count"))
          {
            int int32 = Convert.ToInt32(match.Groups["paramIndex"].Value);
            Msg msg;
            if (!dictionary.TryGetValue(int32, out msg))
            {
              msg = new Msg(name, int32, "SETUP");
              dictionary.Add(int32, msg);
            }
            msg.SetParam(name1, keyValuePair.Value);
          }
        }
      }
      return (IEnumerable<Msg>) dictionary.Values;
    }

    public void RemoveUnion(string name)
    {
      Regex regex = new Regex(string.Format("\\A{0}\\.(?<paramName>[^|]*)\\.(?<paramIndex>[0-9]{{1,3}}|count)\\z", (object) name), RegexOptions.ExplicitCapture | RegexOptions.Compiled);
      foreach (string key in this._params.Keys)
      {
        if (regex.Match(key).Success)
          this.RemoveParam(key);
      }
    }

    public void SetUnion(string name, IEnumerable<Msg> union)
    {
      Dictionary<string, int> dictionary = new Dictionary<string, int>();
      foreach (Msg msg in union)
      {
        foreach (KeyValuePair<string, string> keyValuePair in msg._params)
        {
          int index = 0;
          if (!dictionary.TryGetValue(keyValuePair.Key, out index))
            dictionary.Add(keyValuePair.Key, index);
          this.SetParam(Msg.ParamName(name, keyValuePair.Key, index), keyValuePair.Value);
          dictionary[keyValuePair.Key] = index + 1;
        }
      }
      foreach (KeyValuePair<string, int> keyValuePair in dictionary)
        this.SetParam<int>(string.Format("{0}.{1}.{2}", (object) name, (object) keyValuePair.Key, (object) "count"), keyValuePair.Value);
    }

    public void SetParam(string name, string value)
    {
      if (value != null && value.IndexOfAny(Msg.FORBIDDEN_CHARACTERS) >= 0)
        throw new ArgumentException(string.Format("Value contains invalid characters, name = '{0}', value = '{1}'", (object) name, (object) value));
      this._params[name] = value;
    }

    public void SetParam<T>(string name, T value)
    {
      this.SetParam(name, value.ToString());
    }

    public void SetParam<T>(string type, string name, int index, T value)
    {
      this.SetParam<T>(Msg.ParamName(type, name, index), value);
    }

    public void SetParam(string name, DateTime value)
    {
      this.SetParam(name, value.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff"));
    }

    public void SetParamCoreDateTime(string name, DateTime value)
    {
      this.SetParam(name, string.Format("{0:dd-MM-yy} {0:HH:mm:ss}", (object) value));
    }

    public void SetParamInt(string name, int value)
    {
      this._params[name] = value.ToString();
    }

    public void SetParamAsDateTime(DateTime value, string dateparamname = "date", string timeparamname = "time")
    {
      string str1 = string.Format("{0:dd-MM-yy}", (object) value);
      string empty = string.Empty;
      string str2 = value.Millisecond == 0 ? string.Format("{0:HH:mm:ss}", (object) value) : string.Format("{0:HH:mm:ss.fff}", (object) value);
      this.SetParam(dateparamname, str1);
      this.SetParam(timeparamname, str2);
    }

    public void SetParam(string name, bool value)
    {
      this.SetParam<int>(name, Convert.ToInt32(value));
    }

    public void SetParam(string name, double value)
    {
      this.SetParam(name, value.ToString((IFormatProvider) NumberFormatInfo.InvariantInfo));
    }

    public void SetCount(string type, int count)
    {
      this.SetParam<int>(Msg.CountParamName(type), count);
    }

    public static string ParamName(string type, string name, int index)
    {
      return string.Format("{0}.{1}.{2}", (object) type, (object) name, (object) index);
    }

    public static string CountParamName(string type)
    {
      return string.Format("{0}.count", (object) type);
    }

    public void RemoveParam(string name)
    {
      if (string.IsNullOrEmpty(name))
        return;
      this._params.Remove(name);
    }

    public bool ContainsParam(string name)
    {
      return this._params.ContainsKey(name);
    }

    public override string ToString()
    {
      return this.ToString(-1);
    }

    public virtual string ToString(int trimLength)
    {
      StringBuilder stringBuilder = new StringBuilder(this.header(this.SourceType, this.SourceId, this.Action));
      if (this._params.Count > 0)
      {
        stringBuilder.Append("|");
        foreach (KeyValuePair<string, string> keyValuePair in this._params)
          stringBuilder.Append(keyValuePair.Key + "<" + this.trimValue(keyValuePair.Value, trimLength) + ">,");
        if (stringBuilder[stringBuilder.Length - 1] == ',')
          stringBuilder.Remove(stringBuilder.Length - 1, 1);
      }
      return stringBuilder.ToString();
    }

    public static Msg ConvertReactToCoreEvent(React react)
    {
      Msg msg = new Msg("CORE", string.Empty, "DO_REACT");
      msg.SetParam("source_type", react.SourceType);
      msg.SetParam("source_id", react.SourceId);
      msg.SetParam("action", react.Action);
      int num = 0;
      foreach (KeyValuePair<string, string> keyValuePair in (Msg) react)
      {
        string name1 = string.Format("param{0}_name", (object) num);
        msg.SetParam(name1, keyValuePair.Key);
        string name2 = string.Format("param{0}_val", (object) num);
        msg.SetParam(name2, keyValuePair.Value);
        ++num;
      }
      msg.SetParamInt("params", num);
      return msg;
    }

    private double string2Double(string s)
    {
      return Convert.ToDouble(s.Replace(',', '.'), (IFormatProvider) NumberFormatInfo.InvariantInfo);
    }

    private void parseMessage(string msg)
    {
      try
      {
        Match match = Msg._regex.Match(msg);
        if (match.Success)
        {
          this._sourceType = match.Groups["sourceType"].Value;
          this._sourceId = match.Groups["sourceId"].Value;
          this._action = match.Groups["action"].Value;
          Group group1 = match.Groups["paramName"];
          Group group2 = match.Groups["paramValue"];
          for (int index = 0; index < group1.Captures.Count; ++index)
            {
                this._params[group1.Captures[index].Value] = group2.Captures[index].Value;
            }            
          if(this._sourceType == "ACTIVEX")
          {
              this._params["is_iidk_message"] = "1";
              this._params["iidk_id"] = this._sourceId;
              this._sourceType = this._params["objtype"];
              this._sourceId = this._params["objid"];
              this._action = this._params["objaction"];
          }
        }
        else
          Trace.TraceError("Cannot parse message: " + msg);
      }
      catch (Exception ex)
      {
        Trace.TraceError(ex.Message);
      }
    }

    private string header(string sourceType, string sourceId, string action)
    {
      return string.Format("{0}|{1}|{2}", (object) sourceType, (object) sourceId, (object) action);
    }

    private string trimValue(string value, int trimLength)
    {
      if (value == null)
        return string.Empty;
      if (trimLength < 0 || value.Length <= trimLength)
        return value;
      return value.Substring(0, trimLength) + "...";
    }

    private void error(string message, string name, string value)
    {
      Trace.TraceError("{0}. Name=\"{1}\". Value=\"{2}\"", (object) message, (object) name, (object) value);
    }

    public IEnumerator<KeyValuePair<string, string>> GetEnumerator()
    {
      return (IEnumerator<KeyValuePair<string, string>>) this._params.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
      return (IEnumerator) this._params.GetEnumerator();
    }

    public object Clone()
    {
      Msg msg = new Msg(this.SourceType, this.SourceId, this.Action);
      foreach (KeyValuePair<string, string> keyValuePair in this)
        msg.SetParam(keyValuePair.Key, keyValuePair.Value);
      return (object) msg;
    }
  }
}
