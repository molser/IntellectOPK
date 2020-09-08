-- Данный скрипт необходимо выполнить только на одном выбранном сервере, 
-- где установлена база данных Intellect (ITV), и с которого будет производится импорт основных данных в хранилище IntellectDW

USE [intellect]
GO


/****** Object:  Schema [opk]    Script Date: 01/17/2019 17:16:18 ******/
--IF  NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'opk')
--	DROP SCHEMA [opk]	
--GO

USE [intellect]
GO

/****** Object:  Schema [opk]    Script Date: 01/17/2019 17:16:18 ******/
CREATE SCHEMA [opk] AUTHORIZATION [dbo]
GO

--создаем пользователя для связанного сервера
USE [master]
GO
CREATE LOGIN [IntellectDW_app] WITH PASSWORD=N'IntellectDW_app', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [intellect]
GO
CREATE USER [IntellectDW_app] FOR LOGIN [IntellectDW_app] WITH DEFAULT_SCHEMA=[opk]
GO

GRANT EXECUTE ON SCHEMA::[opk] TO [IntellectDW_app]
GO


--/*
--таблица расширенных уровней доступа (небезопастно создавать ее в основной БД)
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[opk].[LEVEL_EXTANDED]') AND type in (N'U'))
DROP TABLE [opk].[LEVEL_EXTANDED]
GO

/****** Object:  Table [opk].[LEVEL_EXTANDED]    Script Date: 02/16/2019 12:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [opk].[LEVEL_EXTANDED](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[level_id] [varchar](60) NOT NULL,
	[level_num] [int]  NOT NULL,
	[description] [varchar](8000) NULL,
	[type] [varchar](255) NULL,
	[rank] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
--SET IDENTITY_INSERT [opk].[LEVEL_EXTANDED] ON
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES ('',  996, N'', N'', 996.0)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES ('*', 997, N'', N'', 997.0)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES ('-', 998, N'', N'', 998.0)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (2, 1, N'Начальник компании и его заместители', N'основной', 1)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (3, 2, N'Начальник отдела', N'основной', 2)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (4, 3, N'Сотрудник отдела', N'основной', 3)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (83, 72, N'Основные входы в офис', N'дополнительный', NULL)
INSERT [opk].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (84, 73, N'Пожарные выходы из офиса', N'дополнительный', NULL)

--SET IDENTITY_INSERT [opk].[LEVEL_EXTANDED] OFF
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__LEVEL_EXTANDED__level_id__nc_u] ON [opk].[LEVEL_EXTANDED] 
(
	[level_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__LEVEL_EXTANDED__level_num__nc_u] ON [opk].[LEVEL_EXTANDED] 
(
	[level_num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

--*/


--функция, возвращающая таблицу из строки с разделителем
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[opk].[ufn_StringListToTable]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [opk].[ufn_StringListToTable]
GO

CREATE FUNCTION [opk].[ufn_StringListToTable]
( @InputList varchar(MAX),
  @Delimiter char(1) = N',')
RETURNS @OutputTable TABLE (PositionInList int IDENTITY(1, 1) NOT NULL,
                            StringValue    varchar(1000))
AS BEGIN
   DECLARE @RemainingString varchar(MAX) = @InputList;
   DECLARE @DelimiterPosition int;
   DECLARE @CurrentToken varchar(1000);
   
   WHILE LEN(@RemainingString) > 0 
   BEGIN
     SET @DelimiterPosition = CHARINDEX(@Delimiter, @RemainingString);
     IF (@DelimiterPosition = 0) SET @DelimiterPosition = LEN(@RemainingString) + 1;
     IF (@DelimiterPosition > 1000) SET @DelimiterPosition = 1000;
     SET @CurrentToken = SUBSTRING(@RemainingString,1,@DelimiterPosition - 1);
     
     INSERT INTO @OutputTable (StringValue)
       VALUES(@CurrentToken);
       
     SET @RemainingString = SUBSTRING(@RemainingString,@DelimiterPosition + 1,LEN(@RemainingString));
  END;
  RETURN;
END;

GO


--функция удаляет ненужные символы из строки
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[opk].[ufn_RemoveUnnecessaryChars]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [opk].[ufn_RemoveUnnecessaryChars]
GO

