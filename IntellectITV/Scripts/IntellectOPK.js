// Скрипт принимает сообщения от программы IntellectOPK,
// после обработки выполняет соответствующие действия
//© Молотков С.А. 2020

if (Event.SourceType=="MAP" && Event.Action=="FIND_OBJECT")
{
	var map_id = Event.SourceId;
	var objtype = Event.GetParam("obj_type");
	var objid = Event.GetParam("obj_id");
	var slave_id = "";
	slave_id = Event.GetParam("managed_slave_id");
	
	if(slave_id !== "" && map_id !== "")
	{
		//DoReactGlobalStr("MAP",map_id,"ACTIVATE_OBJECT","obj_id<"+objid+">,obj_type<"+objtype+">,__slave_id<" + slave_id + "." + map_id + ">");
		DoReactStr("MAP",map_id,"ACTIVATE_OBJECT","obj_id<"+objid+">,obj_type<"+objtype+">,__slave_id<" + slave_id + "." + map_id + ">");
	}
}

else if (Event.SourceType=="MONITOR" && Event.Action=="SHOW_EVENT")
{
	var slave_id = Event.GetParam("managed_slave_id");
	var event_time = Event.GetParam("time");
	var event_date = Event.GetParam("date");
	var mon_id = Event.SourceId;	
    var objtype = Event.GetParam("obj_type");
	var objid = Event.GetParam("obj_id");	
	var speaker_id = GetObjectParam("SLAVE",slave_id,"speaker_id"); //динамик компьютера
	
	
	var links = GetLinkedObjects(objtype,objid,"CAM")
	//DebugLogString("Связанные объекты " + links);
	//ищем номер первой найденной камеры в списке связанных объектов	
	var result = links.match(/CAM:(\d+)/);
	var cam_id = result[1];
	
	//DebugLogString("----Result:" + result[1]);
	
	
	if(    (cam_id !== null)
	    && (slave_id !== "")
	    && (mon_id !== "")
	    && (cam_id !== "")
	    && (objtype !== "" && objid !== "")
	   )
	{
		DebugLogString("----------start_processing...");
		
		//устанавливаем флаг защиты (для корректной работы совместно со скриптом "Monitor_Time_Set" )				
		Lock();
			Var_var(slave_id + "_monitor_time_saved") = "false";
		Unlock();
		
		//переключаем монитор в режим живого видео
		DoReactStr("MONITOR",mon_id,"KEY_PRESSED","key<MODE_VIDEO>");
		
		//Останавливаем воспроизведение звука предыдущей камеры				
		var previous_cam = Var_var(slave_id + "_monitor_cam");
		var arr_cams_mics = get_cams_mics_arr(previous_cam);
		//DebugLogString("----------arr_cams_mics.length: " + arr_cams_mics.length);
		if(arr_cams_mics.length > 0)
		{
			for(i=0; i<arr_cams_mics.length; i++)
			{
				//DebugLogString("----------arr_cams_mics[" + i + "]: " + arr_cams_mics[i]);
				DoReactStr("OLXA_LINE",arr_cams_mics[i],"STOP_LISTEN","mon_id<" + mon_id + ">,slave_id<" + slave_id + ">,delay<1>");
				DoReactStr("SPEAKER",speaker_id,"STOP_REAL","mic_id<" + arr_cams_mics[i] + ">,delay<2>");
			}
		}
		
		//запоминаем текущую камеру
		Var_var(slave_id + "_monitor_cam") = cam_id;
		
		//Переключаем монитор
		NotifyEventStr("MONITOR",mon_id,"ACTIVATE_OBJECT","cam<" + cam_id + ">,show<1>,slave_id<" + slave_id + ">");
		
		var ipstorage_id = "";
		ipstorage_id = get_monitor_cam_ip_storage(mon_id,cam_id);
		var params =  "";
		params =  "cam<" + cam_id + ">"
				+ ",date<" + event_date + ">"
				+ ",time<" + event_time + ">"
				+ ",__slave_id<" + slave_id + ">"
				+ ",delay<1>";
		
		if(ipstorage_id) params += ",mode<" + (Number(ipstorage_id) + 10) + ">";
		DebugLogString("params = " + params);
		
		//Устанавливаем время просмотра
		//DoReactGlobalStr("MONITOR",mon_id,"ARCH_FRAME_TIME",params);
		DoReactStr("MONITOR",mon_id,"ARCH_FRAME_TIME",params);
	}
		
}

//функция получения массива id микрофонов камеры
function get_cams_mics_arr(cam_id)
{
	var arr_cams_mics = [];
	var msg = CreateMsg();
	msg.StringToMsg(GetObjectParams("CAM", cam_id));
	var cam_mics_count = 0;
	cam_mics_count = Number(msg.GetParam("AUDIO.mic_id.count"));
	if(cam_mics_count > 0)
	{		
		for(i=0; i<cam_mics_count; i++)
		{
			arr_cams_mics.push(msg.GetParam("AUDIO.mic_id."+i));
		}
	}	
	return arr_cams_mics;
}

//функция получает ID IP-хранилища в настройках камеры монитора
//если у камеры нет настроек IP-хранилища, возвращается пустое значение
function get_monitor_cam_ip_storage(mon_id, cam_id)
{
	var ipstorage_id = ""
	var cam_number = "";
	var cam_count; 
	
	var msg_mon = CreateMsg();
	msg_mon.StringToMsg(GetObjectParams("MONITOR", mon_id));
	
	cam_count = Number(msg_mon.GetParam("CAM.cam.count"));	
	
	//DebugLogString("cam_count = " + cam_count);
	
	if(cam_count)
	{
		for(i=0; i<cam_count; i++)
		{
			if(msg_mon.GetParam("CAM.cam." + String(i)) == cam_id)
			{
				cam_number = String(i);
				break;
			}
		}
	}

	if(cam_number)
	{
		ipstorage_id = msg_mon.GetParam("CAM.ipstorage." + cam_number);
		//DebugLogString("ipstorage_id = " + ipstorage_id);		
	}
	
	return ipstorage_id;
}