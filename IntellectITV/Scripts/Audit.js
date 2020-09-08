//Скрипт запускает макрокоманду с параметрами, по событию определенных дейсвий в системе
//© Молотков С.А. 2018г.  

if(Event.SourceType=="RIGHTS" && Event.Action=="IS_OPERATOR")
{
	if( (Var_var("is_operator_user_id") == Event.GetParam("user_id") 
		 && Var_var("is_operator_time") == Event.GetParam("time") 
		 && Var_var("is_operator_date") == Event.GetParam("date")) == false) 
	
	{
		//DebugLogString("---------------попал в RIGHTS");
		Lock();
			Var_var("is_operator_user_id") = Event.GetParam("user_id");
			Var_var("is_operator_time")    = Event.GetParam("time");
			Var_var("is_operator_date")    = Event.GetParam("date");		
		Unlock();
		
		//var action = Event.Action;
		var action = Event.SourceType + ";" + Event.SourceId + ";" + Event.Action;
		var macro_id = "2";
		var objtype = "PERSON";
		var objid = Event.GetParam("user_id");
		var slave_id = Event.GetParam("owner");
		slave_id = slave_id + ';' + GetUserId(slave_id);
		NotifyEventStr("MACRO",macro_id,"RUN","param0<"+objtype+">,param1<"+objid+">,param2<"+slave_id+">,param3<" + action + ">");
	}
	
}
else if (Event.SourceType=="CORE")
{
	if(Event.Action=="UPDATE_OBJECT" || Event.Action=="DELETE_OBJECT" || Event.Action=="CREATE_OBJECT")
	{		
		DebugLogString("----------------------Попал в CORE UPDATE_OBJECT-------------------");
		if(Event.GetParam("module")=="agency_person.run" && Event.GetParam("objtype") != "AGENCY_PERSON")
		{
			var slave_id = Event.GetParam("slave_id");
			var agency_id = slave_id.substring(slave_id.indexOf(".")+1);
			
			slave_id = slave_id.substring(0,slave_id.indexOf("."));
			slave_id = slave_id + ';' + GetUserId(slave_id);
						 
			//var agency_id = Event.GetParam("int_obj_id");
			
			var action = "AGENCY_PERSON" + ";" + agency_id + ";" + Event.Action;
			var macro_id = "2";
			var objtype = Event.GetParam("objtype");
			var objid = Event.GetParam("objid");
			
			NotifyEventStr("MACRO",macro_id,"RUN","param0<"+objtype+">,param1<"+objid+">,param2<"+slave_id+">,param3<" + action + ">");
			//DoReactGlobalStr("MACRO",macro_id,"RUN","param0<"+objtype+">,param1<"+objid+">,param2<"+slave_id+">");
		}
	}
	else if(Event.Action=="notify_UPDATE_OBJECT" || Event.Action=="notify_DELETE_OBJECT")
	{
		//var action = Event.Action;
		var action = Event.SourceType + ";" + Event.SourceId + ";" + Event.Action;
		var objtype = Event.GetParam("objtype");
		if(objtype == "PERSON" || objtype == "DEPARTMENT" || objtype == "LEVEL" || objtype == "RIGHTS" || objtype == "SCRIPT" || objtype == "MACRO")
		{
			var macro_id = "2";
			var objtype = Event.GetParam("objtype");
			var objid = Event.GetParam("objid");
			var slave_id = Event.GetParam("slave_id");
			slave_id = slave_id + ';' + GetUserId(slave_id);
			NotifyEventStr("MACRO",macro_id,"RUN","param0<"+objtype+">,param1<"+objid+">,param2<"+slave_id+">,param3<" + action + ">");
		}		
	}
	else if(Event.Action=="DO_REACT")
	{		
		if(Event.GetParam("param1_name") == "user_id") //проверяем, что в событии есть данные об операторе
		{
			var macro_id = "2";
			var objtype = "OPERATOR"; 
			var user_id = Event.GetParam("param1_val");
			var slave_id = Event.GetParam("param2_val");
			slave_id = slave_id + ';' + GetUserId(slave_id);
			var source_type = Event.GetParam("source_type");
			var source_id = Event.GetParam("source_id");
			var action = source_type + ";" + source_id + ";" + Event.GetParam("action");			
			NotifyEventStr("MACRO",macro_id,"RUN","param0<"+objtype+">,param1<"+user_id+">,param2<"+slave_id+">,param3<" + action + ">");
		}
	
	}
}
else if(Event.SourceType=="MAP" && Event.Action=="ACTIVATE_OBJECT" && Event.GetParam("module")=="map.run" )// &&  Event.GetParam("obj_id")=="160")
{
	var macro_id = "2";
	var sourceType = Event.SourceType;
	//var action = Event.Action;
	var action = Event.SourceType + ";" + Event.SourceId + ";" + Event.Action;
	var sourceId = Event.SourceId;
	var owner = Event.GetParam("owner");
	var slave_id = Event.GetParam("slave_id");
	slave_id = slave_id.substring(0,slave_id.indexOf("."));
	slave_id = slave_id + ';' + GetUserId(slave_id);
	var obj_id = Event.GetParam("obj_id");
	var obj_type = Event.GetParam("obj_type");	
	
	NotifyEventStr("MACRO",macro_id,"RUN","param0<"+obj_type+">,param1<"+obj_id+">,param2<"+slave_id+">,param3<" + action + ">");
	//runSqlcmd(sourceType,sourceId,action,"obj_type<"+obj_type+">,obj_id<"+obj_id+">",owner,slave,null);
}