Create Function [opk].[ufn_RemoveUnnecessaryChars](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin
	Declare @KeepValues as varchar(50)
        
    --оставляем только буквы и 
    Set @KeepValues = '%[^а-я a-z]%'
	While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')
	
	--удаляем дублирующиеся пробелы
	WHILE CHARINDEX('  ',@Temp) > 0
		SET  @Temp = REPLACE(@Temp, '  ',' ')
	
	
	--удаляем пробелы в начеле и конце строки
	SET  @Temp = RTRIM(LTRIM(@Temp))
		
    Return @Temp
End
GO

--функция получения даты из строки
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[opk].[ufn_TryConvertDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [opk].[ufn_TryConvertDate]
GO

CREATE FUNCTION [opk].[ufn_TryConvertDate]
(
  @value varchar(4000)
)
RETURNS datetime
AS
BEGIN
  RETURN (SELECT CONVERT(datetime, CASE WHEN ISDATE(@value) = 1 THEN @value END));
END
GO


--показать события доступа
IF OBJECT_ID('opk.usp_GetAccessEvents', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetAccessEvents
GO
CREATE PROC opk.usp_GetAccessEvents	 
	--,@mode AS varchar(60)
	
	@date_start AS datetime
	,@date_end AS datetime
	,@rowcount_limit int
	,@rowcount int OUTPUT
	,@only_last_10_events_for_day AS bit = 0
	,@persons AS varchar(max) = NULL
	,@access_points varchar(max) = NULL
	,@events varchar(max) = NULL
	,@departments varchar(max) = NULL
	,@facility_code varchar(3) = NULL
	,@card varchar(6) = NULL
	,@person_id varchar(60) = NULL
	
WITH EXECUTE AS OWNER
AS	
BEGIN
	--SET ARITHABORT ON
	DECLARE @sql AS nvarchar(4000)
	--SET DATEFORMAT dmy
	--IF(@date_start IS NULL) SET @date_start = GETDATE()
	--IF(@date_end IS NULL) SET @date_end = DATEADD(DAY,1, @date_end)
		
	PRINT '----REGION1----'
	PRINT '@persons: ' + ISNULL(@persons,'')
	PRINT '@events: ' + ISNULL(@events,'')
	PRINT '@access_points: ' + ISNULL(@access_points,'')
	PRINT '@departments: ' + ISNULL(@departments,'')
	PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
	PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
	PRINT '@facility_code: ' + ISNULL(@facility_code,'')
	PRINT '@card: ' + ISNULL(@card,'')
	PRINT '@person_id: ' + ISNULL(@person_id,'')
	
	
	SET @sql = ''	

	--IF(    (ISNULL(@persons,'') <>'') 
	--	OR (ISNULL(@departments,'') <>'')
	--    OR (ISNULL(@person_id,'') <> '') 
	--    OR (ISNULL(@card,'')<>'') 
	--    OR (ISNULL(@facility_code,'')<>'')
	--   )		    
	BEGIN
		SET @sql = @sql +
		
		N'
				DECLARE @persons_id_tbl table
				([id] [nvarchar](40)
				 ,[parent_id] [nvarchar](40) NULL
				 --,[facility_code] [nvarchar](255) NULL
				 --,[card] [nvarchar](255) NULL
				 --,[name] [nvarchar](255) NULL
				 --,[surname] [nvarchar](255) NULL
				 --,[patronymic] [nvarchar](255) NULL
				 ,primary key ([id])
				)
				
				INSERT INTO @persons_id_tbl 
				SELECT DISTINCT per.id, parent_id 
				FROM [dbo].[OBJ_PERSON] per'
		
		IF(ISNULL(@persons,'') <>'') SET @sql = @sql + '
				INNER JOIN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@persons,'','')) table_names
						ON opk.ufn_RemoveUnnecessaryChars(per.name + '' '' + per.surname + '' '' + per.patronymic) 
						LIKE (''%'' + REPLACE(opk.ufn_RemoveUnnecessaryChars(table_names.StringValue),'' '',''%'') + ''%'')'
		
		SET @sql = @sql + '
		        WHERE 1=1'
		
		IF(ISNULL(@departments,'') <>'') SET @sql = @sql + '  
				AND per.parent_id IN 
					(						
						SELECT id
						FROM [dbo].[OBJ_DEPARTMENT] dept
						INNER JOIN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@departments,'','')) table_names
							ON opk.ufn_RemoveUnnecessaryChars(dept.name) 
							LIKE (''%'' + REPLACE(opk.ufn_RemoveUnnecessaryChars(table_names.StringValue),'' '',''%'') + ''%'')														
					)'
	
		IF((ISNULL(@facility_code,'') <>'') OR (ISNULL(@card,'') <>'')) 
		BEGIN
			 IF(ISNULL(@facility_code,'') <>'') SET @sql = @sql + '
				 AND (LTRIM(RTRIM(ISNULL(per.facility_code,'''')))=@facility_code)'
			 IF(ISNULL(@card,'') <>'') SET @sql = @sql + '
			     AND (LTRIM(RTRIM(ISNULL(per.card,'''')))=@card)'
		END
	END	
	
	
	SET @sql = @sql + ' 
	SELECT'
	
	IF(@only_last_10_events_for_day = 1) 
	BEGIN
		SET @sql = @sql + ' TOP(10)'
	END
	ELSE
			SET @sql = @sql + ' TOP(' + CAST(@rowcount_limit AS nvarchar(20)) + ')'
	
	
	SET @sql = @sql +
	'	
		pr.time AS [date]
		,CASE WHEN (ISNULL(pr.param1,'''')='''') THEN
				-1
			  ELSE 
				0
			  END  AS [person_key]
		,(SELECT ev.description FROM [dbo].[EVENT] ev WHERE ev.objtype = pr.objtype AND ev.action = pr.action)  AS [event]
		,pr.objid AS [nc32k_id]
		,(SELECT name FROM [dbo].[OBJ_PNET3_NC32K] WHERE id = pr.objid) AS [nc32k]
		,RTRIM(pr.param0 + '' '' + pr.param2) AS [person]		
		,pr.param1 AS [person_id]
		--,'''' AS [department]
		,(SELECT [name] FROM [dbo].[OBJ_DEPARTMENT]
		  WHERE [id]=(SELECT parent_id FROM @persons_id_tbl WHERE id = pr.param1)) AS [department]
		,'''' AS [card]
	FROM [dbo].[PROTOCOL] pr  --WITH (NOLOCK)
	WHERE pr.time BETWEEN @date_start AND @date_end 
		AND (pr.objtype = ''PNET3_NC32K'')'
	
	
	IF((ISNULL(@person_id,'') = '') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))
	BEGIN
		IF((ISNULL(@persons,'') <>'') OR (ISNULL(@departments,'') <>''))
		SET @sql = @sql +		
		N'
		AND pr.param1 IN (SELECT id FROM @persons_id_tbl)		
		'
	END
	ELSE IF (ISNULL(@person_id,'') <> '')
	BEGIN
		SET @sql = @sql +		
		N'
		AND pr.param1 = @person_id		
		'
	END
	ELSE IF((ISNULL(@facility_code,'') <>'') OR (ISNULL(@card,'') <>''))
	BEGIN
		SET @sql = @sql +		
		N'
		AND (pr.param1 IN (SELECT id FROM @persons_id_tbl)
				OR
					(
					  pr.param0 LIKE ''('
					IF(ISNULL(@facility_code,'') <>'') SET @sql = @sql + ''' + @facility_code + '')'
					ELSE SET @sql = @sql + '%)'
				
					IF(ISNULL(@card,'') <>'') SET @sql = @sql + ' '' + @card'
					ELSE SET @sql = @sql + '%''' 
				  
					SET @sql = @sql + '
					)
			)		
		'
	END

	IF(ISNULL(@access_points,'') <>'') SET @sql = @sql + '  
		AND pr.objid IN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@access_points,'',''))'


	IF(ISNULL(@events,'') <>'') SET @sql = @sql + ' 
		AND pr.action IN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@events,'',''))'
		
	
		
	IF(@only_last_10_events_for_day = 1) 
	BEGIN
		SET @sql = @sql + ' ORDER BY pr.time DESC'
	END
	
	--SET @sql = @sql + ' 
	--		SELECT @rowcount=@@ROWCOUNT'
			
			
	PRINT @sql	
	DECLARE @ParamsDefinition nvarchar(4000) = N'@date_start datetime, @date_end datetime, @persons varchar(max)
												, @events varchar(max), @access_points varchar(max),@departments varchar(max)
												, @facility_code varchar(3), @card varchar(6), @person_id varchar(60), @rowcount int OUTPUT'
	
	
	EXEC sp_executesql @sql, @ParamsDefinition, @date_start=@date_start, @date_end=@date_end, @persons=@persons
												,@events=@events, @access_points=@access_points,@departments=@departments
												,@facility_code=@facility_code, @card=@card, @person_id=@person_id, @rowcount=@rowcount OUTPUT
	
END
GO

/*
DECLARE @date_start as datetime = DATEADD(day,-1,GETDATE())
DECLARE @date_end  as datetime = DATEADD(day,-0,GETDATE())
DECLARE @rowcount AS INT
EXEC opk.usp_GetAccessEvents
	@rowcount_limit = 100000
	--,@departments = 'дуфри'
	--,@persons = 'матве'
	--,@access_points='1.311,1.255'
	--,@events = 'EVENTA2'
	--,@person_id = '5781'
	,@date_start = @date_start
	,@date_end = @date_end
	--,@date_start = '16.12.2019 0:00:00'
	--,@date_end = '17.12.2019 23:59:59' 
	,@only_last_10_events_for_day = 1
	--,@facility_code = '200'
	--,@card = '31376'
	,@rowcount=@rowcount OUTPUT
SELECT @rowcount

DECLARE @events  as varchar(max) = 'EVENTAF'
DECLARE @access_points varchar(max) = '1.168'
SELECT StringValue FROM [opk].[ufn_StringListToTable](@access_points,',')
*/


--получить точки доступа
IF OBJECT_ID('opk.usp_GetAccessPoints', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetAccessPoints
GO
CREATE PROC opk.usp_GetAccessPoints	 
	@only_worked AS BIT = 1
	,@level_id AS varchar(60) = NULL
	,@person_id AS varchar(60) = NULL
	,@name AS varchar(255) = NULL
WITH EXECUTE AS OWNER
AS	
BEGIN
	
	DECLARE @sql AS nvarchar(4000) = ''	


	IF(ISNULL(@person_id,'') <> '') SET @sql = @sql + '

	DECLARE @person_level_id AS varchar(max)

	SELECT @person_level_id=level_id FROM [dbo].[OBJ_PERSON] WHERE id = @person_id

	IF @person_level_id = '''' SET @person_level_id = '','' 


	DECLARE @person_levels_tbl table
				([level_id] nvarchar(40))


	INSERT INTO @person_levels_tbl 
				SELECT StringValue 
				FROM [opk].[ufn_StringListToTable](@person_level_id,'','')			


	IF EXISTS (SELECT 1 FROM @person_levels_tbl WHERE level_id = '''')
	BEGIN
	
		Declare @dept_level_id AS varchar(max)
	
		SELECT @dept_level_id=level_id 
		FROM [dbo].[OBJ_DEPARTMENT] 
		WHERE id = (SELECT parent_id FROM [dbo].[OBJ_PERSON] WHERE id = @person_id)
	
		INSERT INTO @person_levels_tbl
			SELECT StringValue 
				FROM [opk].[ufn_StringListToTable](@dept_level_id,'','')
	END'
		
	SET @sql = @sql + ' 
		
	SELECT  
	   0 as [nc32k_key]
	  ,nc32k.[guid]
      ,nc32k.[id]     
      ,nc32k.[name]      
	FROM [intellect].[dbo].[OBJ_PNET3_NC32K] nc32k
	WHERE 1=1'
	
	IF(@only_worked = 1)
		SET @sql = @sql + ' AND ISNULL(nc32k.[flags],0) <> 1'
		
	IF(ISNULL(@level_id,'null') <> 'null')
		SET @sql = @sql + ' 
		AND nc32k.[id] IN (SELECT reader_id FROM [dbo].[OBJ_LEVEL_READER]
											   WHERE reader_type=''PNET3_NC32K''
											   AND main_id=@level_id)' 
    IF(ISNULL(@person_id,'') <> '')
		SET @sql = @sql + ' 
		AND nc32k.[id] IN 
		(
			SELECT DISTINCT lr.reader_id 
			FROM
				(
					SELECT reader_id, main_id, time_zone 
					FROM [dbo].[OBJ_LEVEL_READER]
					UNION ALL
					SELECT id, ''*'',''*''
					FROM [dbo].[OBJ_PNET3_NC32K]
				) lr			 
			JOIN 
				(SELECT DISTINCT level_id 
				 FROM @person_levels_tbl) l on l.level_id = lr.main_id
		
			WHERE lr.time_zone = ''*''
		)'
	IF(ISNULL(@name,'') <> '')
	SET @sql = @sql + ' 
		AND nc32k.[name] LIKE ''%' + @name + '%'' '
			
	PRINT @sql	
	DECLARE @ParamsDefinition nvarchar(4000) = N'@level_id varchar(60), @person_id varchar(60)'
	
	EXEC sp_executesql @sql, @ParamsDefinition, @level_id=@level_id, @person_id=@person_id
	
END
GO

--exec opk.usp_GetAccessPoints @name='5.84' @person_id = '1569'  @level_id='20'

--получить отделы
IF OBJECT_ID('opk.usp_GetDepartments', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetDepartments
GO
CREATE PROC opk.usp_GetDepartments	 
	@only_worked AS BIT = 1
WITH EXECUTE AS OWNER
AS	
BEGIN
	
	DECLARE @sql AS nvarchar(4000)
	
	--IF(@date_start IS NULL) SET @date_start = GETDATE()
	--IF(@date_end IS NULL) SET @date_end = DATEADD(DAY,1, @date_end)
		
	SET @sql = 
		
	N'
	SELECT  
	   0 as [dept_key]
	  ,dept.[guid]
      ,dept.[id]     
      ,dept.[name]      
	FROM [intellect].[dbo].[OBJ_DEPARTMENT] dept
	WHERE dept.name <> ''#Операторы Интеллект''
			--AND dept.name <> ''Временные пропуска'''
	
	IF(@only_worked = 1)
		SET @sql = @sql + ' AND ISNULL(dept.[flags],0) <> 1' 		
			
	PRINT @sql	
	--DECLARE @ParamsDefinition nvarchar(4000) = N'@date_start datetime, @date_end datetime, @persons varchar(max)'
	
	EXEC sp_executesql @sql --, @ParamsDefinition, @date_start=@date_start, @date_end=@date_end, @persons=@persons
	
END
GO

--получить уровни доступа
IF OBJECT_ID('opk.usp_GetLevels', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetLevels
GO

CREATE PROC opk.usp_GetLevels	 
	@nc32k_id as varchar(60) = NULL
	,@levels as varchar(max) = NULL
	,@is_department_levels AS bit = 0
	,@show_full_access_level AS bit = 0
	,@name AS varchar(255) = NULL	
AS	
BEGIN
	DECLARE @sql AS nvarchar(4000)
	
	IF(ISNULL(@levels,'null')='') SET @levels = ','
	PRINT '@levels: ' + ISNULL(@levels,'')
	
	
	
	SET @sql = '
			SELECT  
				l.name AS [name]
				,le.description AS [description]
				,le.type AS [type]
				,ISNULL(le.rank,999) AS [rank]
				,l.id AS [id]
				,ISNULL(le.level_num,999) AS [num]
			FROM dbo.OBJ_LEVEL level
			RIGHT JOIN
			(SELECT id [id]
					,name [name]
			   FROM dbo.OBJ_LEVEL
			   UNION ALL'
	IF(@is_department_levels = 0) SET @sql = @sql + '			    
			   SELECT '''', ''Общий доступ'''
	ELSE SET @sql = @sql + '
			   SELECT '''', ''Доступ запрещен'''
	SET @sql = @sql + ' 
			   UNION ALL 
			   SELECT ''-'', ''Доступ запрещен'''
	IF(@show_full_access_level = 1 AND (@nc32k_id IS NULL)) 
		SET @sql = @sql + '
			  UNION ALL 
			  SELECT ''*'', ''Полный доступ'''
	
	SET @sql = @sql + ')  l ON l.id = level.id'	  
		
	IF(ISNULL(@nc32k_id,'')<>'') SET @sql = @sql + '
		JOIN [dbo].[OBJ_LEVEL_READER] lr ON lr.[reader_type] = ''PNET3_NC32K''
											AND lr.reader_id = @nc32k_id
											AND lr.main_id = l.id'
	SET @sql = @sql + '
		LEFT JOIN [opk].[LEVEL_EXTANDED] le ON le.level_id = l.id
		WHERE 1=1
		--WHERE l.name LIKE ''Уровень доступа %'''
	
	
	IF(ISNULL(@levels,'null')<>'null') SET @sql = @sql + '
			AND l.id IN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@levels,'',''))'
	
	IF(ISNULL(@name,'') <> '')
		SET @sql = @sql + ' 
			AND (l.name LIKE ''%' + @name + '%'' OR  le.description LIKE ''%' + @name + '%'')'
	
	PRINT @sql	
	DECLARE @ParamsDefinition nvarchar(4000) = N'@nc32k_id varchar(60), @levels varchar(max), @name varchar(255)'
	EXEC sp_executesql @sql, @ParamsDefinition, @nc32k_id=@nc32k_id, @levels=@levels, @name=@name
		
END
GO

--exec opk.usp_GetLevels @name='22' @levels='', @show_full_access_level = 1, @nc32k_id = '1.236'
--exec opk.usp_GetDepartments

--управление уровнем доступа
IF OBJECT_ID('opk.usp_ManageLevel', 'P') IS NOT NULL 
	DROP PROC opk.usp_ManageLevel
GO

CREATE PROC opk.usp_ManageLevel	 
	@action AS nvarchar(255)
	,@level_id AS varchar(60)
	,@level_num AS int
	,@description AS varchar(8000) = NULL
	,@type AS varchar(255) = NULL
	,@rank AS float = NULL
AS	
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000)  
	DECLARE @ErrorSeverity INT  
	DECLARE @ErrorState INT
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @sql AS nvarchar(4000)
	
	IF(@action NOT IN ('Add','Remove','Modify'))   
		BEGIN
			SET @msg_str = 'Неверные параметры для операции!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END	
	
	--изменение уровня доступа
	IF(@action = 'Modify')
	BEGIN
		IF NOT EXISTS 
			(SELECT 1 
			 FROM [opk].[LEVEL_EXTANDED]
			 WHERE level_id = @level_id)
		BEGIN
			INSERT INTO [opk].[LEVEL_EXTANDED] 
					   ([level_id],
						[level_num],
						[description],
						[type],
						[rank])
				VALUES	(@level_id
						,@level_num
						,@description
						,@type							
						,@rank)
		END
		ELSE
		BEGIN
			UPDATE [opk].[LEVEL_EXTANDED]
			SET 
				[level_num] = @level_num,
				[description] = @description,
				[type] = @type,
				[rank] = @rank
			WHERE [level_id] = @level_id
		END 
	END
	
	/*
	SET @sql = ''
	PRINT @sql	
	DECLARE @ParamsDefinition nvarchar(4000) = N'@nc32k_id varchar(60)'
	EXEC sp_executesql @sql, @ParamsDefinition, @nc32k_id=@nc32k_id
	*/
		
END
GO


--получить пользователей
IF OBJECT_ID('opk.usp_GetPersons', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetPersons
GO
CREATE PROC opk.usp_GetPersons 
	
	@person AS varchar(255) = NULL
	,@departments AS varchar(max) = NULL
	,@nc32k_id AS varchar(60) = NULL
	,@level_id AS varchar(60) = NULL
	,@show_full_access_level AS bit = 0
	,@hide_temp_persons AS bit = 0
	,@facility_code varchar(3) = NULL
	,@card varchar(6) = NULL
	,@person_id varchar(60) = NULL
	
AS	
BEGIN
	--SET ARITHABORT ON
	DECLARE @sql AS nvarchar(4000)
	DECLARE @params_definition nvarchar(4000)
	
	PRINT '@departments: ' + ISNULL(@departments,'')
	
	SET @sql = ''		
	
	IF((ISNULL(@nc32k_id,'') <> '') OR (ISNULL(@level_id,'null') <> 'null')) SET @sql = '
		
		WITH PerLevs (id, parent_id, lev, level_id) AS
		(
			SELECT 
				id
				,parent_id
				,LEFT(CAST(level_id AS varchar(max)),CHARINDEX('','',CAST(level_id AS varchar(max)) + '','')-1)
				,STUFF(CAST(level_id AS varchar(max)), 1, CHARINDEX('','', CAST(level_id AS varchar(max)) + '',''),'''')
			FROM [dbo].[OBJ_PERSON] with (nolock)
			UNION ALL
		
			SELECT 
				id
				,parent_id
				,LEFT(CAST(level_id AS varchar(max)),CHARINDEX('','',CAST(level_id AS varchar(max)) + '','')-1)
				,STUFF(CAST(level_id AS varchar(max)), 1, CHARINDEX('','', CAST(level_id AS varchar(max)) + '',''),'''')
			FROM PerLevs
			WHERE
				CAST(level_id AS varchar(max)) > ''''
		),
		DepLevs (id, lev, level_id) AS
		(
			SELECT 
				id
				,LEFT(CAST(level_id AS varchar(max)),CHARINDEX('','',CAST(level_id AS varchar(max)) + '','')-1)
				,STUFF(CAST(level_id AS varchar(max)), 1, CHARINDEX('','', CAST(level_id AS varchar(max)) + '',''),'''')
			FROM [dbo].[OBJ_DEPARTMENT] with (nolock)
			UNION ALL
		
			SELECT 
				id
				,LEFT(CAST(level_id AS varchar(max)),CHARINDEX('','',CAST(level_id AS varchar(max)) + '','')-1)
				,STUFF(CAST(level_id AS varchar(max)), 1, CHARINDEX('','', CAST(level_id AS varchar(max)) + '',''),'''')
			FROM DepLevs
			WHERE
				CAST(level_id AS varchar(max)) > ''''
		)
	'

	--IF(ISNULL(@departments,'')<>'') SET @sql = @sql + ' 			
	--	DECLARE @department_ids_tbl table
	--	([dept_id] int
	--		,primary key ([dept_id])
	--	)
			
	--	INSERT INTO @department_ids_tbl 
	--		SELECT DISTINCT id 
	--			FROM [dbo].[OBJ_DEPARTMENT] dept2
	--			INNER JOIN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@departments,'','')) table_names
	--					ON opk.ufn_RemoveUnnecessaryChars(dept2.name) 
	--					LIKE (''%'' + REPLACE(opk.ufn_RemoveUnnecessaryChars(table_names.StringValue),'' '',''%'') + ''%'')'

	
	IF((ISNULL(@person_id,'') ='') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))
	BEGIN
		IF(ISNULL(@departments,'')<>'') SET @sql = @sql + ' 			
			DECLARE @department_ids_tbl table
			([dept_id] int
				,primary key ([dept_id])
			)
				
			INSERT INTO @department_ids_tbl 
				SELECT DISTINCT id 
					FROM [dbo].[OBJ_DEPARTMENT] dept2
					INNER JOIN (SELECT StringValue FROM [opk].[ufn_StringListToTable](@departments,'','')) table_names
							ON LTRIM(RTRIM(dept2.name)) = table_names.StringValue
			--SELECT * FROM @department_ids_tbl'
	END
	
	SET @sql = @sql + ' 
	
	SELECT'
	
	IF((ISNULL(@nc32k_id,'') <> '') OR (ISNULL(@level_id,'null') <> 'null')) SET @sql = @sql + ' DISTINCT'
	
	SET @sql = @sql +
	'
		   0 as [person_key],	
		   per.[id],
		   per.[guid], 
		   per.[name], 
		   per.[surname], 
		   per.[patronymic],
		   dep.[name] AS [department],
		   per.[facility_code],
		   per.[card],
		   ISNULL(per.is_locked,0) AS [is_locked],
		   ISNULL(per.is_apb,0) AS [is_apb],
		   ISNULL([opk].[ufn_TryConvertDate](per.expired),''1900/01/01'') AS [expired],
		   0 AS [is_deleted],
		   GETDATE() AS [valid_from],
		   CAST(''9999/01/01'' AS DATE) AS [valid_to]'
		   
	IF((ISNULL(@nc32k_id,'') <> '') OR (ISNULL(@level_id,'null') <> 'null'))
	BEGIN
		SET @sql = @sql + '
	    from [dbo].[OBJ_PERSON] per with (nolock)
		join [dbo].[OBJ_DEPARTMENT] dep ON dep.id = per.parent_id	
		join (SELECT PerLevs.id,'
			IF(ISNULL(@nc32k_id,'') <> '') SET @sql = @sql + ' 
					CASE WHEN PerLevs.lev = '''' THEN DepLevs.lev 
					     ELSE PerLevs.lev END AS [lev]'
			ELSE SET @sql = @sql + '
					 PerLevs.lev AS [lev]'
			SET @sql = @sql + '
			  FROM  PerLevs
			  JOIN DepLevs ON DepLevs.id = PerLevs.parent_id
			  ) per_levels   on per_levels.id = per.id
		join  (select l1.id
					  ,l1.name
			   from [dbo].[OBJ_LEVEL] l1
			   union all 
			   select '''', ''Общий доступ''
			   union all 
			   select ''*'', ''Полный доступ''
			   union all 
			   select ''-'', ''Доступ запрещен''           
			   ) l  on l.id = per_levels.lev'
		IF(ISNULL(@nc32k_id,'') <> '') SET @sql = @sql + '
		join  (select lr1.reader_id
				   ,lr1.main_id
				   ,lr1.time_zone				   
				from [dbo].[OBJ_LEVEL_READER] lr1
				where lr1.reader_type = ''PNET3_NC32K''
				and lr1.time_zone <> ''''
				union all
				select id, ''*'', ''*'' 
				from [dbo].[OBJ_PNET3_NC32K]
				) lr on lr.main_id = per_levels.lev
			where 1=1
				AND lr.reader_id = @nc32k_id
				AND (ISNULL(per.is_locked,0)<>1) 
				AND ([opk].[ufn_TryConvertDate](per.expired) >= GETDATE())'
		ELSE IF(ISNULL(@level_id,'null') <> 'null') SET @sql = @sql + '
		    where l.id = @level_id'		
		IF(@show_full_access_level = 0 ) SET @sql = @sql + '
				AND (per_levels.lev <> ''*'')'
		--and l.name <> ''Полный доступ'''
	END
	ELSE 
	BEGIN
		SET @sql = @sql + '
		FROM [dbo].[OBJ_PERSON] per with (nolock)
		JOIN [dbo].[OBJ_DEPARTMENT] dep ON dep.id = per.parent_id			
		WHERE dep.name <> ''#Операторы Интеллект'''
					
		IF(@hide_temp_persons =1) SET @sql = @sql + '
			AND dep.name <> ''Временные пропуска'''
		
		IF((ISNULL(@person_id,'') = '') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))		    
		BEGIN		
			IF(ISNULL(@person,'') <> '') SET @sql = @sql + ' 
					AND (
						opk.ufn_RemoveUnnecessaryChars(          ISNULL(per.name,'''') 
													   + '' '' + ISNULL(per.surname,'''') 
													   + '' '' + ISNULL(per.patronymic,'''')) 
						LIKE (''%'' + REPLACE(opk.ufn_RemoveUnnecessaryChars(@person),'' '',''%'') + ''%''))'
			 --IF(ISNULL(@department,'') <> '') SET @sql = @sql + ' 
				--	AND (opk.ufn_RemoveUnnecessaryChars(dep.name) LIKE (''%'' + REPLACE(opk.ufn_RemoveUnnecessaryChars(@department),'' '',''%'') + ''%''))'

			IF(ISNULL(@departments,'') <>'') SET @sql = @sql + '  
					AND dep.id IN (SELECT dept_id FROM @department_ids_tbl)'
		END
		ELSE
		BEGIN
			IF(ISNULL(@person_id,'') <> '')
				SET @sql = @sql + '
				AND per.id = @person_id'
			ELSE IF((ISNULL(@facility_code,'') <>'') OR (ISNULL(@card,'') <>'')) 
			BEGIN
				IF(ISNULL(@facility_code,'') <>'') SET @sql = @sql + '
				  AND LTRIM(RTRIM(per.facility_code))=@facility_code'
				IF(ISNULL(@card,'') <>'') SET @sql = @sql + '
				  AND LTRIM(RTRIM(per.card))=@card'
			END
		END
	END

	SET @params_definition = N'@person varchar(max),@departments varchar(max), @nc32k_id varchar(60), @level_id varchar(60)
								,@facility_code varchar(3), @card varchar(6), @person_id varchar(60)'
	PRINT @sql	
	EXEC sp_executesql @sql, @params_definition, @person=@person, @departments=@departments, @nc32k_id=@nc32k_id, @level_id=@level_id
												,@facility_code=@facility_code, @card=@card, @person_id=@person_id
	 
END
GO
--*/

--exec opk.usp_GetPersons @card='7853', @facility_code=200, @person='иванов' ,@departments = 'погранич,временн' @level_id = '-', @show_full_access_level = 1

--получить пользователя
IF OBJECT_ID('opk.usp_GetPerson', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetPerson
GO
CREATE PROC opk.usp_GetPerson
	@person_id AS varchar(60)
	,@guid AS uniqueidentifier = NULL
AS	
BEGIN
	
	DECLARE @sql AS nvarchar(4000) = ''
	DECLARE @params_definition nvarchar(4000)
	
	SET @sql = @sql +
	'
	SELECT
		   0 AS [person_key]
		  ,0 AS [photo_key]
		  ,per.[area_id]
		  ,per.[auto_brand]
		  ,per.[auto_number]
		  ,per.[auto_pass_type]
		  ,per.[begin]
		  ,per.[begin_temp_level]
		  ,per.[card]
		  ,per.[card_date]
		  ,per.[card_loss]
		  ,per.[card_type]
		  ,per.[comment]
		  ,per.[drivers_licence]
		  ,per.[email]
		  ,per.[end_temp_level]
		  ,ISNULL([opk].[ufn_TryConvertDate](per.expired),''1900/01/01'') AS [expired]
		  ,per.[external_id]
		  ,per.[facility_code]
		  ,per.[finished_at]
		  ,per.[flags]
		  ,ISNULL(per.[guid],''00000000-0000-0000-0000-000000000000'') as [guid]
		  ,per.[id]
		  ,per.[is_active_temp_level]
		  ,ISNULL(per.is_apb,0) AS [is_apb]
		  ,per.[is_locked]
		  ,per.[level2_id]
		  ,per.[level_id]
		  ,per.[levels_times]
		  ,per.[location]
		  ,per.[marketing_info]
		  ,per.[name]
		  ,per.[parent_id]
		  ,per.[passport]
		  ,per.[patronymic]
		  ,per.[person]
		  ,per.[phone]
		  ,per.[pin]
		  ,per.[post]
		  ,per.[pur]
		  ,per.[rubeg8_zone_id]
		  ,per.[schedule_id]
		  ,ISNULL([opk].[ufn_TryConvertDate](per.started_at),''1900/01/01'') AS [started_at]
		  ,per.[surname]
		  ,per.[tabnum]
		  ,per.[teleph_work]
		  ,per.[temp_card]
		  ,per.[temp_level_id]
		  ,per.[temp_levels_times]
		  ,per.[visit_birthplace]
		  ,per.[visit_document]
		  ,per.[visit_purpose]
		  ,per.[visit_reg]
		  ,per.[when_area_id_changed]
		  ,per.[whence]
		  ,per.[who_card]
		  ,per.[who_level]
		  ,per.[owner_person_id]
		  ,ISNULL(per.[pnet3_alarm],0) AS [pnet3_alarm]
		  ,ISNULL(per.[pnet3_block],0) AS [pnet3_block]
          ,ISNULL(per.[pnet3_guard],0) AS [pnet3_guard]
		  ,per.[pnet3_guest]
		  ,per.[pnet3_2cards_mask]
		  ,per.[pnet3_acs_counter]
		  ,per.[pnet3_black]
		  ,per.[pnet3_counter]
		  ,per.[pnet3_master]
		  ,per.[pnet3_no_entry]
		  ,per.[pnet3_no_exit]
		  ,per.[pnet3_sound]
		  ,per.[pnet3_temp]
		  --,per.[pnet3_exit_block]
		  --,per.[pnet3_exit_prof]
		  --,per.[pnet3_priv]
		  ,ISNULL(per.is_locked,0) AS [is_locked]
		  ,CAST(''9999/01/01'' AS DATE) AS [valid_from]
		  ,CAST(''9999/01/01'' AS DATE) AS [valid_to] 
		  ,dep.[name] AS [department]
		  ,dep.[level_id] AS [department_level_id]     
		
	    FROM [dbo].[OBJ_PERSON] per with (nolock)
		JOIN [dbo].[OBJ_DEPARTMENT] dep ON dep.id = per.parent_id'	
		IF(ISNULL(@guid,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000')
		BEGIN
			SET @sql = @sql + '
				WHERE per.guid = @guid'
		END
		ELSE
		BEGIN
			SET @sql = @sql + '
				WHERE per.id = @person_id'
		END
		

	SET @params_definition = N'@person_id varchar(60), @guid AS uniqueidentifier'
	PRINT @sql	
	EXEC sp_executesql @sql, @params_definition, @person_id=@person_id, @guid=@guid
	 
END
GO
--*/

--exec opk.usp_GetPerson @person_id = '5175', @guid='00000000-0000-0000-0000-000000000000'



IF OBJECT_ID('opk.usp_GetDepartments', 'P') IS NOT NULL 
	DROP PROC opk.usp_GetDepartments
GO
CREATE PROC opk.usp_GetDepartments	 
	@only_worked AS BIT = 1
WITH EXECUTE AS OWNER
AS	
BEGIN
	
	DECLARE @sql AS nvarchar(4000)
	
	--IF(@date_start IS NULL) SET @date_start = GETDATE()
	--IF(@date_end IS NULL) SET @date_end = DATEADD(DAY,1, @date_end)
		
	SET @sql = 
		
	N'
	SELECT  
	   0 as [dept_key]
	  ,dept.[guid]
      ,dept.[id]     
      ,dept.[name]      
	FROM [intellect].[dbo].[OBJ_DEPARTMENT] dept
	WHERE dept.name <> ''#Операторы Интеллект''
			--AND dept.name <> ''Временные пропуска'''
	
	IF(@only_worked = 1)
		SET @sql = @sql + ' AND ISNULL(dept.[flags],0) <> 1' 		
			
	PRINT @sql	
	--DECLARE @ParamsDefinition nvarchar(4000) = N'@date_start datetime, @date_end datetime, @persons varchar(max)'
	
	EXEC sp_executesql @sql --, @ParamsDefinition, @date_start=@date_start, @date_end=@date_end, @persons=@persons
	
END
GO