else if(Event.SourceType=="MONITOR" && Event.Action=="PLAY_START" && Event.GetParam("module")=="video.run" )// &&  Event.GetParam("obj_id")=="160")
{
	var macro_id = "2";
	var sourceType = Event.SourceType;
	//var action = Event.Action;
	
	var sourceId = Event.SourceId;
	var owner = Event.GetParam("owner");
	var slave_id = Event.GetParam("slave_id");
	slave_id = slave_id + ';' + GetUserId(slave_id);
	var obj_type = "CAM";
	var cam = Event.GetParam("cam");
	var frame_date = Event.GetParam("frame_date");
	var frame_time = Event.GetParam("frame_time");
	var date_time = getDateTimeStr(get_intellect_date(frame_date + " " + frame_time));
	var action = Event.SourceType + ";" + Event.SourceId + ";" + Event.Action + ";" + date_time;
	//var param1 = cam + ";" + date + ";" + time;
	
	NotifyEventStr("MACRO",macro_id,"RUN","param0<"+obj_type+">,param1<"+cam+">,param2<"+slave_id+">,param3<" + action + ">");
	
	//runSqlcmd(sourceType,sourceId,action,"cam<"+cam+">,date<"+date+">,time<"+time+">",owner,slave,null);
}

else if(Event.SourceType=="DISPLAY" && Event.Action=="ACTIVATE")// &&  Event.GetParam("obj_id")=="160")
{
	//если событие зафиксировано на источнике
	if(Event.GetParam("module") != "intellect.exe")
	{
		var macro_id = "2";
		var sourceType = Event.SourceType;
		//var action = Event.Action;
		var action = Event.SourceType + ";" + Event.SourceId + ";" + Event.Action;
		var sourceId = Event.SourceId;
		var owner = Event.GetParam("owner");
		var slave_id = Event.GetParam("slave_id");
		slave_id = slave_id + ';' + GetUserId(slave_id);
		var obj_type = "DISPLAY";
		var cam = Event.GetParam("cam");
		var date = Event.GetParam("date");
		var time = Event.GetParam("time");	
		
		NotifyEventStr("MACRO",macro_id,"RUN","param0<"+obj_type+">,param1<"+sourceId+">,param2<"+slave_id+">,param3<" + action + ">");	
		//runSqlcmd(sourceType,sourceId,action,"cam<"+cam+">,date<"+date+">,time<"+time+">",owner,slave,null);
	}
}

else if (Event.SourceType=="MACRO" && Event.Action=="RUN" && Event.SourceId != "2")
{
	//если событие зафиксировано на источнике
	if(Event.GetParam("module") != "intellect.exe")
	{
		if(Event.GetParam("user_id") != "")//проверяем, что в событии есть данные об операторе
		{
			var macro_id = "2";
			var objtype = "OPERATOR";
			var user_id = Event.GetParam("user_id");
			var owner = Event.GetParam("owner");
			var slave_id = Event.GetParam("slave_id");
			if(slave_id == '') slave_id = owner;
			slave_id = slave_id + ';' + GetUserId(slave_id);
			var action = Event.SourceType + ";" + Event.SourceId + ";" + Event.Action;
			NotifyEventStr("MACRO",macro_id,"RUN","param0<"+objtype+">,param1<"+user_id+">,param2<"+slave_id+">,param3<" + action + ">");
		}
	}
}

//функция парсинга даты пересечения зоны сотрудника
function get_intellect_date(str_date)
{
	//26-10-17 09:09:14
	var arr_datetime = str_date.split(" ");
	var arr_date = arr_datetime[0].split("-");
	var arr_time = arr_datetime[1].split(":");
	
	var day = Number(arr_date[0]);	
	var month = Number(arr_date[1])-1;
	var year = Number(arr_date[2]);
	if (year < 100)
	{
		year = 2000 + year;
	}
	var hours = Number(arr_time[0]);
	var minutes = Number(arr_time[1]);
	var seconds = Number(arr_time[2]);
	// DebugLogString("--------------string_to_parse: " + str_date);
	// DebugLogString("--------------day: " + day);
	// DebugLogString("--------------month: " + month);
	// DebugLogString("--------------year: " + year);
	// DebugLogString("--------------hours: " + hours);
	// DebugLogString("--------------minutes: " + minutes);
	// DebugLogString("--------------seconds: " + seconds);	
	
	var result = new Date(year, month, day, hours, minutes, seconds);
	return result;
}

function getDateTimeStr(date)
{
	var day = ("0"+date.getDate()).slice(-2);
	var month = ("0"+(date.getMonth() + 1)).slice(-2);
	var year = date.getFullYear();
	var hours = ("0"+date.getHours()).slice(-2);
	var minutes = ("0"+date.getMinutes()).slice(-2);
	var seconds = ("0"+date.getSeconds()).slice(-2);
	var milliseconds = ("0"+date.getMilliseconds()).slice(-3);
	var dateStr = "";
	
	//dateStr = year + "###" + month + "-" + day + "#### " + hours + ":" + minutes + ":" + seconds;
	//dateStr = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
	dateStr = day + "." + month + "." + year + " " + hours + ":" + minutes + ":" + seconds;
	return dateStr;
}

