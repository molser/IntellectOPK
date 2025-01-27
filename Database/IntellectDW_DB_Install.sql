USE [master]
GO

IF (EXISTS (SELECT name 
			FROM master.dbo.sysdatabases 
			WHERE ('[' + name + ']' = 'IntellectDW' 
			OR name = 'IntellectDW')))
	DROP DATABASE [IntellectDW]

DECLARE @sql AS nvarchar(4000)
DECLARE @db_path AS nvarchar(4000) = N'C:\IntellectDW_DB'
SET @sql = '
CREATE DATABASE [IntellectDW] ON  PRIMARY 
( NAME = N''IntellectDW'', FILENAME = ''' + @db_path + N'\IntellectDW.mdf'' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
  FILEGROUP [AUDIT] 
( NAME = N''audit'', FILENAME = ''' + @db_path + N'\audit.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [DEFAULT_FG]  DEFAULT 
( NAME = N''default'', FILENAME = ''' + @db_path + N'\default.ndf'' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [MAIN_DATA] 
( NAME = N''main'', FILENAME = ''' + @db_path + N'\main_data.ndf'' , SIZE = 119808KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [MAIN_INDEX] 
( NAME = N''main_index'', FILENAME = ''' + @db_path + N'\main_index.ndf'' , SIZE = 63360KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [MAIN_TEXTIMAGE] 
( NAME = N''main_textimage'', FILENAME = ''' + @db_path + N'\main_textimage.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ),
 FILEGROUP [PHOTO] 
( NAME = N''photo'', FILENAME = ''' + @db_path + N'\photo.ndf'' , SIZE = 1473216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240KB ), 
 FILEGROUP [PROTOCOL_2015] 
( NAME = N''protocol_2015'', FILENAME = ''' + @db_path + N'\protocol_2015.ndf'' , SIZE = 229120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2016] 
( NAME = N''protocol_2016'', FILENAME = ''' + @db_path + N'\protocol_2016.ndf'' , SIZE = 621888KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2017] 
( NAME = N''protocol_2017'', FILENAME = ''' + @db_path + N'\protocol_2017.ndf'' , SIZE = 881664KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2018] 
( NAME = N''protocol_2018'', FILENAME = ''' + @db_path + N'\protocol_2018.ndf'' , SIZE = 274432KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2019] 
( NAME = N''protocol_2019'', FILENAME = ''' + @db_path + N'\protocol_2019.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2020] 
( NAME = N''protocol_2020'', FILENAME = ''' + @db_path + N'\protocol_2020.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2021] 
( NAME = N''protocol_2021'', FILENAME = ''' + @db_path + N'\protocol_2021.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2022] 
( NAME = N''protocol_2022'', FILENAME = ''' + @db_path + N'\protocol_2022.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2023] 
( NAME = N''protocol_2023'', FILENAME = ''' + @db_path + N'\protocol_2023.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2024] 
( NAME = N''protocol_2024'', FILENAME = ''' + @db_path + N'\protocol_2024.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2025] 
( NAME = N''protocol_2025'', FILENAME = ''' + @db_path + N'\protocol_2025.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_2026] 
( NAME = N''protocol_2026'', FILENAME = ''' + @db_path + N'\protocol_2026.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [PROTOCOL_INDEX] 
( NAME = N''protocol_index'', FILENAME = ''' + @db_path + N'\protocol_index.ndf'' , SIZE = 1241856KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ),
 FILEGROUP [MAIN_LOGS] 
( NAME = N''main_logs'', FILENAME = ''' + @db_path + N'\main_logs.ndf'' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N''IntellectDW_log'', FILENAME = ''' + @db_path + N'\IntellectDW_log.LDF'' , SIZE = 1913920KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 '
 EXEC sp_executesql @sql
 
GO
ALTER DATABASE [IntellectDW] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IntellectDW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IntellectDW] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [IntellectDW] SET ANSI_NULLS OFF
GO
ALTER DATABASE [IntellectDW] SET ANSI_PADDING OFF
GO
ALTER DATABASE [IntellectDW] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [IntellectDW] SET ARITHABORT OFF
GO
ALTER DATABASE [IntellectDW] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [IntellectDW] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [IntellectDW] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [IntellectDW] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [IntellectDW] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [IntellectDW] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [IntellectDW] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [IntellectDW] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [IntellectDW] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [IntellectDW] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [IntellectDW] SET  DISABLE_BROKER
GO
ALTER DATABASE [IntellectDW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [IntellectDW] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [IntellectDW] SET TRUSTWORTHY ON
GO
ALTER DATABASE [IntellectDW] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [IntellectDW] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [IntellectDW] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [IntellectDW] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [IntellectDW] SET  READ_WRITE
GO
ALTER DATABASE [IntellectDW] SET RECOVERY FULL
GO
ALTER DATABASE [IntellectDW] SET  MULTI_USER
GO
ALTER DATABASE [IntellectDW] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [IntellectDW] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'IntellectDW', N'ON'
GO
USE [IntellectDW]
GO
/****** Object:  User [intellectDW]    Script Date: 04/20/2018 12:36:35 ******/
--CREATE USER [intellectDW] FOR LOGIN [intellectDW] WITH DEFAULT_SCHEMA=[dbo]
--GO
/****** Object:  User [DOM2VIDEOSRV7\Администратор]    Script Date: 04/20/2018 12:36:35 ******/
--CREATE USER [DOM2VIDEOSRV7\Администратор] FOR LOGIN [DOM2VIDEOSRV7\Администратор] WITH DEFAULT_SCHEMA=[dbo]
--GO
/****** Object:  Schema [stg]    Script Date: 04/20/2018 12:36:35 ******/
CREATE SCHEMA [stg] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [dw]    Script Date: 04/20/2018 12:36:35 ******/
CREATE SCHEMA [dw] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [app]    Script Date: 04/20/2018 12:36:35 ******/
CREATE SCHEMA [app] AUTHORIZATION [dbo]
GO


--######################################### DATABASE SETUP 
--включаем доверие базе данных 'IntellectDW' на уровне сервера
--для возможности управления сервером из процедур базы данных 'IntellectDW'
use [master]
GO
ALTER DATABASE [IntellectDW] SET TRUSTWORTHY ON
GO


--######################################### Linked Server
USE [master]
GO

DECLARE @sql AS nvarchar(4000)
DECLARE @linkedserver AS nvarchar(4000) = N'DOM2SERVERSKUD'
IF NOT EXISTS(SELECT * FROM sys.servers WHERE name = @linkedserver)
BEGIN	
	EXEC master.dbo.sp_addlinkedserver @server = @linkedserver, @srvproduct=N'SQL Server'
    EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=@linkedserver,@useself=N'False',@locallogin=NULL,@rmtuser=N'IntellectDW_app',@rmtpassword='IntellectDW_app'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'collation compatible', @optvalue=N'false'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'data access', @optvalue=N'true'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'dist', @optvalue=N'false'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'pub', @optvalue=N'false'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'rpc', @optvalue=N'false'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'rpc out', @optvalue=N'true'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'sub', @optvalue=N'false'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'connect timeout', @optvalue=N'0'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'collation name', @optvalue=null
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'lazy schema validation', @optvalue=N'false'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'query timeout', @optvalue=N'0'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'use remote collation', @optvalue=N'true'
	EXEC master.dbo.sp_serveroption @server=@linkedserver, @optname=N'remote proc transaction promotion', @optvalue=N'true'
END

--################################## ROLES
USE [IntellectDW]
GO

--создаем роль для всей пользователей IntellectDW
CREATE ROLE [IntellectDW_user]  
GO
GRANT EXECUTE ON SCHEMA::[app] TO [IntellectDW_user]
GRANT SHOWPLAN TO [IntellectDW_user]
GO


--################################## LOGINS AND USERS
--Создаем логин первого пользователя-администратора
USE [master]
GO
IF NOT EXISTS (SELECT loginname FROM master.dbo.syslogins 
    WHERE name = 'Admin')
    --DROP LOGIN [Admin]
BEGIN
	CREATE LOGIN [Admin] 
		WITH PASSWORD=N'1', 
		DEFAULT_DATABASE=[IntellectDW], 
		CHECK_EXPIRATION=OFF, 
		CHECK_POLICY=OFF
END
GO

USE [intellectDW]
GO
--создаем пользователя-администратора в базе данных
CREATE USER [Admin] FOR LOGIN [Admin] WITH DEFAULT_SCHEMA=[app]
GO
--добавляем пользователю роль "пользователь приложения"
sp_addrolemember [IntellectDW_user], [Admin]
GO


/****** Object:  Table [dw].[import_log]    Script Date: 04/20/2018 12:36:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[import_log](
	[param] [varchar](255) NULL,
	[num] [int] NULL,
	[date] [datetime] NULL
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  PartitionFunction [fn_Partition_PROTOCOL]    Script Date: 04/20/2018 12:36:36 ******/
CREATE PARTITION FUNCTION [fn_Partition_PROTOCOL](datetime) AS RANGE FOR VALUES (N'2016-01-01T00:00:00.000', N'2017-01-01T00:00:00.000', N'2018-01-01T00:00:00.000', N'2019-01-01T00:00:00.000', N'2020-01-01T00:00:00.000', N'2021-01-01T00:00:00.000', N'2022-01-01T00:00:00.000', N'2023-01-01T00:00:00.000', N'2024-01-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2026-01-01T00:00:00.000')
GO
/****** Object:  UserDefinedFunction [dw].[ufn_ParsePhotoIdentParams]    Script Date: 04/20/2018 12:36:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dw].[ufn_ParsePhotoIdentParams] (@params VARCHAR(400))  
--функция возвращает obj_type, obj_id, obj_react из строки вида 'PNET3_NC32K;2.1;OPEN_DOOR'
--и user_id, person_id из строки вида '40845;200;77;5469;Компьютер DOM2ARMSKUD1;Компьютер DOM2ARMSKUD1'
RETURNS @resultTable TABLE ([part0] VARCHAR(255), [part1] VARCHAR(255), [part2] VARCHAR(255), [part3] VARCHAR(255), [part4] VARCHAR(255)) 	
AS
	BEGIN 	
		
		DECLARE @part0 VARCHAR(255)
		DECLARE @part1 VARCHAR(255) 
		DECLARE @part2 VARCHAR(255)
		DECLARE @part3 VARCHAR(255)
		DECLARE @part4 VARCHAR(255)
		
		
		
		IF (LEN (@params) - LEN(REPLACE(@params,';','')) = 2)
		BEGIN
			SET @part0 = LEFT(@params, CHARINDEX(';',@params) - 1)
			SET @part1 = SUBSTRING(@params,
							CHARINDEX(';',@params) + 1,
								CHARINDEX(';',@params, 
									CHARINDEX(';',@params) + 1) - CHARINDEX(';',@params) - 1)
			SET @part2 = SUBSTRING(@params,
								CHARINDEX(';',@params, 
									CHARINDEX(';',@params) + 1) + 1,LEN(@params))
			INSERT INTO @resultTable ([part0], [part1] , [part2]) VALUES (@part0, @part1, @part2)
		END
		
		IF (LEN (@params) - LEN(REPLACE(@params,';','')) = 5)
		BEGIN
			SET @part0 = LEFT(@params, CHARINDEX( ';', @params) - 1)
			
			SET @part1 = SUBSTRING(@params 
							,CHARINDEX( ';', @params) + 1 
								,CHARINDEX( ';',  @params 
									,CHARINDEX( ';',  @params) + 1) -	CHARINDEX( ';', @params) - 1)
			
			SET @part2 = SUBSTRING(@params
								,CHARINDEX(';',@params
									,CHARINDEX(';',@params) + 1) + 1
										,CHARINDEX(';',@params
											,CHARINDEX(';',@params
												,CHARINDEX(';',@params) +1) + 1) - CHARINDEX(';',@params
																						,CHARINDEX(';',@params) + 1) - 1)																			
			SET  @part3 = SUBSTRING(@params
								,CHARINDEX(';',@params
									,CHARINDEX(';',@params
										,CHARINDEX(';',@params) + 1) + 1) + 1
											,CHARINDEX(';',@params
												,CHARINDEX(';',@params
													,CHARINDEX(';',@params
														,CHARINDEX(';',@params) + 1) + 1) + 1) - CHARINDEX(';',@params
																									,CHARINDEX(';',@params
																										,CHARINDEX(';',@params) + 1) + 1) - 1)
			SET @part4 = SUBSTRING(@params 
							,CHARINDEX( ';', @params 
								,CHARINDEX( ';',  @params
									,CHARINDEX( ';',  @params
										,CHARINDEX( ';',  @params) + 1) + 1) + 1) + 1 
											,CHARINDEX(';',@params
												,CHARINDEX(';',@params
													,CHARINDEX(';',@params
														,CHARINDEX(';',@params
															,CHARINDEX(';',@params) + 1) + 1) + 1) + 1) - CHARINDEX(';',@params
																											,CHARINDEX(';',@params
																												,CHARINDEX(';',@params
																													,CHARINDEX(';',@params) + 1) + 1) +1) - 1)
			INSERT INTO @resultTable ([part0],[part1],[part2],[part3],[part4]) VALUES (@part0,@part1,@part2,@part3,@part4)
		END
		
		RETURN
	
	END
GO

/****** Object:  Table [dw].[DIM_OBJ_SLAVE]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_SLAVE](
	[slave_key] [int] IDENTITY(1,1) NOT NULL,
	[arch_days] [int] NULL,
	[connection] [varchar](30) NULL,
	[disable_protocol] [int] NULL,
	[display_id] [varchar](40) NULL,
	[drives] [varchar](8000) NULL,
	[drives_a] [varchar](80) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[is_backup] [int] NULL,
	[is_load] [int] NULL,
	[local_protocol] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[password] [varchar](30) NULL,
	[sync_time] [int] NULL,
	[user_id] [varchar](40) NULL,
	[username] [varchar](30) NULL,
	[is64bit] [int] NULL,
	[speaker_id] [varchar](50) NULL,
	[client] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___DE570062117F9D94] PRIMARY KEY CLUSTERED 
(
	[slave_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_SLAVE_id_valid_to_u_nc] ON [dw].[DIM_OBJ_SLAVE] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_RIGHTS_PERSON]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_RIGHTS_PERSON](
	[rights_person_key] [int] IDENTITY(1,1) NOT NULL,
	[change_first] [int] NULL,
	[change_last] [varchar](60) NULL,
	[change_months] [int] NULL,
	[change_user] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[login] [varchar](8000) NULL,
	[main_id] [varchar](60) NULL,
	[md5] [varchar](8000) NULL,
	[passwd] [varchar](60) NULL,
	[person] [varchar](60) NULL,
	[supervisor] [varchar](60) NULL,
	[windows] [varchar](255) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___4EE658A615502E78] PRIMARY KEY CLUSTERED 
(
	[rights_person_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_RIGHTS_PERSON_person_valid_to_u_nc] ON [dw].[DIM_OBJ_RIGHTS_PERSON] 
(
	[person] ASC,
	[main_id] ASC,
	[valid_to] ASC
)
INCLUDE ( [login],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_RIGHTS_OBJECT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_RIGHTS_OBJECT](
	[rights_object_key] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](800) NULL,
	[level] [int] NULL,
	[main_id] [varchar](40) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___F7AB80901920BF5C] PRIMARY KEY CLUSTERED 
(
	[rights_object_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_RIGHTS_OBJECT_main_id_id_valid_to_u_nc] ON [dw].[DIM_OBJ_RIGHTS_OBJECT] 
(
	[main_id] ASC,
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_RIGHTS]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_RIGHTS](
	[rights_key] [int] IDENTITY(1,1) NOT NULL,
	[allow_arch_hours] [int] NULL,
	[allow_archop_hours] [int] NULL,
	[allow_config] [int] NULL,
	[allow_delete_files] [int] NULL,
	[ask_admin_pwd] [int] NULL,
	[ask_user_pwd] [int] NULL,
	[flags] [int] NULL,
	[forbid_hide] [int] NULL,
	[forbid_logoff] [int] NULL,
	[from_last_logon] [int] NULL,
	[from_last_logon_op] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[allow_export_files] [int] NULL,
	[allow_protect_files] [int] NULL,
	[allow_unprotect_files] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___0864D9191CF15040] PRIMARY KEY CLUSTERED 
(
	[rights_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_RIGHTS_id_valid_to_u_nc] ON [dw].[DIM_OBJ_RIGHTS] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PNET3_NC32K]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_PNET3_NC32K](
	[nc32k_key] [int] IDENTITY(1,1) NOT NULL,
	[alarm_time] [int] NULL,
	[channel_com] [varchar](60) NULL,
	[channel_com_type] [varchar](60) NULL,
	[channel_ip] [varchar](60) NULL,
	[com_addr] [int] NULL,
	[door_time] [int] NULL,
	[ex1_opt] [int] NULL,
	[ex2_opt] [int] NULL,
	[exit_time] [int] NULL,
	[external_ip] [varchar](15) NULL,
	[flags] [int] NULL,
	[global_apb] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hardware_opt] [int] NULL,
	[id] [varchar](60) NULL,
	[interface] [int] NULL,
	[lock_time] [int] NULL,
	[mode_opt] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](60) NULL,
	[region_id] [varchar](60) NULL,
	[region_in] [varchar](60) NULL,
	[region_out] [varchar](60) NULL,
	[relay_delay_time] [int] NULL,
	[relay_opt] [int] NULL,
	[relay_time] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___E6D58BF320C1E124] PRIMARY KEY CLUSTERED 
(
	[nc32k_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PNET3_NC32K_id_valid_to_u_nc] ON [dw].[DIM_OBJ_PNET3_NC32K] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PNET3_IP_GATE]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[DIM_OBJ_PNET3_IP_GATE](
	[ip_gate_key] [int] IDENTITY(1,1) NOT NULL,
	[channel_ip] [nvarchar](60) NULL,
	[external_ip] [nvarchar](15) NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](60) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](60) NULL,
	[region_id] [nvarchar](60) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___A989B5EF24927208] PRIMARY KEY CLUSTERED 
(
	[ip_gate_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PNET3_IP_GATE_id_valid_to_u_nc] ON [dw].[DIM_OBJ_PNET3_IP_GATE] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PNET3_AC_PART]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_PNET3_AC_PART](
	[ac_part_key] [int] IDENTITY(1,1) NOT NULL,
	[active] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](60) NULL,
	[name] [varchar](60) NULL,
	[number] [int] NULL,
	[parent_id] [varchar](60) NULL,
	[parsec_name] [varchar](14) NULL,
	[region_id] [varchar](60) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___D728E800286302EC] PRIMARY KEY CLUSTERED 
(
	[ac_part_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PNET3_AC_PART_id_valid_to_u_nc] ON [dw].[DIM_OBJ_PNET3_AC_PART] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PNET3_AC]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_PNET3_AC](
	[ac_key] [int] IDENTITY(1,1) NOT NULL,
	[channel_com] [varchar](60) NULL,
	[channel_com_type] [varchar](60) NULL,
	[com_addr] [int] NULL,
	[ex1_opt] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](60) NULL,
	[keypad_addr] [int] NULL,
	[light_time] [int] NULL,
	[name] [varchar](60) NULL,
	[off_time] [int] NULL,
	[parent_id] [varchar](60) NULL,
	[parsec_name] [varchar](14) NULL,
	[region_id] [varchar](60) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___49E341912C3393D0] PRIMARY KEY CLUSTERED 
(
	[ac_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PNET3_AC_id_valid_to_u_nc] ON [dw].[DIM_OBJ_PNET3_AC] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PHOTO_IDENT_BUTTONS]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_PHOTO_IDENT_BUTTONS](
	[photo_ident_but_key] [int] IDENTITY(1,1) NOT NULL,
	[button_name] [varchar](255) NULL,
	[color] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[line_id] [int] NULL,
	[main_id] [varchar](40) NULL,
	[obj_id] [varchar](40) NULL,
	[obj_react] [varchar](255) NULL,
	[obj_type] [varchar](255) NULL,
	[text] [varchar](255) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___930C0D81300424B4] PRIMARY KEY CLUSTERED 
(
	[photo_ident_but_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PHOTO_IDENT_BUTTONS_mainid_lineid_butname_valid_to_u_nc] ON [dw].[DIM_OBJ_PHOTO_IDENT_BUTTONS] 
(
	[main_id] ASC,
	[line_id] ASC,
	[button_name] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PHOTO_IDENT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_PHOTO_IDENT](
	[photo_ident_key] [int] IDENTITY(1,1) NOT NULL,
	[archive_max] [int] NULL,
	[fixed_layout] [int] NULL,
	[flags] [int] NULL,
	[focus_on_event] [int] NULL,
	[grid_columns] [varchar](8000) NULL,
	[guid] [uniqueidentifier] NULL,
	[h] [int] NULL,
	[id] [varchar](40) NULL,
	[lines_count] [int] NULL,
	[name] [varchar](60) NULL,
	[num_last_event] [int] NULL,
	[parent_id] [varchar](40) NULL,
	[protocol_event] [int] NULL,
	[remove_events] [int] NULL,
	[show_on_event] [int] NULL,
	[show_time] [int] NULL,
	[w] [int] NULL,
	[x] [int] NULL,
	[y] [int] NULL,
	[event_expire] [int] NULL,
	[monitor] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___6E13325533D4B598] PRIMARY KEY CLUSTERED 
(
	[photo_ident_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PHOTO_IDENT_id_valid_to_u_nc] ON [dw].[DIM_OBJ_PHOTO_IDENT] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_PERSON]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_PERSON](
	[person_key] [int] IDENTITY(1,1) NOT NULL,
	[auto_brand] [varchar](32) NULL,
	[auto_number] [varchar](32) NULL,
	[begin_temp_level] [varchar](25) NULL,
	[card] [varchar](255) NULL,
	[card_date] [varchar](25) NULL,
	[card_loss] [int] NULL,
	[comment] [varchar](8000) NULL,
	[drivers_licence] [varchar](120) NULL,
	[end_temp_level] [varchar](25) NULL,
	[expired] [varchar](25) NULL,
	[external_id] [varchar](40) NULL,
	[facility_code] [varchar](255) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NOT NULL,
	[is_active_temp_level] [smallint] NULL,
	[is_apb] [smallint] NULL,
	[is_locked] [smallint] NULL,
	[level_id] [varchar](8000) NULL,
	[levels_times] [varchar](8000) NULL,
	[name] [varchar](255) NULL,
	[parent_id] [varchar](40) NULL,
	[passport] [varchar](120) NULL,
	[patronymic] [varchar](255) NULL,
	[phone] [varchar](60) NULL,
	[pin] [varchar](255) NULL,
	[post] [varchar](255) NULL,
	[pur] [int] NULL,
	[schedule_id] [varchar](40) NULL,
	[started_at] [datetime] NULL,
	[surname] [varchar](255) NULL,
	[tabnum] [varchar](60) NULL,
	[temp_card] [varchar](15) NULL,
	[temp_level_id] [varchar](8000) NULL,
	[temp_levels_times] [varchar](8000) NULL,
	[who_card] [varchar](60) NULL,
	[who_level] [varchar](60) NULL,
	[pnet3_alarm] [bit] NULL,
	[pnet3_block] [bit] NULL,
	[pnet3_guard] [bit] NULL,
	[pnet3_guest] [bit] NULL,
	[photo_key] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___08E9D16637A5467C] PRIMARY KEY CLUSTERED 
(
	[person_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_PERSON_id_valid_to_u_nc] ON [dw].[DIM_OBJ_PERSON] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[parent_id],
[patronymic],
[surname],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_LEVEL_READER]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_LEVEL_READER](
	[level_reader_key] [int] IDENTITY(1,1) NOT NULL,
	[arm] [varchar](1) NULL,
	[disarm] [varchar](1) NULL,
	[guid] [uniqueidentifier] NULL,
	[main_id] [varchar](40) NOT NULL,
	[not_download_cards] [smallint] NULL,
	[parent_id] [varchar](40) NULL,
	[reader_id] [varchar](40) NOT NULL,
	[reader_type] [varchar](32) NULL,
	[time_zone] [varchar](40) NOT NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___77BF96623E52440B] PRIMARY KEY CLUSTERED 
(
	[level_reader_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_LEVEL_READER_mainid_readerid_timezone_valid_to_u_nc] ON [dw].[DIM_OBJ_LEVEL_READER] 
(
	[main_id] ASC,
	[reader_id] ASC,
	[time_zone] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_LEVEL]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_LEVEL](
	[level_key] [int] IDENTITY(1,1) NOT NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](120) NULL,
	[parent_id] [varchar](40) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___9F9CFD1A4222D4EF] PRIMARY KEY CLUSTERED 
(
	[level_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_LEVEL_id_valid_to_u_nc] ON [dw].[DIM_OBJ_LEVEL] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_GRABBER]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_GRABBER](
	[grabber_key] [int] IDENTITY(1,1) NOT NULL,
	[auth] [varchar](30) NULL,
	[brand] [varchar](8000) NULL,
	[chan] [int] NULL,
	[codec] [varchar](60) NULL,
	[flags] [int] NULL,
	[format] [varchar](8) NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[ip] [varchar](8000) NULL,
	[ip_port] [varchar](16) NULL,
	[mode] [varchar](3) NULL,
	[model] [varchar](8000) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[password] [varchar](60) NULL,
	[resolution] [varchar](8) NULL,
	[type] [varchar](16) NULL,
	[useconfigurebyweb] [int] NULL,
	[username] [varchar](60) NULL,
	[watchdog] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___17305CBD45F365D3] PRIMARY KEY CLUSTERED 
(
	[grabber_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_GRABBER_id_valid_to_u_nc] ON [dw].[DIM_OBJ_GRABBER] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_DEPARTMENT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_DEPARTMENT](
	[dept_key] [int] IDENTITY(1,1) NOT NULL,
	[external_id] [varchar](255) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[level_id] [varchar](40) NULL,
	[name] [varchar](255) NULL,
	[owner_id] [varchar](60) NULL,
	[schedule_id] [varchar](40) NULL,
	[type] [smallint] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___04045D5049C3F6B7] PRIMARY KEY CLUSTERED 
(
	[dept_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_DEPARTMENT_id_valid_to_u_nc] ON [dw].[DIM_OBJ_DEPARTMENT] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_OBJ_CAM]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_CAM](
	[cam_key] [int] IDENTITY(1,1) NOT NULL,
	[activity] [smallint] NULL,
	[additional_info] [varchar](100) NULL,
	[alarm_rec] [smallint] NULL,
	[arch_days] [int] NULL,
	[audio_id] [varchar](40) NULL,
	[audio_type] [varchar](16) NULL,
	[blinding] [int] NULL,
	[bosch_ptz_protocol] [varchar](8000) NULL,
	[bright] [smallint] NULL,
	[color] [smallint] NULL,
	[compression] [smallint] NULL,
	[compressor] [varchar](40) NULL,
	[config_id] [varchar](40) NULL,
	[contrast] [smallint] NULL,
	[decoder] [int] NULL,
	[decompressor] [varchar](40) NULL,
	[flags] [int] NULL,
	[fps] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hot_rec_period] [int] NULL,
	[hot_rec_time] [int] NULL,
	[id] [varchar](40) NULL,
	[ifreg] [smallint] NULL,
	[manual] [smallint] NULL,
	[mask0] [varchar](250) NULL,
	[mask1] [varchar](250) NULL,
	[mask2] [varchar](250) NULL,
	[mask3] [varchar](250) NULL,
	[mask4] [varchar](200) NULL,
	[md_contrast] [smallint] NULL,
	[md_mode] [smallint] NULL,
	[md_size] [smallint] NULL,
	[motion] [smallint] NULL,
	[multistreaming_mode] [smallint] NULL,
	[mux] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[password_crc] [int] NULL,
	[pre_rec_time] [int] NULL,
	[priority] [int] NULL,
	[proc_time] [int] NULL,
	[rec_priority] [int] NULL,
	[region_id] [varchar](40) NULL,
	[resolution] [int] NULL,
	[rotate] [smallint] NULL,
	[rotateAngle] [varchar](40) NULL,
	[sat_u] [smallint] NULL,
	[source_folder] [varchar](8000) NULL,
	[stream_analitic] [varchar](40) NULL,
	[stream_archive] [varchar](40) NULL,
	[stream_client] [varchar](40) NULL,
	[telemetry_id] [varchar](40) NULL,
	[type] [int] NULL,
	[yuv] [smallint] NULL,
	[stream_alarm] [varchar](40) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ___829D33D94D94879B] PRIMARY KEY CLUSTERED 
(
	[cam_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_OBJ_CAM_id_valid_to_u_nc] ON [dw].[DIM_OBJ_CAM] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [name],
[valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [dw].[DIM_EVENT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_EVENT](
	[event_key] [int] IDENTITY(1,1) NOT NULL,
	[action] [varchar](32) NULL,
	[objtype] [varchar](32) NULL,
	[description] [varchar](255) NULL,
 CONSTRAINT [PK__DIM_EVEN__D49345B85165187F] PRIMARY KEY CLUSTERED 
(
	[event_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_DIM_EVENT_objtype_action_nc_u] ON [dw].[DIM_EVENT] 
(
	[objtype] ASC,
	[action] ASC
)
INCLUDE ( [description]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
GO


/****** Object:  Table [dw].[DIM_OBJ_DISPLAY]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_DISPLAY](
	[display_key] [int] IDENTITY(1,1) NOT NULL,	
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ_DISPLAY] PRIMARY KEY CLUSTERED 
(
	[display_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_DISPLAY__id__valid_to_u_nc] ON [dw].[DIM_OBJ_DISPLAY] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO



/****** Object:  Table [dw].[DIM_OBJ_MAP]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_MAP](
	[map_key] [int] IDENTITY(1,1) NOT NULL,	
	[alarm_top] [smallint] NULL,
	[auto] [smallint] NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[h] [int] NULL,
	[id] [varchar](40) NULL,
	[interpolation_mode] [int] NULL,
	[monitor] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[recurs] [smallint] NULL,
	[shortest] [int] NULL,
	[w] [int] NULL,
	[x] [int] NULL,
	[y] [int] NULL,
	[tracking_monitor_id] [varchar](8000) NULL,
	[show_last_events] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ_MAP] PRIMARY KEY CLUSTERED 
(
	[map_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_MAP__id__valid_to_u_nc] ON [dw].[DIM_OBJ_MAP] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO


/****** Object:  Table [dw].[DIM_OBJ_MAPLAYER]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_MAPLAYER](
	[maplayer_key] [int] IDENTITY(1,1) NOT NULL,	
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[layer_file] [varchar](8000) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[version] [int] NULL,
	[xml] [varchar](8000)  NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ_MAPLAYER] PRIMARY KEY CLUSTERED 
(
	[maplayer_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_MAPLAYER__id__valid_to_u_nc] ON [dw].[DIM_OBJ_MAPLAYER] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO


/****** Object:  Table [dw].[DIM_OBJ_MACRO]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_MACRO](
	[macro_key] [int] IDENTITY(1,1) NOT NULL,	
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hidden] [int] NULL,
	[id] [varchar](40) NULL,
	[local] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[state] [varchar](30) NULL,
	[delay] [int] NULL,
	[hotkey] [varchar] (8000) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
 CONSTRAINT [PK__DIM_OBJ_MACRO] PRIMARY KEY CLUSTERED 
(
	[macro_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_MACRO__id__valid_to_u_nc] ON [dw].[DIM_OBJ_MACRO] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO



/****** Object:  Table [dw].[DIM_OBJ_SCRIPT]    Script Date: 12/05/2018 12:13:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[DIM_OBJ_SCRIPT](
	[script_key] [int] IDENTITY(1,1) NOT NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[script] [ntext] NULL,
	[time_zone] [varchar](16) NULL,
	[type] [int] NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,	
 CONSTRAINT [PK__DIM_OBJ_SCRIPT] PRIMARY KEY CLUSTERED 
(
	[script_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_TEXTIMAGE]
GO

SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_SCRIPT__id__valid_to_u_nc] ON [dw].[DIM_OBJ_SCRIPT] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[DIM_OBJ_CAM_AUDIO](
	[cam_audio_key] [int] IDENTITY(1,1) NOT NULL,
	[main_id] [varchar](40) NULL,
	[mic_id] [varchar](40) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
CONSTRAINT [PK__DIM_OBJ_CAM_AUDIO] PRIMARY KEY CLUSTERED 
(
	[cam_audio_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_CAM_AUDIO__main_id__mic_id__valid_to_u_nc] ON [dw].[DIM_OBJ_CAM_AUDIO] 
(
	[main_id] ASC,
	[mic_id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[DIM_OBJ_LINK](
	[link_key] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
CONSTRAINT [PK__DIM_OBJ_LINK] PRIMARY KEY CLUSTERED 
(
	[link_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_LINK__id__valid_to_u_nc] ON [dw].[DIM_OBJ_LINK] 
(
	[id] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[DIM_OBJ_LINK_OBJECTS](
	[link_objects_key] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NULL,
	[main_id] [varchar](40) NULL,
	[objid] [varchar](40) NULL,
	[objtype] [varchar](60) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_inferred] [bit] NULL,
CONSTRAINT [PK__DIM_OBJ_LINK_OBJECTS] PRIMARY KEY CLUSTERED 
(
	[link_objects_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__DIM_OBJ_LINK_OBJECTS__main_id__objtype__objid__valid_to_u_nc] ON [dw].[DIM_OBJ_LINK_OBJECTS] 
(
	[main_id] ASC,
	[objtype] ASC,
	[objid] ASC,
	[valid_to] ASC
)
INCLUDE ( [valid_from]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO








/****** Object:  Table [dw].[photo]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[photo](
	[photo_key] [int] IDENTITY(1,1) NOT NULL,
	[photo] [varbinary](max) NULL,
	[photo_md5] [varbinary](128) NULL,
	[valid_from] [datetime] NULL,
	[valid_to] [datetime] NULL
) ON [PHOTO] TEXTIMAGE_ON [PHOTO]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [idx_photo_key_del_c_u] ON [dw].[photo] 
(
	[photo_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [PHOTO]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_photo_md5_u_nc] ON [dw].[photo] 
(
	[photo_md5] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PHOTO]
GO






/****** Object:  Table [dw].[LEVEL_EXTANDED]    Script Date: 11/29/2018 11:57:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dw].[LEVEL_EXTANDED](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[level_id] [int] NULL,
	[level_num] [int] NULL,
	[description] [varchar](8000) NULL,
	[type] [varchar](255) NULL,
	[rank] [float] NULL
) ON [MAIN_DATA]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Index [idx_LEVEL_EXTANDED__level_id__u__nc]    Script Date: 11/29/2018 11:57:20 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_LEVEL_EXTANDED__level_id__u__nc] ON [dw].[LEVEL_EXTANDED] 
(
	[level_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_INDEX]
GO








/****** Object:  PartitionScheme [sch_Partition_PROTOCOL]    Script Date: 04/20/2018 12:36:38 ******/
CREATE PARTITION SCHEME [sch_Partition_PROTOCOL] AS PARTITION [fn_Partition_PROTOCOL] TO ([PROTOCOL_2015], [PROTOCOL_2016], [PROTOCOL_2017], [PROTOCOL_2018], [PROTOCOL_2019], [PROTOCOL_2020], [PROTOCOL_2021], [PROTOCOL_2022], [PROTOCOL_2023], [PROTOCOL_2024], [PROTOCOL_2025], [PROTOCOL_2026])
GO
/****** Object:  Table [dw].[FACT_PROTOCOL]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[FACT_PROTOCOL](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[event_key] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[server_date] [datetime] NOT NULL,
	[person_key] [int] NULL,
	[dept_key] [int] NULL,
	[nc32k_key] [int] NULL,
	[ac_key] [int] NULL,
	[ac_part_key] [int] NULL,
	[ip_gate_key] [int] NULL,
	[cam_key] [int] NULL,
	[photo_ident_key] [int] NULL,
	[photo_ident_but_key] [int] NULL,
	[user_key] [int] NULL,
	[owner_key] [int] NULL,
	[slave_key] [int] NULL,
	[params] [varchar](1000) NULL,
	[guid] [uniqueidentifier] NOT NULL
) ON [sch_Partition_PROTOCOL]([date])
WITH
(
DATA_COMPRESSION = ROW ON PARTITIONS (1 TO 10)
)
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [idx_FACT_PROTOCOL_date_num_c_u] ON [dw].[FACT_PROTOCOL] 
(
	[date] ASC,
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95, DATA_COMPRESSION = ROW ON PARTITIONS (1 TO 10)) ON [sch_Partition_PROTOCOL]([date])
GO


CREATE UNIQUE NONCLUSTERED INDEX [idx_FACT_PROTOCOL_guid_nc_u] ON [dw].[FACT_PROTOCOL] 
(
	[guid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PROTOCOL_INDEX]
GO


CREATE NONCLUSTERED INDEX [idx_FACT_PROTOCOL_person_nc] ON [dw].[FACT_PROTOCOL] 
(
	[person_key] ASC
)
INCLUDE ( [event_key],
[date],
[dept_key],
[nc32k_key],
[params]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PROTOCOL_INDEX]
GO


/****** Object:  Table [dw].[FACT_AUDIT]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dw].[FACT_AUDIT](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[event_key] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[server_date] [datetime] NOT NULL,
	[user_key] [int] NULL,
	[person_key] [int] NULL,
	[dept_key] [int] NULL,
	[level_key] [int] NULL,
	[nc32k_key] [int] NULL,
	[ac_key] [int] NULL,
	[ac_part_key] [int] NULL,
	[ip_gate_key] [int] NULL,
	[grabber_key] [int] NULL,
	[cam_key] [int] NULL,
	[cam_date] [datetime] NULL,
	[photo_ident_key] [int] NULL,
	[photo_ident_but_key] [int] NULL,	
	[display_key] [int] NULL,
	[map_key] [int] NULL,
	[maplayer_key] [int] NULL,
	[macro_key] [int] NULL,
	[script_key] [int] NULL,
	[rights_key] [int] NULL,
	[owner_key] [int] NULL,
	[slave_key] [int] NULL,
	[params] [varchar](1000) NULL,
	[guid] [uniqueidentifier] NOT NULL
) ON [AUDIT]

GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [idx_FACT_AUDIT_date_num_c_u] ON [dw].[FACT_AUDIT] 
(
	[date] ASC,
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95, DATA_COMPRESSION = PAGE) ON [AUDIT]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_FACT_AUDIT_guid_nc_u] ON [dw].[FACT_AUDIT] 
(
	[guid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [AUDIT]
GO





/****** Object:  View [dw].[v_Protocol]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dw].[v_Protocol]  
AS   
SELECT  pr.num
		,pr.date
		,pr.server_date		
		,ev.description AS [event]
		,per.name AS [per_name]
		,per.surname AS [per_surname]
		,per.patronymic AS [per_patronymic]
		,dep.name AS [dep_name]
		,nc.name AS [nc_name]
		,ac.name AS [ac_name]
		,ac_part.name AS [ac_part_name]
		,ip_gate.name AS [ip_gate_name]
		,cam.name AS [cam_name]
		,u.name AS [user_name]
		,u.surname AS [user_surname]
		,u.patronymic AS [user_patronymic]
		,[pi].name AS [photo_ident_name]
		,[pi_b].[text] AS [button_text]
		,sl.name AS [owner_name]
		,sl2.name AS [slave_name]
		,ev.objtype
		,ev.action
		,pr.[event_key]
		,pr.[person_key] 
		,pr.[dept_key] 
		,pr.[nc32k_key] 
		,pr.[ac_key] 
		,pr.[ac_part_key]  
		,pr.[ip_gate_key] 
		,pr.[cam_key]
		,pr.[photo_ident_key]
		,pr.[photo_ident_but_key]
		,pr.[user_key]
		,pr.[owner_key]
		,pr.[slave_key]
		,pr.[params]
		,pr.[guid]
FROM dw.FACT_PROTOCOL pr   
LEFT JOIN dw.[DIM_EVENT] ev ON ev.event_key = pr.event_key
LEFT JOIN dw.DIM_OBJ_PERSON per ON per.person_key = pr.person_key
LEFT JOIN dw.DIM_OBJ_PERSON u ON u.person_key = pr.user_key
LEFT JOIN dw.DIM_OBJ_DEPARTMENT dep ON dep.dept_key = pr.dept_key
LEFT JOIN dw.DIM_OBJ_PNET3_NC32K nc ON nc.nc32k_key = pr.nc32k_key
LEFT JOIN dw.DIM_OBJ_PNET3_AC ac ON ac.ac_key = pr.ac_key
LEFT JOIN dw.DIM_OBJ_PNET3_AC_PART ac_part ON ac_part.ac_part_key = pr.ac_part_key
LEFT JOIN dw.DIM_OBJ_PNET3_IP_GATE ip_gate ON ip_gate.ip_gate_key = pr.ip_gate_key
LEFT JOIN dw.DIM_OBJ_CAM cam ON cam.cam_key = pr.cam_key
LEFT JOIN dw.DIM_OBJ_SLAVE sl ON sl.slave_key = pr.owner_key
LEFT JOIN dw.DIM_OBJ_SLAVE sl2 ON sl2.slave_key = pr.slave_key
LEFT JOIN dw.DIM_OBJ_PHOTO_IDENT [pi] ON [pi].photo_ident_key = pr.photo_ident_key
LEFT JOIN dw.DIM_OBJ_PHOTO_IDENT_BUTTONS [pi_b] ON [pi_b].photo_ident_but_key = pr.photo_ident_but_key
GO




/****** Object:  StoredProcedure [dw].[load_photo]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[load_photo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[load_photo]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[load_photo] (
	@file_path AS nvarchar(256),
	@result AS bit OUTPUT)
AS 
BEGIN
	--процедура для загрузки в темповую таблицу фотографии из файла
	BEGIN TRY	
		DECLARE @cmd as nvarchar(1000)
		DELETE FROM IntellectSTG.stg.photo_temp
		SET @cmd = 'INSERT INTO IntellectSTG.stg.photo_temp SELECT * FROM OPENROWSET(BULK N''' +  @file_path + ''', SINGLE_BLOB) AS photo'
		--SET @cmd = 'SELECT * FROM OPENROWSET(BULK ''C:\Program Files\Интеллект\Bmp\Person\61665655.bmp'', SINGLE_BLOB) AS photo'
		EXECUTE (@cmd)
		SET @result = 1
		--PRINT 'Photo added. @file_path: ' + @file_path
	END TRY
	BEGIN CATCH
		SET @result = 0
		--PRINT 'Photo not added! @file_path: ' + @file_path
	END CATCH
END
GO

/****** Object:  StoredProcedure [dw].[usp_GetDimUserKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimUserKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimUserKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimUserKey]
	@user_id AS VARCHAR(40),
	@user_name AS VARCHAR(255),
	@user_surname AS VARCHAR(255),
	@user_patronymic AS VARCHAR(255),
	@user_parent_id AS VARCHAR(40),
	@valid_from AS DATETIME,
	@user_key as INT OUTPUT
AS
--Проверяем, если в dw.DIM_OBJ_PERSON сотрудник с таким же id, именем и текущим сроком действия.
--Если есть, возвращаем @person_key.
SET @user_key = (SELECT TOP(1) person_key
				   FROM dw.DIM_OBJ_PERSON 
				   WHERE id = @user_id  
				   AND name = @user_name 
		           AND surname = @user_surname 
		           AND patronymic = @user_patronymic 
		           AND parent_id = @user_parent_id
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc)    
--Если нет, добавляем нового сотрудника с текущими параметрами, возвращаем @person_key.
--Срок действия предыдущих сотрудников с таким же @user_id, закрываем. 
IF @user_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PERSON SET valid_to = @valid_from, is_inferred = 0 WHERE id = @user_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PERSON (id,name,surname,patronymic,parent_id,valid_from,is_inferred)
	VALUES (@user_id,@user_name,@user_surname,@user_patronymic,@user_parent_id,@valid_from,1)
	SET @user_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimSlaveKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimSlaveKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimSlaveKey]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimSlaveKey]
	@slave_id AS VARCHAR(60),
	--@slave_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@slave_key AS INT OUTPUT
AS
SET @slave_key = (SELECT TOP(1) slave_key
				   FROM dw.DIM_OBJ_SLAVE
				   WHERE id = @slave_id  
				   --AND name = @slave_name 
		          AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		          ORDER BY valid_from desc) 
IF @slave_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_SLAVE SET valid_to = @valid_from, is_inferred = 0 WHERE id = @slave_id AND valid_to IS NULL 
	INSERT INTO	dw.DIM_OBJ_SLAVE (id,valid_from,is_inferred)
	VALUES (@slave_id,@valid_from,1)
	SET @slave_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimPhotoIdentKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimPhotoIdentKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimPhotoIdentKey]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimPhotoIdentKey]
	@photo_ident_id AS VARCHAR(40),
	@valid_from AS DATETIME,
	@photo_ident_key AS INT OUTPUT
AS
--Проверяем, если в dw.DIM_OBJ_PHOTO_IDENT модуль с таким же id и текущим сроком действия.
--Если есть, возвращаем @photo_ident_key.
SET @photo_ident_key = (SELECT TOP(1) photo_ident_key
				   FROM dw.DIM_OBJ_PHOTO_IDENT 
				   WHERE id = @photo_ident_id  
				   AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
				   ORDER BY valid_from desc) 
--Если нет, добавляем новый модуль с текущими параметрами, возвращаем @photo_ident_key.
--Срок действия предыдущих модудей с таким же @photo_ident_id, закрываем. 
IF @photo_ident_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PHOTO_IDENT SET valid_to = @valid_from, is_inferred = 0 WHERE id = @photo_ident_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PHOTO_IDENT (id,valid_from,is_inferred)
	VALUES (@photo_ident_id,@valid_from,1)
	SET @photo_ident_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimPhotoIdentButKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimPhotoIdentButKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimPhotoIdentButKey]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimPhotoIdentButKey]
	@photo_ident_id AS VARCHAR(40),
	@line_id AS VARCHAR(40),
	@button_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@photo_ident_but_key AS INT OUTPUT
AS
--Проверяем, если в dw.DIM_OBJ_PHOTO_IDENT_BUT кнопка с таким же параметрами и сроком действия.
--Если есть, возвращаем @photo_ident_but_key.
SET @photo_ident_but_key = (SELECT TOP(1) photo_ident_but_key
						   FROM dw.DIM_OBJ_PHOTO_IDENT_BUTTONS 
						   WHERE	main_id  = @photo_ident_id  
							   AND line_id  = @line_id
							   AND button_name = @button_name
							   AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
							   ORDER BY valid_from desc) 
--Если нет, добавляем новую кнопку с текущими параметрами, возвращаем @photo_ident_but_key.
--Срок действия предыдущих реакций с таким же параметрами закрываем. 
IF @photo_ident_but_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PHOTO_IDENT_BUTTONS SET valid_to = @valid_from, 
									is_inferred = 0 
	WHERE	main_id = @photo_ident_id
			AND line_id  = @line_id
			AND button_name = @button_name
			AND valid_to IS NULL
	
	INSERT INTO	dw.DIM_OBJ_PHOTO_IDENT_BUTTONS  (main_id
												,line_id
												,button_name
												,valid_from
												,is_inferred)
	VALUES  (@photo_ident_id
			,@line_id
			,@button_name
			,@valid_from
			,1)
	SET @photo_ident_but_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimPersonKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimPersonKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimPersonKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimPersonKey]
	@person_id AS VARCHAR(40),
	@person_name AS VARCHAR(255),
	@person_surname AS VARCHAR(255),
	@person_patronymic AS VARCHAR(255),
	@person_parent_id AS VARCHAR(40),
	@valid_from AS DATETIME,
	@person_key as INT OUTPUT
AS

--Проверяем, если в dw.DIM_OBJ_PERSON сотрудник с таким же id, и сроком начала действия
--(фишечка от интеллекта, когда в базу приходят события о сотруднике с одинаковым id, разными компонентами и одинаковым таймштампом)
--Если есть, возвращаем @person_key.
SET @person_key = 
				   (SELECT person_key
				   FROM dw.DIM_OBJ_PERSON 
				   WHERE id = @person_id  
				   AND (valid_from = @valid_from))

--Проверяем, если в dw.DIM_OBJ_PERSON сотрудник с таким же id, именем, отделом и подходящим сроком действия.
--Если есть, возвращаем @person_key.
IF @person_key IS NULL
SET @person_key = (SELECT TOP(1) person_key
				   FROM dw.DIM_OBJ_PERSON 
				   WHERE id = @person_id  
				   AND name = @person_name 
		           AND surname = @person_surname 
		           AND patronymic = @person_patronymic 
		           AND ISNULL(parent_id,'') = ISNULL(@person_parent_id,'')
		           AND ((valid_from < @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
--Если нет, добавляем нового сотрудника с текущими параметрами, возвращаем @person_key.
--Срок действия предыдущих сотрудников с таким же @person_id, закрываем. 
IF @person_key IS NULL
BEGIN
	BEGIN TRANSACTION
	--тестовая ошибка
	--SET @person_key = 1 / 0
	UPDATE dw.DIM_OBJ_PERSON SET valid_to = @valid_from, is_inferred = 0 WHERE id = @person_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PERSON (id,name,surname,patronymic,parent_id,valid_from,is_inferred)
	VALUES (@person_id,@person_name,@person_surname,@person_patronymic,@person_parent_id,@valid_from,1)
	SET @person_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimNc32kKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimNc32kKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimNc32kKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimNc32kKey]
	@nc32k_id AS VARCHAR(60),
	--@nc32k_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@nc32k_key as INT OUTPUT
AS
--Проверяем, есть ли в dw.DIM_OBJ_PNET3_NC32K контроллер с таким же id, именем и текущим сроком действия.
--Если есть, возвращаем @nc32k_key.
SET @nc32k_key = (SELECT TOP(1) nc32k_key
				   FROM dw.DIM_OBJ_PNET3_NC32K
				   WHERE id = @nc32k_id  
				   --AND name = @nc32k_name 
		           --AND valid_to IS NULL)
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
--Если нет, добавляем новый контроллер с текущими параметрами, возвращаем @nc32k_key.
--Срок действия предыдущих строк с таким же @nc32k_id, закрываем. 
IF @nc32k_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PNET3_NC32K SET valid_to = @valid_from, is_inferred = 0 WHERE id = @nc32k_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PNET3_NC32K (id,valid_from,is_inferred)
	VALUES (@nc32k_id,@valid_from,1)
	SET @nc32k_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimIpGateKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimIpGateKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimIpGateKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimIpGateKey]
	@ip_gate_id AS VARCHAR(60),
	--@ip_gate_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@ip_gate_key AS INT OUTPUT
AS
SET @ip_gate_key = (SELECT TOP(1) ip_gate_key
				   FROM dw.DIM_OBJ_PNET3_IP_GATE
				   WHERE id = @ip_gate_id  
				   --AND name = @ip_gate_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
		           --AND valid_to IS NULL)
IF @ip_gate_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PNET3_IP_GATE SET valid_to = @valid_from, is_inferred = 0 WHERE id = @ip_gate_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PNET3_IP_GATE (id,valid_from,is_inferred)
	VALUES (@ip_gate_id,@valid_from,1)
	SET @ip_gate_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimEventKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimEventKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimEventKey]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimEventKey]
	@objtype AS VARCHAR(32),
	@action AS VARCHAR(32),
	@event_key as INT OUTPUT
AS
--Проверяем, если в dw.DIM_EVENT событие с такими objtype и action.
SET @event_key = (SELECT [event_key]
				   FROM dw.[DIM_EVENT] 
				   WHERE [objtype] = @objtype  
				   AND [action] = @action)
--Если нет, добавляем новое событие с текущими параметрами, возвращаем @event_key.
IF @event_key IS NULL
BEGIN
	BEGIN TRANSACTION
	INSERT INTO	dw.[DIM_EVENT] ([action],[objtype])
	VALUES (@action,@objtype)
	SET @event_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimDeptKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimDeptKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimDeptKey]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimDeptKey]
	@dept_id AS VARCHAR(40),
	@dept_name AS VARCHAR(255) = NULL,
	@valid_from AS DATETIME,
	@dept_key as INT OUTPUT
AS
--Проверяем, если в dw.DIM_OBJ_DEPARTMENT отдел с таким же id, именем и текущим сроком действия.
--Если есть, возвращаем @dept_key.
SET @dept_key = (SELECT TOP(1) dept_key
				   FROM dw.DIM_OBJ_DEPARTMENT
				   WHERE id = @dept_id  
				   --AND name = @dept_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc)
		           --AND valid_to IS NULL) 
--Если нет, добавляем новый отдел с текущими параметрами, возвращаем @dept_key.
--Срок действия предыдущих строк с таким же @dept_id, закрываем. 
IF @dept_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_DEPARTMENT SET valid_to = @valid_from, is_inferred = 0 WHERE id = @dept_id  AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_DEPARTMENT (id,valid_from,is_inferred)
	VALUES (@dept_id,@valid_from,1)
	SET @dept_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimCamKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimCamKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimCamKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimCamKey]
	@cam_id AS VARCHAR(60),
	--@cam_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@cam_key AS INT OUTPUT
AS
SET @cam_key = (SELECT TOP(1)cam_key
				   FROM dw.DIM_OBJ_CAM
				   WHERE id = @cam_id  
				   --AND name = @cam_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
		           --AND valid_to IS NULL)
IF @cam_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_CAM SET valid_to = @valid_from, is_inferred = 0 WHERE  id = @cam_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_CAM (id,valid_from,is_inferred)
	VALUES (@cam_id,@valid_from,1)
	SET @cam_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimAcPartKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimAcPartKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimAcPartKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimAcPartKey]
	@ac_part_id AS VARCHAR(60),
	--@ac_part_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@ac_part_key as INT OUTPUT
AS
SET @ac_part_key = (SELECT TOP(1) ac_part_key
				   FROM dw.DIM_OBJ_PNET3_AC_PART
				   WHERE id = @ac_part_id  
				   --AND name = @ac_part_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
		           --AND valid_to IS NULL)
IF @ac_part_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PNET3_AC_PART SET valid_to = @valid_from, is_inferred = 0 WHERE id = @ac_part_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PNET3_AC_PART (id,valid_from,is_inferred)
	VALUES (@ac_part_id,@valid_from,1)
	SET @ac_part_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dw].[usp_GetDimAcKey]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimAcKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimAcKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimAcKey]
	@ac_id AS VARCHAR(60),
	--@ac_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@ac_key AS INT OUTPUT
AS
SET @ac_key = (SELECT TOP(1) ac_key
				   FROM dw.DIM_OBJ_PNET3_AC
				   WHERE id = @ac_id  
				   --AND name = @ac_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc)
		            
IF @ac_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_PNET3_AC SET valid_to = @valid_from, is_inferred = 0 WHERE id = @ac_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_PNET3_AC (id,valid_from,is_inferred)
	VALUES (@ac_id,@valid_from,1)
	SET @ac_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO

/****** Object:  StoredProcedure [dw].[usp_GetDimLevelKey]  ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimLevelKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimLevelKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimLevelKey]
	@level_id AS VARCHAR(60),
	--@level_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@level_key AS INT OUTPUT
AS
--SET @level_name = LTRIM(RTRIM(@level_name))
SET @level_key = (SELECT TOP(1)level_key
				   FROM dw.DIM_OBJ_LEVEL
				   WHERE id = @level_id  
				   --AND name = @level_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
IF @level_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_LEVEL SET valid_to = @valid_from, is_inferred = 0 WHERE id = @level_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_LEVEL (id,valid_from,is_inferred)
	VALUES (@level_id,@valid_from,1)
	SET @level_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO


/****** Object:  StoredProcedure [dw].[usp_GetDimRightsKey]  ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimRightsKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimRightsKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimRightsKey]
	@rights_id AS VARCHAR(60),
	--@rights_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@rights_key AS INT OUTPUT
AS
--SET @rights_name = LTRIM(RTRIM(@rights_name))
SET @rights_key = (SELECT TOP(1) rights_key
				   FROM dw.DIM_OBJ_RIGHTS
				   WHERE id = @rights_id  
				   --AND name = @rights_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
IF @rights_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_RIGHTS SET valid_to = @valid_from, is_inferred = 0 WHERE id = @rights_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_RIGHTS (id,valid_from,is_inferred)
	VALUES (@rights_id,@valid_from,1)
	SET @rights_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO


/****** Object:  StoredProcedure [dw].[usp_GetDimScriptKey]  ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimScriptKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimScriptKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimScriptKey]
	@script_id AS VARCHAR(60),
	--@script_name AS VARCHAR(255),
	@valid_from AS DATETIME,
	@script_key AS INT OUTPUT
AS
--SET @script_name = LTRIM(RTRIM(@script_name))
SET @script_key = (SELECT TOP(1)script_key
				   FROM dw.DIM_OBJ_SCRIPT
				   WHERE id = @script_id  
				   --AND name = @script_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
IF @script_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_SCRIPT SET valid_to = @valid_from, is_inferred = 0 WHERE id = @script_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_SCRIPT (id,valid_from,is_inferred)
	VALUES (@script_id,@valid_from,1)
	SET @script_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO


/****** Object:  StoredProcedure [dw].[usp_GetDimMacroKey]  ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_GetDimMacroKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_GetDimMacroKey]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_GetDimMacroKey]
	@macro_id AS VARCHAR(60),
	@valid_from AS DATETIME,
	@macro_key AS INT OUTPUT
AS
SET @macro_key = (SELECT TOP(1) macro_key
				   FROM dw.DIM_OBJ_MACRO
				   WHERE id = @macro_id  
				   --AND name = @script_name 
		           AND ((valid_from <= @valid_from) AND (ISNULL(valid_to,'01.01.9999') > @valid_from))
		           ORDER BY valid_from desc) 
IF @macro_key IS NULL
BEGIN
	BEGIN TRANSACTION
	UPDATE dw.DIM_OBJ_MACRO SET valid_to = @valid_from, is_inferred = 0 WHERE id = @macro_id AND valid_to IS NULL
	INSERT INTO	dw.DIM_OBJ_MACRO (id,valid_from,is_inferred)
	VALUES (@macro_id,@valid_from,1)
	SET @macro_key = SCOPE_IDENTITY()
	COMMIT TRANSACTION
END
GO





/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_SLAVE]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_SLAVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_SLAVE]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_SLAVE]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[arch_days] [int] NULL,
	[connection] [varchar](30) NULL,
	[disable_protocol] [int] NULL,
	[display_id] [varchar](40) NULL,
	[drives] [varchar](8000) NULL,
	[drives_a] [varchar](80) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[is_backup] [int] NULL,
	[is_load] [int] NULL,
	[local_protocol] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[password] [varchar](30) NULL,
	[sync_time] [int] NULL,
	[user_id] [varchar](40) NULL,
	[username] [varchar](30) NULL,
	[is64bit] [int] NULL,
	[speaker_id] [varchar](50) NULL,
	[client] [int] NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_SLAVE as tgt
USING IntellectSTG.stg.OBJ_SLAVE AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [arch_days]
      ,[connection]
      ,[disable_protocol]
      ,[display_id]
      ,[drives]
      ,[drives_a]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_backup]
      ,[is_load]
      ,[local_protocol]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[sync_time]
      ,[user_id]
      ,[username]
      ,[is64bit]
      ,[speaker_id]
      ,[client]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[arch_days]
      ,				src.[connection]
      ,				src.[disable_protocol]
      ,				src.[display_id]
      ,				src.[drives]
      ,				src.[drives_a]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[is_backup]
      ,				src.[is_load]
      ,				src.[local_protocol]
      ,	LTRIM(RTRIM(src.[name]									))
      ,				src.[parent_id]
      ,				src.[password]
      ,				src.[sync_time]
      ,				src.[user_id]
      ,				src.[username]
      ,				src.[is64bit]
      ,				src.[speaker_id]
      ,				src.[client]
     
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[arch_days],'')				<>							     ISNULL(src.[arch_days],'')			
		   OR ISNULL(tgt.[connection],'')				<>								 ISNULL(src.[connection],'')			
		   OR ISNULL(tgt.[disable_protocol],'')			<>								 ISNULL(src.[disable_protocol],'')		
		   OR ISNULL(tgt.[display_id],'')				<>								 ISNULL(src.[display_id],'')			
		   OR ISNULL(tgt.[drives],'')					<>	CONVERT(VARCHAR(8000),		 ISNULL(src.[drives],''))				
		   OR ISNULL(tgt.[drives_a],'')					<>								 ISNULL(src.[drives_a],'')				
		   OR ISNULL(tgt.[flags],'')					<>								 ISNULL(src.[flags],'')				
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1))<>							 ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1))					
		   OR ISNULL(tgt.[is_backup],'')				<>								 ISNULL(src.[is_backup],'')			
		   OR ISNULL(tgt.[is_load],'')					<>								 ISNULL(src.[is_load],'')				
		   OR ISNULL(tgt.[local_protocol],'')			<>								 ISNULL(src.[local_protocol],'')		
		   OR ISNULL(tgt.[name],'')						<>	LTRIM(RTRIM(				 ISNULL(src.[name],'')))					
		   OR ISNULL(tgt.[parent_id],'')				<>								 ISNULL(src.[parent_id],'')			
		   OR ISNULL(tgt.[password],'')					<>								 ISNULL(src.[password],'')				
		   OR ISNULL(tgt.[sync_time],'')				<>								 ISNULL(src.[sync_time],'')			
		   OR ISNULL(tgt.[user_id],'')					<>								 ISNULL(src.[user_id],'')				
		   OR ISNULL(tgt.[username],'')					<>								 ISNULL(src.[username],'')				
		   OR ISNULL(tgt.[is64bit],'')					<>								 ISNULL(src.[is64bit],'')				
		   OR ISNULL(tgt.[speaker_id],'')				<>								 ISNULL(src.[speaker_id],'')			
		   OR ISNULL(tgt.[client],'')					<>								 ISNULL(src.[client],'')				
		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[arch_days]
      ,				src.[connection]
      ,				src.[disable_protocol]
      ,				src.[display_id]
      ,				src.[drives]
      ,				src.[drives_a]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[is_backup]
      ,				src.[is_load]
      ,				src.[local_protocol]
      ,	LTRIM(RTRIM(src.[name]									))
      ,				src.[parent_id]
      ,				src.[password]
      ,				src.[sync_time]
      ,				src.[user_id]
      ,				src.[username]
      ,				src.[is64bit]
      ,				src.[speaker_id]
      ,				src.[client]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_SLAVE (
	   [arch_days]
      ,[connection]
      ,[disable_protocol]
      ,[display_id]
      ,[drives]
      ,[drives_a]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_backup]
      ,[is_load]
      ,[local_protocol]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[sync_time]
      ,[user_id]
      ,[username]
      ,[is64bit]
      ,[speaker_id]
      ,[client]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [arch_days]
      ,[connection]
      ,[disable_protocol]
      ,[display_id]
      ,[drives]
      ,[drives_a]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_backup]
      ,[is_load]
      ,[local_protocol]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[sync_time]
      ,[user_id]
      ,[username]
      ,[is64bit]
      ,[speaker_id]
      ,[client]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[arch_days]			=					src.[arch_days]
	,tgt.[connection]			=					src.[connection]
	,tgt.[disable_protocol]		=					src.[disable_protocol]
	,tgt.[display_id]			=					src.[display_id]
	,tgt.[drives]				=					src.[drives]
	,tgt.[drives_a]				=					src.[drives_a]
	,tgt.[flags]				=					src.[flags]
	,tgt.[guid]					=					src.[guid]
	,tgt.[is_backup]			=					src.[is_backup]
	,tgt.[is_load]				=					src.[is_load]
	,tgt.[local_protocol]		=					src.[local_protocol]
	,tgt.[name]					=		LTRIM(RTRIM(src.[name]					))
	,tgt.[parent_id]			=					src.[parent_id]
	,tgt.[password]				=					src.[password]
	,tgt.[sync_time]			=					src.[sync_time]
	,tgt.[user_id]				=					src.[user_id]
	,tgt.[username]				=					src.[username]
	,tgt.[is64bit]				=					src.[is64bit]
	,tgt.[speaker_id]			=					src.[speaker_id]
	,tgt.[client]				=					src.[client]
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_SLAVE tgt
INNER JOIN IntellectSTG.stg.OBJ_SLAVE AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_SLAVE as tgt
USING IntellectSTG.stg.OBJ_SLAVE AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[arch_days]
      ,				src.[connection]
      ,				src.[disable_protocol]
      ,				src.[display_id]
      ,				src.[drives]
      ,				src.[drives_a]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[is_backup]
      ,				src.[is_load]
      ,				src.[local_protocol]
      ,	LTRIM(RTRIM(src.[name]									))
      ,				src.[parent_id]
      ,				src.[password]
      ,				src.[sync_time]
      ,				src.[user_id]
      ,				src.[username]
      ,				src.[is64bit]
      ,				src.[speaker_id]
      ,				src.[client]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_SLAVE (
	 
       [arch_days]
      ,[connection]
      ,[disable_protocol]
      ,[display_id]
      ,[drives]
      ,[drives_a]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_backup]
      ,[is_load]
      ,[local_protocol]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[sync_time]
      ,[user_id]
      ,[username]
      ,[is64bit]
      ,[speaker_id]
      ,[client]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [arch_days]
      ,[connection]
      ,[disable_protocol]
      ,[display_id]
      ,[drives]
      ,[drives_a]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_backup]
      ,[is_load]
      ,[local_protocol]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[sync_time]
      ,[user_id]
      ,[username]
      ,[is64bit]
      ,[speaker_id]
      ,[client]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_SLAVE WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_RIGHTS_PERSON]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_RIGHTS_PERSON]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_RIGHTS_PERSON]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_RIGHTS_PERSON]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[change_first] [int] NULL,
	[change_last] [varchar](60) NULL,
	[change_months] [int] NULL,
	[change_user] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[login] [varchar](8000) NULL,
	[main_id] [varchar](60) NULL,
	[md5] [varchar](8000) NULL,
	[passwd] [varchar](60) NULL,
	[person] [varchar](60) NULL,
	[supervisor] [varchar](60) NULL,
	[windows] [varchar](255) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_RIGHTS_PERSON as tgt
USING IntellectSTG.stg.OBJ_RIGHTS_PERSON AS src	   
ON (tgt.main_id=src.main_id
	AND tgt.person=src.person)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [change_first]
      ,[change_last]
      ,[change_months]
      ,[change_user]
      ,[guid]
      ,[login]
      ,[main_id]
      ,[md5]
      ,[passwd]
      ,[person]
      ,[supervisor]
      ,[windows]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[change_first]
      ,				src.[change_last]
      ,				src.[change_months]
      ,				src.[change_user]
      ,				src.[guid]
      ,				src.[login]
      ,				src.[main_id]
      ,				src.[md5]
      ,				src.[passwd]
      ,				src.[person]
      ,				src.[supervisor]
      ,				src.[windows]
                     
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[change_first]		,'') <>							     ISNULL(src.[change_first]		,'')
		   OR ISNULL(tgt.[change_last]		,'') <>								 ISNULL(src.[change_last]		,'')
		   OR ISNULL(tgt.[change_months]	,'') <>								 ISNULL(src.[change_months]		,'')
		   OR ISNULL(tgt.[change_user]		,'') <>								 ISNULL(src.[change_user]		,'')
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>					 ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[login]			,'') <>	CONVERT(VARCHAR(8000),		 ISNULL(src.[login]				,''))		   
		   OR ISNULL(tgt.[md5]				,'') <>	CONVERT(VARCHAR(8000),		 ISNULL(src.[md5]				,''))
		   OR ISNULL(tgt.[passwd]			,'') <>								 ISNULL(src.[passwd]			,'')
		   OR ISNULL(tgt.[supervisor]		,'') <>								 ISNULL(src.[supervisor]		,'')
		   OR ISNULL(tgt.[windows]			,'') <>								 ISNULL(src.[windows]			,'')
		   		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[change_first]
      ,				src.[change_last]
      ,				src.[change_months]
      ,				src.[change_user]
      ,				src.[guid]
      ,				src.[login]
      ,				src.[main_id]
      ,				src.[md5]
      ,				src.[passwd]
      ,				src.[person]
      ,				src.[supervisor]
      ,				src.[windows]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_RIGHTS_PERSON (
	   [change_first]
      ,[change_last]
      ,[change_months]
      ,[change_user]
      ,[guid]
      ,[login]
      ,[main_id]
      ,[md5]
      ,[passwd]
      ,[person]
      ,[supervisor]
      ,[windows]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [change_first]
      ,[change_last]
      ,[change_months]
      ,[change_user]
      ,[guid]
      ,[login]
      ,[main_id]
      ,[md5]
      ,[passwd]
      ,[person]
      ,[supervisor]
      ,[windows]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.person is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[change_first]			=					 			src.[change_first]
	,tgt.[change_last]			=					 			src.[change_last]
	,tgt.[change_months]		=					 			src.[change_months]
	,tgt.[change_user]			=					 			src.[change_user]
	,tgt.[guid]					=					 			src.[guid]
	,tgt.[login]				=		  CONVERT(VARCHAR(8000),src.[login]				)	
	,tgt.[md5]					=		  CONVERT(VARCHAR(8000),src.[md5]				)
	,tgt.[passwd]				=					 			src.[passwd]
	,tgt.[supervisor]			=					 			src.[supervisor]
	,tgt.[windows]				=					 			src.[windows]
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_RIGHTS_PERSON tgt
INNER JOIN IntellectSTG.stg.OBJ_RIGHTS_PERSON AS src ON (tgt.main_id=src.main_id	
											AND tgt.person=src.person)
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_RIGHTS_PERSON as tgt
USING IntellectSTG.stg.OBJ_RIGHTS_PERSON AS src	   
ON (tgt.main_id=src.main_id
	AND tgt.person=src.person)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[change_first]
      ,				src.[change_last]
      ,				src.[change_months]
      ,				src.[change_user]
      ,				src.[guid]
      ,				src.[login]
      ,				src.[main_id]
      ,				src.[md5]
      ,				src.[passwd]
      ,				src.[person]
      ,				src.[supervisor]
      ,				src.[windows]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_RIGHTS_PERSON (
	 
       [change_first]
      ,[change_last]
      ,[change_months]
      ,[change_user]
      ,[guid]
      ,[login]
      ,[main_id]
      ,[md5]
      ,[passwd]
      ,[person]
      ,[supervisor]
      ,[windows]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [change_first]
      ,[change_last]
      ,[change_months]
      ,[change_user]
      ,[guid]
      ,[login]
      ,[main_id]
      ,[md5]
      ,[passwd]
      ,[person]
      ,[supervisor]
      ,[windows]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_RIGHTS_PERSON WHERE main_id=tmp.main_id	
																AND person=tmp.person
																AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_RIGHTS_OBJECT]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_RIGHTS_OBJECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_RIGHTS_OBJECT]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_RIGHTS_OBJECT]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](800) NULL,
	[level] [int] NULL,
	[main_id] [varchar](40) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_RIGHTS_OBJECT as tgt
USING IntellectSTG.stg.OBJ_RIGHTS_OBJECT AS src	   
ON (tgt.main_id = convert(varchar(40),src.main_id)
	AND tgt.id = convert(varchar(800),src.id))
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [guid]
      ,[id]
      ,[level]
      ,[main_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
								src.[guid]
      ,	convert(varchar(800),  src.[id]      )
      ,							src.[level]
      ,							src.[main_id]
                       
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			     ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>	ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1))
			  OR ISNULL(tgt.[level]	,'')						<>	ISNULL(src.[level]		,'') 
		   	   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  						src.[guid]
      ,	convert(varchar(800),  src.[id]      )
      ,							src.[level]
      ,							src.[main_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_RIGHTS_OBJECT (
	   [guid]
      ,[id]
      ,[level]
      ,[main_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [guid]
      ,[id]
      ,[level]
      ,[main_id]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[guid]		=		src.[guid]		
	,tgt.[level]	=		src.[level]	
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_RIGHTS_OBJECT tgt
INNER JOIN IntellectSTG.stg.OBJ_RIGHTS_OBJECT AS src ON (tgt.main_id = convert(varchar(40),src.main_id)
										AND tgt.id = convert(varchar(800),src.id))
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_RIGHTS_OBJECT as tgt
USING IntellectSTG.stg.OBJ_RIGHTS_OBJECT AS src	   
ON (tgt.main_id = convert(varchar(40),src.main_id)
	AND tgt.id = convert(varchar(800),src.id))
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  						src.[guid]
      ,	convert(varchar(800),  src.[id]      )
      ,							src.[level]
      ,							src.[main_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_RIGHTS_OBJECT (
	 
       [guid]
      ,[id]
      ,[level]
      ,[main_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [guid]
      ,[id]
      ,[level]
      ,[main_id]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_RIGHTS_OBJECT WHERE main_id = tmp.main_id
														  AND id = tmp.id 
														  AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_RIGHTS]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_RIGHTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_RIGHTS]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_RIGHTS]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[allow_arch_hours] [int] NULL,
	[allow_archop_hours] [int] NULL,
	[allow_config] [int] NULL,
	[allow_delete_files] [int] NULL,
	[ask_admin_pwd] [int] NULL,
	[ask_user_pwd] [int] NULL,
	[flags] [int] NULL,
	[forbid_hide] [int] NULL,
	[forbid_logoff] [int] NULL,
	[from_last_logon] [int] NULL,
	[from_last_logon_op] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[allow_export_files] [int] NULL,
	[allow_protect_files] [int] NULL,
	[allow_unprotect_files] [int] NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_RIGHTS as tgt
USING IntellectSTG.stg.OBJ_RIGHTS AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [allow_arch_hours]
      ,[allow_archop_hours]
      ,[allow_config]
      ,[allow_delete_files]
      ,[ask_admin_pwd]
      ,[ask_user_pwd]
      ,[flags]
      ,[forbid_hide]
      ,[forbid_logoff]
      ,[from_last_logon]
      ,[from_last_logon_op]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[allow_export_files]
      ,[allow_protect_files]
      ,[allow_unprotect_files]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[allow_arch_hours]
      ,				src.[allow_archop_hours]
      ,				src.[allow_config]
      ,				src.[allow_delete_files]
      ,				src.[ask_admin_pwd]
      ,				src.[ask_user_pwd]
      ,				src.[flags]
      ,				src.[forbid_hide]
      ,				src.[forbid_logoff]
      ,				src.[from_last_logon]
      ,				src.[from_last_logon_op]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]						))
      ,				src.[parent_id]
      ,				src.[allow_export_files]
      ,				src.[allow_protect_files]
      ,				src.[allow_unprotect_files]
      
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[allow_arch_hours]				,'') <>							     ISNULL(src.[allow_arch_hours]				,'')
		   OR ISNULL(tgt.[allow_archop_hours]			,'') <>								 ISNULL(src.[allow_archop_hours]			,'')
		   OR ISNULL(tgt.[allow_config]					,'') <>								 ISNULL(src.[allow_config]					,'')
		   OR ISNULL(tgt.[allow_delete_files]			,'') <>								 ISNULL(src.[allow_delete_files]			,'')
		   OR ISNULL(tgt.[ask_admin_pwd]				,'') <>								 ISNULL(src.[ask_admin_pwd]					,'')
		   OR ISNULL(tgt.[ask_user_pwd]					,'') <>								 ISNULL(src.[ask_user_pwd]					,'')
		   OR ISNULL(tgt.[flags]						,'') <>								 ISNULL(src.[flags]							,'')
		   OR ISNULL(tgt.[forbid_hide]					,'') <>								 ISNULL(src.[forbid_hide]					,'')
		   OR ISNULL(tgt.[forbid_logoff]				,'') <>								 ISNULL(src.[forbid_logoff]					,'')
		   OR ISNULL(tgt.[from_last_logon]				,'') <>								 ISNULL(src.[from_last_logon]				,'')
		   OR ISNULL(tgt.[from_last_logon_op]			,'') <>								 ISNULL(src.[from_last_logon_op]			,'')
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>								 ISNULL(src.[guid],  CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[name]							,'') <>					 LTRIM(RTRIM(ISNULL(src.[name]							,'')))
		   OR ISNULL(tgt.[parent_id]					,'') <>								 ISNULL(src.[parent_id]						,'')
		   OR ISNULL(tgt.[allow_export_files]			,'') <>								 ISNULL(src.[allow_export_files]			,'')
		   OR ISNULL(tgt.[allow_protect_files]			,'') <>								 ISNULL(src.[allow_protect_files]			,'')
		   OR ISNULL(tgt.[allow_unprotect_files]		,'') <>								 ISNULL(src.[allow_unprotect_files]			,'')
		   		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[allow_arch_hours]
      ,				src.[allow_archop_hours]
      ,				src.[allow_config]
      ,				src.[allow_delete_files]
      ,				src.[ask_admin_pwd]
      ,				src.[ask_user_pwd]
      ,				src.[flags]
      ,				src.[forbid_hide]
      ,				src.[forbid_logoff]
      ,				src.[from_last_logon]
      ,				src.[from_last_logon_op]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]						))
      ,				src.[parent_id]
      ,				src.[allow_export_files]
      ,				src.[allow_protect_files]
      ,				src.[allow_unprotect_files]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_RIGHTS (
	   [allow_arch_hours]
      ,[allow_archop_hours]
      ,[allow_config]
      ,[allow_delete_files]
      ,[ask_admin_pwd]
      ,[ask_user_pwd]
      ,[flags]
      ,[forbid_hide]
      ,[forbid_logoff]
      ,[from_last_logon]
      ,[from_last_logon_op]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[allow_export_files]
      ,[allow_protect_files]
      ,[allow_unprotect_files]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [allow_arch_hours]
      ,[allow_archop_hours]
      ,[allow_config]
      ,[allow_delete_files]
      ,[ask_admin_pwd]
      ,[ask_user_pwd]
      ,[flags]
      ,[forbid_hide]
      ,[forbid_logoff]
      ,[from_last_logon]
      ,[from_last_logon_op]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[allow_export_files]
      ,[allow_protect_files]
      ,[allow_unprotect_files]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[allow_arch_hours]				=				 			src.[allow_arch_hours]				
	,tgt.[allow_archop_hours]			=				 			src.[allow_archop_hours]			
	,tgt.[allow_config]					=				 			src.[allow_config]					
	,tgt.[allow_delete_files]			=				 			src.[allow_delete_files]			
	,tgt.[ask_admin_pwd]				=				 			src.[ask_admin_pwd]				
	,tgt.[ask_user_pwd]					=				 			src.[ask_user_pwd]					
	,tgt.[flags]						=				 			src.[flags]						
	,tgt.[forbid_hide]					=				 			src.[forbid_hide]					
	,tgt.[forbid_logoff]				=				 			src.[forbid_logoff]				
	,tgt.[from_last_logon]				=				 			src.[from_last_logon]				
	,tgt.[from_last_logon_op]			=				 			src.[from_last_logon_op]			
	,tgt.[guid]							=				 			src.[guid]							
	,tgt.[name]							=				LTRIM(RTRIM(src.[name]							))					
	,tgt.[parent_id]					=				 			src.[parent_id]					
	,tgt.[allow_export_files]			=				 			src.[allow_export_files]			
	,tgt.[allow_protect_files]			=				 			src.[allow_protect_files]			
	,tgt.[allow_unprotect_files]		=				 			src.[allow_unprotect_files]		
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_RIGHTS tgt
INNER JOIN IntellectSTG.stg.OBJ_RIGHTS AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_RIGHTS as tgt
USING IntellectSTG.stg.OBJ_RIGHTS AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[allow_arch_hours]
      ,				src.[allow_archop_hours]
      ,				src.[allow_config]
      ,				src.[allow_delete_files]
      ,				src.[ask_admin_pwd]
      ,				src.[ask_user_pwd]
      ,				src.[flags]
      ,				src.[forbid_hide]
      ,				src.[forbid_logoff]
      ,				src.[from_last_logon]
      ,				src.[from_last_logon_op]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]						))
      ,				src.[parent_id]
      ,				src.[allow_export_files]
      ,				src.[allow_protect_files]
      ,				src.[allow_unprotect_files]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_RIGHTS (
	 
       [allow_arch_hours]
      ,[allow_archop_hours]
      ,[allow_config]
      ,[allow_delete_files]
      ,[ask_admin_pwd]
      ,[ask_user_pwd]
      ,[flags]
      ,[forbid_hide]
      ,[forbid_logoff]
      ,[from_last_logon]
      ,[from_last_logon_op]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[allow_export_files]
      ,[allow_protect_files]
      ,[allow_unprotect_files]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [allow_arch_hours]
      ,[allow_archop_hours]
      ,[allow_config]
      ,[allow_delete_files]
      ,[ask_admin_pwd]
      ,[ask_user_pwd]
      ,[flags]
      ,[forbid_hide]
      ,[forbid_logoff]
      ,[from_last_logon]
      ,[from_last_logon_op]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[allow_export_files]
      ,[allow_protect_files]
      ,[allow_unprotect_files]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_RIGHTS WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_PHOTO_IDENT_BUT]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_PHOTO_IDENT_BUT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_PHOTO_IDENT_BUT]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_PHOTO_IDENT_BUT]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[button_name] [varchar](255) NULL,
	[color] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[line_id] [int] NULL,
	[main_id] [varchar](40) NULL,
	[obj_id] [varchar](40) NULL,
	[obj_react] [varchar](255) NULL,
	[obj_type] [varchar](255) NULL,
	[text] [varchar](255) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PHOTO_IDENT_BUTTONS as tgt
USING IntellectSTG.stg.OBJ_PHOTO_IDENT_BUTTONS AS src	   
ON	(tgt.main_id   = src.main_id
 AND tgt.line_id  = src.line_id
 AND tgt.button_name    = src.button_name)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [button_name]
      ,[color]
      ,[guid]
      ,[line_id]
      ,[main_id]
      ,[obj_id]
      ,[obj_react]
      ,[obj_type]
      ,[text]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
		LTRIM(RTRIM(src.[button_name]		))
      ,				src.[color]
      ,				src.[guid]
      ,				src.[line_id]
      ,				src.[main_id]
      ,				src.[obj_id]
      ,				src.[obj_react]
      ,				src.[obj_type]
      , LTRIM(RTRIM(src.[text]				)) 
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[color]								,'') <>								 ISNULL(src.[color]									,'')
		   OR ISNULL(tgt.[guid],		 CONVERT(VARBINARY(16),0,1)) <>								 ISNULL(src.[guid],			 CONVERT(VARBINARY(16),0,1))
		   OR ISNULL(tgt.[line_id]								,'') <>								 ISNULL(src.[line_id]								,'')
		   OR ISNULL(tgt.[obj_id]								,'') <>								 ISNULL(src.[obj_id]								,'')
		   OR ISNULL(tgt.[obj_react]							,'') <>								 ISNULL(src.[obj_react]								,'')
		   OR ISNULL(tgt.[obj_type]							    ,'') <>								 ISNULL(src.[obj_type]								,'')
		   OR ISNULL(tgt.[text]									,'') <>			LTRIM(RTRIM(		 ISNULL(src.[text]									,'')))
		  		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0

OUTPUT 
		LTRIM(RTRIM(src.[button_name]))
      ,				src.[color]
      ,				src.[guid]
      ,				src.[line_id]
      ,				src.[main_id]
      ,				src.[obj_id]
      ,				src.[obj_react]
      ,				src.[obj_type]
      , LTRIM(RTRIM(src.[text]))
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PHOTO_IDENT_BUTTONS (
	   [button_name]
      ,[color]
      ,[guid]
      ,[line_id]
      ,[main_id]
      ,[obj_id]
      ,[obj_react]
      ,[obj_type]
      ,[text]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [button_name]
      ,[color]
      ,[guid]
      ,[line_id]
      ,[main_id]
      ,[obj_id]
      ,[obj_react]
      ,[obj_type]
      ,[text]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.main_id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[color]	 =					src.[color]									
	,tgt.[guid]      =					src.[guid]
	,tgt.[line_id]   =					src.[line_id]
	,tgt.[obj_id]    =					src.[obj_id]
	,tgt.[obj_react] =					src.[obj_react]
	,tgt.[obj_type]  =					src.[obj_type]
	,tgt.[text]	     =		LTRIM(RTRIM(src.[text]						))		
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PHOTO_IDENT_BUTTONS tgt
INNER JOIN IntellectSTG.stg.OBJ_PHOTO_IDENT_BUTTONS AS src ON (tgt.main_id   = src.main_id
												AND tgt.line_id  = src.line_id
												AND tgt.button_name    = src.button_name)
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PHOTO_IDENT_BUTTONS as tgt
USING IntellectSTG.stg.OBJ_PHOTO_IDENT_BUTTONS AS src	   
ON (tgt.main_id   = src.main_id
 AND tgt.line_id  = src.line_id
 AND tgt.button_name    = src.button_name)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		LTRIM(RTRIM(src.[button_name]   ))
      ,				src.[color]
      ,				src.[guid]
      ,				src.[line_id]
      ,				src.[main_id]
      ,				src.[obj_id]
      ,				src.[obj_react]
      ,				src.[obj_type]
      , LTRIM(RTRIM(src.[text]			))
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PHOTO_IDENT_BUTTONS (
	 
       [button_name]
      ,[color]
      ,[guid]
      ,[line_id]
      ,[main_id]
      ,[obj_id]
      ,[obj_react]
      ,[obj_type]
      ,[text]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [button_name]
      ,[color]
      ,[guid]
      ,[line_id]
      ,[main_id]
      ,[obj_id]
      ,[obj_react]
      ,[obj_type]
      ,[text]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PHOTO_IDENT_BUTTONS WHERE main_id   = tmp.main_id
																 AND line_id  = tmp.line_id
																AND button_name    = tmp.button_name
																AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_PHOTO_IDENT]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_PHOTO_IDENT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_PHOTO_IDENT]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_PHOTO_IDENT]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[archive_max] [int] NULL,
	[fixed_layout] [int] NULL,
	[flags] [int] NULL,
	[focus_on_event] [int] NULL,
	[grid_columns] [varchar](8000) NULL,
	[guid] [uniqueidentifier] NULL,
	[h] [int] NULL,
	[id] [varchar](40) NULL,
	[lines_count] [int] NULL,
	[name] [varchar](60) NULL,
	[num_last_event] [int] NULL,
	[parent_id] [varchar](40) NULL,
	[protocol_event] [int] NULL,
	[remove_events] [int] NULL,
	[show_on_event] [int] NULL,
	[show_time] [int] NULL,
	[w] [int] NULL,
	[x] [int] NULL,
	[y] [int] NULL,
	[event_expire] [int] NULL,
	[monitor] [int] NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PHOTO_IDENT as tgt
USING IntellectSTG.stg.OBJ_PHOTO_IDENT AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [archive_max]
      ,[fixed_layout]
      ,[flags]
      ,[focus_on_event]
      ,[grid_columns]
      ,[guid]
      ,[h]
      ,[id]
      ,[lines_count]
      ,[name]
      ,[num_last_event]
      ,[parent_id]
      ,[protocol_event]
      ,[remove_events]
      ,[show_on_event]
      ,[show_time]
      ,[w]
      ,[x]
      ,[y]
      ,[event_expire]
      ,[monitor]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
								src.[archive_max]
      ,							src.[fixed_layout]
      ,							src.[flags]
      ,							src.[focus_on_event]
      ,	CONVERT(VARCHAR(8000),	src.[grid_columns]				)
      ,							src.[guid]
      ,							src.[h]
      ,							src.[id]
      ,							src.[lines_count]
      , LTRIM(RTRIM(			src.[name]						))
      ,							src.[num_last_event]
      ,							src.[parent_id]
      ,							src.[protocol_event]
      ,							src.[remove_events]
      ,							src.[show_on_event]
      ,							src.[show_time]
      ,							src.[w]
      ,							src.[x]
      ,							src.[y]
      ,							src.[event_expire]
      ,							src.[monitor]
     
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[archive_max]				,'') <>							     ISNULL(src.[archive_max]				,'')
		   OR ISNULL(tgt.[fixed_layout]				,'') <>								 ISNULL(src.[fixed_layout]				,'')
		   OR ISNULL(tgt.[flags]					,'') <>								 ISNULL(src.[flags]						,'')
		   OR ISNULL(tgt.[focus_on_event]			,'') <>								 ISNULL(src.[focus_on_event]			,'')
		   OR ISNULL(tgt.[grid_columns]				,'') <>		CONVERT(VARCHAR(8000),	 ISNULL(src.[grid_columns]				,''))
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>							 ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[h]						,'') <>								 ISNULL(src.[h]							,'')
		   OR ISNULL(tgt.[lines_count]				,'') <>								 ISNULL(src.[lines_count]				,'')
		   OR ISNULL(tgt.[name]						,'') <>			LTRIM(RTRIM(		 ISNULL(src.[name]						,'')))
		   OR ISNULL(tgt.[num_last_event]			,'') <>								 ISNULL(src.[num_last_event]			,'')
		   OR ISNULL(tgt.[parent_id]				,'') <>								 ISNULL(src.[parent_id]					,'')
		   OR ISNULL(tgt.[protocol_event]			,'') <>								 ISNULL(src.[protocol_event]			,'')
		   OR ISNULL(tgt.[remove_events]			,'') <>								 ISNULL(src.[remove_events]				,'')
		   OR ISNULL(tgt.[show_on_event]			,'') <>								 ISNULL(src.[show_on_event]				,'')
		   OR ISNULL(tgt.[show_time]				,'') <>								 ISNULL(src.[show_time]					,'')
		   OR ISNULL(tgt.[w]						,'') <>								 ISNULL(src.[w]							,'')
		   OR ISNULL(tgt.[x]						,'') <>								 ISNULL(src.[x]							,'')
		   OR ISNULL(tgt.[y]						,'') <>								 ISNULL(src.[y]							,'')
		   OR ISNULL(tgt.[event_expire]				,'') <>								 ISNULL(src.[event_expire]				,'')
		   OR ISNULL(tgt.[monitor]					,'') <>								 ISNULL(src.[monitor]					,'')
		  		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  						src.[archive_max]
      ,							src.[fixed_layout]
      ,							src.[flags]
      ,							src.[focus_on_event]
      ,	CONVERT(VARCHAR(8000),	src.[grid_columns]				)
      ,							src.[guid]
      ,							src.[h]
      ,							src.[id]
      ,							src.[lines_count]
      , LTRIM(RTRIM(			src.[name]						))
      ,							src.[num_last_event]
      ,							src.[parent_id]
      ,							src.[protocol_event]
      ,							src.[remove_events]
      ,							src.[show_on_event]
      ,							src.[show_time]
      ,							src.[w]
      ,							src.[x]
      ,							src.[y]
      ,							src.[event_expire]
      ,							src.[monitor]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PHOTO_IDENT (
	   [archive_max]
      ,[fixed_layout]
      ,[flags]
      ,[focus_on_event]
      ,[grid_columns]
      ,[guid]
      ,[h]
      ,[id]
      ,[lines_count]
      ,[name]
      ,[num_last_event]
      ,[parent_id]
      ,[protocol_event]
      ,[remove_events]
      ,[show_on_event]
      ,[show_time]
      ,[w]
      ,[x]
      ,[y]
      ,[event_expire]
      ,[monitor]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [archive_max]
      ,[fixed_layout]
      ,[flags]
      ,[focus_on_event]
      ,[grid_columns]
      ,[guid]
      ,[h]
      ,[id]
      ,[lines_count]
      ,[name]
      ,[num_last_event]
      ,[parent_id]
      ,[protocol_event]
      ,[remove_events]
      ,[show_on_event]
      ,[show_time]
      ,[w]
      ,[x]
      ,[y]
      ,[event_expire]
      ,[monitor]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[archive_max]			=					 			src.[archive_max]			
	,tgt.[fixed_layout]			=					 			src.[fixed_layout]			
	,tgt.[flags]				=					 			src.[flags]				
	,tgt.[focus_on_event]		=					 			src.[focus_on_event]		
	,tgt.[grid_columns]			=		CONVERT(VARCHAR(8000),	src.[grid_columns]			)	
	,tgt.[guid]					=					 			src.[guid]					
	,tgt.[h]					=					 			src.[h]					
	,tgt.[lines_count]			=					 			src.[lines_count]			
	,tgt.[name]					=		LTRIM(RTRIM(			src.[name]					))	
	,tgt.[num_last_event]		=					 			src.[num_last_event]		
	,tgt.[parent_id]			=					 			src.[parent_id]			
	,tgt.[protocol_event]		=					 			src.[protocol_event]		
	,tgt.[remove_events]		=					 			src.[remove_events]		
	,tgt.[show_on_event]		=					 			src.[show_on_event]		
	,tgt.[show_time]			=					 			src.[show_time]			
	,tgt.[w]					=					 			src.[w]					
	,tgt.[x]					=					 			src.[x]					
	,tgt.[y]					=					 			src.[y]					
	,tgt.[event_expire]			=					 			src.[event_expire]			
	,tgt.[monitor]				=								src.[monitor]						
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PHOTO_IDENT tgt
INNER JOIN IntellectSTG.stg.OBJ_PHOTO_IDENT AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PHOTO_IDENT as tgt
USING IntellectSTG.stg.OBJ_PHOTO_IDENT AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[archive_max]
      ,							src.[fixed_layout]
      ,							src.[flags]
      ,							src.[focus_on_event]
      ,	CONVERT(VARCHAR(8000),	src.[grid_columns]				)
      ,							src.[guid]
      ,							src.[h]
      ,							src.[id]
      ,							src.[lines_count]
      , LTRIM(RTRIM(			src.[name]						))
      ,							src.[num_last_event]
      ,							src.[parent_id]
      ,							src.[protocol_event]
      ,							src.[remove_events]
      ,							src.[show_on_event]
      ,							src.[show_time]
      ,							src.[w]
      ,							src.[x]
      ,							src.[y]
      ,							src.[event_expire]
      ,							src.[monitor]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PHOTO_IDENT (
	 
       [archive_max]
      ,[fixed_layout]
      ,[flags]
      ,[focus_on_event]
      ,[grid_columns]
      ,[guid]
      ,[h]
      ,[id]
      ,[lines_count]
      ,[name]
      ,[num_last_event]
      ,[parent_id]
      ,[protocol_event]
      ,[remove_events]
      ,[show_on_event]
      ,[show_time]
      ,[w]
      ,[x]
      ,[y]
      ,[event_expire]
      ,[monitor]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [archive_max]
      ,[fixed_layout]
      ,[flags]
      ,[focus_on_event]
      ,[grid_columns]
      ,[guid]
      ,[h]
      ,[id]
      ,[lines_count]
      ,[name]
      ,[num_last_event]
      ,[parent_id]
      ,[protocol_event]
      ,[remove_events]
      ,[show_on_event]
      ,[show_time]
      ,[w]
      ,[x]
      ,[y]
      ,[event_expire]
      ,[monitor]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PHOTO_IDENT WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_PERSON]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_PERSON]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_PERSON]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_PERSON]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	--[area_id] [varchar](40) NULL,
	[auto_brand] [varchar](32) NULL,
	[auto_number] [varchar](32) NULL,
	[begin_temp_level] [varchar](25) NULL,
	[card] [varchar](255) NULL,
	[card_date] [varchar](25) NULL,
	[card_loss] [int] NULL,
	[comment] [varchar](8000) NULL,
	[drivers_licence] [varchar](120) NULL,
	[end_temp_level] [varchar](25) NULL,
	[expired] [varchar](25) NULL,
	[external_id] [varchar](40) NULL,
	[facility_code] [varchar](255) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[is_active_temp_level] [smallint] NULL,
	[is_apb] [smallint] NULL,
	[is_locked] [smallint] NULL,
	[level_id] [varchar](8000) NULL,
	[levels_times] [varchar](8000) NULL,
	[name] [varchar](255) NULL,
	[parent_id] [varchar](40) NULL,
	[passport] [varchar](120) NULL,
	[patronymic] [varchar](255) NULL,
	[phone] [varchar](60) NULL,
	[pin] [varchar](255) NULL,
	[post] [varchar](255) NULL,
	[pur] [int] NULL,
	[schedule_id] [varchar](40) NULL,
	[started_at] [datetime] NULL,
	[surname] [varchar](255) NULL,
	[tabnum] [varchar](60) NULL,
	[temp_card] [varchar](15) NULL,
	[temp_level_id] [varchar](8000) NULL,
	[temp_levels_times] [varchar](8000) NULL,
	--[when_area_id_changed] [datetime] NULL,
	[who_card] [varchar](60) NULL,
	[who_level] [varchar](60) NULL,
	[pnet3_alarm] [bit] NULL,
	[pnet3_block] [bit] NULL,
	[pnet3_guard] [bit] NULL,
	[pnet3_guest] [bit] NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PERSON as tgt
USING IntellectSTG.stg.OBJ_PERSON AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       --[area_id]
      [auto_brand]
      ,[auto_number]
      ,[begin_temp_level]
      ,[card]
      ,[card_date]
      ,[card_loss]
      ,[comment]
      ,[drivers_licence]
      ,[end_temp_level]
      ,[expired]
      ,[external_id]
      ,[facility_code]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_active_temp_level]
      ,[is_apb]
      ,[is_locked]
      ,[level_id]
      ,[levels_times]
      ,[name]
      ,[parent_id]
      ,[passport]
      ,[patronymic]
      ,[phone]
      ,[pin]
      ,[post]
      ,[pur]
      ,[schedule_id]
      ,[started_at]
      ,[surname]
      ,[tabnum]
      ,[temp_card]
      ,[temp_level_id]
      ,[temp_levels_times]
      --,[when_area_id_changed]
      ,[who_card]
      ,[who_level]
      ,[pnet3_alarm]
      ,[pnet3_block]
      ,[pnet3_guard]
      ,[pnet3_guest]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					--src.[area_id]
      				src.[auto_brand]
      ,				src.[auto_number]
      ,				src.[begin_temp_level]
      ,				src.[card]
      ,				src.[card_date]
      ,				src.[card_loss]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[comment])))
      ,				src.[drivers_licence]
      ,				src.[end_temp_level]
      ,				src.[expired]
      ,				src.[external_id]
      ,				src.[facility_code]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[is_active_temp_level]
      ,				src.[is_apb]
      ,				src.[is_locked]
      ,				src.[level_id]
      ,				src.[levels_times]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[passport]
      ,	LTRIM(RTRIM(src.[patronymic]								))
      ,				src.[phone]
      ,				src.[pin]
      ,	LTRIM(RTRIM(src.[post]										))
      ,				src.[pur]
      ,				src.[schedule_id]
      ,				src.[started_at]
      ,	LTRIM(RTRIM(src.[surname]									))
      ,				src.[tabnum]
      ,				src.[temp_card]
      ,				src.[temp_level_id]
      ,				src.[temp_levels_times]
      --,				src.[when_area_id_changed]
      ,				src.[who_card]
      ,				src.[who_level]
      ,				src.[pnet3_alarm]
      ,				src.[pnet3_block]
      ,				src.[pnet3_guard]
      ,				src.[pnet3_guest]
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, строка не является inferred и строка не является новой записью, т.е. данные обновились
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1  --AND tgt.is_deleted <> 1
		 AND (
			  --ISNULL(tgt.[area_id]					,'') <>							     ISNULL(src.[area_id]					,'') 
		      ISNULL(tgt.[auto_brand]				,'') <>								 ISNULL(src.[auto_brand]				,'') 
		   OR ISNULL(tgt.[auto_number]				,'') <>								 ISNULL(src.[auto_number]				,'') 
		   OR ISNULL(tgt.[begin_temp_level]			,'') <>								 ISNULL(src.[begin_temp_level]			,'') 
		   OR ISNULL(tgt.[card]						,'') <>								 ISNULL(src.[card]						,'') 
		   --OR ISNULL(tgt.[card_date]				,'') <>								 ISNULL(src.[card_date]					,'') 
		   OR ISNULL(tgt.[card_loss]				,'') <>								 ISNULL(src.[card_loss]					,'') 
		   OR ISNULL(tgt.[comment]					,'') <>	LTRIM(RTRIM(CONVERT(VARCHAR(8000),		 ISNULL(src.[comment]					,'')))) 
		   OR ISNULL(tgt.[drivers_licence]			,'') <>								 ISNULL(src.[drivers_licence]			,'') 
		   OR ISNULL(tgt.[end_temp_level]			,'') <>								 ISNULL(src.[end_temp_level]			,'') 
		   OR ISNULL(tgt.[expired]					,'') <>								 ISNULL(src.[expired]					,'') 
		   OR ISNULL(tgt.[external_id]				,'') <>								 ISNULL(src.[external_id]				,'') 
		   OR ISNULL(tgt.[facility_code]			,'') <>								 ISNULL(src.[facility_code]				,'') 
		   OR ISNULL(tgt.[flags]					,'') <>								 ISNULL(src.[flags]						,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))<>							 ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[is_active_temp_level]		,'') <>								 ISNULL(src.[is_active_temp_level]		,'') 
		   OR ISNULL(tgt.[is_apb]					,'') <>								 ISNULL(src.[is_apb]					,'') 
		   OR ISNULL(tgt.[is_locked]				,'') <>								 ISNULL(src.[is_locked]					,'') 
		   OR ISNULL(tgt.[level_id]					,'') <>	CONVERT(VARCHAR(8000),		 ISNULL(src.[level_id]					,'')) 
		   OR ISNULL(tgt.[levels_times]				,'') <>	CONVERT(VARCHAR(8000),		 ISNULL(src.[levels_times]				,'')) 
		   OR ISNULL(tgt.[name]						,'') <>	LTRIM(RTRIM(				 ISNULL(src.[name]						,''))) 
		   OR ISNULL(tgt.[parent_id]				,'') <>								 ISNULL(src.[parent_id]					,'') 
		   OR ISNULL(tgt.[passport]					,'') <>								 ISNULL(src.[passport]					,'') 
		   OR ISNULL(tgt.[patronymic]				,'') <> LTRIM(RTRIM(				 ISNULL(src.[patronymic]				,''))) 
		   OR ISNULL(tgt.[phone]					,'') <>								 ISNULL(src.[phone]						,'') 
		   OR ISNULL(tgt.[pin]						,'') <>								 ISNULL(src.[pin]						,'') 
		   OR ISNULL(tgt.[post]						,'') <>	LTRIM(RTRIM(				 ISNULL(src.[post]						,''))) 
		   OR ISNULL(tgt.[pur]						,'') <>								 ISNULL(src.[pur]						,'') 
		   OR ISNULL(tgt.[schedule_id]				,'') <>								 ISNULL(src.[schedule_id]				,'') 
		   OR ISNULL(tgt.[started_at]				,'') <>								 ISNULL(src.[started_at]				,'') 
		   OR ISNULL(tgt.[surname]					,'') <> LTRIM(RTRIM(				 ISNULL(src.[surname]					,''))) 
		   OR ISNULL(tgt.[tabnum]					,'') <>								 ISNULL(src.[tabnum]					,'') 
		   OR ISNULL(tgt.[temp_card]				,'') <>								 ISNULL(src.[temp_card]					,'') 
		   OR ISNULL(tgt.[temp_level_id]			,'') <>	convert(varchar(8000),		 ISNULL(src.[temp_level_id]				,'')) 
		   OR ISNULL(tgt.[temp_levels_times]		,'') <>	convert(varchar(8000),		 ISNULL(src.[temp_levels_times]			,'')) 
		  -- OR ISNULL(tgt.[when_area_id_changed]		,'') <>								 ISNULL(src.[when_area_id_changed]		,'') 
		  -- OR ISNULL(tgt.[who_card]					,'') <>								 ISNULL(src.[who_card]					,'') 
		  -- OR ISNULL(tgt.[who_level]				,'') <>								 ISNULL(src.[who_level]					,'') 
		   OR ISNULL(tgt.[pnet3_alarm]				,'') <>								 ISNULL(src.[pnet3_alarm]				,'') 
		   OR ISNULL(tgt.[pnet3_block]				,'') <>								 ISNULL(src.[pnet3_block]				,'') 
		   OR ISNULL(tgt.[pnet3_guard]				,'') <>								 ISNULL(src.[pnet3_guard]				,'') 
		   OR ISNULL(tgt.[pnet3_guest]				,'') <>								 ISNULL(src.[pnet3_guest]				,'')
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time 
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1
OUTPUT 
		  			--src.[area_id]
      				src.[auto_brand]
      ,				src.[auto_number]
      ,				src.[begin_temp_level]
      ,				src.[card]
      ,				src.[card_date]
      ,				src.[card_loss]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[comment]						)))
      ,				src.[drivers_licence]
      ,				src.[end_temp_level]
      ,				src.[expired]
      ,				src.[external_id]
      ,				src.[facility_code]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[is_active_temp_level]
      ,				src.[is_apb]
      ,				src.[is_locked]
      ,				src.[level_id]
      ,				src.[levels_times]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[passport]
      ,	LTRIM(RTRIM(src.[patronymic]								))
      ,				src.[phone]
      ,				src.[pin]
      ,	LTRIM(RTRIM(src.[post]										))
      ,				src.[pur]
      ,				src.[schedule_id]
      ,				src.[started_at]
      ,	LTRIM(RTRIM(src.[surname]									))
      ,				src.[tabnum]
      ,				src.[temp_card]
      ,				src.[temp_level_id]
      ,				src.[temp_levels_times]
     -- ,				src.[when_area_id_changed]
      ,				src.[who_card]
      ,				src.[who_level]
      ,				src.[pnet3_alarm]
      ,				src.[pnet3_block]
      ,				src.[pnet3_guard]
      ,				src.[pnet3_guest]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PERSON (
	   --[area_id]
       [auto_brand]
      ,[auto_number]
      ,[begin_temp_level]
      ,[card]
      ,[card_date]
      ,[card_loss]
      ,[comment]
      ,[drivers_licence]
      ,[end_temp_level]
      ,[expired]
      ,[external_id]
      ,[facility_code]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_active_temp_level]
      ,[is_apb]
      ,[is_locked]
      ,[level_id]
      ,[levels_times]
      ,[name]
      ,[parent_id]
      ,[passport]
      ,[patronymic]
      ,[phone]
      ,[pin]
      ,[post]
      ,[pur]
      ,[schedule_id]
      ,[started_at]
      ,[surname]
      ,[tabnum]
      ,[temp_card]
      ,[temp_level_id]
      ,[temp_levels_times]
      --,[when_area_id_changed]
      ,[who_card]
      ,[who_level]
      ,[pnet3_alarm]
      ,[pnet3_block]
      ,[pnet3_guard]
      ,[pnet3_guest]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   --[area_id]
      [auto_brand]
      ,[auto_number]
      ,[begin_temp_level]
      ,[card]
      ,[card_date]
      ,[card_loss]
      ,[comment]
      ,[drivers_licence]
      ,[end_temp_level]
      ,[expired]
      ,[external_id]
      ,[facility_code]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_active_temp_level]
      ,[is_apb]
      ,[is_locked]
      ,[level_id]
      ,[levels_times]
      ,[name]
      ,[parent_id]
      ,[passport]
      ,[patronymic]
      ,[phone]
      ,[pin]
      ,[post]
      ,[pur]
      ,[schedule_id]
      ,[started_at]
      ,[surname]
      ,[tabnum]
      ,[temp_card]
      ,[temp_level_id]
      ,[temp_levels_times]
      --,[when_area_id_changed]
      ,[who_card]
      ,[who_level]
      ,[pnet3_alarm]
      ,[pnet3_block]
      ,[pnet3_guard]
      ,[pnet3_guest]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 --tgt.[area_id]							=					 			src.[area_id]
	tgt.[auto_brand]						=					 			src.[auto_brand]
	,tgt.[auto_number]						=					 			src.[auto_number]
	,tgt.[begin_temp_level]					=					 			src.[begin_temp_level]
	,tgt.[card]								=					 			src.[card]
	,tgt.[card_date]						=					 			src.[card_date]
	,tgt.[card_loss]						=					 			src.[card_loss]
	,tgt.[comment]							=	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[comment]								)))
	,tgt.[drivers_licence]					=					 			src.[drivers_licence]
	,tgt.[end_temp_level]					=					 			src.[end_temp_level]
	,tgt.[expired]							=					 			src.[expired]
	,tgt.[external_id]						=					 			src.[external_id]
	,tgt.[facility_code]					=					 			src.[facility_code]
	,tgt.[flags]							=					 			src.[flags]
	,tgt.[guid]								=					 			src.[guid]
	,tgt.[is_active_temp_level]				=					 			src.[is_active_temp_level]
	,tgt.[is_apb]							=					 			src.[is_apb]
	,tgt.[is_locked]						=					 			src.[is_locked]
	,tgt.[level_id]							=					 			src.[level_id]
	,tgt.[levels_times]						=					 			src.[levels_times]
	,tgt.[name]								=					LTRIM(RTRIM(src.[name]										))
	,tgt.[parent_id]						=					 			src.[parent_id]
	,tgt.[passport]							=					 			src.[passport]
	,tgt.[patronymic]						=					LTRIM(RTRIM(src.[patronymic]								))
	,tgt.[phone]							=					 			src.[phone]
	,tgt.[pin]								=					 			src.[pin]
	,tgt.[post]								=				    LTRIM(RTRIM(src.[post]										))
	,tgt.[pur]								=					 			src.[pur]
	,tgt.[schedule_id]						=					 			src.[schedule_id]
	,tgt.[started_at]						=					 			src.[started_at]
	,tgt.[surname]							=					LTRIM(RTRIM(src.[surname]									))
	,tgt.[tabnum]							=					 			src.[tabnum]
	,tgt.[temp_card]						=					 			src.[temp_card]
	,tgt.[temp_level_id]					=					 			src.[temp_level_id]
	,tgt.[temp_levels_times]				=					 			src.[temp_levels_times]
	--,tgt.[when_area_id_changed]				=					 			src.[when_area_id_changed]
	,tgt.[who_card]							=					 			src.[who_card]
	,tgt.[who_level]						=					 			src.[who_level]
	,tgt.[pnet3_alarm]						=					 			src.[pnet3_alarm]
	,tgt.[pnet3_block]						=					 			src.[pnet3_block]
	,tgt.[pnet3_guard]						=					 			src.[pnet3_guard]
	,tgt.[pnet3_guest]						=					 			src.[pnet3_guest]
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PERSON tgt
INNER JOIN IntellectSTG.stg.OBJ_PERSON AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PERSON as tgt
USING IntellectSTG.stg.OBJ_PERSON AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  			--src.[area_id]
      				src.[auto_brand]
      ,				src.[auto_number]
      ,				src.[begin_temp_level]
      ,				src.[card]
      ,				src.[card_date]
      ,				src.[card_loss]
      , LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[comment]								)))
      ,				src.[drivers_licence]
      ,				src.[end_temp_level]
      ,				src.[expired]
      ,				src.[external_id]
      ,				src.[facility_code]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[is_active_temp_level]
      ,				src.[is_apb]
      ,				src.[is_locked]
      ,				src.[level_id]
      ,				src.[levels_times]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[passport]
      ,	LTRIM(RTRIM(src.[patronymic]								))
      ,				src.[phone]
      ,				src.[pin]
      ,	LTRIM(RTRIM(src.[post]										))
      ,				src.[pur]
      ,				src.[schedule_id]
      ,				src.[started_at]
      ,	LTRIM(RTRIM(src.[surname]									))
      ,				src.[tabnum]
      ,				src.[temp_card]
      ,				src.[temp_level_id]
      ,				src.[temp_levels_times]
      --,				src.[when_area_id_changed]
      ,				src.[who_card]
      ,				src.[who_level]
      ,				src.[pnet3_alarm]
      ,				src.[pnet3_block]
      ,				src.[pnet3_guard]
      ,				src.[pnet3_guest]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PERSON (
	  -- [area_id]
      [auto_brand]
      ,[auto_number]
      ,[begin_temp_level]
      ,[card]
      ,[card_date]
      ,[card_loss]
      ,[comment]
      ,[drivers_licence]
      ,[end_temp_level]
      ,[expired]
      ,[external_id]
      ,[facility_code]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_active_temp_level]
      ,[is_apb]
      ,[is_locked]
      ,[level_id]
      ,[levels_times]
      ,[name]
      ,[parent_id]
      ,[passport]
      ,[patronymic]
      ,[phone]
      ,[pin]
      ,[post]
      ,[pur]
      ,[schedule_id]
      ,[started_at]
      ,[surname]
      ,[tabnum]
      ,[temp_card]
      ,[temp_level_id]
      ,[temp_levels_times]
      --,[when_area_id_changed]
      ,[who_card]
      ,[who_level]
      ,[pnet3_alarm]
      ,[pnet3_block]
      ,[pnet3_guard]
      ,[pnet3_guest]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   --[area_id]
      [auto_brand]
      ,[auto_number]
      ,[begin_temp_level]
      ,[card]
      ,[card_date]
      ,[card_loss]
      ,[comment]
      ,[drivers_licence]
      ,[end_temp_level]
      ,[expired]
      ,[external_id]
      ,[facility_code]
      ,[flags]
      ,[guid]
      ,[id]
      ,[is_active_temp_level]
      ,[is_apb]
      ,[is_locked]
      ,[level_id]
      ,[levels_times]
      ,[name]
      ,[parent_id]
      ,[passport]
      ,[patronymic]
      ,[phone]
      ,[pin]
      ,[post]
      ,[pur]
      ,[schedule_id]
      ,[started_at]
      ,[surname]
      ,[tabnum]
      ,[temp_card]
      ,[temp_level_id]
      ,[temp_levels_times]
     -- ,[when_area_id_changed]
      ,[who_card]
      ,[who_level]
      ,[pnet3_alarm]
      ,[pnet3_block]
      ,[pnet3_guard]
      ,[pnet3_guest]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PERSON WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_NC32K]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_NC32K]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_NC32K]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_NC32K]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[alarm_time] [int] NULL,
	[channel_com] [varchar](60) NULL,
	[channel_com_type] [varchar](60) NULL,
	[channel_ip] [varchar](60) NULL,
	[com_addr] [int] NULL,
	[door_time] [int] NULL,
	[ex1_opt] [int] NULL,
	[ex2_opt] [int] NULL,
	[exit_time] [int] NULL,
	[external_ip] [varchar](15) NULL,
	[global_apb] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hardware_opt] [int] NULL,
	[id] [varchar](60) NULL,
	[interface] [int] NULL,
	[lock_time] [int] NULL,
	[mode_opt] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](60) NULL,
	[region_id] [varchar](60) NULL,
	[region_in] [varchar](60) NULL,
	[region_out] [varchar](60) NULL,
	[relay_delay_time] [int] NULL,
	[relay_opt] [int] NULL,
	[relay_time] [int] NULL,
	[flags] [int] NULL,

	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PNET3_NC32K as tgt
USING IntellectSTG.stg.OBJ_PNET3_NC32K AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
	   [alarm_time]
      ,[channel_com]
      ,[channel_com_type]
      ,[channel_ip]
      ,[com_addr]
      ,[door_time]
      ,[ex1_opt]
      ,[ex2_opt]
      ,[exit_time]
      ,[external_ip]
      ,[global_apb]
      ,[guid]
      ,[hardware_opt]
      ,[id]
      ,[interface]
      ,[lock_time]
      ,[mode_opt]
      ,[name]
      ,[parent_id]
      ,[region_id]
      ,[region_in]
      ,[region_out]
      ,[relay_delay_time]
      ,[relay_opt]
      ,[relay_time]
      ,[flags]
      
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
						src.[alarm_time]
      ,					src.[channel_com]
      ,					src.[channel_com_type]
      ,					src.[channel_ip]
      ,					src.[com_addr]
      ,					src.[door_time]
      ,					src.[ex1_opt]
      ,					src.[ex2_opt]
      ,					src.[exit_time]
      ,					src.[external_ip]
      ,					src.[global_apb]
      ,					src.[guid]
      ,					src.[hardware_opt]
      ,					src.[id]
      ,					src.[interface]
      ,					src.[lock_time]
      ,					src.[mode_opt]
      ,	LTRIM(RTRIM	   (src.[name]							))
      ,					src.[parent_id]
      ,					src.[region_id]
      ,					src.[region_in]
      ,					src.[region_out]
      ,					src.[relay_delay_time]
      ,					src.[relay_opt]
      ,					src.[relay_time]
      ,					src.[flags]
      
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (ISNULL(tgt.[alarm_time]			,'') <> 							ISNULL(src.[alarm_time]			,'')
		   OR ISNULL(tgt.[channel_com]			,'') <> 							ISNULL(src.[channel_com]		,'')
		   OR ISNULL(tgt.[channel_com_type]		,'') <> 							ISNULL(src.[channel_com_type]	,'')
		   OR ISNULL(tgt.[channel_ip]			,'') <> 							ISNULL(src.[channel_ip]			,'')
		   OR ISNULL(tgt.[com_addr]				,'') <> 							ISNULL(src.[com_addr]			,'')
		   OR ISNULL(tgt.[door_time]			,'') <> 							ISNULL(src.[door_time]			,'')
		   OR ISNULL(tgt.[ex1_opt]				,'') <> 							ISNULL(src.[ex1_opt]			,'')
		   OR ISNULL(tgt.[ex2_opt]				,'') <> 							ISNULL(src.[ex2_opt]			,'')
		   OR ISNULL(tgt.[exit_time]			,'') <> 							ISNULL(src.[exit_time]			,'')
		   OR ISNULL(tgt.[external_ip]			,'') <> 							ISNULL(src.[external_ip]		,'')
		   OR ISNULL(tgt.[global_apb]			,'') <> 							ISNULL(src.[global_apb]			,'')
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1))<> 					    ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1))
		   OR ISNULL(tgt.[hardware_opt]			,'') <> 							ISNULL(src.[hardware_opt]		,'')
		   OR ISNULL(tgt.[id]					,'') <> 							ISNULL(src.[id]					,'')
		   OR ISNULL(tgt.[interface]			,'') <> 							ISNULL(src.[interface]			,'')
		   OR ISNULL(tgt.[lock_time]			,'') <> 							ISNULL(src.[lock_time]			,'')
		   OR ISNULL(tgt.[mode_opt]				,'') <> 							ISNULL(src.[mode_opt]			,'')
		   OR ISNULL(tgt.[name]					,'') <> 	LTRIM(RTRIM(			ISNULL(src.[name]				,'')))
		   OR ISNULL(tgt.[parent_id]			,'') <> 							ISNULL(src.[parent_id]			,'')
		   OR ISNULL(tgt.[region_id]			,'') <> 							ISNULL(src.[region_id]			,'')
		   OR ISNULL(tgt.[region_in]			,'') <> 							ISNULL(src.[region_in]			,'')
		   OR ISNULL(tgt.[region_out]			,'') <> 							ISNULL(src.[region_out]			,'')
		   OR ISNULL(tgt.[relay_delay_time]		,'') <> 							ISNULL(src.[relay_delay_time]	,'')
		   OR ISNULL(tgt.[relay_opt]			,'') <> 							ISNULL(src.[relay_opt]			,'')
		   OR ISNULL(tgt.[relay_time]			,'') <> 							ISNULL(src.[relay_time]			,'')
		   OR ISNULL(tgt.[flags]				,'') <> 							ISNULL(src.[flags]				,''))
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
						src.[alarm_time]
	,					src.[channel_com]
	,					src.[channel_com_type]
	,					src.[channel_ip]
	,					src.[com_addr]
	,					src.[door_time]
	,					src.[ex1_opt]
	,					src.[ex2_opt]
	,					src.[exit_time]
	,					src.[external_ip]
	,					src.[global_apb]
	,					src.[guid]
	,					src.[hardware_opt]
	,					src.[id]
	,					src.[interface]
	,					src.[lock_time]
	,					src.[mode_opt]
	,		LTRIM(RTRIM(src.[name]								))
	,					src.[parent_id]
	,					src.[region_id]
	,					src.[region_in]
	,					src.[region_out]
	,					src.[relay_delay_time]
	,					src.[relay_opt]
	,					src.[relay_time]
	,					src.[flags]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PNET3_NC32K (
	   [alarm_time]
      ,[channel_com]
      ,[channel_com_type]
      ,[channel_ip]
      ,[com_addr]
      ,[door_time]
      ,[ex1_opt]
      ,[ex2_opt]
      ,[exit_time]
      ,[external_ip]
      ,[global_apb]
      ,[guid]
      ,[hardware_opt]
      ,[id]
      ,[interface]
      ,[lock_time]
      ,[mode_opt]
      ,[name]
      ,[parent_id]
      ,[region_id]
      ,[region_in]
      ,[region_out]
      ,[relay_delay_time]
      ,[relay_opt]
      ,[relay_time]
      ,[flags]
      
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [alarm_time]
      ,[channel_com]
      ,[channel_com_type]
      ,[channel_ip]
      ,[com_addr]
      ,[door_time]
      ,[ex1_opt]
      ,[ex2_opt]
      ,[exit_time]
      ,[external_ip]
      ,[global_apb]
      ,[guid]
      ,[hardware_opt]
      ,[id]
      ,[interface]
      ,[lock_time]
      ,[mode_opt]
      ,[name]
      ,[parent_id]
      ,[region_id]
      ,[region_in]
      ,[region_out]
      ,[relay_delay_time]
      ,[relay_opt]
      ,[relay_time]
      ,[flags]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	tgt.[alarm_time]			= 					src.[alarm_time],
	tgt.[channel_com]			= 					src.[channel_com],
	tgt.[channel_com_type]		= 					src.[channel_com_type],
	tgt.[channel_ip]			= 					src.[channel_ip],
	tgt.[com_addr]				= 					src.[com_addr],
	tgt.[door_time]				= 					src.[door_time],
	tgt.[ex1_opt]				= 					src.[ex1_opt],
	tgt.[ex2_opt]				= 					src.[ex2_opt],
	tgt.[exit_time]				= 					src.[exit_time],
	tgt.[external_ip]			= 					src.[external_ip],
	tgt.[global_apb]			= 					src.[global_apb],
	tgt.[guid]					= 					src.[guid],
	tgt.[hardware_opt]			= 					src.[hardware_opt],
	tgt.[interface]				= 					src.[interface],
	tgt.[lock_time]				= 					src.[lock_time],
	tgt.[mode_opt]				= 					src.[mode_opt],
	tgt.[name]					= 	LTRIM(RTRIM(	src.[name])),
	tgt.[parent_id]				= 					src.[parent_id],
	tgt.[region_id]				= 					src.[region_id],
	tgt.[region_in]				= 					src.[region_in],
	tgt.[region_out]			= 					src.[region_out],
	tgt.[relay_delay_time]		= 					src.[relay_delay_time],
	tgt.[relay_opt]				= 					src.[relay_opt],
	tgt.[relay_time]			= 					src.[relay_time],
	tgt.[flags]					= 					src.[flags],
	
	tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PNET3_NC32K tgt
INNER JOIN IntellectSTG.stg.OBJ_PNET3_NC32K AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PNET3_NC32K as tgt
USING IntellectSTG.stg.OBJ_PNET3_NC32K AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[alarm_time]
	,					src.[channel_com]
	,					src.[channel_com_type]
	,					src.[channel_ip]
	,					src.[com_addr]
	,					src.[door_time]
	,					src.[ex1_opt]
	,					src.[ex2_opt]
	,					src.[exit_time]
	,					src.[external_ip]
	,					src.[global_apb]
	,					src.[guid]
	,					src.[hardware_opt]
	,					src.[id]
	,					src.[interface]
	,					src.[lock_time]
	,					src.[mode_opt]
	,		LTRIM(RTRIM(src.[name]								))
	,					src.[parent_id]
	,					src.[region_id]
	,					src.[region_in]
	,					src.[region_out]
	,					src.[relay_delay_time]
	,					src.[relay_opt]
	,					src.[relay_time]
	,					src.[flags]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PNET3_NC32K (
	 
       [alarm_time]
      ,[channel_com]
      ,[channel_com_type]
      ,[channel_ip]
      ,[com_addr]
      ,[door_time]
      ,[ex1_opt]
      ,[ex2_opt]
      ,[exit_time]
      ,[external_ip]
      ,[global_apb]
      ,[guid]
      ,[hardware_opt]
      ,[id]
      ,[interface]
      ,[lock_time]
      ,[mode_opt]
      ,[name]
      ,[parent_id]
      ,[region_id]
      ,[region_in]
      ,[region_out]
      ,[relay_delay_time]
      ,[relay_opt]
      ,[relay_time]
      ,[flags]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [alarm_time]
      ,[channel_com]
      ,[channel_com_type]
      ,[channel_ip]
      ,[com_addr]
      ,[door_time]
      ,[ex1_opt]
      ,[ex2_opt]
      ,[exit_time]
      ,[external_ip]
      ,[global_apb]
      ,[guid]
      ,[hardware_opt]
      ,[id]
      ,[interface]
      ,[lock_time]
      ,[mode_opt]
      ,[name]
      ,[parent_id]
      ,[region_id]
      ,[region_in]
      ,[region_out]
      ,[relay_delay_time]
      ,[relay_opt]
      ,[relay_time]
      ,[flags]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PNET3_NC32K WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_LEVEL_READER]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_LEVEL_READER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_LEVEL_READER]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_LEVEL_READER]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[arm] [varchar](1) NULL,
	[disarm] [varchar](1) NULL,
	[guid] [uniqueidentifier] NULL,
	[main_id] [varchar](40) NULL,
	[not_download_cards] [smallint] NULL,
	[parent_id] [varchar](40) NULL,
	[reader_id] [varchar](40) NULL,
	[reader_type] [varchar](32) NULL,
	[time_zone] [varchar](40) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_LEVEL_READER as tgt
USING IntellectSTG.stg.OBJ_LEVEL_READER AS src	   
ON     (tgt.main_id   = src.main_id
	AND tgt.reader_id = src.reader_id
	AND tgt.time_zone = src.time_zone)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
	   [arm]
      ,[disarm]
      ,[guid]
      ,[main_id]
      ,[not_download_cards]
      ,[parent_id]
      ,[reader_id]
      ,[reader_type]
      ,[time_zone]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[arm]
      ,				src.[disarm]
      ,				src.[guid]
      ,				src.[main_id]
      ,				src.[not_download_cards]
      ,				src.[parent_id]
      ,				src.[reader_id]
      ,				src.[reader_type]
      ,				src.[time_zone]
                       
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[arm]					,'') <>							     ISNULL(src.[arm]					,'') 
		   OR ISNULL(tgt.[disarm]				,'') <>								 ISNULL(src.[disarm]				,'') 
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>						 ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[not_download_cards]	,'') <>								 ISNULL(src.[not_download_cards]	,'') 
		   OR ISNULL(tgt.[parent_id]			,'') <>								 ISNULL(src.[parent_id]				,'') 
		   OR ISNULL(tgt.[reader_type]			,'') <>								 ISNULL(src.[reader_type]			,'') 		  
		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[arm]
      ,				src.[disarm]
      ,				src.[guid]      
      ,				src.[main_id]
      ,				src.[not_download_cards]
      ,				src.[parent_id]
      ,				src.[reader_id]
      ,				src.[reader_type]
      ,				src.[time_zone]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_LEVEL_READER (
	   [arm]
      ,[disarm]
      ,[guid]
      ,[main_id]
      ,[not_download_cards]
      ,[parent_id]
      ,[reader_id]
      ,[reader_type]
      ,[time_zone]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [arm]
      ,[disarm]
      ,[guid]
      ,[main_id]
      ,[not_download_cards]
      ,[parent_id]
      ,[reader_id]
      ,[reader_type]
      ,[time_zone]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.main_id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[arm]					=					 			src.[arm]					
	,tgt.[disarm]				=					 			src.[disarm]				
	,tgt.[guid]					=					 			src.[guid]					
	,tgt.[not_download_cards]	=					 			src.[not_download_cards]	
	,tgt.[parent_id]			=					 			src.[parent_id]			
	,tgt.[reader_type]			=					 			src.[reader_type]			
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_LEVEL_READER tgt
INNER JOIN IntellectSTG.stg.OBJ_LEVEL_READER AS src ON  (tgt.main_id = src.main_id
										AND tgt.reader_id = src.reader_id
										AND tgt.time_zone = src.time_zone)
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_LEVEL_READER as tgt
USING IntellectSTG.stg.OBJ_LEVEL_READER AS src	   
ON (tgt.main_id   = src.main_id
	AND tgt.reader_id = src.reader_id
	AND tgt.time_zone = src.time_zone)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[arm]
      ,				src.[disarm]
      ,				src.[guid]      
      ,				src.[main_id]
      ,				src.[not_download_cards]
      ,				src.[parent_id]
      ,				src.[reader_id]
      ,				src.[reader_type]
      ,				src.[time_zone]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_LEVEL_READER (
	 
       [arm]
      ,[disarm]
      ,[guid]
      ,[main_id]
      ,[not_download_cards]
      ,[parent_id]
      ,[reader_id]
      ,[reader_type]
      ,[time_zone]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [arm]
      ,[disarm]
      ,[guid]
      ,[main_id]
      ,[not_download_cards]
      ,[parent_id]
      ,[reader_id]
      ,[reader_type]
      ,[time_zone]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_LEVEL_READER WHERE main_id   = tmp.main_id
														AND reader_id = tmp.reader_id
														AND time_zone = tmp.time_zone 
														AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_LEVEL]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_LEVEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_LEVEL]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_LEVEL]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](120) NULL,
	[parent_id] [varchar](40) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_LEVEL as tgt
USING IntellectSTG.stg.OBJ_LEVEL AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[flags]
      ,				src.[guid]
      ,	LTRIM(RTRIM(src.[id]			))
      ,				src.[name]
      ,				src.[parent_id]
                       
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[flags]		,'') <>							     ISNULL(src.[flags]			,'') 
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>				 ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[name]			,'') <>					 LTRIM(RTRIM(ISNULL(src.[name]			,'')		))
		   OR ISNULL(tgt.[parent_id]	,'') <>								 ISNULL(src.[parent_id]		,'') 
		   		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[flags]
      ,				src.[guid]
      ,	LTRIM(RTRIM(src.[id]			))
      ,				src.[name]
      ,				src.[parent_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_LEVEL (
	   [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[flags]		=			 			src.[flags]			
	,tgt.[guid]			=			 			src.[guid]				
	,tgt.[name]			=			LTRIM(RTRIM(src.[name]			))		
	,tgt.[parent_id]	=			 			src.[parent_id]		
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_LEVEL tgt
INNER JOIN IntellectSTG.stg.OBJ_LEVEL AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_LEVEL as tgt
USING IntellectSTG.stg.OBJ_LEVEL AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[flags]
      ,				src.[guid]
      ,	LTRIM(RTRIM(src.[id]			))
      ,				src.[name]
      ,				src.[parent_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_LEVEL (
	 
       [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_LEVEL WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_IP_GATE]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_IP_GATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_IP_GATE]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_IP_GATE]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[channel_ip] [nvarchar](60) NULL,
	[external_ip] [nvarchar](15) NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](60) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](60) NULL,
	[region_id] [nvarchar](60) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PNET3_IP_GATE as tgt
USING IntellectSTG.stg.OBJ_PNET3_IP_GATE AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [channel_ip]
      ,[external_ip]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[channel_ip]
      ,				src.[external_ip]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]					))
      ,				src.[parent_id]
      ,				src.[region_id]
                     
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[channel_ip]		,'') <>							     ISNULL(src.[channel_ip]		,'') 
		   OR ISNULL(tgt.[external_ip]		,'') <>								 ISNULL(src.[external_ip]		,'') 
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>					 ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1))  
		   OR ISNULL(tgt.[name]				,'') <>					 LTRIM(RTRIM(ISNULL(src.[name]				,'')		))
		   OR ISNULL(tgt.[parent_id]		,'') <>								 ISNULL(src.[parent_id]			,'') 
		   OR ISNULL(tgt.[region_id]		,'') <>								 ISNULL(src.[region_id]			,'') 
		  		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[channel_ip]
      ,				src.[external_ip]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]					))
      ,				src.[parent_id]
      ,				src.[region_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PNET3_IP_GATE (
	    [channel_ip]
      ,[external_ip]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	    [channel_ip]
      ,[external_ip]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[region_id]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[channel_ip]		=					 			src.[channel_ip]		
	,tgt.[external_ip]		=					 			src.[external_ip]		
	,tgt.[guid]				=					 			src.[guid]				
	,tgt.[name]				=					LTRIM(RTRIM(src.[name]				))	
	,tgt.[parent_id]		=					 			src.[parent_id]		
	,tgt.[region_id]		=					 			src.[region_id]		
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PNET3_IP_GATE tgt
INNER JOIN IntellectSTG.stg.OBJ_PNET3_IP_GATE AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PNET3_IP_GATE as tgt
USING IntellectSTG.stg.OBJ_PNET3_IP_GATE AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[channel_ip]
      ,				src.[external_ip]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]					))
      ,				src.[parent_id]
      ,				src.[region_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PNET3_IP_GATE (
	 
       [channel_ip]
      ,[external_ip]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [channel_ip]
      ,[external_ip]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]
      ,[region_id]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PNET3_IP_GATE WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_GRABBER]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_GRABBER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_GRABBER]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_GRABBER]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[auth] [varchar](30) NULL,
	[brand] [varchar](8000) NULL,
	[chan] [int] NULL,
	[codec] [varchar](60) NULL,
	[flags] [int] NULL,
	[format] [varchar](8) NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[ip] [varchar](8000) NULL,
	[ip_port] [varchar](16) NULL,
	[mode] [varchar](3) NULL,
	[model] [varchar](8000) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[password] [varchar](60) NULL,
	[resolution] [varchar](8) NULL,
	[type] [varchar](16) NULL,
	[useconfigurebyweb] [int] NULL,
	[username] [varchar](60) NULL,
	[watchdog] [int] NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_GRABBER as tgt
USING IntellectSTG.stg.OBJ_GRABBER AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [auth]
      ,[brand]
      ,[chan]
      ,[codec]
      ,[flags]
      ,[format]
      ,[guid]
      ,[id]
      ,[ip]
      ,[ip_port]
      ,[mode]
      ,[model]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[resolution]
      ,[type]
      ,[useconfigurebyweb]
      ,[username]
      ,[watchdog]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
								src.[auth]
      ,	convert(varchar(8000),	src.[brand]					)
      ,							src.[chan]
      ,							src.[codec]
      ,							src.[flags]
      ,							src.[format]
      ,							src.[guid]
      ,							src.[id]
      , convert(varchar(8000),	src.[ip]					)
      ,							src.[ip_port]
      ,							src.[mode]
      ,	convert(varchar(8000),	src.[model]					)
      ,	LTRIM(RTRIM(			src.[name]					))
      ,							src.[parent_id]
      ,							src.[password]
      ,							src.[resolution]
      ,							src.[type]
      ,							src.[useconfigurebyweb]
      ,							src.[username]
      ,							src.[watchdog]
                      
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[auth],				'') <>							     ISNULL(src.[auth],					'')
		   OR ISNULL(tgt.[brand],				'') <>	convert(varchar(8000),	     ISNULL(src.[brand],				''))
		   OR ISNULL(tgt.[chan],				'') <>								 ISNULL(src.[chan],					'')
		   OR ISNULL(tgt.[codec],				'') <>								 ISNULL(src.[codec],				'')
		   OR ISNULL(tgt.[flags],				'') <>								 ISNULL(src.[flags],				'')
		   OR ISNULL(tgt.[format],				'') <>								 ISNULL(src.[format],				'')
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))<>						 ISNULL(src.[guid],CONVERT(VARBINARY(16),0,1))
		   OR ISNULL(tgt.[ip],					'') <>	convert(varchar(8000),		 ISNULL(src.[ip],					''))
		   OR ISNULL(tgt.[ip_port],				'') <>								 ISNULL(src.[ip_port],				'')
		   OR ISNULL(tgt.[mode],				'') <>								 ISNULL(src.[mode],					'')
		   OR ISNULL(tgt.[model],				'') <>	convert(varchar(8000),		 ISNULL(src.[model],				''))
		   OR ISNULL(tgt.[name],				'') <>					 LTRIM(RTRIM(ISNULL(src.[name],					'')			))
		   OR ISNULL(tgt.[parent_id],			'') <>								 ISNULL(src.[parent_id],			'')
		   OR ISNULL(tgt.[password],			'') <>								 ISNULL(src.[password],				'')
		   OR ISNULL(tgt.[resolution],			'') <>								 ISNULL(src.[resolution],			'')
		   OR ISNULL(tgt.[type],				'') <>								 ISNULL(src.[type],					'')
		   OR ISNULL(tgt.[useconfigurebyweb],	'') <>								 ISNULL(src.[useconfigurebyweb],	'')
		   OR ISNULL(tgt.[username],			'') <>								 ISNULL(src.[username],				'')
		   OR ISNULL(tgt.[watchdog],			'') <>								 ISNULL(src.[watchdog],				'')
		   		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
								src.[auth]
      ,	convert(varchar(8000),	src.[brand]					)
      ,							src.[chan]
      ,							src.[codec]
      ,							src.[flags]
      ,							src.[format]
      ,							src.[guid]
      ,							src.[id]
      , convert(varchar(8000),	src.[ip]					)
      ,							src.[ip_port]
      ,							src.[mode]
      ,	convert(varchar(8000),	src.[model]					)
      ,	LTRIM(RTRIM(			src.[name]					))
      ,							src.[parent_id]
      ,							src.[password]
      ,							src.[resolution]
      ,							src.[type]
      ,							src.[useconfigurebyweb]
      ,							src.[username]
      ,							src.[watchdog]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_GRABBER (
       [auth]
      ,[brand]
      ,[chan]
      ,[codec]
      ,[flags]
      ,[format]
      ,[guid]
      ,[id]
      ,[ip]
      ,[ip_port]
      ,[mode]
      ,[model]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[resolution]
      ,[type]
      ,[useconfigurebyweb]
      ,[username]
      ,[watchdog]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [auth]
      ,[brand]
      ,[chan]
      ,[codec]
      ,[flags]
      ,[format]
      ,[guid]
      ,[id]
      ,[ip]
      ,[ip_port]
      ,[mode]
      ,[model]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[resolution]
      ,[type]
      ,[useconfigurebyweb]
      ,[username]
      ,[watchdog]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[auth]					=					 			src.[auth]
	,tgt.[brand]				=	convert(varchar(8000),	    src.[brand]					)
	,tgt.[chan]					=					 			src.[chan]
	,tgt.[codec]				=					 			src.[codec]
	,tgt.[flags]				=					 			src.[flags]
	,tgt.[format]				=					 			src.[format]
	,tgt.[guid]					=					 			src.[guid]
	,tgt.[ip]					=	convert(varchar(8000),	    src.[ip]					)
	,tgt.[ip_port]				=					 			src.[ip_port]
	,tgt.[mode]					=					 			src.[mode]
	,tgt.[model]				=	convert(varchar(8000),		src.[model]					)
	,tgt.[name]					=				LTRIM(RTRIM(	src.[name]					))
	,tgt.[parent_id]			=					 			src.[parent_id]
	,tgt.[password]				=					 			src.[password]
	,tgt.[resolution]			=					 			src.[resolution]
	,tgt.[type]					=					 			src.[type]
	,tgt.[useconfigurebyweb]	=					 			src.[useconfigurebyweb]
	,tgt.[username]				=					 			src.[username]
	,tgt.[watchdog]				=					 			src.[watchdog]
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_GRABBER tgt
INNER JOIN IntellectSTG.stg.OBJ_GRABBER AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_GRABBER as tgt
USING IntellectSTG.stg.OBJ_GRABBER AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  						src.[auth]
      ,	convert(varchar(8000),	src.[brand]					)
      ,							src.[chan]
      ,							src.[codec]
      ,							src.[flags]
      ,							src.[format]
      ,							src.[guid]
      ,							src.[id]
      , convert(varchar(8000),	src.[ip]					)
      ,							src.[ip_port]
      ,							src.[mode]
      ,	convert(varchar(8000),	src.[model]					)
      ,	LTRIM(RTRIM(			src.[name]					))
      ,							src.[parent_id]
      ,							src.[password]
      ,							src.[resolution]
      ,							src.[type]
      ,							src.[useconfigurebyweb]
      ,							src.[username]
      ,							src.[watchdog]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_GRABBER (
	 
       [auth]
      ,[brand]
      ,[chan]
      ,[codec]
      ,[flags]
      ,[format]
      ,[guid]
      ,[id]
      ,[ip]
      ,[ip_port]
      ,[mode]
      ,[model]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[resolution]
      ,[type]
      ,[useconfigurebyweb]
      ,[username]
      ,[watchdog]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [auth]
      ,[brand]
      ,[chan]
      ,[codec]
      ,[flags]
      ,[format]
      ,[guid]
      ,[id]
      ,[ip]
      ,[ip_port]
      ,[mode]
      ,[model]
      ,[name]
      ,[parent_id]
      ,[password]
      ,[resolution]
      ,[type]
      ,[useconfigurebyweb]
      ,[username]
      ,[watchdog]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_GRABBER WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_DEPARTMENT]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_DEPARTMENT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_DEPARTMENT]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_DEPARTMENT]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[external_id] [varchar](255) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[level_id] [varchar](40) NULL,
	[name] [varchar](255) NULL,
	[owner_id] [varchar](60) NULL,
	[schedule_id] [varchar](40) NULL,
	[type] [smallint] NULL,
		
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_DEPARTMENT as tgt
USING IntellectSTG.stg.OBJ_DEPARTMENT AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [external_id]
      ,[flags]
      ,[guid]
      ,[id]
      ,[level_id]
      ,[name]
      ,[owner_id]
      ,[schedule_id]
      ,[type]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[external_id]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[level_id]
      ,	LTRIM(RTRIM(src.[name]))
      ,				src.[owner_id]
      ,				src.[schedule_id]
      ,				src.[type]
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[external_id]				,'') <>								 ISNULL(src.[external_id]		,'') 
		   OR ISNULL(tgt.[flags]					,'') <>								 ISNULL(src.[flags]				,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))<>							 ISNULL(src.[guid],		 CONVERT(VARBINARY(16),0,1))
		   OR ISNULL(tgt.[level_id]					,'') <>								 ISNULL(src.[level_id]			,'') 
		   OR ISNULL(tgt.[name]						,'') <>			LTRIM(RTRIM(		 ISNULL(src.[name]				,''))) 
		   OR ISNULL(tgt.[owner_id]					,'') <>								 ISNULL(src.[owner_id]			,'') 
		   OR ISNULL(tgt.[schedule_id]				,'') <>								 ISNULL(src.[schedule_id]		,'') 
		   OR ISNULL(tgt.[type]						,'') <>								 ISNULL(src.[type]				,'') 
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
					src.[external_id]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[level_id]
      ,	LTRIM(RTRIM(src.[name]))
      ,				src.[owner_id]
      ,				src.[schedule_id]
      ,				src.[type]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_DEPARTMENT (
       [external_id]
      ,[flags]
      ,[guid]
      ,[id]
      ,[level_id]
      ,[name]
      ,[owner_id]
      ,[schedule_id]
      ,[type]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [external_id]
      ,[flags]
      ,[guid]
      ,[id]
      ,[level_id]
      ,[name]
      ,[owner_id]
      ,[schedule_id]
      ,[type]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[external_id]			=			src.[external_id]	
	,tgt.[flags]				=			src.[flags]		
	,tgt.[guid]					=			src.[guid]			
	,tgt.[level_id]				=			src.[level_id]		
	,tgt.[name]					=			src.[name]			
	,tgt.[owner_id]				=			src.[owner_id]		
	,tgt.[schedule_id]			=			src.[schedule_id]	
	,tgt.[type]					=			src.[type]			
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_DEPARTMENT tgt
INNER JOIN IntellectSTG.stg.OBJ_DEPARTMENT AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_DEPARTMENT as tgt
USING IntellectSTG.stg.OBJ_DEPARTMENT AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  			src.[external_id]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[level_id]
      ,	LTRIM(RTRIM(src.[name]))
      ,				src.[owner_id]
      ,				src.[schedule_id]
      ,				src.[type]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_DEPARTMENT (
	   [external_id]
      ,[flags]
      ,[guid]
      ,[id]
      ,[level_id]
      ,[name]
      ,[owner_id]
      ,[schedule_id]
      ,[type]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [external_id]
      ,[flags]
      ,[guid]
      ,[id]
      ,[level_id]
      ,[name]
      ,[owner_id]
      ,[schedule_id]
      ,[type]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_DEPARTMENT WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_CAM]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_CAM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_CAM]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_CAM]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[activity] [smallint] NULL,
	[additional_info] [varchar](100) NULL,
	[alarm_rec] [smallint] NULL,
	[arch_days] [int] NULL,
	[audio_id] [varchar](40) NULL,
	[audio_type] [varchar](16) NULL,
	[blinding] [int] NULL,
	[bosch_ptz_protocol] [varchar](8000) NULL,
	[bright] [smallint] NULL,
	[color] [smallint] NULL,
	[compression] [smallint] NULL,
	[compressor] [varchar](40) NULL,
	[config_id] [varchar](40) NULL,
	[contrast] [smallint] NULL,
	[decoder] [int] NULL,
	[decompressor] [varchar](40) NULL,
	[flags] [int] NULL,
	[fps] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hot_rec_period] [int] NULL,
	[hot_rec_time] [int] NULL,
	[id] [varchar](40) NULL,
	[ifreg] [smallint] NULL,
	[manual] [smallint] NULL,
	[mask0] [varchar](250) NULL,
	[mask1] [varchar](250) NULL,
	[mask2] [varchar](250) NULL,
	[mask3] [varchar](250) NULL,
	[mask4] [varchar](200) NULL,
	[md_contrast] [smallint] NULL,
	[md_mode] [smallint] NULL,
	[md_size] [smallint] NULL,
	[motion] [smallint] NULL,
	[multistreaming_mode] [smallint] NULL,
	[mux] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[password_crc] [int] NULL,
	[pre_rec_time] [int] NULL,
	[priority] [int] NULL,
	[proc_time] [int] NULL,
	[rec_priority] [int] NULL,
	[region_id] [varchar](40) NULL,
	[resolution] [int] NULL,
	[rotate] [smallint] NULL,
	[rotateAngle] [varchar](40) NULL,
	[sat_u] [smallint] NULL,
	[source_folder] [varchar](8000) NULL,
	[stream_analitic] [varchar](40) NULL,
	[stream_archive] [varchar](40) NULL,
	[stream_client] [varchar](40) NULL,
	[telemetry_id] [varchar](40) NULL,
	[type] [int] NULL,
	[yuv] [smallint] NULL,
	[stream_alarm] [varchar](40) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_CAM as tgt
USING IntellectSTG.stg.OBJ_CAM AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [activity]
      ,[additional_info]
      ,[alarm_rec]
      ,[arch_days]
      ,[audio_id]
      ,[audio_type]
      ,[blinding]
      ,[bosch_ptz_protocol]
      ,[bright]
      ,[color]
      ,[compression]
      ,[compressor]
      ,[config_id]
      ,[contrast]
      ,[decoder]
      ,[decompressor]
      ,[flags]
      ,[fps]
      ,[guid]
      ,[hot_rec_period]
      ,[hot_rec_time]
      ,[id]
      ,[ifreg]
      ,[manual]
      ,[mask0]
      ,[mask1]
      ,[mask2]
      ,[mask3]
      ,[mask4]
      ,[md_contrast]
      ,[md_mode]
      ,[md_size]
      ,[motion]
      ,[multistreaming_mode]
      ,[mux]
      ,[name]
      ,[parent_id]
      ,[password_crc]
      ,[pre_rec_time]
      ,[priority]
      ,[proc_time]
      ,[rec_priority]
      ,[region_id]
      ,[resolution]
      ,[rotate]
      ,[rotateAngle]
      ,[sat_u]
      ,[source_folder]
      ,[stream_analitic]
      ,[stream_archive]
      ,[stream_client]
      ,[telemetry_id]
      ,[type]
      ,[yuv]
      ,[stream_alarm]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[activity]
      ,				src.[additional_info]
      ,				src.[alarm_rec]
      ,				src.[arch_days]
      ,				src.[audio_id]
      ,				src.[audio_type]
      ,				src.[blinding]
      ,				src.[bosch_ptz_protocol]
      ,				src.[bright]
      ,				src.[color]
      ,				src.[compression]
      ,				src.[compressor]
      ,				src.[config_id]
      ,				src.[contrast]
      ,				src.[decoder]
      ,				src.[decompressor]
      ,				src.[flags]
      ,				src.[fps]
      ,				src.[guid]
      ,				src.[hot_rec_period]
      ,				src.[hot_rec_time]
      ,				src.[id]
      ,				src.[ifreg]
      ,				src.[manual]
      ,				src.[mask0]
      ,				src.[mask1]
      ,				src.[mask2]
      ,				src.[mask3]
      ,				src.[mask4]
      ,				src.[md_contrast]
      ,				src.[md_mode]
      ,				src.[md_size]
      ,				src.[motion]
      ,				src.[multistreaming_mode]
      ,				src.[mux]
      , LTRIM(RTRIM(src.[name]								))
      ,				src.[parent_id]
      ,				src.[password_crc]
      ,				src.[pre_rec_time]
      ,				src.[priority]
      ,				src.[proc_time]
      ,				src.[rec_priority]
      ,				src.[region_id]
      ,				src.[resolution]
      ,				src.[rotate]
      ,				src.[rotateAngle]
      ,				src.[sat_u]
      ,				src.[source_folder]
      ,				src.[stream_analitic]
      ,				src.[stream_archive]
      ,				src.[stream_client]
      ,				src.[telemetry_id]
      ,				src.[type]
      ,				src.[yuv]
      ,				src.[stream_alarm]
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[activity]				,'') <>							     ISNULL(src.[activity]				,'') 
		   OR ISNULL(tgt.[additional_info]		,'') <>								 ISNULL(src.[additional_info]		,'') 
		   OR ISNULL(tgt.[alarm_rec]			,'') <>								 ISNULL(src.[alarm_rec]				,'') 
		   OR ISNULL(tgt.[arch_days]			,'') <>								 ISNULL(src.[arch_days]				,'') 
		   OR ISNULL(tgt.[audio_id]				,'') <>								 ISNULL(src.[audio_id]				,'') 
		   OR ISNULL(tgt.[audio_type]			,'') <>								 ISNULL(src.[audio_type]			,'') 
		   OR ISNULL(tgt.[blinding]				,'') <>								 ISNULL(src.[blinding]				,'') 
		   OR ISNULL(tgt.[bosch_ptz_protocol]	,'') <>	CONVERT(VARCHAR(8000),		 ISNULL(src.[bosch_ptz_protocol]	,'')) 
		   OR ISNULL(tgt.[bright]				,'') <>								 ISNULL(src.[bright]				,'') 
		   OR ISNULL(tgt.[color]				,'') <>								 ISNULL(src.[color]					,'') 
		   OR ISNULL(tgt.[compression]			,'') <>								 ISNULL(src.[compression]			,'') 
		   OR ISNULL(tgt.[compressor]			,'') <>								 ISNULL(src.[compressor]			,'') 
		   OR ISNULL(tgt.[config_id]			,'') <>								 ISNULL(src.[config_id]				,'') 
		   OR ISNULL(tgt.[contrast]				,'') <>								 ISNULL(src.[contrast]				,'') 
		   OR ISNULL(tgt.[decoder]				,'') <>								 ISNULL(src.[decoder]				,'') 
		   OR ISNULL(tgt.[decompressor]			,'') <>								 ISNULL(src.[decompressor]			,'') 
		   OR ISNULL(tgt.[flags]				,'') <>								 ISNULL(src.[flags]					,'') 
		   OR ISNULL(tgt.[fps]					,'') <>								 ISNULL(src.[fps]					,'') 
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1))<>						 ISNULL(src.[guid],		 CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[hot_rec_period]		,'') <>								 ISNULL(src.[hot_rec_period]		,'') 
		   OR ISNULL(tgt.[hot_rec_time]			,'') <>								 ISNULL(src.[hot_rec_time]			,'') 
		   OR ISNULL(tgt.[ifreg]				,'') <>								 ISNULL(src.[ifreg]					,'') 
		   OR ISNULL(tgt.[manual]				,'') <>								 ISNULL(src.[manual]				,'') 
		   OR ISNULL(tgt.[mask0]				,'') <>								 ISNULL(src.[mask0]					,'') 
		   OR ISNULL(tgt.[mask1]				,'') <>								 ISNULL(src.[mask1]					,'') 
		   OR ISNULL(tgt.[mask2]				,'') <>								 ISNULL(src.[mask2]					,'') 
		   OR ISNULL(tgt.[mask3]				,'') <>								 ISNULL(src.[mask3]					,'') 
		   OR ISNULL(tgt.[mask4]				,'') <>								 ISNULL(src.[mask4]					,'') 
		   OR ISNULL(tgt.[md_contrast]			,'') <>								 ISNULL(src.[md_contrast]			,'') 
		   OR ISNULL(tgt.[md_mode]				,'') <>								 ISNULL(src.[md_mode]				,'') 
		   OR ISNULL(tgt.[md_size]				,'') <>								 ISNULL(src.[md_size]				,'') 
		   OR ISNULL(tgt.[motion]				,'') <>								 ISNULL(src.[motion]				,'') 
		   OR ISNULL(tgt.[multistreaming_mode]	,'') <>								 ISNULL(src.[multistreaming_mode]	,'') 
		   OR ISNULL(tgt.[mux]					,'') <>								 ISNULL(src.[mux]					,'') 
		   OR ISNULL(tgt.[name]					,'') <>	LTRIM(RTRIM(				 ISNULL(src.[name]					,''))) 
		   OR ISNULL(tgt.[parent_id]			,'') <>								 ISNULL(src.[parent_id]				,'') 
		   OR ISNULL(tgt.[password_crc]			,'') <>								 ISNULL(src.[password_crc]			,'') 
		   OR ISNULL(tgt.[pre_rec_time]			,'') <>								 ISNULL(src.[pre_rec_time]			,'') 
		   OR ISNULL(tgt.[priority]				,'') <>								 ISNULL(src.[priority]				,'') 
		   OR ISNULL(tgt.[proc_time]			,'') <>								 ISNULL(src.[proc_time]				,'') 
		   OR ISNULL(tgt.[rec_priority]			,'') <>								 ISNULL(src.[rec_priority]			,'') 
		   OR ISNULL(tgt.[region_id]			,'') <>								 ISNULL(src.[region_id]				,'') 
		   OR ISNULL(tgt.[resolution]			,'') <>								 ISNULL(src.[resolution]			,'') 
		   OR ISNULL(tgt.[rotate]				,'') <>								 ISNULL(src.[rotate]				,'') 
		   OR ISNULL(tgt.[rotateAngle]			,'') <>								 ISNULL(src.[rotateAngle]			,'') 
		   OR ISNULL(tgt.[sat_u]				,'') <>								 ISNULL(src.[sat_u]					,'') 
		   OR ISNULL(tgt.[source_folder]		,'') <>	convert(varchar(8000),		 ISNULL(src.[source_folder]			,'')) 
		   OR ISNULL(tgt.[stream_analitic]		,'') <>								 ISNULL(src.[stream_analitic]		,'') 
		   OR ISNULL(tgt.[stream_archive]		,'') <>								 ISNULL(src.[stream_archive]		,'') 
		   OR ISNULL(tgt.[stream_client]		,'') <>								 ISNULL(src.[stream_client]			,'') 
		   OR ISNULL(tgt.[telemetry_id]			,'') <>								 ISNULL(src.[telemetry_id]			,'') 
		   OR ISNULL(tgt.[type]					,'') <>								 ISNULL(src.[type]					,'') 
		   OR ISNULL(tgt.[yuv]					,'') <>								 ISNULL(src.[yuv]					,'') 
		   OR ISNULL(tgt.[stream_alarm]			,'') <>								 ISNULL(src.[stream_alarm]			,'') 
		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[activity]
      ,				src.[additional_info]
      ,				src.[alarm_rec]
      ,				src.[arch_days]
      ,				src.[audio_id]
      ,				src.[audio_type]
      ,				src.[blinding]
      ,				src.[bosch_ptz_protocol]
      ,				src.[bright]
      ,				src.[color]
      ,				src.[compression]
      ,				src.[compressor]
      ,				src.[config_id]
      ,				src.[contrast]
      ,				src.[decoder]
      ,				src.[decompressor]
      ,				src.[flags]
      ,				src.[fps]
      ,				src.[guid]
      ,				src.[hot_rec_period]
      ,				src.[hot_rec_time]
      ,				src.[id]
      ,				src.[ifreg]
      ,				src.[manual]
      ,				src.[mask0]
      ,				src.[mask1]
      ,				src.[mask2]
      ,				src.[mask3]
      ,				src.[mask4]
      ,				src.[md_contrast]
      ,				src.[md_mode]
      ,				src.[md_size]
      ,				src.[motion]
      ,				src.[multistreaming_mode]
      ,				src.[mux]
      , LTRIM(RTRIM(src.[name]								))
      ,				src.[parent_id]
      ,				src.[password_crc]
      ,				src.[pre_rec_time]
      ,				src.[priority]
      ,				src.[proc_time]
      ,				src.[rec_priority]
      ,				src.[region_id]
      ,				src.[resolution]
      ,				src.[rotate]
      ,				src.[rotateAngle]
      ,				src.[sat_u]
      ,				src.[source_folder]
      ,				src.[stream_analitic]
      ,				src.[stream_archive]
      ,				src.[stream_client]
      ,				src.[telemetry_id]
      ,				src.[type]
      ,				src.[yuv]
      ,				src.[stream_alarm]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_CAM (
	   [activity]
      ,[additional_info]
      ,[alarm_rec]
      ,[arch_days]
      ,[audio_id]
      ,[audio_type]
      ,[blinding]
      ,[bosch_ptz_protocol]
      ,[bright]
      ,[color]
      ,[compression]
      ,[compressor]
      ,[config_id]
      ,[contrast]
      ,[decoder]
      ,[decompressor]
      ,[flags]
      ,[fps]
      ,[guid]
      ,[hot_rec_period]
      ,[hot_rec_time]
      ,[id]
      ,[ifreg]
      ,[manual]
      ,[mask0]
      ,[mask1]
      ,[mask2]
      ,[mask3]
      ,[mask4]
      ,[md_contrast]
      ,[md_mode]
      ,[md_size]
      ,[motion]
      ,[multistreaming_mode]
      ,[mux]
      ,[name]
      ,[parent_id]
      ,[password_crc]
      ,[pre_rec_time]
      ,[priority]
      ,[proc_time]
      ,[rec_priority]
      ,[region_id]
      ,[resolution]
      ,[rotate]
      ,[rotateAngle]
      ,[sat_u]
      ,[source_folder]
      ,[stream_analitic]
      ,[stream_archive]
      ,[stream_client]
      ,[telemetry_id]
      ,[type]
      ,[yuv]
      ,[stream_alarm]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [activity]
      ,[additional_info]
      ,[alarm_rec]
      ,[arch_days]
      ,[audio_id]
      ,[audio_type]
      ,[blinding]
      ,[bosch_ptz_protocol]
      ,[bright]
      ,[color]
      ,[compression]
      ,[compressor]
      ,[config_id]
      ,[contrast]
      ,[decoder]
      ,[decompressor]
      ,[flags]
      ,[fps]
      ,[guid]
      ,[hot_rec_period]
      ,[hot_rec_time]
      ,[id]
      ,[ifreg]
      ,[manual]
      ,[mask0]
      ,[mask1]
      ,[mask2]
      ,[mask3]
      ,[mask4]
      ,[md_contrast]
      ,[md_mode]
      ,[md_size]
      ,[motion]
      ,[multistreaming_mode]
      ,[mux]
      ,[name]
      ,[parent_id]
      ,[password_crc]
      ,[pre_rec_time]
      ,[priority]
      ,[proc_time]
      ,[rec_priority]
      ,[region_id]
      ,[resolution]
      ,[rotate]
      ,[rotateAngle]
      ,[sat_u]
      ,[source_folder]
      ,[stream_analitic]
      ,[stream_archive]
      ,[stream_client]
      ,[telemetry_id]
      ,[type]
      ,[yuv]
      ,[stream_alarm]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[activity]				=					 			src.[activity]				
	,tgt.[additional_info]		=					 			src.[additional_info]		
	,tgt.[alarm_rec]			=					 			src.[alarm_rec]			
	,tgt.[arch_days]			=					 			src.[arch_days]			
	,tgt.[audio_id]				=					 			src.[audio_id]				
	,tgt.[audio_type]			=					 			src.[audio_type]			
	,tgt.[blinding]				=					 			src.[blinding]				
	,tgt.[bosch_ptz_protocol]	=					 			src.[bosch_ptz_protocol]	
	,tgt.[bright]				=					 			src.[bright]				
	,tgt.[color]				=					 			src.[color]				
	,tgt.[compression]			=					 			src.[compression]			
	,tgt.[compressor]			=					 			src.[compressor]			
	,tgt.[config_id]			=					 			src.[config_id]			
	,tgt.[contrast]				=					 			src.[contrast]				
	,tgt.[decoder]				=					 			src.[decoder]				
	,tgt.[decompressor]			=					 			src.[decompressor]			
	,tgt.[flags]				=					 			src.[flags]				
	,tgt.[fps]					=					 			src.[fps]					
	,tgt.[guid]					=					 			src.[guid]					
	,tgt.[hot_rec_period]		=					 			src.[hot_rec_period]		
	,tgt.[hot_rec_time]			=								src.[hot_rec_time]					
	,tgt.[ifreg]				=								src.[ifreg]				
	,tgt.[manual]				=								src.[manual]						
	,tgt.[mask0]				=								src.[mask0]				
	,tgt.[mask1]				=								src.[mask1]				
	,tgt.[mask2]				=							    src.[mask2]							
	,tgt.[mask3]				=								src.[mask3]				
	,tgt.[mask4]				=								src.[mask4]				
	,tgt.[md_contrast]			=								src.[md_contrast]			
	,tgt.[md_mode]				=								src.[md_mode]						
	,tgt.[md_size]				=					 			src.[md_size]				
	,tgt.[motion]				=					 			src.[motion]				
	,tgt.[multistreaming_mode]	=					 			src.[multistreaming_mode]	
	,tgt.[mux]					=					 			src.[mux]					
	,tgt.[name]					=					LTRIM(RTRIM(src.[name]							))				
	,tgt.[parent_id]			=					 			src.[parent_id]			
	,tgt.[password_crc]			=					 			src.[password_crc]			
	,tgt.[pre_rec_time]			=					 			src.[pre_rec_time]			
	,tgt.[priority]				=					 			src.[priority]				
	,tgt.[proc_time]			=					 			src.[proc_time]			
	,tgt.[rec_priority]			=					 			src.[rec_priority]			
	,tgt.[region_id]			=					 			src.[region_id]			
	,tgt.[resolution]			=					 			src.[resolution]			
	,tgt.[rotate]				=					 			src.[rotate]				
	,tgt.[rotateAngle]			=					 			src.[rotateAngle]			
	,tgt.[sat_u]				=					 			src.[sat_u]				
	,tgt.[source_folder]		=					 			src.[source_folder]		
	,tgt.[stream_analitic]		=					 			src.[stream_analitic]		
	,tgt.[stream_archive]		=					 			src.[stream_archive]		
	,tgt.[stream_client]		=					 			src.[stream_client]		
	,tgt.[telemetry_id]			=					 			src.[telemetry_id]			
	,tgt.[type]					=					 			src.[type]					
	,tgt.[yuv]					=					 			src.[yuv]					
	,tgt.[stream_alarm]			=					 			src.[stream_alarm]			

	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_CAM tgt
INNER JOIN IntellectSTG.stg.OBJ_CAM AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_CAM as tgt
USING IntellectSTG.stg.OBJ_CAM AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[activity]
      ,				src.[additional_info]
      ,				src.[alarm_rec]
      ,				src.[arch_days]
      ,				src.[audio_id]
      ,				src.[audio_type]
      ,				src.[blinding]
      ,				src.[bosch_ptz_protocol]
      ,				src.[bright]
      ,				src.[color]
      ,				src.[compression]
      ,				src.[compressor]
      ,				src.[config_id]
      ,				src.[contrast]
      ,				src.[decoder]
      ,				src.[decompressor]
      ,				src.[flags]
      ,				src.[fps]
      ,				src.[guid]
      ,				src.[hot_rec_period]
      ,				src.[hot_rec_time]
      ,				src.[id]
      ,				src.[ifreg]
      ,				src.[manual]
      ,				src.[mask0]
      ,				src.[mask1]
      ,				src.[mask2]
      ,				src.[mask3]
      ,				src.[mask4]
      ,				src.[md_contrast]
      ,				src.[md_mode]
      ,				src.[md_size]
      ,				src.[motion]
      ,				src.[multistreaming_mode]
      ,				src.[mux]
      , LTRIM(RTRIM(src.[name]								))
      ,				src.[parent_id]
      ,				src.[password_crc]
      ,				src.[pre_rec_time]
      ,				src.[priority]
      ,				src.[proc_time]
      ,				src.[rec_priority]
      ,				src.[region_id]
      ,				src.[resolution]
      ,				src.[rotate]
      ,				src.[rotateAngle]
      ,				src.[sat_u]
      ,				src.[source_folder]
      ,				src.[stream_analitic]
      ,				src.[stream_archive]
      ,				src.[stream_client]
      ,				src.[telemetry_id]
      ,				src.[type]
      ,				src.[yuv]
      ,				src.[stream_alarm]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_CAM (
	 
       [activity]
      ,[additional_info]
      ,[alarm_rec]
      ,[arch_days]
      ,[audio_id]
      ,[audio_type]
      ,[blinding]
      ,[bosch_ptz_protocol]
      ,[bright]
      ,[color]
      ,[compression]
      ,[compressor]
      ,[config_id]
      ,[contrast]
      ,[decoder]
      ,[decompressor]
      ,[flags]
      ,[fps]
      ,[guid]
      ,[hot_rec_period]
      ,[hot_rec_time]
      ,[id]
      ,[ifreg]
      ,[manual]
      ,[mask0]
      ,[mask1]
      ,[mask2]
      ,[mask3]
      ,[mask4]
      ,[md_contrast]
      ,[md_mode]
      ,[md_size]
      ,[motion]
      ,[multistreaming_mode]
      ,[mux]
      ,[name]
      ,[parent_id]
      ,[password_crc]
      ,[pre_rec_time]
      ,[priority]
      ,[proc_time]
      ,[rec_priority]
      ,[region_id]
      ,[resolution]
      ,[rotate]
      ,[rotateAngle]
      ,[sat_u]
      ,[source_folder]
      ,[stream_analitic]
      ,[stream_archive]
      ,[stream_client]
      ,[telemetry_id]
      ,[type]
      ,[yuv]
      ,[stream_alarm]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [activity]
      ,[additional_info]
      ,[alarm_rec]
      ,[arch_days]
      ,[audio_id]
      ,[audio_type]
      ,[blinding]
      ,[bosch_ptz_protocol]
      ,[bright]
      ,[color]
      ,[compression]
      ,[compressor]
      ,[config_id]
      ,[contrast]
      ,[decoder]
      ,[decompressor]
      ,[flags]
      ,[fps]
      ,[guid]
      ,[hot_rec_period]
      ,[hot_rec_time]
      ,[id]
      ,[ifreg]
      ,[manual]
      ,[mask0]
      ,[mask1]
      ,[mask2]
      ,[mask3]
      ,[mask4]
      ,[md_contrast]
      ,[md_mode]
      ,[md_size]
      ,[motion]
      ,[multistreaming_mode]
      ,[mux]
      ,[name]
      ,[parent_id]
      ,[password_crc]
      ,[pre_rec_time]
      ,[priority]
      ,[proc_time]
      ,[rec_priority]
      ,[region_id]
      ,[resolution]
      ,[rotate]
      ,[rotateAngle]
      ,[sat_u]
      ,[source_folder]
      ,[stream_analitic]
      ,[stream_archive]
      ,[stream_client]
      ,[telemetry_id]
      ,[type]
      ,[yuv]
      ,[stream_alarm]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_CAM WHERE id = tmp.id AND valid_to IS NULL)
GO


/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_AC_PART]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_AC_PART]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_AC_PART]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_AC_PART]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[active] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](60) NULL,
	[name] [varchar](60) NULL,
	[number] [int] NULL,
	[parent_id] [varchar](60) NULL,
	[parsec_name] [varchar](14) NULL,
	[region_id] [varchar](60) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PNET3_AC_PART as tgt
USING IntellectSTG.stg.OBJ_PNET3_AC_PART AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [active]
      ,[guid]
      ,[id]
      ,[name]
      ,[number]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[active]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]             ))
      ,				src.[number]
      ,				src.[parent_id]
      ,				src.[parsec_name]
      ,				src.[region_id]
                      
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[active]				,'') <>							     ISNULL(src.[active]		,'') 
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>						ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[name]					,'') <>					 LTRIM(RTRIM(ISNULL(src.[name]			,'')           ))
		   OR ISNULL(tgt.[number]				,'') <>								 ISNULL(src.[number]		,'') 
		   OR ISNULL(tgt.[parent_id]			,'') <>								 ISNULL(src.[parent_id]		,'') 
		   OR ISNULL(tgt.[parsec_name]			,'') <>								 ISNULL(src.[parsec_name]	,'') 
		   OR ISNULL(tgt.[region_id]			,'') <>								 ISNULL(src.[region_id]		,'') 
		  		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[active]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]             ))
      ,				src.[number]
      ,				src.[parent_id]
      ,				src.[parsec_name]
      ,				src.[region_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PNET3_AC_PART (
	   [active]
      ,[guid]
      ,[id]
      ,[name]
      ,[number]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
                  
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [active]
      ,[guid]
      ,[id]
      ,[name]
      ,[number]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
           
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[active]			=				src.[active]	
	,tgt.[guid]				=				src.[guid]	
	,tgt.[name]				=	LTRIM(RTRIM(src.[name]				))
	,tgt.[number]			=				src.[number]	
	,tgt.[parent_id]		=				src.[parent_id]	
	,tgt.[parsec_name]		=				src.[parsec_name]	
	,tgt.[region_id]		=				src.[region_id]	
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PNET3_AC_PART tgt
INNER JOIN IntellectSTG.stg.OBJ_PNET3_AC_PART AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PNET3_AC_PART as tgt
USING IntellectSTG.stg.OBJ_PNET3_AC_PART AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[active]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]             ))
      ,				src.[number]
      ,				src.[parent_id]
      ,				src.[parsec_name]
      ,				src.[region_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PNET3_AC_PART (
	 
       [active]
      ,[guid]
      ,[id]
      ,[name]
      ,[number]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [active]
      ,[guid]
      ,[id]
      ,[name]
      ,[number]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PNET3_AC_PART WHERE id = tmp.id AND valid_to IS NULL)
GO
/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_AC]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_AC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_AC]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_AC]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[channel_com] [varchar](60) NULL,
	[channel_com_type] [varchar](60) NULL,
	[com_addr] [int] NULL,
	[ex1_opt] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](60) NULL,
	[keypad_addr] [int] NULL,
	[light_time] [int] NULL,
	[name] [varchar](60) NULL,
	[off_time] [int] NULL,
	[parent_id] [varchar](60) NULL,
	[parsec_name] [varchar](14) NULL,
	[region_id] [varchar](60) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_PNET3_AC as tgt
USING IntellectSTG.stg.OBJ_PNET3_AC AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
       [channel_com]
      ,[channel_com_type]
      ,[com_addr]
      ,[ex1_opt]
      ,[guid]
      ,[id]
      ,[keypad_addr]
      ,[light_time]
      ,[name]
      ,[off_time]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[channel_com]
      ,				src.[channel_com_type]
      ,				src.[com_addr]
      ,				src.[ex1_opt]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[keypad_addr]
      ,				src.[light_time]
      ,	LTRIM(RTRIM(src.[name]					))
      ,				src.[off_time]
      ,				src.[parent_id]
      ,				src.[parsec_name]
      ,				src.[region_id]
                       
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, т.е. данные обновились, строка не является inferred
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1
		 AND (
			  ISNULL(tgt.[channel_com],			'') <>							     ISNULL(src.[channel_com],			'') 
		   OR ISNULL(tgt.[channel_com_type],	'') <>								 ISNULL(src.[channel_com_type],		'') 
		   OR ISNULL(tgt.[com_addr],			'') <>								 ISNULL(src.[com_addr],				'') 
		   OR ISNULL(tgt.[ex1_opt],				'') <>								 ISNULL(src.[ex1_opt],				'') 
		   OR ISNULL(tgt.[guid], CONVERT(VARBINARY(16),0,1)) <>						 ISNULL(src.[guid], CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[keypad_addr],			'') <>								 ISNULL(src.[keypad_addr],			'') 
		   OR ISNULL(tgt.[light_time],			'') <>								 ISNULL(src.[light_time],			'') 
		   OR ISNULL(tgt.[name],				'') <>					 LTRIM(RTRIM(ISNULL(src.[name],					'')   ))
		   OR ISNULL(tgt.[off_time],			'') <>								 ISNULL(src.[off_time],				'') 
		   OR ISNULL(tgt.[parent_id],			'') <>								 ISNULL(src.[parent_id],			'') 
		   OR ISNULL(tgt.[parsec_name],			'') <>								 ISNULL(src.[parsec_name],			'') 
		   OR ISNULL(tgt.[region_id],			'') <>								 ISNULL(src.[region_id],			'') 
		  		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time				
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1 --, tgt.is_inferred = 0
OUTPUT 
		  			src.[channel_com]
      ,				src.[channel_com_type]
      ,				src.[com_addr]
      ,				src.[ex1_opt]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[keypad_addr]
      ,				src.[light_time]
      ,	LTRIM(RTRIM(src.[name]					))
      ,				src.[off_time]
      ,				src.[parent_id]
      ,				src.[parsec_name]
      ,				src.[region_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_PNET3_AC (
	   [channel_com]
      ,[channel_com_type]
      ,[com_addr]
      ,[ex1_opt]
      ,[guid]
      ,[id]
      ,[keypad_addr]
      ,[light_time]
      ,[name]
      ,[off_time]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [channel_com]
      ,[channel_com_type]
      ,[com_addr]
      ,[ex1_opt]
      ,[guid]
      ,[id]
      ,[keypad_addr]
      ,[light_time]
      ,[name]
      ,[off_time]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[channel_com]			=					 			src.[channel_com]				
	,tgt.[channel_com_type]		=					 			src.[channel_com_type]			
	,tgt.[com_addr]				=					 			src.[com_addr]				
	,tgt.[ex1_opt]				=					 			src.[ex1_opt]				
	,tgt.[guid]					=					 			src.[guid]						
	,tgt.[keypad_addr]			=					 			src.[keypad_addr]				
	,tgt.[light_time]			=					 			src.[light_time]				
	,tgt.[name]					=					LTRIM(RTRIM(src.[name]						))			
	,tgt.[off_time]				=					 			src.[off_time]					
	,tgt.[parent_id]			=					 			src.[parent_id]			
	,tgt.[parsec_name]			=					 			src.[parsec_name]				
	,tgt.[region_id]			=					 			src.[region_id]				
		
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_PNET3_AC tgt
INNER JOIN IntellectSTG.stg.OBJ_PNET3_AC AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_PNET3_AC as tgt
USING IntellectSTG.stg.OBJ_PNET3_AC AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
		  		src.[channel_com]
      ,				src.[channel_com_type]
      ,				src.[com_addr]
      ,				src.[ex1_opt]
      ,				src.[guid]
      ,				src.[id]
      ,				src.[keypad_addr]
      ,				src.[light_time]
      ,	LTRIM(RTRIM(src.[name]					))
      ,				src.[off_time]
      ,				src.[parent_id]
      ,				src.[parsec_name]
      ,				src.[region_id]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_PNET3_AC (
	 
       [channel_com]
      ,[channel_com_type]
      ,[com_addr]
      ,[ex1_opt]
      ,[guid]
      ,[id]
      ,[keypad_addr]
      ,[light_time]
      ,[name]
      ,[off_time]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
       [channel_com]
      ,[channel_com_type]
      ,[com_addr]
      ,[ex1_opt]
      ,[guid]
      ,[id]
      ,[keypad_addr]
      ,[light_time]
      ,[name]
      ,[off_time]
      ,[parent_id]
      ,[parsec_name]
      ,[region_id]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_PNET3_AC WHERE id = tmp.id AND valid_to IS NULL)
GO




/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_DISPLAY]   ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_DISPLAY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_DISPLAY]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_DISPLAY]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_DISPLAY as tgt
USING IntellectSTG.stg.OBJ_DISPLAY AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
	[flags]
	,[guid]
	,[id]
	,[name]
	,[parent_id]
	,[valid_from]
    ,[valid_to]
    ,[is_inferred])
	VALUES (					
      				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,LTRIM(RTRIM( src.[name]))
      ,				src.[parent_id]
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, строка не является inferred и строка не является новой записью, т.е. данные обновились
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1  --AND tgt.is_deleted <> 1
		 AND (
			  ISNULL(tgt.[flags]					    ,'')	<>								 ISNULL(src.[flags]				,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))		<>								 ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1))  
		   OR ISNULL(tgt.[name]							,'')	<>	LTRIM(RTRIM(				 ISNULL(src.[name]						,''))) 
		   OR ISNULL(tgt.[parent_id]					,'')	<>								 ISNULL(src.[parent_id]					,'') 
		   )
THEN UPDATE SET tgt.valid_to = @extract_time 
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1
OUTPUT 
 				    src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,LTRIM(RTRIM( src.[name]))
      ,				src.[parent_id]
      
      ,$Action AS MergeAction
INTO @tempTable
;
--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_DISPLAY (
	  [flags]
	,[guid]
	,[id]
	,[name]
	,[parent_id]
	
	,[valid_from]
    ,[valid_to]
    ,[is_inferred])
SELECT
	  [flags]
	,[guid]
	,[id]
	,[name]
	,[parent_id]
	    
     ,@extract_time
     ,NULL
     ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null
--обновляем inferred строки
UPDATE 	tgt
SET 
	tgt.[flags]							=					 			src.[flags]
	,tgt.[guid]								=					 			src.[guid]
	,tgt.[name]								=					LTRIM(RTRIM(src.[name]										))
	,tgt.[parent_id]						=					 			src.[parent_id]	
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_DISPLAY tgt
INNER JOIN IntellectSTG.stg.OBJ_DISPLAY AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL

--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable
MERGE INTO dw.DIM_OBJ_DISPLAY as tgt
USING IntellectSTG.stg.OBJ_DISPLAY AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
	  				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]      
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_DISPLAY (
	  [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id]      
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
	   [flags]
      ,[guid]
      ,[id]
      ,[name]
      ,[parent_id] 
                       
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_DISPLAY WHERE id = tmp.id AND valid_to IS NULL)
GO












/****** Object:  StoredProcedure [dw].[usp_SCD_OBJ_MAP]  ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_MAP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_MAP]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_MAP]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[alarm_top] [smallint] NULL,
	[auto] [smallint] NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[h] [int] NULL,
	[id] [varchar](40) NULL,
	[interpolation_mode] [int] NULL,
	[monitor] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[recurs] [smallint] NULL,
	[shortest] [int] NULL,
	[w] [int] NULL,
	[x] [int] NULL,
	[y] [int] NULL,
	[tracking_monitor_id] [varchar](8000) NULL,
	[show_last_events] [int] NULL,

	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_MAP as tgt
USING IntellectSTG.stg.OBJ_MAP AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
        [alarm_top]
		,[auto]
		,[flags]
		,[guid]
		,[h]
		,[id]
		,[interpolation_mode]
		,[monitor]
		,[name]
		,[parent_id]
		,[recurs]
		,[shortest]
		,[w]
		,[x]
		,[y]
		,[tracking_monitor_id]
		,[show_last_events]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
					src.[alarm_top]
      ,				src.[auto]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[h]
      ,				src.[id]
      ,				src.[interpolation_mode]
      ,				src.[monitor]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[recurs]
      ,				src.[shortest]
      ,				src.[w]
      ,				src.[x]
      ,				src.[y]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[tracking_monitor_id])))
      ,				src.[show_last_events]
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, строка не является inferred и строка не является новой записью, т.е. данные обновились
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1  --AND tgt.is_deleted <> 1
		 AND (
			  ISNULL(tgt.[alarm_top]				,'') <>								 ISNULL(src.[alarm_top]					,'') 
		   OR ISNULL(tgt.[auto]						,'') <>								 ISNULL(src.[auto]						,'') 
		   OR ISNULL(tgt.[flags]					,'') <>								 ISNULL(src.[flags]						,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))<>							 ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[h]						,'') <>								 ISNULL(src.[h]							,'') 
		   OR ISNULL(tgt.[interpolation_mode]		,'') <>								 ISNULL(src.[interpolation_mode]		,'') 
		   OR ISNULL(tgt.[monitor]					,'') <>								 ISNULL(src.[monitor]					,'') 
		   OR ISNULL(tgt.[name]						,'') <>	LTRIM(RTRIM(				 ISNULL(src.[name]						,''))) 
		   OR ISNULL(tgt.[parent_id]				,'') <>								 ISNULL(src.[parent_id]					,'') 
		   OR ISNULL(tgt.[recurs]					,'') <>								 ISNULL(src.[recurs]					,'') 
		   OR ISNULL(tgt.[shortest]					,'') <>								 ISNULL(src.[shortest]					,'') 
		   OR ISNULL(tgt.[w]						,'') <>								 ISNULL(src.[w]							,'')
		   OR ISNULL(tgt.[x]						,'') <>								 ISNULL(src.[x]							,'') 
		   OR ISNULL(tgt.[y]						,'') <>								 ISNULL(src.[y]							,'')  
		   OR ISNULL(tgt.[tracking_monitor_id]		,'') <>	LTRIM(RTRIM(CONVERT(VARCHAR(8000),ISNULL(src.[tracking_monitor_id]	,'')))) 
		   OR ISNULL(tgt.[show_last_events]			,'') <>								 ISNULL(src.[show_last_events]			,'') 
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time 
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1
OUTPUT 
					src.[alarm_top]
      ,				src.[auto]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[h]
      ,				src.[id]
      ,				src.[interpolation_mode]
      ,				src.[monitor]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[recurs]
      ,				src.[shortest]
      ,				src.[w]
      ,				src.[x]
      ,				src.[y]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[tracking_monitor_id])))
      ,				src.[show_last_events]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_MAP (
        [alarm_top]
		,[auto]
		,[flags]
		,[guid]
		,[h]
		,[id]
		,[interpolation_mode]
		,[monitor]
		,[name]
		,[parent_id]
		,[recurs]
		,[shortest]
		,[w]
		,[x]
		,[y]
		,[tracking_monitor_id]
		,[show_last_events]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
        [alarm_top]
		,[auto]
		,[flags]
		,[guid]
		,[h]
		,[id]
		,[interpolation_mode]
		,[monitor]
		,[name]
		,[parent_id]
		,[recurs]
		,[shortest]
		,[w]
		,[x]
		,[y]
		,[tracking_monitor_id]
		,[show_last_events]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
		   tgt.[alarm_top]				=						src.[alarm_top] 
		   ,tgt.[auto]					=						src.[auto]
		   ,tgt.[flags]					=						src.[flags]
		   ,tgt.[guid]					=						src.[guid]
		   ,tgt.[h]						=						src.[h]
		   ,tgt.[interpolation_mode]	=						src.[interpolation_mode]
		   ,tgt.[monitor]				=						src.[monitor]
		   ,tgt.[name]					=			LTRIM(RTRIM(src.[name])) 
		   ,tgt.[parent_id]				=					    src.[parent_id]
		   ,tgt.[recurs]				=						src.[recurs]	
		   ,tgt.[shortest]				=						src.[shortest]	
		   ,tgt.[w]						=						src.[w]		
		   ,tgt.[x]						=						src.[x]		
		   ,tgt.[y]						=						src.[y]		
		   ,tgt.[tracking_monitor_id]	=	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[tracking_monitor_id]))) 
		   ,tgt.[show_last_events]		=						src.[show_last_events] 
		  	
		  ,tgt.[is_inferred]			= 0
		  
FROM dw.DIM_OBJ_MAP tgt
INNER JOIN IntellectSTG.stg.OBJ_MAP AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_MAP as tgt
USING IntellectSTG.stg.OBJ_MAP AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
					src.[alarm_top]
      ,				src.[auto]
      ,				src.[flags]
      ,				src.[guid]
      ,				src.[h]
      ,				src.[id]
      ,				src.[interpolation_mode]
      ,				src.[monitor]
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[recurs]
      ,				src.[shortest]
      ,				src.[w]
      ,				src.[x]
      ,				src.[y]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[tracking_monitor_id])))
      ,				src.[show_last_events]
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_MAP (
         [alarm_top]
		,[auto]
		,[flags]
		,[guid]
		,[h]
		,[id]
		,[interpolation_mode]
		,[monitor]
		,[name]
		,[parent_id]
		,[recurs]
		,[shortest]
		,[w]
		,[x]
		,[y]
		,[tracking_monitor_id]
		,[show_last_events]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
        [alarm_top]
		,[auto]
		,[flags]
		,[guid]
		,[h]
		,[id]
		,[interpolation_mode]
		,[monitor]
		,[name]
		,[parent_id]
		,[recurs]
		,[shortest]
		,[w]
		,[x]
		,[y]
		,[tracking_monitor_id]
		,[show_last_events]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_MAP WHERE id = tmp.id AND valid_to IS NULL)
GO






/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_MAPLAYER]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_MAPLAYER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_MAPLAYER]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_MAPLAYER]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[layer_file] [varchar](8000) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[version] [int] NULL,
	[xml] [varchar](8000) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_MAPLAYER as tgt
USING IntellectSTG.stg.OBJ_MAPLAYER AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
		[flags],
		[guid],
		[id],
		[layer_file],
		[name],
		[parent_id],
		[version],
		[xml]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
     				src.[flags]
      ,				src.[guid]
      ,				src.[id]
	  ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[layer_file])))
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[version]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[xml])))
      
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, строка не является inferred и строка не является новой записью, т.е. данные обновились
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1  --AND tgt.is_deleted <> 1
		 AND (		      
		      ISNULL(tgt.[flags]					,'') <>								 ISNULL(src.[flags]						,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))<>							 ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[layer_file]				,'') <>	LTRIM(RTRIM(CONVERT(VARCHAR(8000),ISNULL(src.[layer_file]					,''))))		 
		   OR ISNULL(tgt.[name]						,'') <>	LTRIM(RTRIM(				 ISNULL(src.[name]						,''))) 
		   OR ISNULL(tgt.[parent_id]				,'') <>								 ISNULL(src.[parent_id]					,'') 
		   OR ISNULL(tgt.[version]					,'') <>								 ISNULL(src.[version]					,'') 
		   OR ISNULL(tgt.[xml]						,'') <>	LTRIM(RTRIM(CONVERT(VARCHAR(8000),ISNULL(src.[xml]					,''))))		  
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time 
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1
OUTPUT 
     				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[layer_file])))
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[version]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[xml])))
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_MAPLAYER (
		[flags],
		[guid],
		[id],
		[layer_file],
		[name],
		[parent_id],
		[version],
		[xml]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
		[flags],
		[guid],
		[id],
		[layer_file],
		[name],
		[parent_id],
		[version],
		[xml]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[flags]							=					 			src.[flags]
	,tgt.[guid]								=					 			src.[guid]
	,tgt.[layer_file]							=	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[layer_file]								)))	
	,tgt.[name]								=					LTRIM(RTRIM(src.[name]								))
	,tgt.[parent_id]						=					 			src.[parent_id]
	,tgt.[version]							=					 			src.[version]
	,tgt.[xml]							=	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[xml]								)))	
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_MAPLAYER tgt
INNER JOIN IntellectSTG.stg.OBJ_MAPLAYER AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_MAPLAYER as tgt
USING IntellectSTG.stg.OBJ_MAPLAYER AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
     				src.[flags]
      ,				src.[guid]
      ,				src.[id]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[layer_file])))
      ,	LTRIM(RTRIM(src.[name]										))
      ,				src.[parent_id]
      ,				src.[version]
      ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[xml])))
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_MAPLAYER (
		[flags],
		[guid],
		[id],
		[layer_file],
		[name],
		[parent_id],
		[version],
		[xml]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
		[flags],
		[guid],
		[id],
		[layer_file],
		[name],
		[parent_id],
		[version],
		[xml]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_MAPLAYER WHERE id = tmp.id AND valid_to IS NULL)
GO





/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_MACRO]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_MACRO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_MACRO]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_MACRO]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hidden] [int] NULL,
	[id] [varchar](40) NULL,
	[local] [int] NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[state] [varchar](30) NULL,
	[delay] [int] NULL,
	[hotkey] [varchar] (8000) NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_MACRO as tgt
USING IntellectSTG.stg.OBJ_MACRO AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
		[flags],
		[guid],
		[hidden],
		[id],
		[local],
		[name],
		[parent_id], 
		[state],
		[delay],
		[hotkey]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
     				src.[flags]
      ,				src.[guid]
      ,				src.[hidden]
      ,				src.[id]
	  ,				src.[local]
	  ,	LTRIM(RTRIM(src.[name]										))
	  ,				src.[parent_id]
	  ,				src.[state]
	  ,				src.[delay]
	  ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[hotkey])))     
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, строка не является inferred и строка не является новой записью, т.е. данные обновились
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1  --AND tgt.is_deleted <> 1
		 AND (		      
		      ISNULL(tgt.[flags]					,'') <>								 ISNULL(src.[flags]						,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1))<>							 ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[hidden]					,'') <>								 ISNULL(src.[hidden]					,'') 
		   OR ISNULL(tgt.[local]					,'') <>								 ISNULL(src.[local]						,'') 
		   OR ISNULL(tgt.[name]						,'') <>	LTRIM(RTRIM(				 ISNULL(src.[name]						,''))) 
		   OR ISNULL(tgt.[parent_id]				,'') <>								 ISNULL(src.[parent_id]					,'') 
		   OR ISNULL(tgt.[state]					,'') <>								 ISNULL(src.[state]						,'') 
		   OR ISNULL(tgt.[delay]					,'') <>								 ISNULL(src.[delay]						,'') 
		   OR ISNULL(tgt.[hotkey]					,'') <>	LTRIM(RTRIM(CONVERT(VARCHAR(8000),ISNULL(src.[hotkey]				,''))))		  
		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time 
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1
OUTPUT 
     				src.[flags]
      ,				src.[guid]
      ,				src.[hidden]
      ,				src.[id]
	  ,				src.[local]
	  ,	LTRIM(RTRIM(src.[name]										))
	  ,				src.[parent_id]
	  ,				src.[state]
	  ,				src.[delay]
	  ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[hotkey])))    
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_MACRO (
		[flags],
		[guid],
		[hidden],
		[id],
		[local],
		[name],
		[parent_id], 
		[state],
		[delay],
		[hotkey]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
		[flags],
		[guid],
		[hidden],
		[id],
		[local],
		[name],
		[parent_id], 
		[state],
		[delay],
		[hotkey]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[flags]							=					 			src.[flags]
	,tgt.[guid]								=					 			src.[guid]
	,tgt.[hidden] 							=					 			src.[hidden]
	,tgt.[local] 							=					 			src.[local]
	,tgt.[name]								=					LTRIM(RTRIM(src.[name]								))
	,tgt.[parent_id]						=					 			src.[parent_id]
	,tgt.[state] 							=					 			src.[state]
	,tgt.[delay]  							=					 			src.[delay]
	,tgt.[hotkey]							=	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[hotkey]								)))	
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_MACRO tgt
INNER JOIN IntellectSTG.stg.OBJ_MACRO AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_MACRO as tgt
USING IntellectSTG.stg.OBJ_MACRO AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
     				src.[flags]
      ,				src.[guid]
      ,				src.[hidden]
      ,				src.[id]
	  ,				src.[local]
	  ,	LTRIM(RTRIM(src.[name]										))
	  ,				src.[parent_id]
	  ,				src.[state]
	  ,				src.[delay]
	  ,	LTRIM(RTRIM(CONVERT(VARCHAR(8000),src.[hotkey])))   
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_MACRO (
		[flags],
		[guid],
		[hidden],
		[id],
		[local],
		[name],
		[parent_id], 
		[state],
		[delay],
		[hotkey]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
		[flags],
		[guid],
		[hidden],
		[id],
		[local],
		[name],
		[parent_id], 
		[state],
		[delay],
		[hotkey]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_MACRO WHERE id = tmp.id AND valid_to IS NULL)
GO



/****** Object:  StoredProcedure [dw].[usp_SCD_DIM_SCRIPT]   ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_DIM_SCRIPT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_DIM_SCRIPT]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_DIM_SCRIPT]
	@extract_time AS DATETIME
AS
DECLARE @tempTable TABLE(
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [varchar](40) NULL,
	[name] [varchar](60) NULL,
	[parent_id] [varchar](40) NULL,
	[script] [ntext] NULL,
	[time_zone] [varchar](16) NULL,
	[type] [int] NULL,
	
	[MergeAction] [varchar](10) NULL)

MERGE INTO dw.DIM_OBJ_SCRIPT as tgt
USING IntellectSTG.stg.OBJ_SCRIPT AS src	   
ON (tgt.id=src.id)
--Не совпали (во второй таблице есть запись которой нет в первой, т.е появились новые записи)
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (
		[flags],
		[guid],
		[id],
		[name],
		[parent_id], 
		[script],
		[time_zone],
		[type]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
      VALUES (
     				src.[flags]
      ,				src.[guid]
      ,				src.[id]
	  ,	LTRIM(RTRIM(src.[name]										))
	  ,				src.[parent_id]
	  ,				src.[script]
	  ,				src.[time_zone]
	  ,				src.[type]  
                 
      ,@extract_time
      ,NULL
      ,0)
--Совпали и есть различия в столбцах, строка не является inferred и строка не является новой записью, т.е. данные обновились
WHEN MATCHED 
	AND tgt.valid_to IS NULL AND tgt.is_inferred <> 1  --AND tgt.is_deleted <> 1
		 AND (		      
		      ISNULL(tgt.[flags]									,'') <>								   ISNULL(src.[flags]						,'') 
		   OR ISNULL(tgt.[guid],CONVERT(VARBINARY(16),0,1)			   ) <>								   ISNULL(src.[guid],	CONVERT(VARBINARY(16),0,1)) 
		   OR ISNULL(tgt.[name]										,'') <>					   LTRIM(RTRIM(ISNULL(src.[name]						,''))) 
		   OR ISNULL(tgt.[parent_id]								,'') <>								   ISNULL(src.[parent_id]					,'') 
		   OR CAST(ISNULL(tgt.[script],'') AS NVARCHAR(MAX))    <>	CAST(ISNULL(src.[script],'') AS NVARCHAR(MAX))		  
		   OR ISNULL(tgt.[time_zone]				,'') <>								 ISNULL(src.[time_zone]					,'') 
		   OR ISNULL(tgt.[type]						,'') <>								 ISNULL(src.[type]						,'') 
		   		   
		   ) 
	
	THEN UPDATE SET tgt.valid_to = @extract_time 
--Есть запись в первой таблице, которой нет во второй, т.е запись удалена
WHEN NOT MATCHED BY SOURCE
	AND tgt.valid_to IS NULL
    THEN UPDATE SET tgt.valid_to = @extract_time, tgt.is_deleted = 1
OUTPUT 
     				src.[flags]
      ,				src.[guid]
      ,				src.[id]
	  ,	LTRIM(RTRIM(src.[name]										))
	  ,				src.[parent_id]
	  ,				src.[script]
	  ,				src.[time_zone]
	  ,				src.[type]    
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

--вставляем измененные строки
INSERT INTO dw.DIM_OBJ_SCRIPT (
		[flags],
		[guid],
		[id],
		[name],
		[parent_id], 
		[script],
		[time_zone],
		[type]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
		[flags],
		[guid],
		[id],
		[name],
		[parent_id], 
		[script],
		[time_zone],
		[type]
      
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
WHERE tmp.MergeAction = 'UPDATE' and tmp.id is not null

--обновляем inferred строки
UPDATE 	tgt
SET 
	 tgt.[flags]							=					 			src.[flags]
	,tgt.[guid]								=					 			src.[guid]
	,tgt.[name]								=					LTRIM(RTRIM(src.[name]								))
	,tgt.[parent_id]						=					 			src.[parent_id]
	,tgt.[script] 							=					 			src.[script]
	,tgt.[time_zone]  						=					 		    src.[time_zone]
	,tgt.[type]								=								src.[type]								
	
	,tgt.[is_inferred]			= 0
FROM dw.DIM_OBJ_SCRIPT tgt
INNER JOIN IntellectSTG.stg.OBJ_SCRIPT AS src ON tgt.id = src.id
WHERE tgt.is_inferred = 1 AND tgt.valid_to IS NULL


--вставляем "новые" строки, с id, которые ранее уже были присвоены другим записям (фишечка от intellect'а)
DELETE FROM @tempTable

MERGE INTO dw.DIM_OBJ_SCRIPT as tgt
USING IntellectSTG.stg.OBJ_SCRIPT AS src	   
ON (tgt.id=src.id)
WHEN MATCHED 
	AND tgt.is_deleted = 1
	THEN UPDATE SET tgt.is_deleted = 0
OUTPUT 
     				src.[flags]
      ,				src.[guid]
      ,				src.[id]
	  ,	LTRIM(RTRIM(src.[name]										))
	  ,				src.[parent_id]
	  ,				src.[script]
	  ,				src.[time_zone]
	  ,				src.[type] 
	  
	  ,$Action AS MergeAction
INTO @tempTable 
;

INSERT INTO dw.DIM_OBJ_SCRIPT (
		[flags],
		[guid],
		[id],
		[name],
		[parent_id], 
		[script],
		[time_zone],
		[type]
            
      ,[valid_from]
      ,[valid_to]
      ,[is_inferred])
SELECT 
		[flags],
		[guid],
		[id],
		[name],
		[parent_id], 
		[script],
		[time_zone],
		[type]
                 
      ,@extract_time
      ,NULL
      ,0
FROM @tempTable tmp
--отсеиваем строки, которые могли уже быть добавлены (например как infreded)
WHERE NOT EXISTS (SELECT 1 FROM dw.DIM_OBJ_SCRIPT WHERE id = tmp.id AND valid_to IS NULL)
GO







/****** Object:  StoredProcedure [dw].[usp_SCD_photo]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_SCD_photo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_SCD_photo]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_SCD_photo]
	@extract_time AS DATETIME
AS
BEGIN
	-----ЗАГРУЗКА ФОТОГРАФИЙ----------------
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[photo]') AND type in (N'U'))
	BEGIN
		--PRINT 'Начинаем загрузку фото'
		DECLARE
			@person_key AS int, 
			@photo_key AS int,
			@id AS varchar(40), 
			--путь для папки с фотографиями
			@photo_dir AS nvarchar(255) = '\\DOM2SERVERSKUD\C$\Program Files (x86)\Интеллект\Bmp\Person\',
			--@photo_dir AS nvarchar(255)= 'C:\Program Files\Интеллект\Bmp\Person\',
			@photo_file_path AS nvarchar(255),
			@photo_load_result AS bit,
			@photo_md5 AS varbinary(128)
		
		
		DECLARE C CURSOR FAST_FORWARD FOR 
			SELECT  [person_key],
					[id]					
			FROM dw.DIM_OBJ_PERSON
			WHERE [valid_to] IS NULL 
				AND [photo_key] IS NULL
				--AND (CAST([ID] AS int) >= 300 AND CAST([ID] AS int) < 400) 
			OPEN C 
			FETCH NEXT FROM C INTO 
					@person_key,
					@id				
			WHILE @@fetch_status = 0 
			BEGIN				
				--PRINT 'Начинаем проверку  @photo_key_parent. ID: ' +   @id + ', person_key: ' + CAST(@person_key AS VARCHAR(20))	 		
				--пытаемся загрузить фото во временную таблицу
				SET @photo_file_path = @photo_dir + @id + '.bmp'
				SET @photo_load_result = 0
				EXEC dw.load_photo @file_path = @photo_file_path, 
					@result = @photo_load_result OUTPUT
				--если фото загрузилось
				IF @photo_load_result = 1
				BEGIN
					SET @photo_md5 = (SELECT master.sys.fn_repl_hash_binary(photo) FROM IntellectSTG.stg.photo_temp)
					--ищем в базе такое же фото, если находим, присваиваем ссылку на это фото	
					SET @photo_key = (SELECT [photo_key] FROM dw.photo WHERE [photo_md5] = @photo_md5)
					--если не нашли такое же фото в базе
					IF @photo_key IS NULL
					BEGIN					
						--вставляем в базу новое фото
						INSERT dw.photo ([photo], [photo_md5], [valid_from]) SELECT photo, @photo_md5, @extract_time  FROM IntellectSTG.stg.photo_temp
						SET @photo_key = SCOPE_IDENTITY()						
					END
				END					
				--обновляем данные о фото у сотрудника
				IF @photo_key IS NOT NULL
				BEGIN
					BEGIN TRAN
						UPDATE dw.DIM_OBJ_PERSON SET [photo_key] = @photo_key WHERE [person_key] = @person_key						
						UPDATE photo SET [valid_to] = NULL FROM dw.photo    
							JOIN dw.DIM_OBJ_PERSON ON dw.DIM_OBJ_PERSON.[photo_key] =  dw.photo.[photo_key]
							WHERE dw.DIM_OBJ_PERSON.[person_key] = @person_key
					COMMIT TRAN
				END
				SET @person_key = NULL 
				SET @photo_key = NULL
				SET @id = NULL
				SET @photo_md5 = NULL 
				FETCH NEXT FROM C INTO
					@person_key,
					@id					
			END
			CLOSE C 
			DEALLOCATE C
			
			--помечаем фотографии, которых больше нет в оперативной базе, как удаленные 
			UPDATE dw.photo SET valid_to = @extract_time 
			WHERE photo_key IN (
				SELECT photo_key FROM (
					SELECT DISTINCT p1.photo_key FROM dw.DIM_OBJ_PERSON p1 
					--JOIN dw.photo ph ON p1.photo_key = ph.photo_key --AND ph.valid_to IS NOT NULL
					LEFT JOIN dw.DIM_OBJ_PERSON p2 ON  p2.photo_key = p1.photo_key AND p2.valid_to IS NULL 
					WHERE p1.photo_key IS NOT NULL 
						AND p1.valid_to IS NOT NULL
						AND p2.photo_key IS NULL) AS [inactive_photo])
			AND valid_to IS NULL
	END
END
GO






/****** Object:  StoredProcedure [dw].[usp_LoadFactProtocol]    Script Date: 04/20/2018 12:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_LoadFactProtocol]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_LoadFactProtocol]
GO

USE [IntellectDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_LoadFactProtocol]
AS
	DECLARE	
	@num AS int,
	@objtype AS VARCHAR (50), 
	@objid AS VARCHAR (50),
	@action AS VARCHAR (50),
	@param0 AS VARCHAR (255),
	@param1 AS VARCHAR (60),
	@param2 AS VARCHAR (255), 
	@param3 AS VARCHAR (255),
	@param4 AS VARCHAR (400),
	@date AS DATETIME,
	@server_date AS DATETIME,
	@owner AS VARCHAR (50),
	@pk AS UNIQUEIDENTIFIER,
			
	@person_id AS VARCHAR (40),
	@person_name AS VARCHAR (255),
	@person_surname AS VARCHAR (255),
	@person_patronymic AS VARCHAR (255),
	@person_parent_id AS VARCHAR (40),
	@person_dept_name AS VARCHAR (255),
	@user_id [varchar](50),
    @user_name [varchar](255),
	@user_surname [varchar](255),
	@user_patronymic [varchar](255),
	@user_parent_id [varchar](40),
	
	@event_key AS INT,
	@person_key AS INT,
	@dept_key AS INT,
	@nc32k_key AS INT,
	@ac_key AS INT,
	@ac_part_key AS INT,
	@ip_gate_key AS INT,
	@cam_key AS INT,
	@photo_ident_key AS INT,
	@photo_ident_but_key AS INT,
	@user_key AS INT,
	@owner_key AS INT,
	@slave_key AS INT,
	@params AS VARCHAR(1000),
	@last_load_stg_protocol_num AS int,
	@is_valid_event AS bit = 0, --флаг сохранения события в базу
	@last_load_param_name AS varchar(255) = 'last_load_stg_protocol_num' --имя параметра последней загрузки
	
	IF NOT EXISTS (SELECT num FROM dw.import_log WHERE [param] = @last_load_param_name)
	BEGIN
		INSERT INTO dw.import_log ([param],[num]) VALUES (@last_load_param_name,0)
		SET @last_load_stg_protocol_num = 0
	END
	ELSE
	BEGIN
		SET @last_load_stg_protocol_num = (SELECT [num] FROM dw.import_log WHERE [param] = @last_load_param_name)
	END
	PRINT @last_load_param_name + ': ' + CAST(@last_load_stg_protocol_num AS varchar(20))
	DECLARE @error AS INT = 0 --наличие ошибки в теле курсора
	DECLARE C CURSOR FAST_FORWARD FOR 
	SELECT  [num] 
			,[objtype]
			,[objid]
			,[action]
			,[param0]
			,[param1]
			,[param2]
			,[param3]
			,[param4]
			,[person_id]
			,[person_name]
			,[person_surname]
			,[person_patronymic]
			,[person_parent_id]
			,[person_dept_name]
			,[user_id]
			,[user_name]
			,[user_surname]
			,[user_patronymic]
			,[user_parent_id]
			,[date]
			,[server_date]
			,[owner]
			,[pk]
	FROM IntellectSTG.stg.PROTOCOL WHERE [num] > @last_load_stg_protocol_num
	ORDER BY IntellectSTG.stg.PROTOCOL.[date]
	OPEN C 
	FETCH NEXT FROM C INTO 
			@num,
			@objtype, 
			@objid,
			@action,
			@param0,
			@param1,
			@param2, 
			@param3,
			@param4,
			@person_id,
			@person_name,
			@person_surname,
			@person_patronymic,
			@person_parent_id,
			@person_dept_name,					
			@user_id,
			@user_name,
			@user_surname,
			@user_patronymic,
			@user_parent_id,			
			@date,
			@server_date,
			@owner,
			@pk
	WHILE @@fetch_status = 0 AND @error = 0
	BEGIN 
		PRINT '@num: ' + CAST(@num as varchar(20)) + ', @objtype: ' + @objtype + ', @objid: ' + @objid + ', @action: ' + @action + ', @pk: ' + CAST(@pk as varchar(40))
		IF EXISTS (SELECT 1 FROM dw.FACT_PROTOCOL WHERE [guid] = @pk)
		BEGIN
			DECLARE @ErrorMessage NVARCHAR(4000)
			SET @ErrorMessage = 'IntellectDW. Попытка вставить в dw.FACT_PROTOCOL уже имеющуюся строку! GUID строки: ' + CAST(@pk AS NVARCHAR(60)) 
			RAISERROR (@ErrorMessage, -- Message text.  
					   10, -- Severity.  
					   1 -- State.  
					   )  --WITH LOG
			UPDATE dw.import_log SET [num] = @num, [date] = @server_date WHERE [param] = @last_load_param_name
			
			FETCH NEXT FROM C INTO 
				@num,
				@objtype, 
				@objid,
				@action,
				@param0,
				@param1,
				@param2, 
				@param3,
				@param4,
				@person_id,
				@person_name,
				@person_surname,
				@person_patronymic,
				@person_parent_id,
				@person_dept_name,					
				@user_id,
				@user_name,
				@user_surname,
				@user_patronymic,
				@user_parent_id,			
				@date,
				@server_date,
				@owner,
				@pk
		END
		ELSE
		BEGIN TRY			
			PRINT 'Попал в BEGIN TRY'
			PRINT '@num: ' + CAST(@num as varchar(20)) + ', @objtype: ' + @objtype + ', @objid: ' + @objid + ', @action: ' + @action + ', @pk: ' + CAST(@pk as varchar(40))
			IF(ISNULL(@param0,'')='')		
			BEGIN
				SET @param0 = null
			END
			
			EXEC dw.usp_GetDimEventKey 
				@objtype = @objtype, 
				@action = @action, 
				@event_key = @event_key OUTPUT
			
			EXEC dw.usp_GetDimSlaveKey 
				@slave_id = @owner, 
				@valid_from = @date,
				@slave_key = @owner_key OUTPUT 
			
			IF (ISNULL(@person_id,'') <> '')				
				EXEC dw.usp_GetDimPersonKey 
					@person_id = @person_id,
					@person_name = @person_name,
					@person_surname = @person_surname,
					@person_patronymic = @person_patronymic,
					@person_parent_id = @person_parent_id,
					@valid_from = @date,
					@person_key = @person_key OUTPUT 
				
			IF (ISNULL(@person_parent_id,'') <> '') 
				EXEC dw.usp_GetDimDeptKey 
					@dept_id = @person_parent_id, 
					@dept_name = @person_dept_name, 
					@valid_from = @date, 
					@dept_key = @dept_key OUTPUT				
				
			IF (ISNULL(@user_id,'') <> '')
				EXEC dw.usp_GetDimUserKey 
					@user_id = @user_id,
					@user_name = @user_name,
					@user_surname = @user_surname,
					@user_patronymic = @user_patronymic,
					@user_parent_id = @user_parent_id,
					@valid_from = @date,
					@user_key = @user_key OUTPUT			
			
			IF @objtype  = 'PNET3_NC32K'
			BEGIN			
				EXEC dw.usp_GetDimNc32kKey 
						@nc32k_id = @objid,
						@valid_from = @date,
						@nc32k_key = @nc32k_key OUTPUT
				--IF ((ISNULL(@person_id,'') <> '') OR @action IN ('EVENTEB','EVENTCA'))
				--	SET @is_valid_event = 1
				
				IF (ISNULL(@person_id,'') <> '')
				BEGIN
					SET @is_valid_event = 1
					IF(ISNULL(@param2,'') <> '') SET @params  = @param2					 
				END
								
				ELSE IF(@objid NOT IN ('2.1','2.2','2.3','2.4','2.5','2.6','1.260','1.269')
							   AND (@action IN (										
											   'EVENTE2' --Дверь открыта с ПК
											  ,'EVENTE3' --Дверь закрыта с ПК
											  ,'EVENTA2' --В доступе отказано (нет ключа в БД контроллера)
											  ,'EVENTE6' --Реле включено с ПК
											  ,'EVENTE7' --Реле выключено с ПК
											  ,'EVENTEB' --Фактический выход по RTE
											  ,'EVENTA7' --Дверь оставлена открытой
											  ,'EVENTA8' --Незакрытая дверь закрыта
											  ,'EVENTCA' --Фактический выход по DRTE
											  ,'SECURED_UNLOCK' --Контролируемая дверь открыта
											  ,'EVENT81' --Взлом двери
											  ,'EVENT8A' --Дверь после взлома закрыта
											  ,'EVENT86' --Аварийное открывание двери
											  ,'EVENT87' --Аварийное открывание двери сброшено
											  ,'EVENTB4' --Снята с охраны с ПК
											  ,'EVENTB3' --Взята на охрану с ПК
											  ,'EVENTAF' --Включена абсолютная блокировка
											  ,'EVENTB1' --Снята абсолютная блокировка с ПК
											  ,'EVENTB0' --Включена относительная блокировка
											  ,'EVENTB9' --Снята относительная блокировка
											  )))
				BEGIN
					SET @is_valid_event = 1
					SET @params  = @param0
				END
				
				ELSE IF((@objid IN ('2.1','2.2','2.3','2.4','2.5','2.6','1.260','1.269'))
						AND (@action NOT IN (
											 'EVENTE2' --Дверь открыта с ПК
											,'EVENTE3' --Дверь закрыта с ПК
											--,'EVENTA2' --В доступе отказано (нет ключа в БД контроллера)
											,'EVENTE6' --Реле включено с ПК
											,'EVENTE7' --Реле выключено с ПК
											)))
				BEGIN
					SET @is_valid_event = 1
					SET @params  = @param0
				END					 	
			END			
			
			ELSE IF (@objtype = 'PHOTO_IDENT' AND @action = 'PUSH_BUTTON')
			BEGIN
				EXEC dw.usp_GetDimPhotoIdentKey
					@photo_ident_id = @objid,
					@valid_from = @date,
					@photo_ident_key = @photo_ident_key OUTPUT
				
				IF (@param1 IS NOT NULL)
				BEGIN		
					DECLARE @pi_obj_type AS VARCHAR(60),
							@pi_obj_id AS VARCHAR(40)
					SELECT @pi_obj_type = part0,
						   @pi_obj_id = part1 
					FROM dw.ufn_ParsePhotoIdentParams(@param1)
					
					IF (@pi_obj_type = 'PNET3_NC32K')
					BEGIN
						IF (ISNULL(@pi_obj_id,'') <> '')
						EXEC dw.usp_GetDimNc32kKey 
							@nc32k_id = @pi_obj_id,
							@valid_from = @date,
							@nc32k_key = @nc32k_key OUTPUT
					END
				END		
				
				IF (@param4 IS NOT NULL)
				BEGIN
					DECLARE	@pi_main_id AS VARCHAR(255),
							@pi_line_id AS VARCHAR(255),
							@pi_button_name AS VARCHAR(40)										
				
					SELECT @pi_main_id = part0,
						   @pi_line_id = part1,
						   @pi_button_name = part2					   
					FROM dw.ufn_ParsePhotoIdentParams(@param4)				
					
					EXEC dw.usp_GetDimPhotoIdentButKey
						@photo_ident_id = @objid,
						@line_id = @pi_line_id,
						@button_name = @pi_button_name,
						@valid_from = @date,
						@photo_ident_but_key = @photo_ident_but_key OUTPUT					
				END			
				
				IF (ISNULL(@person_id,'') <> ''	AND ISNULL(@user_id,'') <> '')				
					SET @is_valid_event = 1				
			END
			
			ELSE IF @objtype  = 'PNET3_AC'
			BEGIN
				EXEC dw.usp_GetDimAcKey 
					@ac_id = @objid,
					@valid_from = @date,
					@ac_key = @ac_key OUTPUT
				SET @is_valid_event = 1				
			END
			
			ELSE IF @objtype  = 'PNET3_AC_PART'
			BEGIN
				EXEC dw.usp_GetDimAcPartKey 
					@ac_part_id = @objid,
					@valid_from = @date,
					@ac_part_key = @ac_part_key OUTPUT
				SET @is_valid_event = 1				
			END
			
			ELSE IF @objtype  = 'PNET3_IP_GATE'
			BEGIN
				EXEC dw.usp_GetDimIpGateKey 
					@ip_gate_id = @objid,
					@valid_from = @date,
					@ip_gate_key = @ip_gate_key OUTPUT
				SET @is_valid_event = 1				
			END
			
			ELSE IF @objtype  = 'PERSON'
			BEGIN				
				IF (@action IN ('REGISTERED','UNREGISTERED'))
					EXEC dw.usp_GetDimSlaveKey 
					@slave_id = @param1, 
					@valid_from = @date,
					@slave_key = @slave_key OUTPUT
				
				IF (ISNULL(@user_id,'') <> '' AND ISNULL(@param1,'') <> '')
					SET @is_valid_event = 1									
			END		
			
			IF (@is_valid_event = 1)		
			BEGIN
				--BEGIN TRAN
					PRINT 'Начинаю вставку в dw.FACT_PROTOCOL'
					PRINT '@event_key: ' + CAST(@event_key as varchar(20)) + ', GUID строки: ' + CAST(@pk AS NVARCHAR(60))	
					INSERT INTO dw.FACT_PROTOCOL 
							([event_key]
							,[date]
							,[server_date]
							,[person_key] 
							,[dept_key] 
							,[nc32k_key] 
							,[ac_key] 
							,[ac_part_key]  
							,[ip_gate_key] 
							,[cam_key]					
							,[photo_ident_key]
							,[photo_ident_but_key]
							,[user_key]					
							,[owner_key]
							,[slave_key]
							,[params]
							,[guid])
					VALUES ( @event_key
							,@date
							,@server_date
							,@person_key
							,@dept_key
							,@nc32k_key
							,@ac_key
							,@ac_part_key
							,@ip_gate_key
							,@cam_key
							,@photo_ident_key
							,@photo_ident_but_key
							,@user_key					
							,@owner_key
							,@slave_key
							,@params
							,@pk)				
					UPDATE dw.import_log SET [num] = @num, [date] = @server_date WHERE [param] = @last_load_param_name
					
				--COMMIT TRAN
			END
			
			SET @num = NULL
			SET @objtype = NULL 
			SET @objid = NULL
			SET @action = NULL
			SET @param0 = NULL
			SET @param1 = NULL
			SET @param2 = NULL 
			SET @param3 = NULL
			SET @person_id = NULL
			SET @person_name = NULL
			SET @person_surname = NULL
			SET @person_patronymic = NULL
			SET @person_parent_id = NULL
			SET @person_dept_name = NULL					
			SET @user_id = NULL
			SET @user_name = NULL
			SET @user_surname = NULL
			SET @user_patronymic = NULL
			SET @user_parent_id = NULL			
			SET @date = NULL
			SET @server_date = NULL
			SET @owner = NULL
			SET @pk = NULL		
			SET @event_key  = NULL
			SET @person_key  = NULL
			SET @dept_key  = NULL
			SET @nc32k_key  = NULL
			SET @ac_key  = NULL
			SET @ac_part_key  = NULL
			SET @ip_gate_key  = NULL
			SET @cam_key  = NULL
			SET @photo_ident_key  = NULL
			SET @photo_ident_but_key  = NULL
			SET @user_key  = NULL
			SET @owner_key  = NULL
			SET @slave_key = NULL
			SET @params  = NULL
			SET @is_valid_event = 0
						
			FETCH NEXT FROM C INTO 
				@num,
				@objtype, 
				@objid,
				@action,
				@param0,
				@param1,
				@param2, 
				@param3,
				@param4,
				@person_id,
				@person_name,
				@person_surname,
				@person_patronymic,
				@person_parent_id,
				@person_dept_name,					
				@user_id,
				@user_name,
				@user_surname,
				@user_patronymic,
				@user_parent_id,			
				@date,
				@server_date,
				@owner,
				@pk	
				
			PRINT 'Конец BEGIN TRY'		
		END TRY
		BEGIN CATCH			
			SET @error = @@ERROR
			--DECLARE @ErrorMessage NVARCHAR(4000);  
			DECLARE @ErrorSeverity INT;  
			DECLARE @ErrorState INT;
			SELECT
			@ErrorMessage = 'Ошибка в процедуре [dw].[usp_LoadFactProtocol].'  + ' GUID строки: ' + CAST(@pk AS NVARCHAR(60)) + '. ' + ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),  
			@ErrorState = ERROR_STATE(); 
			RAISERROR (@ErrorMessage, -- Message text.  
						   @ErrorSeverity, -- Severity.  
						   @ErrorState -- State.  
						   )  WITH LOG --записываем ошибку в системный журнал
			ROLLBACK TRANSACTION									
		END CATCH	
	END 
	CLOSE C 
	DEALLOCATE C

GO









/****** Object:  StoredProcedure [dw].[usp_LoadFactAudit] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[usp_LoadFactAudit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dw].[usp_LoadFactAudit]
GO

USE [IntellectDW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dw].[usp_LoadFactAudit]
AS
	DECLARE
	@num AS int,
	@objtype AS VARCHAR (50), 
	@objid AS VARCHAR (50),
	@action AS VARCHAR (50),
	@param0 AS VARCHAR (255),
	@param1 AS VARCHAR (60),
	@param2 AS VARCHAR (255), 
	@param3 AS VARCHAR (255),
	@param4 AS VARCHAR (400),
	@date AS DATETIME,
	@server_date AS DATETIME,
	@owner AS VARCHAR (50),
	@pk AS UNIQUEIDENTIFIER,
			
	
	@dept_id AS VARCHAR (40),	
	   
    
    @person_id AS VARCHAR (40),
	@person_name AS VARCHAR (255),
	@person_surname AS VARCHAR (255),
	@person_patronymic AS VARCHAR (255),
	@person_parent_id AS VARCHAR (40),
	@person_dept_name AS VARCHAR (255),
	@user_id [varchar](50),
    @user_name [varchar](255),
	@user_surname [varchar](255),
	@user_patronymic [varchar](255),
	@user_parent_id [varchar](40),
    
	
	@event_key AS INT,
	@user_key AS INT,
	@person_key AS INT,
	@dept_key AS INT,
	@level_key AS INT,
	@level_reader_key AS INT,
	@nc32k_key AS INT,
	@ac_key AS INT,
	@ac_part_key AS INT,
	@ip_gate_key AS INT,
	@grabber_key AS INT,
	@cam_key AS INT,
	@photo_ident_key AS INT,
	@photo_ident_but_key AS INT,
	
	@cam_date AS DATETIME,
	@display_key AS INT,
	@map_key AS INT,
	@maplayer_key AS INT,
	@macro_key AS INT,
	@script_key AS INT,
	@rights_key AS INT,
	
	
	@owner_key AS INT,
	@slave_key AS INT,
	@params AS VARCHAR(1000),
	@last_load_stg_protocol_audit_num AS int,
	@is_valid_event AS bit = 0, --флаг сохранения события в базу
	@last_load_param_name AS varchar(255) = 'last_load_stg_protocol_audit_num' --имя параметра последней загрузки
	
	IF NOT EXISTS (SELECT num FROM dw.import_log WHERE [param] = @last_load_param_name)
	BEGIN
		INSERT INTO dw.import_log ([param],[num]) VALUES (@last_load_param_name,0)
		SET @last_load_stg_protocol_audit_num = 0
	END
	ELSE
	BEGIN
		SET @last_load_stg_protocol_audit_num = (SELECT [num] FROM dw.import_log WHERE [param] = @last_load_param_name)
	END
	PRINT @last_load_param_name + ': ' + CAST(@last_load_stg_protocol_audit_num AS varchar(20))
	DECLARE @error AS INT = 0 --наличие ошибки в теле курсора
	DECLARE C CURSOR FAST_FORWARD FOR 
	SELECT  [num] 
			,[objtype]
			,[objid]
			,[action]
			,[param0]
			,[param1]
			,[param2]
			,[param3]
			,[param4]			
			,[person_id]
			,[person_name]
			,[person_surname]
			,[person_patronymic]
			,[person_parent_id]
			,[person_dept_name]
			,[user_id]
			,[user_name]
			,[user_surname]
			,[user_patronymic]
			,[user_parent_id]
			,[date]
			,[server_date]
			,[owner]
			,[pk]
	FROM IntellectSTG.stg.PROTOCOL WHERE [num] > @last_load_stg_protocol_audit_num
	ORDER BY IntellectSTG.stg.PROTOCOL.[date]
	OPEN C 
	FETCH NEXT FROM C INTO 
			@num,
			@objtype, 
			@objid,
			@action,
			@param0,
			@param1,
			@param2, 
			@param3,
			@param4,
			@person_id,
			@person_name,
			@person_surname,
			@person_patronymic,
			@person_parent_id,
			@person_dept_name,					
			@user_id,
			@user_name,
			@user_surname,
			@user_patronymic,
			@user_parent_id,
			@date,
			@server_date,
			@owner,
			@pk
	WHILE @@fetch_status = 0 AND @error = 0
	BEGIN 			
			PRINT '@num: ' + CAST(@num as varchar(20)) + ', @objtype: ' + @objtype + ', @objid: ' + @objid + ', @action: ' + @action + ', @pk: ' + CAST(@pk as varchar(40))
					
			IF EXISTS (SELECT 1 FROM dw.FACT_AUDIT WHERE [guid] = @pk)
			BEGIN
				DECLARE @ErrorMessage NVARCHAR(4000)
				SET @ErrorMessage = 'IntellectDW. Попытка вставить в dw.FACT_AUDIT уже имеющуюся строку! GUID строки: ' + CAST(@pk AS NVARCHAR(60)) 
				RAISERROR (@ErrorMessage, -- Message text.  
						   10, -- Severity.  
						   1 -- State.  
						   ) -- WITH LOG
				UPDATE dw.import_log SET [num] = @num, [date] = @server_date WHERE [param] = @last_load_param_name
				
				FETCH NEXT FROM C INTO 
					@num,
					@objtype, 
					@objid,
					@action,
					@param0,
					@param1,
					@param2, 
					@param3,
					@param4,
					@person_id,
					@person_name,
					@person_surname,
					@person_patronymic,
					@person_parent_id,
					@person_dept_name,					
					@user_id,
					@user_name,
					@user_surname,
					@user_patronymic,
					@user_parent_id,
					@date,
					@server_date,
					@owner,
					@pk	
			
			END
			ELSE
			BEGIN TRY
				PRINT 'Попал в BEGIN TRY'
				PRINT '@num: ' + CAST(@num as varchar(20)) + ', @objtype: ' + @objtype + ', @objid: ' + @objid + ', @action: ' + @action + ', @pk:  ' + CAST(@pk as varchar(40))
				EXEC dw.usp_GetDimEventKey 
						@objtype = @objtype, 
						@action = @action, 
						@event_key = @event_key OUTPUT
					
				EXEC dw.usp_GetDimSlaveKey 
					@slave_id = @owner, 
					@valid_from = @date,
					@slave_key = @owner_key OUTPUT
				
				IF(@objtype = 'PERSON' AND @action IN ('REGISTERED','UNREGISTERED'))
				BEGIN
					EXEC dw.usp_GetDimSlaveKey 
						@slave_id = @param1, 
						@valid_from = @date,
						@slave_key = @slave_key OUTPUT
					
					IF(ISNULL(@objid,'') <> '') SET @user_key = (SELECT person_key FROM dw.DIM_OBJ_PERSON WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					IF (@user_key IS NOT NULL) SET @is_valid_event = 1	 
				END
				
				ELSE IF(ISNULL(@param0,'') IN (  'OPERATOR'
												,'PERSON'
												,'DEPARTMENT'
												,'LEVEL'
												,'RIGHTS'
												,'SCRIPT'
												,'MACRO'
												--,'PNET3_NC32K'
												--,'PNET3_AC'
												--,'PNET3_AC_PART'
												--,'PNET3_IP_GATE'
												,'CAM'
												,'DISPLAY'
												))
				BEGIN			
					SET @is_valid_event = 1
										
					
					IF(ISNULL(@param2,'')<>'') SET @slave_key = (SELECT slave_key FROM dw.DIM_OBJ_SLAVE WHERE id = @param2 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					IF(ISNULL(@param3,'')<>'') SET @user_key = (SELECT person_key FROM dw.DIM_OBJ_PERSON WHERE id = @param3 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
																		
					
					IF(@objtype = 'PNET3_NC32K') SET @nc32k_key = (SELECT nc32k_key FROM dw.DIM_OBJ_PNET3_NC32K WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					ELSE IF(@objtype = 'PNET3_AC_PART') SET @ac_part_key = (SELECT ac_part_key FROM dw.DIM_OBJ_PNET3_AC_PART WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					ELSE IF(@objtype = 'MACRO') SET @macro_key = (SELECT macro_key FROM dw.DIM_OBJ_MACRO WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					ELSE IF(@objtype = 'SCRIPT') SET @script_key = (SELECT script_key FROM dw.DIM_OBJ_SCRIPT WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					ELSE IF(@objtype = 'MAP') SET @map_key = (SELECT map_key FROM dw.DIM_OBJ_MAP WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					ELSE IF(@objtype = 'DISPLAY') SET @display_key = (SELECT display_key FROM dw.DIM_OBJ_DISPLAY WHERE id = @objid AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					ELSE IF((@objtype = 'MONITOR') AND(@action='PLAY_START')) SET @cam_date = ISNULL([app].[ufn_TryConvertDate](@param4),'1900/01/01')
					
													
					
					
					IF(@param0 = 'PERSON' AND @person_id IS NOT NULL)
					BEGIN
							EXEC dw.usp_GetDimPersonKey 
							@person_id = @person_id,
							@person_name = @person_name,
							@person_surname = @person_surname,
							@person_patronymic = @person_patronymic,
							@person_parent_id = @person_parent_id,
							@valid_from = @date,
							@person_key = @person_key OUTPUT			
						
					END
					ELSE IF (@param0 = 'PERSON' AND @param1 IS NOT NULL)
					BEGIN 
						SET @person_key = (SELECT person_key FROM dw.DIM_OBJ_PERSON WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
					END					
					
					ELSE IF(@param0 = 'DEPARTMENT' AND @param1 <> '')
					BEGIN
						--SET @dept_key = (SELECT dept_key FROM dw.DIM_OBJ_DEPARTMENT WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
						EXEC dw.usp_GetDimDeptKey 
							@dept_id = @param1,
							@valid_from = @date,
							@dept_key = @dept_key OUTPUT	
					END
					
					ELSE IF(@param0 = 'LEVEL' AND @param1 <> '')
					BEGIN
						--SET @level_key = (SELECT level_key FROM dw.DIM_OBJ_LEVEL WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
						EXEC dw.usp_GetDimLevelKey 
							@level_id = @param1,
							@valid_from = @date,
							@level_key = @level_key OUTPUT
					END
					
					ELSE IF(@param0 = 'RIGHTS' AND @param1 <> '')
					BEGIN
						--SET @rights_key = (SELECT rights_key FROM dw.DIM_OBJ_RIGHTS WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
						EXEC dw.usp_GetDimRightsKey 
							@rights_id = @param1,
							@valid_from = @date,
							@rights_key = @rights_key OUTPUT
					END
					ELSE IF(@param0 = 'CAM' AND @param1 <> '')
					BEGIN
						--SET @cam_key = (SELECT cam_key FROM dw.DIM_OBJ_CAM WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))	
						EXEC dw.usp_GetDimCamKey 
							@cam_id = @param1,
							@valid_from = @date,
							@cam_key = @cam_key OUTPUT
					END					
					ELSE IF(@param0 = 'MACRO' AND @param1 <> '')
					BEGIN
						--SET @macro_key = (SELECT macro_key FROM dw.DIM_OBJ_MACRO WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
						EXEC dw.usp_GetDimMacroKey 
							@macro_id = @param1,
							@valid_from = @date,
							@macro_key = @macro_key OUTPUT	
					END
					
					ELSE IF(@param0 = 'SCRIPT' AND @param1 <> '')
					BEGIN
						--SET @script_key = (SELECT script_key FROM dw.DIM_OBJ_SCRIPT WHERE id = @param1 AND ((valid_from <= @date) AND (ISNULL(valid_to,'01.01.9999') > @date)))
						EXEC dw.usp_GetDimScriptKey 
							@script_id = @param1,
							@valid_from = @date,
							@script_key = @script_key OUTPUT	
					END 
					
					
					IF(     @person_key IS NULL
						AND @dept_key IS NULL
						AND @level_key IS NULL
						AND @rights_key IS NULL
						AND @cam_key IS NULL
						AND @nc32k_key IS NULL
						AND @ac_part_key IS NULL
						AND @macro_key IS NULL
						AND @script_key IS NULL
						AND @cam_key IS NULL
						AND @display_key IS NULL)
					BEGIN
						IF(@param1 <> '') SET @params = 'objtype=' + @param0 + ',objid=' + @param1
					END
					
				END			
				
				IF (@is_valid_event = 1)		
				BEGIN
					--BEGIN TRAN
					PRINT 'Начинаю вставку в dw.FACT_AUDIT'
					PRINT '@event_key: ' + CAST(@event_key as varchar(20)) + ', GUID строки: ' + CAST(@pk AS NVARCHAR(60))
						INSERT INTO dw.FACT_AUDIT 
								(
								[event_key]
							  ,[date]
							  ,[server_date]
							  ,[user_key]
							  ,[person_key]
							  ,[dept_key]
							  ,[level_key]
							  ,[nc32k_key]
							  ,[ac_key]
							  ,[ac_part_key]
							  ,[ip_gate_key]
							  ,[grabber_key]
							  ,[cam_key]
							  ,[cam_date]
							  ,[photo_ident_key]
							  ,[photo_ident_but_key]
							  ,[display_key]
							  ,[map_key]
							  ,[maplayer_key]
							  ,[macro_key]
							  ,[script_key]
							  ,[rights_key]
							  ,[owner_key]
							  ,[slave_key]
							  ,[params]
							  ,[guid]
								)
						VALUES ( 
								@event_key
							  ,@date
							  ,@server_date
							  ,@user_key
							  ,@person_key
							  ,@dept_key
							  ,@level_key
							  ,@nc32k_key
							  ,@ac_key
							  ,@ac_part_key
							  ,@ip_gate_key
							  ,@grabber_key
							  ,@cam_key
							  ,@cam_date
							  ,@photo_ident_key
							  ,@photo_ident_but_key
							  ,@display_key
							  ,@map_key
							  ,@maplayer_key
							  ,@macro_key
							  ,@script_key
							  ,@rights_key
							  ,@owner_key
							  ,@slave_key
							  ,@params
							  ,@pk
								)
					
						UPDATE dw.import_log SET [num] = @num, [date] = @server_date WHERE [param] = @last_load_param_name
					--COMMIT TRAN
				END
				
				SET @num = NULL
				SET @objtype = NULL 
				SET @objid = NULL
				SET @action = NULL
				SET @param0 = NULL
				SET @param1 = NULL
				SET @param2 = NULL 
				SET @param3 = NULL
				SET @person_id = NULL									
				SET @user_id = NULL
						
				SET @date = NULL
				SET @server_date = NULL
				SET @owner = NULL
				SET @pk = NULL
				
				SET @owner_key  = NULL
				SET @slave_key = NULL
				SET @params  = NULL		
				
				SET @event_key  = NULL
				SET @user_key  = NULL				
				SET @person_key  = NULL
				SET @dept_key  = NULL
				SET @level_key = NULL
				SET @level_reader_key = NULL
				SET @nc32k_key  = NULL
				SET @ac_key  = NULL
				SET @ac_part_key  = NULL
				SET @ip_gate_key  = NULL
				SET @grabber_key = NULL
				SET @cam_key  = NULL
				SET @photo_ident_key  = NULL
				SET @photo_ident_but_key  = NULL
							
				SET @cam_date = NULL
				SET @display_key = NULL
				SET @map_key = NULL
				SET @maplayer_key = NULL
				SET @macro_key = NULL
				SET @script_key = NULL
				SET @rights_key = NULL			
				
				SET @is_valid_event = 0
				
				FETCH NEXT FROM C INTO 
					@num,
					@objtype, 
					@objid,
					@action,
					@param0,
					@param1,
					@param2, 
					@param3,
					@param4,
					@person_id,
					@person_name,
					@person_surname,
					@person_patronymic,
					@person_parent_id,
					@person_dept_name,					
					@user_id,
					@user_name,
					@user_surname,
					@user_patronymic,
					@user_parent_id,
					@date,
					@server_date,
					@owner,
					@pk		
				PRINT 'Конец BEGIN TRY'				
			END TRY
			BEGIN CATCH
				SET @error = @@ERROR
				--DECLARE @ErrorMessage NVARCHAR(4000);  
				DECLARE @ErrorSeverity INT;  
				DECLARE @ErrorState INT;
				SELECT
				@ErrorMessage = ERROR_MESSAGE(),
				@ErrorMessage = 'Ошибка в процедуре [dw].[usp_LoadFactAudit].'  + ' GUID строки: ' + CAST(@pk AS NVARCHAR(60)) + '. ' + ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),  
				@ErrorState = ERROR_STATE(); 
				RAISERROR (@ErrorMessage, -- Message text.  
							   @ErrorSeverity, -- Severity.  
							   @ErrorState -- State.  
							   )  WITH LOG --записываем ошибку в системный журнал
				ROLLBACK TRANSACTION									
			END CATCH					
	END 
	CLOSE C 
	DEALLOCATE C

GO





/****** Object:  Default [DF__DIM_OBJ_S__is_de__72C60C4A]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_SLAVE] ADD  CONSTRAINT [DF__DIM_OBJ_S__is_de__72C60C4A]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_S__is_in__73BA3083]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_SLAVE] ADD  CONSTRAINT [DF__DIM_OBJ_S__is_in__73BA3083]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_R__is_de__74AE54BC]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_RIGHTS_PERSON] ADD  CONSTRAINT [DF__DIM_OBJ_R__is_de__74AE54BC]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_R__is_in__75A278F5]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_RIGHTS_PERSON] ADD  CONSTRAINT [DF__DIM_OBJ_R__is_in__75A278F5]  DEFAULT ((0)) FOR [is_inferred]
GO


ALTER TABLE [dw].[DIM_OBJ_RIGHTS_OBJECT] ADD  CONSTRAINT [DF__DIM_OBJ_RIGHTS_OBJECT__is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dw].[DIM_OBJ_RIGHTS_OBJECT] ADD  CONSTRAINT [DF__DIM_OBJ_RIGHTS_OBJECT__is_inferred]  DEFAULT ((0)) FOR [is_inferred]
GO


/****** Object:  Default [DF__DIM_OBJ_R__is_de__787EE5A0]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_RIGHTS] ADD  CONSTRAINT [DF__DIM_OBJ_R__is_de__787EE5A0]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_R__is_in__797309D9]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_RIGHTS] ADD  CONSTRAINT [DF__DIM_OBJ_R__is_in__797309D9]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__7A672E12]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_NC32K] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__7A672E12]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__7B5B524B]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_NC32K] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__7B5B524B]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__7C4F7684]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_IP_GATE] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__7C4F7684]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__7D439ABD]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_IP_GATE] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__7D439ABD]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__7E37BEF6]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_AC_PART] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__7E37BEF6]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__7F2BE32F]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_AC_PART] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__7F2BE32F]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__00200768]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_AC] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__00200768]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__01142BA1]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PNET3_AC] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__01142BA1]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__02084FDA]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PHOTO_IDENT_BUTTONS] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__02084FDA]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__02FC7413]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PHOTO_IDENT_BUTTONS] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__02FC7413]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__03F0984C]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PHOTO_IDENT] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__03F0984C]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__04E4BC85]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PHOTO_IDENT] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__04E4BC85]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_de__05D8E0BE]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PERSON] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_de__05D8E0BE]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_P__is_in__06CD04F7]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_PERSON] ADD  CONSTRAINT [DF__DIM_OBJ_P__is_in__06CD04F7]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_L__is_de__07C12930]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_LEVEL_READER] ADD  CONSTRAINT [DF__DIM_OBJ_L__is_de__07C12930]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_L__is_in__08B54D69]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_LEVEL_READER] ADD  CONSTRAINT [DF__DIM_OBJ_L__is_in__08B54D69]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_L__is_de__09A971A2]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_LEVEL] ADD  CONSTRAINT [DF__DIM_OBJ_L__is_de__09A971A2]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_L__is_in__0A9D95DB]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_LEVEL] ADD  CONSTRAINT [DF__DIM_OBJ_L__is_in__0A9D95DB]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_G__is_de__0B91BA14]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_GRABBER] ADD  CONSTRAINT [DF__DIM_OBJ_G__is_de__0B91BA14]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_G__is_in__0C85DE4D]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_GRABBER] ADD  CONSTRAINT [DF__DIM_OBJ_G__is_in__0C85DE4D]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_D__is_de__0D7A0286]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_DEPARTMENT] ADD  CONSTRAINT [DF__DIM_OBJ_D__is_de__0D7A0286]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_D__is_in__0E6E26BF]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_DEPARTMENT] ADD  CONSTRAINT [DF__DIM_OBJ_D__is_in__0E6E26BF]  DEFAULT ((0)) FOR [is_inferred]
GO
/****** Object:  Default [DF__DIM_OBJ_C__is_de__0F624AF8]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_CAM] ADD  CONSTRAINT [DF__DIM_OBJ_C__is_de__0F624AF8]  DEFAULT ((0)) FOR [is_deleted]
GO
/****** Object:  Default [DF__DIM_OBJ_C__is_in__10566F31]    Script Date: 04/20/2018 12:36:38 ******/
ALTER TABLE [dw].[DIM_OBJ_CAM] ADD  CONSTRAINT [DF__DIM_OBJ_C__is_in__10566F31]  DEFAULT ((0)) FOR [is_inferred]
GO










--######################################### APPLICATION TABLES
USE [IntellectDW]
GO

--таблица пользователей
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[DIM_USER]') AND type in (N'U'))
DROP TABLE [app].[DIM_USER]
GO

CREATE TABLE [app].[DIM_USER](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](60) NOT NULL,
	[name] [varchar](255) NULL,
	[comment] [varchar](8000) NULL,
	[is_admin] [bit] NOT NULL DEFAULT 0,
	[is_securityadmin] [bit] NOT NULL DEFAULT 0,
	[must_change_password] [bit] NOT NULL DEFAULT 0,
	[is_locked] [bit] NOT NULL DEFAULT 0,	
	[valid_from] [datetime] NOT NULL DEFAULT GETDATE(),
	[valid_to] [datetime] NULL,
	[is_deleted] [bit] NOT NULL DEFAULT 0
 CONSTRAINT [PK__app__DIM_USER] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__DIM_USER__login__valid_to] ON [app].[DIM_USER] 
(
	[login] ASC,
	[valid_to] ASC
)
ON [MAIN_DATA]
GO

--Добавляем пользователя-администартора
INSERT INTO app.DIM_USER (login,name,comment,is_admin,is_securityadmin,must_change_password,valid_from)
VALUES	('Admin','Администратор',NULL,1,1,0,GETDATE())
GO


--таблица ролей
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ROLE]') AND type in (N'U'))
DROP TABLE [app].[ROLE]
GO

CREATE TABLE [app].[ROLE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] sysname NOT NULL,
	[description] [varchar](255) NULL,
	--[is_deleted] [bit] NOT NULL DEFAULT 0
 CONSTRAINT [PK__app__ROLE] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__ROLE__name] ON [app].[ROLE] 
(
	[name] ASC
)
ON [MAIN_DATA]
GO

SET IDENTITY_INSERT [app].[ROLE] ON
--INSERT [app].[ROLE] ([id], [name], [description]) VALUES (1, 'admin', 'Администратор')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (2, 'buro', 'Бюро пропусков')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (3, 'oksb', 'Оператор КСБ')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (4, 'otryad', 'Отряд')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (5, 'kpp1', 'КПП-1')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (6, 'kpp2', 'КПП-2')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (7, 'gaspk1', 'ГАСПК КПП-1')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (8, 'gaspk2', 'ГАСПК КПП-2')
INSERT [app].[ROLE] ([id], [name], [description]) VALUES (9, 'nopk', 'Начальник Отряда')
SET IDENTITY_INSERT [app].[ROLE] OFF

--shchepka
--chelka


--таблица наличия ролей у пользователей
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[USER_ROLES]') AND type in (N'U'))
DROP TABLE [app].[USER_ROLES]
GO

CREATE TABLE [app].[USER_ROLES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
	--[is_system] [bit] NOT NULL DEFAULT 0,
	CONSTRAINT [PK__app__USER_ROLES__id] PRIMARY KEY CLUSTERED 
	(
		[id] ASC		
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__USER_ROLES__user_id__role_id] ON [app].[USER_ROLES] 
(
	[user_id] ASC,
	[role_id] ASC
)
ON [MAIN_DATA]
GO



--таблица полномочий
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[PERMISSION]') AND type in (N'U'))
DROP TABLE [app].[PERMISSION]
GO

CREATE TABLE [app].[PERMISSION](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] sysname NOT NULL,
	[description] [varchar](255) NULL,
	--[is_system] [bit] NOT NULL DEFAULT 0,
	CONSTRAINT [PK__app__PERMISSION] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__PERMISSION_name] ON [app].[PERMISSION] 
(
	[name] ASC
)
ON [MAIN_DATA]
GO

SET IDENTITY_INSERT [app].[PERMISSION] ON
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (1, N'ChangePassword', N'Изменять пароль')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (2, N'RunCardConverter', N'Запускать конвертер карт')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (3, N'SeePersons', N'Просматривать сотрудников')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (4, N'SeePersonHistory', N'Просматривать историю сотрудника')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (5, N'SeeLevels', N'Просматривать уровни доступа')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (6, N'SeeFullLevels', N'Просматривать полные уровни доступа')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (7, N'SeeUsers', N'Просматривать пользователей')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (8, N'ExportData', N'Экспортировать данные')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (9, N'ManageLevels', N'Управлять уровнями доступа')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (10, N'ManageUsers', N'Управлять пользователями')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (11, N'ManageAdminUsers', N'Управлять пользователями-администраторами')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (12, N'ManageUserRoles', N'Управлять группами пользователей')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (13, N'ManageRolePermissions', N'Управлять полномочиями групп')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (14, N'SeeAccessEventsOverSixMonths', N'Просматривать события доступа более чем за последние 6 месяцев')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (15, N'SeeAccessEventsOPKPersonOverSevenDays', N'Просматривать события доступа сотрудника офиса более чем за последние 7 суток')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (16, N'RunIidkDebug', N'Запускать отладочное окно')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (17, N'SeeNotifications', N'Просматривать оповещения')
INSERT [app].[PERMISSION] ([id], [name], [description]) VALUES (18, N'SeeStatistics', N'Просматривать статистические данные')

SET IDENTITY_INSERT [app].[PERMISSION] OFF



--таблица наличия полномочий у ролей
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ROLE_PERMISSIONS]') AND type in (N'U'))
DROP TABLE [app].[ROLE_PERMISSIONS]
GO

CREATE TABLE [app].[ROLE_PERMISSIONS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
	--[is_system] [bit] NOT NULL DEFAULT 0,
	CONSTRAINT [PK__app__ROLE_PERMISSIONS__id] PRIMARY KEY CLUSTERED 
	(
		[id] ASC		
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__ROLE_PERMISSIONS__role_id__permission_id] ON [app].[ROLE_PERMISSIONS] 
(
	[role_id] ASC,
	[permission_id] ASC
)
ON [MAIN_DATA]
GO

--SET IDENTITY_INSERT [app].[ROLE_PERMISSIONS] ON
--INSERT [app].[ROLE_PERMISSIONS] ([id], [role_id], [permission_id], [is_system]) VALUES (1, 1, 1, 1)
--SET IDENTITY_INSERT [app].[PERMISSIONS] OFF



--таблица групп аудита
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[AUDIT_GROUPS]') AND type in (N'U'))
DROP TABLE [app].[AUDIT_GROUPS]
GO

CREATE TABLE [app].[AUDIT_GROUPS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group] [varchar](60) NULL,
	[description] [varchar](255) NULL 
 CONSTRAINT [PK__app__AUDIT_GROUPS] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__AUDIT_GROUPS__group] ON [app].[AUDIT_GROUPS] 
(
	[group] ASC
)
ON [MAIN_DATA]
GO

SET IDENTITY_INSERT [app].[AUDIT_GROUPS] ON
INSERT [app].[AUDIT_GROUPS] ([id], [group], [description]) VALUES (1, 'autorisation', 'События авторизации')
INSERT [app].[AUDIT_GROUPS] ([id], [group], [description]) VALUES (2, 'db_query', 'Запросы событий из базы данных')
INSERT [app].[AUDIT_GROUPS] ([id], [group], [description]) VALUES (3, 'video', 'События по работе с видео системой')
INSERT [app].[AUDIT_GROUPS] ([id], [group], [description]) VALUES (4, 'user_and_right_managment', 'Управление пользователями и правами')
INSERT [app].[AUDIT_GROUPS] ([id], [group], [description]) VALUES (5, 'objects_managment', 'Управление объектами системы')
INSERT [app].[AUDIT_GROUPS] ([id], [group], [description]) VALUES (6, 'others', 'Другие события')
SET IDENTITY_INSERT [app].[AUDIT_GROUPS] OFF


--таблица действий аудита
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[AUDIT_ACTIONS]') AND type in (N'U'))
DROP TABLE [app].[AUDIT_ACTIONS]
GO

CREATE TABLE [app].[AUDIT_ACTIONS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group_id] [int] NOT NULL,
	[action] [varchar](60) NULL,
	[description] [varchar](255) NULL 
 CONSTRAINT [PK__app__AUDIT_ACTIONS] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__AUDIT_ACTIONS__group_id__action] ON [app].[AUDIT_ACTIONS] 
(
	[group_id] ASC
	,[action] ASC
)
ON [MAIN_DATA]
GO

SET IDENTITY_INSERT [app].[AUDIT_ACTIONS] ON
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (1, 1, 'login_in', 'Вход пользователя в систему')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (2, 1, 'login_out', 'Завершение работы пользователя')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (3, 1, 'needed_change_password', 'Необходимо изменить пароль')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (4, 2, 'persons_access', 'Поиск по проходам сотрудников')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (5, 2, 'access_points_events', 'Запрос событий точек доступа')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (6, 2, 'alarm_events', 'Запрос событий охранных датчиков')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (7, 3, 'cam_activate', 'Активация камеры')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (8, 3, 'video_play', 'Воспроизведение видео')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (9, 3, 'display_activate', 'Активация экрана')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (10, 4, 'add_user', 'Добавление пользователя')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (11, 4, 'remove_user', 'Удаление пользователя')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (12, 4, 'modify_user', 'Изменение пользователя')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (13, 4, 'add_role_to_user', 'Добавление роли пользователю')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (14, 4, 'remove_role_from_user', 'Удаление роли у пользователя')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (15, 4, 'add_permission_to_role', 'Добавление разрешения роли')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (16, 4, 'remove_permission_from_role', 'Удаление разрешения у роли')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (17, 4, 'change_password', 'Изменение пароля')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (18, 4, 'reset_password', 'Сброс пароля')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (19, 5, 'modify_level', 'Изменение уровня доступа')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (20, 6, 'permission_fauled', 'Нарушение безопастности')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (21, 6, 'export_data_to_excel', 'Экспорт данных в MS Excel')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (22, 6, 'export_photo', 'Экспорт фотографии')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (23, 6, 'row_count_limit_exceeded', 'Превышение допустимого предела количества строк запроса')
INSERT [app].[AUDIT_ACTIONS] ([id], [group_id], [action], [description]) VALUES (24, 6, 'add_notifications', 'Добавление оповещений')
SET IDENTITY_INSERT [app].[AUDIT_ACTIONS] OFF


--таблица лога аудита
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[AUDIT_LOG]') AND type in (N'U'))
DROP TABLE [app].[AUDIT_LOG]
GO

CREATE TABLE [app].[AUDIT_LOG](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL DEFAULT GETDATE(),
	[action_id] [int] NOT NULL,
	[user_id] [int] NULL,
	[managed_user_id] [int] NULL,
	[date_start] [datetime] NULL,
	[date_end] [datetime] NULL,
	[events] [varchar] (max) NULL,
	[persons] [varchar] (max) NULL,
	[departments] [varchar] (max) NULL,
	[access_points] [varchar] (max) NULL,
	[alarm_controllers] [varchar] (max) NULL,
	[alarm_sensors] [varchar] (max) NULL,
	[cams] [varchar] (max) NULL,
	[cam_date] [datetime] NULL,
	[display] [varchar] (255) NULL,
	[computer_name] [varchar] (255) NULL,
	[app_build] [varchar] (10) NULL,
	[extension] [varchar] (8000) NULL
 CONSTRAINT [PK__app__AUDIT_LOG] PRIMARY KEY CLUSTERED 
	(
		 [num] ASC
		,[date] ASC
	) ON [MAIN_LOGS]
) ON [MAIN_LOGS]
GO


--/*
--таблица расширенных уровней доступа (небезопастно создавать ее в основной БД)
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dw].[LEVEL_EXTANDED]') AND type in (N'U'))
DROP TABLE [dw].[LEVEL_EXTANDED]
GO

/****** Object:  Table [dw].[LEVEL_EXTANDED]    Script Date: 02/16/2019 12:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[LEVEL_EXTANDED](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[level_id] [varchar](60) NOT NULL,
	[level_num] [int]  NOT NULL,
	[description] [varchar](8000) NULL,
	[type] [varchar](255) NULL,
	[rank] [float] NULL
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
--SET IDENTITY_INSERT [dw].[LEVEL_EXTANDED] ON
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES ('',  996, N'', N'', 996.0)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES ('*', 997, N'', N'', 997.0)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES ('-', 998, N'', N'', 998.0)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (2, 1, N'Начальник компании и его заместители', N'основной', 1)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (3, 2, N'Начальник отдела', N'основной', 2)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (4, 3, N'Сотрудник отдела', N'основной', 3)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (83, 72, N'Основные входы в офис', N'дополнительный', NULL)
INSERT [dw].[LEVEL_EXTANDED] ([level_id], [level_num], [description], [type], [rank]) VALUES (84, 73, N'Пожарные выходы из офиса', N'дополнительный', NULL)


--SET IDENTITY_INSERT [dw].[LEVEL_EXTANDED] OFF
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__LEVEL_EXTANDED__level_id__nc_u] ON [dw].[LEVEL_EXTANDED] 
(
	[level_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_INDEX]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__LEVEL_EXTANDED__level_num__nc_u] ON [dw].[LEVEL_EXTANDED] 
(
	[level_num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_INDEX]
GO




--таблица настроек приложения
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[SETTINGS]') AND type in (N'U'))
DROP TABLE [app].[SETTINGS]
GO

CREATE TABLE [app].[SETTINGS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[host_name] [varchar](255) NOT NULL,
	[is_iidk_enable] [bit] NOT NULL DEFAULT 0,
	[iidk_managed_slave] [varchar](60) NULL,
	[iidk_map] [varchar](40) NULL,
	[iidk_monitor] [varchar](40) NULL
 CONSTRAINT [PK__app__SETTINGS] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__app__SETTINGS__host_name] ON [app].[SETTINGS] 
(
	[host_name] ASC
)
ON [MAIN_DATA]
GO




--######################################### DATATYPES

CREATE TYPE app.TableOfKeys AS Table
([key] int NOT NULL PRIMARY KEY CLUSTERED
); 





--######################################## PROCEDURES
USE [IntellectDW]
GO

--проверить, является ли пользователь администратором 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ufn_CheckUserForAdmin]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [app].[ufn_CheckUserForAdmin]
GO
CREATE FUNCTION [app].[ufn_CheckUserForAdmin] (
	@user_login AS sysname  = NULL )
RETURNS BIT
AS
BEGIN
	DECLARE @result AS BIT = 0
	IF(@user_login IS NULL) SET @user_login = SUSER_NAME()
	SELECT @result=is_admin FROM app.DIM_USER WHERE login = @user_login AND [valid_to] IS NULL
	RETURN @result
END
GO



--проверить наличие у пользователя права на управление другими пользователями
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ufn_CheckUserForSecurityAdmin]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [app].[ufn_CheckUserForSecurityAdmin]
GO
CREATE FUNCTION [app].[ufn_CheckUserForSecurityAdmin] ()
RETURNS BIT
AS
BEGIN
	DECLARE @result AS BIT = 0
	SELECT @result=is_securityadmin FROM app.DIM_USER WHERE login = SUSER_NAME() AND [valid_to] IS NULL
	RETURN @result
END
GO


--проверить наличие у пользователя определенного разрешения
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ufn_CheckUserPermission]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [app].[ufn_CheckUserPermission]
GO
CREATE FUNCTION [app].[ufn_CheckUserPermission] (@permission_name as sysname)
RETURNS BIT
AS
BEGIN
	DECLARE @result AS BIT = 0
	DECLARE @user_id AS int
	DECLARE @is_admin AS BIT = 0
	
	SELECT @user_id=[ID], @is_admin = [is_admin] FROM app.DIM_USER WHERE [login] = SUSER_NAME() AND [valid_to] IS NULL
	
	IF(@is_admin = 1) SET @result = 1
	ELSE
	BEGIN
		IF  EXISTS (SELECT 1 
				FROM [app].[PERMISSION] per
				JOIN app.ROLE_PERMISSIONS rp ON per.name = @permission_name AND rp.[permission_id] = per.[id] 
				JOIN app.USER_ROLES ur ON ur.[user_id] = @user_id AND ur.[role_id] = rp.[role_id])				
		SET @result = 1
	END	
	
	RETURN @result
END
GO


--функция, возвращающая таблицу из строки с разделителем
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ufn_StringListToTable]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [app].[ufn_StringListToTable]
GO

CREATE FUNCTION [app].[ufn_StringListToTable]
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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ufn_RemoveUnnecessaryChars]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [app].[ufn_RemoveUnnecessaryChars]
GO

Create Function [app].[ufn_RemoveUnnecessaryChars](@Temp VarChar(1000))
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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[app].[ufn_TryConvertDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [app].[ufn_TryConvertDate]
GO

CREATE FUNCTION [app].[ufn_TryConvertDate]
(
  @value varchar(4000)
)
RETURNS datetime
AS
BEGIN
  RETURN (SELECT CONVERT(datetime, CASE WHEN ISDATE(@value) = 1 THEN @value END));
END
GO

--сохранение лога аудита
IF OBJECT_ID('app.usp_LogAuditEvent', 'P') IS NOT NULL 
	DROP PROC app.usp_LogAuditEvent
GO
CREATE PROC app.usp_LogAuditEvent 
	 @group AS varchar(60)
	,@action AS varchar(60)
	,@managed_user_login AS sysname = NULL
	,@date_start datetime = NULL
	,@date_end  datetime = NULL
	,@events AS varchar (max) = NULL
	,@persons AS varchar (max) = NULL
	,@departments AS varchar (max) = NULL
	,@access_points varchar (max) = NULL
	,@alarm_controllers varchar (max) = NULL
	,@alarm_sensors varchar (max) = NULL
	,@cams varchar (max) = NULL
	,@cam_date datetime = NULL
	,@display varchar (256) = NULL
	,@computer_name [varchar] (255) = NULL
	,@app_build varchar (10) = NULL
	,@extension [varchar] (8000) = NULL
AS
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_id AS int
	DECLARE @managed_user_id AS int
	DECLARE @group_id AS int
	DECLARE @action_id AS int

		
	SELECT @user_id = u.id FROM app.DIM_USER u WHERE u.login=SUSER_NAME() AND u.valid_to IS NULL
	
	IF(@managed_user_login IS NOT NULL)
	BEGIN
		SELECT @managed_user_id = u.id FROM app.DIM_USER u WHERE u.login=@managed_user_login AND u.valid_to IS NULL
	END	
	
	--PRINT 'SUSER_NAME(): ' + SUSER_NAME()
	--PRINT 'USER_NAME(): ' + USER_NAME()	
			
	SELECT @group_id = gr.id FROM [app].[AUDIT_GROUPS] gr WHERE gr.[group] = @group
	
	IF(@group_id IS NULL)
	BEGIN
		SET @msg_str = 'Неверная группа аудита'
		RAISERROR (@msg_str,14,-1)
		RETURN
	END		
		
	SELECT @action_id = ac.id 
	FROM [app].[AUDIT_ACTIONS] ac 
	WHERE ac.action = @action
	AND ac.group_id = @group_id
	
	IF(@action_id IS NULL)   
	BEGIN
		SET @msg_str = 'Неверное действие аудита'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END
	
	INSERT INTO [app].[AUDIT_LOG] (
		[action_id],
		[user_id],
		[managed_user_id],
		[date_start],
		[date_end],
		[events],
		[persons],
		[departments],
		[access_points],
		[alarm_controllers],
		[alarm_sensors],
		[cams],
		[cam_date],
		[display],
		[computer_name],
		[app_build],
		[extension])
	VALUES (
		@action_id
		,@user_id
		,@managed_user_id
		,@date_start
		,@date_end
		,@events
		,@persons
		,@departments
		,@access_points
		,@alarm_controllers
		,@alarm_sensors
		,@cams
		,@cam_date
		,@display
		,@computer_name
		,@app_build
		,@extension)
END
GO

--проверить, имеет ли пользователь, право работать с программой 
IF OBJECT_ID('app.usp_CheckUser', 'P') IS NOT NULL 
	DROP PROC app.usp_CheckUser
GO
CREATE PROC app.usp_CheckUser 
	@procedure AS varchar(255) 	
AS
BEGIN	
	DECLARE @user_id AS int = 0
	DECLARE @is_locked AS bit = 0
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(1000)
	
	SET @extension = 'procedure=' + @procedure +  ',user_login=' +  CAST(SUSER_NAME() AS nvarchar(255))
	SELECT @user_id = u.id, @is_locked=u.is_locked FROM app.DIM_USER u WHERE u.login=SUSER_NAME() AND u.valid_to IS NULL
	
	
	IF((@user_id = 0) OR (@is_locked = 1))
	BEGIN
		EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@extension = @extension
	END
	
	IF(@user_id = 0)
	BEGIN
		SET @msg_str = 'Пользователь ' + CAST(SUSER_NAME() AS nvarchar(255)) + ' не зарегистрирован.'
		RAISERROR (@msg_str,14,-1)
		RETURN (1)
	END
	ELSE IF(@is_locked = 1)
	BEGIN
		SET @msg_str = 'Пользователь ' + CAST(SUSER_NAME() AS nvarchar(255)) + ' заблокирован.'
		RAISERROR (@msg_str,14,-1)
		RETURN (1)
	END
END
GO


--проверка полномочий пользователя на изменение другого пользователя
IF OBJECT_ID('app.usp_CheckUserPermissionForModifyOtherUser', 'P') IS NOT NULL 
	DROP PROC app.usp_CheckUserPermissionForModifyOtherUser
GO
CREATE PROC app.usp_CheckUserPermissionForModifyOtherUser 
	@managed_user_login AS sysname
	,@new_value_of_managed_user_is_admin AS bit = 0 	
AS
BEGIN	
	DECLARE @user_id AS INT = 0
	DECLARE @managed_user_id AS INT = 0
	DECLARE @user_login AS sysname
	DECLARE @user_is_admin AS bit = 0
	DECLARE @user_is_security_admin AS BIT = 0
	DECLARE @managed_user_is_admin AS bit = 0
	DECLARE @managed_user_is_securityadmin AS bit = 0
		
	SET @user_login = SUSER_NAME()
	SET @user_is_security_admin = app.ufn_CheckUserForSecurityAdmin()
	--PRINT '@user_is_security_admin: ' + CAST(@user_is_security_admin AS char)
		
	--получаем параметры управляемого пользователя
	SELECT @managed_user_id = u.id
		   ,@managed_user_is_securityadmin = is_securityadmin
		   ,@managed_user_is_admin = is_admin
	FROM app.DIM_USER u 
	WHERE u.login=@managed_user_login AND u.valid_to IS NULL
	
	IF(@managed_user_id <> 0) 
	BEGIN
		--PRINT 'IN @managed_user_id <> 0'
		IF(@user_is_security_admin=1) RETURN (0)
		ELSE
		BEGIN
			--PRINT 'IN @user_is_security_admin<>1'
			IF(@managed_user_is_securityadmin = 0) 
			BEGIN
				--PRINT 'IN @managed_user_is_securityadmin = 0'
				IF(app.ufn_CheckUserPermission('ManageAdminUsers')=1) RETURN (0)
				ELSE
				BEGIN
					--PRINT 'IN app.ufn_CheckUserPermission(ManageAdminUsers)<>1'
					IF((@managed_user_is_admin = 0) AND (@new_value_of_managed_user_is_admin = 0))
					BEGIN
						--PRINT 'IN (@managed_user_is_admin = 0) AND (@new_value_of_managed_user_is_admin = 0)'
						IF(app.ufn_CheckUserPermission('ManageUsers')=1) 
						BEGIN
							--PRINT 'IN app.ufn_CheckUserPermission(ManageUsers)=1'
							RETURN (0)
						END
					END
				END
			END
		END
	END
	RETURN (1)
END
GO


--управление пользователем
IF OBJECT_ID('app.usp_ManageUser', 'P') IS NOT NULL 
	DROP PROC app.usp_ManageUser
GO
CREATE PROC app.usp_ManageUser 
	@action AS nvarchar(255)
	,@managed_user_login AS sysname 
	,@managed_user_password AS nvarchar(255) = 1
	,@managed_user_name AS varchar(255) = NULL
	,@managed_user_comment AS varchar(8000) = NULL
	,@managed_user_is_admin AS bit = 0
	,@managed_user_is_locked AS bit = 0
	,@old_managed_user_login AS sysname = NULL
	,@new_user_id AS int = NULL OUTPUT	
WITH EXECUTE AS OWNER
AS
BEGIN
	
	DECLARE @user_is_security_admin AS BIT = 0
	DECLARE @managed_user_id AS INT = 0
	DECLARE @user_login AS sysname
	DECLARE @managed_user_is_securityadmin AS bit = 0
	DECLARE @must_change_password AS bit = 1
	DECLARE @user_is_admin AS bit = 0
	DECLARE @permission_fauled AS bit = 0	
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @ErrorMessage NVARCHAR(4000)  
	DECLARE @ErrorSeverity INT  
	DECLARE @ErrorState INT
	DECLARE @extension AS varchar(8000)
	DECLARE @result AS bit = 0
	
	SET @extension = 'procedure=ManageUser' 
					 + ',action=' + @action 
					 + ',managed_user_login=' + ISNULL(@managed_user_login,'') 
					 + ',managed_user_is_admin=' + CAST(@managed_user_is_admin AS nvarchar(5))
					 + ',managed_user_is_locked=' + CAST(@managed_user_is_locked AS nvarchar(5))
					 + ',managed_user_comment=' + ISNULL(@managed_user_comment,'')
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
		
	EXECUTE AS CALLER
		
		SET @user_login = SUSER_NAME()
		SET @user_is_security_admin = app.ufn_CheckUserForSecurityAdmin()
					
		IF(@action NOT IN ('Add','Remove','Modify','ResetPassword'))   
		BEGIN
			SET @msg_str = 'Неверные параметры для операции!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END	
	
		IF((@user_is_security_admin=0) AND (app.ufn_CheckUserPermission('ManageUsers')=0))
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@managed_user_login = @managed_user_login
					,@extension = @extension
			REVERT
		
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END	

	REVERT
	
	--добавление пользователя
	IF(@action = 'Add')
	BEGIN		
		IF EXISTS (SELECT 1 FROM app.DIM_USER u WHERE u.login=@managed_user_login AND u.valid_to IS NULL)
		BEGIN
			SET @msg_str = 'Пользователь с логином ''' + @managed_user_login + ''' уже существует в базе данных!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END
		--проверка на существование логина с таким же именем на сервере sql
		IF EXISTS (SELECT 1	FROM sys.sql_logins WHERE name = @managed_user_login)
		BEGIN
			SET @msg_str = 'Пользователь с логином ''' + @managed_user_login + ''' уже зарегистрирован на сервере!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END

		
		EXECUTE AS CALLER
			--проверяем полномочие на создание пользователей-администраторов
			IF((@managed_user_is_admin = 1) AND (app.ufn_CheckUserPermission('ManageAdminUsers')=0))
			BEGIN
			
					EXEC app.usp_LogAuditEvent
						@group = 'others'
						,@action = 'permission_fauled'				
						,@managed_user_login = @managed_user_login
						,@extension = @extension
			
			
				SET @msg_str = 'Отсутствует разрешение на выполнение операции'
				RAISERROR (@msg_str,14,-1)
				RETURN
			END
		REVERT
			
		BEGIN TRY
			BEGIN TRANSACTION			
				--меняем контекст безопастности
				--EXECUTE AS LOGIN = 'IntellectDW_app'
				
				DECLARE @sql AS varchar(300)
				SET @sql = 
					'CREATE LOGIN ' + QUOTENAME(@managed_user_login) + ' ' +  
					'WITH PASSWORD=''' + @managed_user_password + ''', ' + 
					'DEFAULT_DATABASE=[IntellectDW], ' + 
					'CHECK_EXPIRATION=OFF, ' + 
					'CHECK_POLICY=OFF'
				--PRINT '@sql: ' + @sql
				EXEC(@sql)			
				
				SET @sql = 'CREATE USER ' + QUOTENAME(@managed_user_login) + ' FOR LOGIN ' + QUOTENAME(@managed_user_login) + ' WITH DEFAULT_SCHEMA=[app]'
				EXEC(@sql)
				
				--добавляем пользователю роль "пользователь приложения"
				SET @sql = 'sp_addrolemember [IntellectDW_user], ' + QUOTENAME(@managed_user_login)
				EXEC(@sql)
				
				INSERT INTO app.DIM_USER (login
										  ,name
										  ,comment
										  ,is_admin
										  ,is_securityadmin
										  ,must_change_password
										  ,is_locked
										  ,valid_from)
				VALUES	(@managed_user_login
						,@managed_user_name
						,@managed_user_comment
						,@managed_user_is_admin
						,@managed_user_is_securityadmin
						,@must_change_password
						,@managed_user_is_locked
						,GETDATE())
				SET @new_user_id = SCOPE_IDENTITY()
				
				EXECUTE AS CALLER
					EXEC app.usp_LogAuditEvent
						@group = 'user_and_right_managment'
						,@action = 'add_user'				
						,@managed_user_login = @managed_user_login
						--,@extension = @extension
				REVERT					
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0  
			BEGIN  
				PRINT ' Rolling back add_user transaction.'  
				ROLLBACK TRANSACTION 
			END	  
			SELECT @ErrorMessage = ERROR_MESSAGE();  
			SELECT @ErrorSeverity = ERROR_SEVERITY();  
			SELECT @ErrorState = ERROR_STATE();  
	  
			RAISERROR 
				(@ErrorMessage, -- Message text.  
				 @ErrorSeverity, -- Severity.  
				 @ErrorState -- State.  
				 ); 
		END CATCH				
	END
	
	--удаление пользователя
	ELSE IF(@action = 'Remove')
	BEGIN
		--получаем параметры удаляемого пользователя
		SELECT @managed_user_id = u.id
		FROM app.DIM_USER u 
		WHERE u.login=@managed_user_login AND u.valid_to IS NULL
		
		IF(@managed_user_id = 0)
		BEGIN
			SET @msg_str = 'Пользователя с логином ''' + @managed_user_login + ''' не существует в базе данных!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END
		
		IF (@managed_user_login = @user_login)
		BEGIN
			SET @msg_str = 'Нельзя удалить текущего пользователя!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END

		EXECUTE AS CALLER
			
			EXEC @result = app.usp_CheckUserPermissionForModifyOtherUser 
							@managed_user_login = @managed_user_login
			IF(@result <> 0)
			BEGIN
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@managed_user_login = @managed_user_login
					,@extension = @extension
			
				SET @msg_str = 'Отсутствует разрешение на выполнение операции'
				RAISERROR (@msg_str,14,-1)
				RETURN
			END
		REVERT

		BEGIN TRY			
			BEGIN TRANSACTION				
				EXECUTE AS CALLER
					EXEC app.usp_LogAuditEvent
						@group = 'user_and_right_managment'
						,@action = 'remove_user'				
						,@managed_user_login = @managed_user_login
				REVERT			
				
				IF EXISTS 
					(SELECT 1 
					FROM sys.sql_logins 
					WHERE name = @managed_user_login)
				BEGIN
					SET @sql = 'DROP LOGIN ' + QUOTENAME(@managed_user_login)
					EXEC(@sql)
				END			
				
				SET @sql = 'DROP USER ' + QUOTENAME(@managed_user_login)
				EXEC(@sql)				
				
				
				
				UPDATE app.DIM_USER
				SET valid_to=GETDATE() --, is_deleted = 1
				WHERE login=@managed_user_login	AND valid_to IS NULL
							
				DELETE FROM app.USER_ROLES 
				WHERE [user_id] = @managed_user_id			
											
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0  
			BEGIN  
				PRINT ' Rolling back delete_user transaction.'  
				ROLLBACK TRANSACTION 
			END			 
	  
			SELECT @ErrorMessage = ERROR_MESSAGE();  
			SELECT @ErrorSeverity = ERROR_SEVERITY();  
			SELECT @ErrorState = ERROR_STATE();  
	  
			RAISERROR 
				(@ErrorMessage, -- Message text.  
				 @ErrorSeverity, -- Severity.  
				 @ErrorState -- State.  
				 ); 
		END CATCH
	END
	
	--изменение пользователя
	ELSE IF(@action = 'Modify')
	BEGIN
		DECLARE @user_changed AS BIT = 0
		DECLARE @login_changed AS BIT = 0
		DECLARE @old_managed_user_name AS varchar(255)
		DECLARE @old_managed_user_comment AS varchar(8000)
		DECLARE @old_managed_user_is_securityadmin AS bit
		DECLARE @old_managed_user_is_admin AS bit
		
		IF(@old_managed_user_login IS NULL)
		BEGIN
			BEGIN
				SET @msg_str = 'Неверные параметры для операции!'
				RAISERROR (@msg_str,11,-1)
				RETURN
			END
		END
		ELSE
		BEGIN
			--получаем параметры изменяемого пользователя
			SELECT @managed_user_id = u.id
				   ,@old_managed_user_name = name
				   --,@old_managed_user_comment = comment
				   ,@old_managed_user_is_securityadmin = is_securityadmin
				   ,@old_managed_user_is_admin = is_admin				   
			FROM app.DIM_USER u 
			WHERE u.login=@old_managed_user_login AND u.valid_to IS NULL
		END		
		
		IF(@managed_user_id = 0)
		BEGIN
			SET @msg_str = 'Пользователя с логином ''' + @old_managed_user_login + ''' не существует в базе данных!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END		
		
		IF ((@old_managed_user_login = @user_login) AND (@managed_user_is_locked = 1))
		BEGIN
			SET @msg_str = 'Нельзя заблокировать текущего пользователя!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END

		EXECUTE AS CALLER			
			EXEC @result = app.usp_CheckUserPermissionForModifyOtherUser 
							@managed_user_login = @old_managed_user_login
							,@new_value_of_managed_user_is_admin =  @managed_user_is_admin
			IF(@result <> 0)
			BEGIN
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@managed_user_login = @managed_user_login
					,@extension = @extension
			
				SET @msg_str = 'Отсутствует разрешение на выполнение операции'
				RAISERROR (@msg_str,14,-1)
				RETURN
			END
		REVERT
		
		IF(@old_managed_user_login <> @managed_user_login) SET @login_changed = 1

		IF((ISNULL(@old_managed_user_name,'') <> ISNULL(@managed_user_name,'')))
			--OR (ISNULL(@old_managed_user_comment,'') <> ISNULL(@managed_user_comment,''))
			--OR (@old_managed_user_is_admin <> @managed_user_is_admin))
		BEGIN
			SET @user_changed = 1
		END
		
		EXECUTE AS CALLER
			EXEC app.usp_LogAuditEvent
				@group = 'user_and_right_managment'
				,@action = 'modify_user'				
				,@managed_user_login = @old_managed_user_login
				,@extension = @extension
		REVERT
		
		--если у пользователя обновились существенные поля
		IF((@user_changed = 1) OR (@login_changed = 1))
		BEGIN
			BEGIN TRY			
				BEGIN TRANSACTION
					
					IF(@login_changed = 1)
					BEGIN
						SET @sql = 'ALTER LOGIN ' + QUOTENAME(@old_managed_user_login) + ' WITH NAME = ' + QUOTENAME(@managed_user_login)
						EXEC(@sql)
											
						SET @sql = 'ALTER USER ' + QUOTENAME(@old_managed_user_login) + ' WITH NAME = ' + QUOTENAME(@managed_user_login)
						EXEC(@sql)
						
					END
					
					UPDATE app.DIM_USER
					SET valid_to=GETDATE()
					WHERE login=@old_managed_user_login	AND valid_to IS NULL
								
									
					INSERT INTO app.DIM_USER (login,name,comment,is_admin,is_securityadmin,must_change_password,is_locked,valid_from)
					VALUES	(@managed_user_login,@managed_user_name,@managed_user_comment,@managed_user_is_admin,@managed_user_is_securityadmin,0,@managed_user_is_locked,GETDATE())
					SET @new_user_id = SCOPE_IDENTITY()
					
						
					UPDATE app.USER_ROLES
					SET  [user_id] = @new_user_id
					WHERE [user_id] = @managed_user_id
												
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0  
				BEGIN  
					PRINT ' Rolling back modify_user transaction.'  
					ROLLBACK TRANSACTION 
				END			 
		  
				SELECT @ErrorMessage = ERROR_MESSAGE();  
				SELECT @ErrorSeverity = ERROR_SEVERITY();  
				SELECT @ErrorState = ERROR_STATE();  
		  
				RAISERROR 
					(@ErrorMessage, -- Message text.  
					 @ErrorSeverity, -- Severity.  
					 @ErrorState -- State.  
					 ); 
			END CATCH		
		END
		--если у пользователя обновились не существенные поля
		ELSE
		BEGIN
			UPDATE app.DIM_USER
				SET 
					comment = @managed_user_comment
					,is_admin = @managed_user_is_admin
					,is_locked = @managed_user_is_locked
				WHERE login=@old_managed_user_login	AND valid_to IS NULL
		END		
	END	
	--сброс пароля пользователя
	ELSE IF(@action = 'ResetPassword')
	BEGIN
		--получаем параметры удаляемого пользователя
		SELECT @managed_user_id = u.id				
		FROM app.DIM_USER u 
		WHERE u.login=@managed_user_login AND u.valid_to IS NULL
		
		IF(@managed_user_id = 0)
		BEGIN
			SET @msg_str = 'Пользователя с логином ''' + @managed_user_login + ''' не существует в базе данных!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END
		
		IF (@managed_user_login = @user_login)
		BEGIN
			SET @msg_str = 'Нельзя сбросить пароль текущего пользователя!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
		
		EXECUTE AS CALLER			
			EXEC @result = app.usp_CheckUserPermissionForModifyOtherUser 
							@managed_user_login = @managed_user_login
			IF(@result <> 0)
			BEGIN
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@managed_user_login = @managed_user_login
					,@extension = @extension
			
				SET @msg_str = 'Отсутствует разрешение на выполнение операции'
				RAISERROR (@msg_str,14,-1)
				RETURN
			END
		REVERT
			
		BEGIN TRY			
				BEGIN TRANSACTION				
					EXECUTE AS CALLER
						EXEC app.usp_LogAuditEvent
							@group = 'user_and_right_managment'
							,@action = 'reset_password'				
							,@managed_user_login = @managed_user_login
					REVERT			
					
					SET @sql = 'ALTER LOGIN ' + QUOTENAME(@managed_user_login) + ' WITH PASSWORD = ''' + @managed_user_password + ''''
					PRINT @sql
					EXEC(@sql)
									
					
					UPDATE app.DIM_USER
					SET must_change_password = 1
					WHERE login=@managed_user_login	AND valid_to IS NULL
												
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0  
				BEGIN  
					PRINT ' Rolling back reset_user_password transaction.'  
					ROLLBACK TRANSACTION 
				END			 
		  
				SELECT @ErrorMessage = ERROR_MESSAGE();  
				SELECT @ErrorSeverity = ERROR_SEVERITY();  
				SELECT @ErrorState = ERROR_STATE();  
		  
				RAISERROR 
					(@ErrorMessage, -- Message text.  
					 @ErrorSeverity, -- Severity.  
					 @ErrorState -- State.  
					 ); 
			END CATCH
	END			
END
GO

--управление ролями пользователя
IF OBJECT_ID('app.usp_ManageUserRoles', 'P') IS NOT NULL 
	DROP PROC app.usp_ManageUserRoles
GO
CREATE PROC app.usp_ManageUserRoles 
	@action AS nvarchar(255),
	@managed_user_login AS sysname, 
	@role_name AS sysname
WITH EXECUTE AS OWNER	 
AS
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @ErrorMessage NVARCHAR(4000)  
	DECLARE @ErrorSeverity INT  
	DECLARE @ErrorState INT
	
	DECLARE @managed_user_id AS int = 0
	DECLARE @role_id AS int = 0
	DECLARE @user_login AS sysname
	DECLARE @user_is_security_admin AS bit = 0
	DECLARE @extension AS varchar(8000)
	SET @extension = 'procedure=ManageUserRoles' + ',role_name=' + @role_name + ',managed_user_login=' + @managed_user_login
	DECLARE @permission_fauled AS bit = 0
	DECLARE @result AS BIT	
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	IF((@managed_user_login IS NULL OR @role_name IS NULL)
		OR (@action NOT IN ('Add','Remove')))   
	BEGIN
		SET @msg_str = 'Неверные параметры для операции!'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END	
	SELECT @managed_user_id = u.id FROM app.DIM_USER u WHERE u.login=@managed_user_login AND u.valid_to IS NULL		
	IF (@managed_user_id = 0)
	BEGIN
		SET @msg_str = 'Пользователя с логином ' + @managed_user_login + ' нет в базе данных!'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END
	
	
	EXECUTE AS CALLER
		--PRINT 'SUSER_NAME(): ' + SUSER_NAME()
		--PRINT 'USER_NAME(): ' + USER_NAME()
		
			
		SET @user_login = SUSER_NAME()
		SET @user_is_security_admin = app.ufn_CheckUserForSecurityAdmin()
		
		IF(@user_is_security_admin=0)
		BEGIN
			IF(app.ufn_CheckUserPermission('ManageUserRoles')=0) SET @permission_fauled = 1
			--ELSE
			--BEGIN			
			--	EXEC @result = app.usp_CheckUserPermissionForModifyOtherUser 
			--					@managed_user_login = @managed_user_login
			--	IF(@result <> 0) SET @permission_fauled = 1				
			--END
		END
		
		IF(@permission_fauled = 1)
		BEGIN
			EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@managed_user_login = @managed_user_login
				,@extension = @extension
		
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	REVERT
	
	
	SELECT @role_id = r.id FROM app.[ROLE] r WHERE r.name=@role_name
	IF(@role_id = 0)
	BEGIN
		SET @msg_str = 'Роль ' + @role_name + ' не существует!'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END
	
	
	--добавление роли
	IF(@action = 'Add')
	BEGIN
		IF EXISTS 
		(SELECT 1 
		 FROM [app].[USER_ROLES] ur 
		 WHERE ur.user_id=@managed_user_id AND ur.role_id=@role_id)
		BEGIN
			SET @msg_str = 'У пользователя с логином ' + @managed_user_login + ' уже есть роль ' + @role_name + '!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END		
		
		BEGIN TRY
			BEGIN TRANSACTION			
				EXECUTE AS CALLER
					EXEC app.usp_LogAuditEvent
						@group = 'user_and_right_managment'
						,@action = 'add_role_to_user'				
						,@managed_user_login = @managed_user_login
						,@extension = @extension
				REVERT		
				INSERT [app].[USER_ROLES] ([user_id], [role_id]) VALUES (@managed_user_id, @role_id)
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0  
			BEGIN  
				PRINT ' Rolling back add_role transaction.'  
				ROLLBACK TRANSACTION 
			END			 
	  
			SELECT @ErrorMessage = ERROR_MESSAGE();  
			SELECT @ErrorSeverity = ERROR_SEVERITY();  
			SELECT @ErrorState = ERROR_STATE();  
	  
			RAISERROR 
				(@ErrorMessage, -- Message text.  
				 @ErrorSeverity, -- Severity.  
				 @ErrorState -- State.  
				 ); 
		END CATCH
	END
	--удаление роли
	IF(@action = 'Remove')
	BEGIN
		IF NOT EXISTS 
			(SELECT 1 
			 FROM [app].[USER_ROLES] ur 
			 WHERE ur.user_id=@managed_user_id AND ur.role_id=@role_id)
		BEGIN
			SET @msg_str = 'У пользователя с логином ' + @managed_user_login + ' нет роли ' + @role_name + '!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
		
		BEGIN TRY
			BEGIN TRANSACTION
				EXECUTE AS CALLER
					EXEC app.usp_LogAuditEvent
							@group = 'user_and_right_managment'
							,@action = 'remove_role_from_user'				
							,@managed_user_login = @managed_user_login
							,@extension = @extension
				REVERT						
				DELETE FROM [app].[USER_ROLES] WHERE [user_id] = @managed_user_id AND [role_id] = @role_id
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0  
			BEGIN  
				PRINT ' Rolling back remove_role transaction.'  
				ROLLBACK TRANSACTION 
			END			 
	  
			SELECT @ErrorMessage = ERROR_MESSAGE();  
			SELECT @ErrorSeverity = ERROR_SEVERITY();  
			SELECT @ErrorState = ERROR_STATE();  
	  
			RAISERROR 
				(@ErrorMessage, -- Message text.  
				 @ErrorSeverity, -- Severity.  
				 @ErrorState -- State.  
				 ); 
		END CATCH
	END	
END
GO

--управление полномочиями ролей
IF OBJECT_ID('app.usp_ManageRolePermissions', 'P') IS NOT NULL 
	DROP PROC app.usp_ManageRolePermissions
GO
CREATE PROC app.usp_ManageRolePermissions 
	@action AS nvarchar(255),
	@role_name AS sysname, 
	@permission_name AS sysname
	 
WITH EXECUTE AS OWNER
AS
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @ErrorMessage NVARCHAR(4000)  
	DECLARE @ErrorSeverity INT  
	DECLARE @ErrorState INT
		
	DECLARE @user_is_security_admin AS bit = 0
	DECLARE @role_id AS int = 0
	DECLARE @permission_id AS int = 0
	DECLARE @user_login AS sysname
	
	DECLARE @result AS bit
	
	DECLARE @extension AS varchar(8000)
	SET @extension = 'procedure=ManageRolePermissions' +  ',role_name=' + @role_name + ',permission_name=' + @permission_name
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	
	EXECUTE AS CALLER
		--PRINT 'SUSER_NAME(): ' + SUSER_NAME()
		--PRINT 'USER_NAME(): ' + USER_NAME()
		SET @user_login = SUSER_NAME()
		SET @user_is_security_admin = app.ufn_CheckUserForSecurityAdmin()
	
	
		IF(@user_is_security_admin=0)
		BEGIN
			IF(app.ufn_CheckUserPermission('ManageRolePermissions')=0)
			BEGIN
				EXEC app.usp_LogAuditEvent
						@group = 'others'
						,@action = 'permission_fauled'				
						,@extension = @extension
				SET @msg_str = 'Отсутствует разрешение на выполнение операции'
				RAISERROR (@msg_str,14,-1)
				RETURN
			END
		END	
	REVERT
	
	IF((@role_name IS NULL OR @permission_name IS NULL)
		AND (@action NOT IN ('Add','Remove')))   
	BEGIN
		SET @msg_str = 'Неверные параметры для операции!'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END		
	
	SELECT @role_id = r.id FROM app.[ROLE] r WHERE r.name=@role_name
	IF (@role_id = 0)
	BEGIN
		SET @msg_str = 'Роль ' + @role_name + ' не существует!'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END
	
	SELECT @permission_id = per.id  FROM app.PERMISSION per WHERE per.name=@permission_name
	IF (@permission_id = 0)
	BEGIN
		SET @msg_str = 'Полномочие ' + @permission_name + ' не существует!'
		RAISERROR (@msg_str,11,-1)
		RETURN
	END		
	
	--добавление полномочия
	IF(@action = 'Add')
	BEGIN
		IF EXISTS 
		(SELECT 1 
		 FROM [app].[ROLE_PERMISSIONS] rp 
		 WHERE rp.role_id =@role_id AND rp.permission_id=@permission_id)
		BEGIN
			SET @msg_str = 'У роли ' + @role_name + ' уже есть полномочие ' + @permission_name + '!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END		
		BEGIN TRY
			BEGIN TRANSACTION
				EXECUTE AS CALLER
					EXEC app.usp_LogAuditEvent
							@group = 'user_and_right_managment'
							,@action = 'add_permission_to_role'				
							,@extension = @extension
				REVERT		
				INSERT [app].[ROLE_PERMISSIONS] ([role_id],[permission_id]) VALUES (@role_id, @permission_id)
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0  
			BEGIN  
				PRINT ' Rolling back delete_user transaction.'  
				ROLLBACK TRANSACTION 
			END			 
	  
			SELECT @ErrorMessage = ERROR_MESSAGE();  
			SELECT @ErrorSeverity = ERROR_SEVERITY();  
			SELECT @ErrorState = ERROR_STATE();  
	  
			RAISERROR 
				(@ErrorMessage, -- Message text.  
				 @ErrorSeverity, -- Severity.  
				 @ErrorState -- State.  
				 ); 
		END CATCH
	END
	--удаление полномочия
	IF(@action = 'Remove')
	BEGIN
		IF NOT EXISTS 
		(SELECT 1 
		 FROM [app].[ROLE_PERMISSIONS] rp 
		 WHERE rp.role_id =@role_id AND rp.permission_id=@permission_id)
		BEGIN
			SET @msg_str = 'У роли ' + @role_name + ' нет полномочия ' + @permission_name + '!'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
		BEGIN TRY
			BEGIN TRANSACTION
				EXECUTE AS CALLER
					EXEC app.usp_LogAuditEvent
							@group = 'user_and_right_managment'
							,@action = 'remove_permission_from_role'				
							,@extension = @extension
				REVERT			
				DELETE FROM [app].[ROLE_PERMISSIONS] WHERE [role_id] = @role_id AND [permission_id] = @permission_id
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0  
			BEGIN  
				PRINT ' Rolling back delete_user transaction.'  
				ROLLBACK TRANSACTION 
			END			 
	  
			SELECT @ErrorMessage = ERROR_MESSAGE();  
			SELECT @ErrorSeverity = ERROR_SEVERITY();  
			SELECT @ErrorState = ERROR_STATE();  
	  
			RAISERROR 
				(@ErrorMessage, -- Message text.  
				 @ErrorSeverity, -- Severity.  
				 @ErrorState -- State.  
				 ); 
		END CATCH
	END
END
GO


--проверка пользователя для работы с IntellectDW
IF OBJECT_ID('app.usp_Login', 'P') IS NOT NULL 
	DROP PROC app.usp_Login
GO
CREATE PROC app.usp_Login	 
	@app_build AS varchar(10)
	,@computer_name AS varchar(200) = NULL
	,@result AS varchar(255) OUTPUT
AS	
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_login AS sysname
	DECLARE @extension AS varchar(8000)
	SET @extension = 'procedure=Login' +  ',user_login=' +  @user_login

	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT

	SET @user_login = SUSER_NAME()	
	
	DECLARE @must_change_password AS bit
	SET @must_change_password = 
		(SELECT u.must_change_password 
	     FROM app.DIM_USER u 
		 WHERE u.login=@user_login 
			AND u.valid_to IS NULL)
	
	IF (@must_change_password = 1)
	BEGIN
		SET @result = 'needed_change_password'
		EXEC app.usp_LogAuditEvent
			@group = 'autorisation'
			,@action = 'needed_change_password'
			,@app_build = @app_build
	END
	ELSE
	BEGIN
		SET @result = 'ok'
		EXEC app.usp_LogAuditEvent
			@group = 'autorisation'
			,@action = 'login_in'
			,@app_build = @app_build
			,@computer_name = @computer_name
			--,@extension = @extension			
	END			
	
	--RETURN @result
END
GO



--процедура, выполняемая после изменения пароля пользователя
IF OBJECT_ID('app.usp_ChangeUserPassword', 'P') IS NOT NULL 
	DROP PROC app.usp_ChangeUserPassword
GO
CREATE PROC app.usp_ChangeUserPassword 
	 @user_login AS sysname	
	--,@app_build AS varchar(10) = NULL
	--,@result AS varchar(255) OUTPUT 
--WITH EXECUTE AS OWNER
AS
BEGIN	
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @ErrorMessage NVARCHAR(4000)  
	DECLARE @ErrorSeverity INT  
	DECLARE @ErrorState INT
	DECLARE @result AS bit
	DECLARE @extension AS varchar(8000)
	SET @extension = 'procedure=ChangeUserPassword' +  ',user_login=' +  @user_login
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
				
	IF(@user_login <> SUSER_NAME())
	--IF(@user_login <>'lol')
	BEGIN
		EXECUTE AS CALLER
			EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@extension = @extension
		REVERT
		
		SET @msg_str = 'Отсутствует разрешение на выполнение операции'
		RAISERROR (@msg_str,14,-1)
		RETURN
	END		
	ELSE
	
	BEGIN TRY
			BEGIN TRANSACTION								
				
				UPDATE app.DIM_USER 	
				SET must_change_password = 0
				WHERE [login] = @user_login
				AND [valid_to] IS NULL
				
				EXEC app.usp_LogAuditEvent
				@group = 'user_and_right_managment'
				,@action = 'change_password'				
				--,@app_build = @app_build
								
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
		BEGIN  
			PRINT ' Rolling back ChangeUserPassword transaction.'  
			ROLLBACK TRANSACTION 
		END	  
		SELECT @ErrorMessage = ERROR_MESSAGE();  
		SELECT @ErrorSeverity = ERROR_SEVERITY();  
		SELECT @ErrorState = ERROR_STATE();  
	  
		RAISERROR 
			(@ErrorMessage, -- Message text.  
				@ErrorSeverity, -- Severity.  
				@ErrorState -- State.  
				); 
	END CATCH				
END
GO


--получить права
IF OBJECT_ID('app.usp_GetPermissions', 'P') IS NOT NULL 
	DROP PROC app.usp_GetPermissions
GO
CREATE PROC app.usp_GetPermissions	 
	@for_current_user AS bit = 0
	,@role_name AS sysname = NULL
	,@managed_user_login AS sysname = NULL
WITH EXECUTE AS OWNER
AS	
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_id AS int
	DECLARE @managed_user_id AS int = 0
	DECLARE @role_id AS int
	DECLARE @is_admin AS bit = 0
	DECLARE @managed_user_is_admin AS bit = 0
	DECLARE @user_is_security_admin AS bit = 0
	DECLARE @is_permitted AS int = 0
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit

	DECLARE @extension AS varchar(8000)
	SET @extension = 'procedure=GetPermissions' +  ',for_current_user=' +  CAST(@for_current_user AS varchar(6)) + ',role_name=' + ISNULL(@role_name,'') + ',managed_user_login=' +  ISNULL(@managed_user_login,'') 
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	
	EXECUTE AS CALLER	
		SET @user_is_security_admin = app.ufn_CheckUserForSecurityAdmin()
		--SET @user_login = SUSER_NAME()
		SELECT @user_id = u.id FROM app.DIM_USER u WHERE u.login=SUSER_NAME() AND u.valid_to IS NULL
		
		SET @is_admin = app.ufn_CheckUserForAdmin(SUSER_NAME())
		SET @is_permitted = app.ufn_CheckUserPermission('SeeUsers')	
	REVERT
	
	IF(
		(
			   (@for_current_user = 0) 
			OR (@managed_user_login IS NOT NULL) 
			OR (@role_name IS NOT NULL)
		)
		AND (@is_permitted=0)
	   )		
	BEGIN
		EXECUTE AS CALLER
			EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@extension = @extension
		REVERT

		SET @msg_str = 'Отсутствует разрешение на выполнение операции'
		RAISERROR (@msg_str,14,-1)
		RETURN
	END
	
	IF(@managed_user_login IS NOT NULL)
	BEGIN
		SELECT @managed_user_id = u.id FROM app.DIM_USER u WHERE u.login=@managed_user_login AND u.valid_to IS NULL
		IF(@managed_user_id IS NULL)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = @extension
			REVERT
			
			SET @msg_str = 'Не удалось идентифицировать пользователя ' + CAST(@managed_user_login AS varchar(255))
			RAISERROR (@msg_str,14,-1)
			RETURN
		END	
		SET @managed_user_is_admin = app.ufn_CheckUserForAdmin(@managed_user_login)
		--PRINT '@managed_user_is_admin: ' + CAST(@managed_user_is_admin as varchar(255))	
	END
	
	IF(@role_name IS NOT NULL)
	BEGIN
		SELECT @role_id = r.id FROM app.[ROLE] r WHERE r.name=@role_name
		IF(@role_id = 0)
		BEGIN
			SET @msg_str = 'Роль ' + @role_name + ' не существует!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END
	END	

	SET @sql = '	
	SELECT 
		per.[id],
		per.[name],
		per.[description]  
	FROM [app].[PERMISSION] per '
	
	DECLARE @filtered_user_id AS int = 0
	IF ((@for_current_user=1) AND (@is_admin = 0)) SET @filtered_user_id = @user_id
	ELSE IF ((@managed_user_login IS NOT NULL) AND (@managed_user_is_admin = 0)) SET @filtered_user_id = @managed_user_id
	
	--PRINT '@filtered_user_id: ' + CAST(@filtered_user_id as varchar(255))
	
	
	IF(@filtered_user_id <> 0)
	BEGIN
		SET @sql = @sql + ' JOIN [app].[ROLE_PERMISSIONS] rp ON rp.permission_id = per.id'
		SET @sql = @sql + ' JOIN [app].[USER_ROLES] ur ON ur.role_id = rp.role_id AND ur.user_id = ' + CAST(@filtered_user_id AS varchar(20))
	END
	ELSE IF (@role_id <> 0)
	BEGIN
		SET @sql = @sql + ' JOIN [app].[ROLE_PERMISSIONS] rp ON rp.permission_id = per.id AND rp.role_id = ' + CAST(@role_id AS varchar(20))
	END
	
	--SET @sql = @sql + ' ORDER BY per.[name]'
	
	EXECUTE (@sql)
END
GO


--выбрать пользователей IntellectDW
IF OBJECT_ID('app.usp_GetUsers', 'P') IS NOT NULL 
	DROP PROC app.usp_GetUsers
GO
CREATE PROC app.usp_GetUsers 
	@role_name AS sysname = NULL

WITH EXECUTE AS OWNER
AS	
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @role_id AS int
	DECLARE @sql AS nvarchar(4000)
	DECLARE @extension AS varchar(8000)
	DECLARE @result AS bit
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	
	
	EXECUTE AS CALLER
		SET @extension = 'procedure=GetUsers' +  ',role_name=' + ISNULL(@role_name,'') + ',user_login=' +  SUSER_NAME() 	
		IF (app.ufn_CheckUserPermission('SeeUsers')=0)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = @extension
			REVERT
			
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
		IF(@role_name IS NOT NULL)
		BEGIN
			SELECT @role_id = r.id FROM app.[ROLE] r WHERE r.name=@role_name
			IF(@role_id = 0)
			BEGIN
				SET @msg_str = 'Роль ' + @role_name + ' не существует!'
				RAISERROR (@msg_str,11,-1)
				RETURN
			END	
		END
	
	REVERT


	SET @sql = 
	'SELECT  u.id
			,u.login
			,u.name
			,u.comment
			,u.is_admin
			,u.is_locked
			--,u.is_securityadmin
	FROM app.DIM_USER u'
	
	
	IF (@role_id <> 0)
	BEGIN
		SET @sql = @sql + ' JOIN [app].[USER_ROLES] ur ON ur.user_id = u.id AND ur.role_id = ' + CAST(@role_id AS varchar(20))
	END
	
	SET @sql = @sql + ' WHERE u.valid_to IS NULL'
		
	--SET @sql = @sql + ' ORDER BY u.[login]'
			
	--PRINT @sql
	--PRINT 'SUSER_NAME(): ' + SUSER_NAME()
	--PRINT 'USER_NAME(): ' + USER_NAME()
	
	EXECUTE (@sql)
	
END
GO


--выбрать роли IntellectDW
IF OBJECT_ID('app.usp_GetRoles', 'P') IS NOT NULL 
	DROP PROC app.usp_GetRoles
GO
CREATE PROC app.usp_GetRoles 
	@user_login AS sysname = NULL

WITH EXECUTE AS OWNER
AS	
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_id AS int
	DECLARE @sql AS nvarchar(4000)
	DECLARE @extension AS varchar(8000)
	DECLARE @result AS bit
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	 
	
	EXECUTE AS CALLER
		SET @extension = 'procedure=GetRoles' +  ',user_login=' +  SUSER_NAME()
		IF (app.ufn_CheckUserPermission('SeeUsers')=0)
		BEGIN			
			EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@extension = @extension
			
			
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
		IF(@user_login IS NOT NULL)
		BEGIN
			SELECT @user_id = u.id FROM app.DIM_USER u WHERE u.login=@user_login AND u.valid_to IS NULL
		END
	
	REVERT			
	

	SET @sql = 
	'SELECT  r.id
			,r.name
			,r.description				
		FROM [app].[ROLE] r'
		
	
	IF (@user_id <> 0)
	BEGIN
		SET @sql = @sql + ' LEFT JOIN [app].[USER_ROLES] ur ON ur.role_id = r.id WHERE ur.user_id = ' + CAST(@user_id AS varchar(20))
	END
	
	--SET @sql = @sql + ' ORDER BY r.[name]'
			
	--PRINT @sql
	--PRINT 'SUSER_NAME(): ' + SUSER_NAME()
	--PRINT 'USER_NAME(): ' + USER_NAME()
	
	EXECUTE (@sql)

END
GO


--получить роли с полномочиями
IF OBJECT_ID('app.usp_GetRolesPermissions', 'P') IS NOT NULL 
	DROP PROC app.usp_GetRolesPermissions
GO
CREATE PROC app.usp_GetRolesPermissions	 

AS	
BEGIN
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_id AS int

	DECLARE @extension AS varchar(8000)
	SET @extension = 'procedure=GetRolesPermissions' +  ',user_login=' +  SUSER_NAME() 
	
	DECLARE @result AS bit
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT	
			
	SELECT @user_id = u.id FROM app.DIM_USER u WHERE u.login=SUSER_NAME() AND u.valid_to IS NULL
	
	IF (app.ufn_CheckUserPermission('SeeUsers')=0)
	BEGIN
		EXEC app.usp_LogAuditEvent
			@group = 'others'
			,@action = 'permission_fauled'				
			,@extension = @extension
		
		SET @msg_str = 'Отсутствует разрешение на выполнение операции'
		RAISERROR (@msg_str,14,-1)
		RETURN
	END
		
	SELECT 
	rp.id AS [ID], 
	r.name AS [RoleName], 
	per.name AS [PermissionName]
	FROM [IntellectDW].[app].[ROLE_PERMISSIONS] rp
	JOIN [IntellectDW].[app].ROLE r ON rp.role_id = r.id
	JOIN [IntellectDW].[app].PERMISSION per ON rp.permission_id = per.id		
END
GO

--/*
--выбрать владельцев карт
IF OBJECT_ID('app.usp_GetPersons', 'P') IS NOT NULL 
	DROP PROC app.usp_GetPersons
GO

CREATE PROC app.usp_GetPersons 
	@person AS varchar(max) = NULL
	,@departments AS varchar(max) = NULL
	,@use_oper_db AS bit = 0
	,@nc32k_id AS varchar(60) = NULL
	,@level_id AS varchar(60) = NULL
	,@show_full_access_level AS bit = 0
	,@show_person_history AS bit = 0
	,@hide_temp_persons AS bit = 0
	,@facility_code varchar(3) = NULL
	,@card varchar(6) = NULL
	,@person_id varchar(60) = NULL

WITH EXECUTE AS OWNER
AS	
BEGIN
	--SET ARITHABORT ON
		
	DECLARE @is_permitted AS bit = 1
	DECLARE @user_id AS int = 0
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit
	DECLARE @params_definition nvarchar(4000)
	
	SET DATEFORMAT dmy
	SET @extension = 'procedure=usp_GetPersons' 
							+ ',user_login=' +  SUSER_NAME() 
							+ ',show_person_history=' + CAST(@show_person_history AS nvarchar(5))
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	EXECUTE AS CALLER
		
		IF((app.ufn_CheckUserPermission('SeeFullLevels') = 0)
			AND @show_full_access_level = 1) 
			SET @is_permitted=0
			
		IF((app.ufn_CheckUserPermission('SeePersonHistory') = 0)
			AND @show_person_history = 1) 
			SET @is_permitted=0
		
		IF(@is_permitted=0)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = @extension
			REVERT

			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
	REVERT
	
	PRINT '@person_id: ' + ISNULL(@person_id,'')
	PRINT '@facility_code: ' + ISNULL(@facility_code,'')
	PRINT '@card: ' + ISNULL(@card,'')
	
	IF(@use_oper_db =0 OR @show_person_history = 1)
	BEGIN		
		SET @sql = ''		
		
		IF((ISNULL(@nc32k_id,'') <> '') OR (ISNULL(@level_id,'null') <> 'null')) SET @sql =
			'
			WITH PerLevs (id, parent_id, lev, level_id) AS
			(
				SELECT 
					id
					,parent_id
					,LEFT(CAST(level_id AS varchar(max)),CHARINDEX('','',CAST(level_id AS varchar(max)) + '','')-1)
					,STUFF(CAST(level_id AS varchar(max)), 1, CHARINDEX('','', CAST(level_id AS varchar(max)) + '',''),'''')
				FROM [dw].[DIM_OBJ_PERSON] with (nolock)
				WHERE valid_to IS NULL
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
				FROM [dw].[DIM_OBJ_DEPARTMENT] with (nolock)
				WHERE valid_to IS NULL
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
			
		IF((ISNULL(@person_id,'') ='') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))
		BEGIN
			IF(ISNULL(@departments,'')<>'') 
			BEGIN
				SET @sql = @sql + '			
				DECLARE @department_keys_tbl table
				([dept_key] int
					,primary key ([dept_key])
				)

				INSERT INTO @department_keys_tbl 
				SELECT DISTINCT dept_key 
					FROM [dw].[DIM_OBJ_DEPARTMENT] dept2 
					INNER JOIN (SELECT StringValue FROM [app].[ufn_StringListToTable](@departments,'','')) table_names'
				IF(@show_person_history = 0) SET @sql = @sql + '
								ON LTRIM(RTRIM(dept2.name)) = table_names.StringValue
						WHERE dept2.valid_to IS NULL'
				ELSE SET @sql = @sql + '
								ON app.ufn_RemoveUnnecessaryChars(dept2.name) 
								LIKE (''%'' + REPLACE(app.ufn_RemoveUnnecessaryChars(table_names.StringValue),'' '',''%'') + ''%'')'
				
			END
		END
		
		SET @sql = @sql +
		' SELECT'
		
		IF((ISNULL(@nc32k_id,'') <> '') OR (ISNULL(@level_id,'null') <> 'null')) SET @sql = @sql + ' DISTINCT'
		
		SET @sql = @sql +  
		
		'
			   per.[person_key],	
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
			   ISNULL([app].[ufn_TryConvertDate](per.expired),''1900/01/01'') AS [expired],
			   (CASE WHEN (per.valid_to IS NULL) THEN 0 ELSE 1 END) AS [is_deleted],
			   per.[valid_from],
			   ISNULL(per.[valid_to],''9999/01/01'') AS [valid_to]'
		
		IF((ISNULL(@nc32k_id,'') <> '') OR (ISNULL(@level_id,'null') <> 'null')) 
		BEGIN
			SET @sql = @sql + '
			from [dw].[DIM_OBJ_PERSON] per with (nolock)
			join [dw].[DIM_OBJ_DEPARTMENT] dep ON dep.id = per.parent_id			
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
			   from [dw].[DIM_OBJ_LEVEL] l1
			   where l1.valid_to IS NULL
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
						from [dw].[DIM_OBJ_LEVEL_READER] lr1
						where lr1.reader_type = ''PNET3_NC32K''
						and lr1.time_zone <> ''''
						and lr1.valid_to IS NULL					
							union all					
						select id, ''*'', ''*'' 
						from [dw].[DIM_OBJ_PNET3_NC32K] nc1
						where nc1.valid_to IS NULL
						) lr on lr.main_id = per_levels.lev'
			SET @sql = @sql + '
				where 1=1' 
			IF(@show_person_history = 0)
			SET @sql = @sql + '
					and per.valid_to IS NULL
					and dep.valid_to IS NULL'
			IF(ISNULL(@nc32k_id,'') <> '') SET @sql = @sql + '
					and lr.reader_id = @nc32k_id
					and (isnull(per.is_locked,0)<>1) 
					and ([app].[ufn_TryConvertDate](per.expired) >= GETDATE())'
			ELSE IF(ISNULL(@level_id,'null') <> 'null') SET @sql = @sql + '
					and l.id = @level_id'	
			IF(@show_full_access_level = 0 ) SET @sql = @sql + '
					and (per_levels.lev <> ''*'')'			
		END
		ELSE 
		BEGIN
			SET @sql = @sql + ' 
				    
			FROM dw.DIM_OBJ_PERSON per  with (nolock)'
			IF (@show_person_history = 1) 
			BEGIN
				SET @sql = @sql + '
				  JOIN (SELECT DISTINCT
							(SELECT MAX([person_key]) FROM [dw].[DIM_OBJ_PERSON] WHERE guid = per3.guid) [person_key],
							per3.[guid] [guid]
						FROM [dw].[DIM_OBJ_PERSON] per3 with (nolock)
						JOIN dw.DIM_OBJ_DEPARTMENT dep3 ON dep3.id = per3.parent_id
													   AND (dep3.valid_from >= (SELECT MAX(valid_from) 
																			   FROM dw.DIM_OBJ_DEPARTMENT  with (nolock)
																			   WHERE id = per3.parent_id AND valid_from <= per3.valid_from))
													   AND (dep3.valid_from <= ISNULL(per3.valid_to,''9999/01/01''))
						WHERE per3.[guid] IS NOT NULL
							AND dep3.name <> ''#Операторы Интеллект'''
					 IF((ISNULL(@person_id,'') ='') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))
					 BEGIN
						 IF(ISNULL(@person,'') <> '') SET @sql = @sql + ' 
								AND (
									app.ufn_RemoveUnnecessaryChars(          ISNULL(per3.name,'''') 
																   + '' '' + ISNULL(per3.surname,'''') 
																   + '' '' + ISNULL(per3.patronymic,'''')) 
									LIKE (''%'' + REPLACE(app.ufn_RemoveUnnecessaryChars(@person),'' '',''%'') + ''%''))'					 
						 IF(ISNULL(@departments,'') <> '') SET @sql = @sql + ' 
							 		AND dep3.dept_key IN (SELECT dept_key FROM @department_keys_tbl)'
					 END
					 ELSE
					 BEGIN
						IF(ISNULL(@person_id,'') <> '')
							SET @sql = @sql + '
							AND per3.id = @person_id'
						ELSE IF((ISNULL(@facility_code,'') <>'') OR (ISNULL(@card,'') <>'')) 
						BEGIN
							IF(ISNULL(@facility_code,'') <>'') SET @sql = @sql + '
							  AND LTRIM(RTRIM(per3.facility_code))=@facility_code'
							IF(ISNULL(@card,'') <>'') SET @sql = @sql + '
							  AND LTRIM(RTRIM(per3.card))=@card'
						END
					 END					 
					 SET @sql = @sql + ' 
					    ) guid_table ON guid_table.person_key = per.person_key'
				 SET @sql = @sql + '
				 JOIN dw.DIM_OBJ_DEPARTMENT dep ON dep.id = per.parent_id
				 AND (dep.valid_from = (SELECT MAX(valid_from) 
								FROM dw.DIM_OBJ_DEPARTMENT  with (nolock)
								WHERE id = per.parent_id AND valid_from <= per.valid_from))'
				 
			END
			ELSE 
			BEGIN
				SET @sql = @sql + '
					JOIN dw.DIM_OBJ_DEPARTMENT dep ON dep.id = per.parent_id  AND dep.valid_to IS NULL
					WHERE dep.name <> ''#Операторы Интеллект''
						AND per.valid_to IS NULL'
				IF(@hide_temp_persons =1) SET @sql = @sql + '
						AND dep.name <> ''Временные пропуска'''
					
				IF((ISNULL(@person_id,'') ='') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))
			    BEGIN
					IF(ISNULL(@person,'') <> '') SET @sql = @sql + ' 
								AND (
									app.ufn_RemoveUnnecessaryChars(          ISNULL(per.name,'''') 
																   + '' '' + ISNULL(per.surname,'''') 
																   + '' '' + ISNULL(per.patronymic,'''')) 
									LIKE (''%'' + REPLACE(app.ufn_RemoveUnnecessaryChars(@person),'' '',''%'') + ''%''))'				 	
					IF(ISNULL(@departments,'') <> '') SET @sql = @sql + ' 
							  AND dep.dept_key IN (SELECT dept_key FROM @department_keys_tbl)'
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
		END
		
		PRINT @sql	
		SET @params_definition = N'@person varchar(max),@departments varchar(max),@nc32k_id varchar(60),@level_id varchar(60)
									,@facility_code varchar(3), @card varchar(6), @person_id varchar(60)'
			EXEC sp_executesql @sql, @params_definition, @person=@person, @departments = @departments,@nc32k_id=@nc32k_id,@level_id=@level_id
									,@facility_code=@facility_code, @card=@card, @person_id=@person_id
	END
	ELSE
	BEGIN
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_GetPersons'
		EXEC @C_SP_CMD @person = @person, @departments = @departments, @nc32k_id=@nc32k_id, @level_id=@level_id,
								  @show_full_access_level=@show_full_access_level, @hide_temp_persons=@hide_temp_persons
								  ,@facility_code=@facility_code, @card=@card, @person_id=@person_id
	END
END
GO
--*/

--exec opk.usp_GetPersons @nc32k_id = '1.255'


--выбрать владельца карты
IF OBJECT_ID('app.usp_GetPerson', 'P') IS NOT NULL 
	DROP PROC app.usp_GetPerson
GO

CREATE PROC app.usp_GetPerson 
	@person_key AS int,
	@person_id AS varchar(60),
	@guid AS uniqueidentifier = NULL,
	@valid_date AS datetime,
	@show_person_history AS bit = 0,
	@use_oper_db AS bit = 0

WITH EXECUTE AS OWNER
AS	
BEGIN
	DECLARE @is_permitted AS bit = 1
	DECLARE @user_id AS int = 0
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000) = ''
	DECLARE @result AS bit
	DECLARE @params_definition nvarchar(4000)
	SET DATEFORMAT dmy
	SET @extension = 'procedure=usp_GetPerson' 
							+ ',user_login=' +  SUSER_NAME() 
							+ ',show_person_history=' + CAST(@show_person_history AS nvarchar(5))
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	EXECUTE AS CALLER
		
		IF((app.ufn_CheckUserPermission('SeePersonHistory') <> 1)
			AND @show_person_history = 1) 
			SET @is_permitted=0
		
		IF(@is_permitted=0)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = @extension
			REVERT

			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
	REVERT
	
	IF(   
		  ((@person_key =0) AND (@person_id=''))
		  --((@person_key =0) AND (@use_oper_db = 0) AND (@show_person_history = 0))
	   --OR ((@show_person_history = 0) AND (@person_key <> 0) AND (@valid_date IS NULL))
	   OR ((@show_person_history = 1) AND (@guid IS NULL)) 
	   )
	BEGIN
			SET @msg_str = 'Неверные параметры для операции!'
			RAISERROR (@msg_str,11,-1)
			RETURN
	END

	IF(@use_oper_db = 0)
	BEGIN	
		SET @sql = @sql + '
		WITH PersonAndDept (person_key, dept_key, valid_from, valid_to) AS
		('
		IF(@show_person_history = 0)
		BEGIN 
			SET @sql = @sql + '
			SELECT
				p.person_key [person_key],	
				d.dept_key [dept_key],
				@valid_date [valid_from],
				@valid_date [valid_to]
			FROM [dw].[DIM_OBJ_PERSON] p 
			LEFT JOIN [dw].[DIM_OBJ_DEPARTMENT] d ON d.id = p.parent_id'			
			IF(@person_key <> 0) SET @sql = @sql + '			
												AND (d.valid_from = (SELECT MAX(valid_from) 
												FROM dw.DIM_OBJ_DEPARTMENT
												WHERE id = p.parent_id 
													AND valid_from <= @valid_date))
				WHERE p.[person_key] = @person_key'
			ELSE SET @sql = @sql + '
												AND d.valid_to IS NULL
				WHERE p.[id] = @person_id 
					AND p.valid_to IS NULL'
			SET @sql = @sql + '
		)'
		END
		ELSE
		BEGIN
			SET @sql = @sql + '	
			SELECT
				person_key,
				dept_key,
				valid_from,
				MAX(valid_to) as [valid_to] 
			FROM
			(
				SELECT 
					p.person_key [person_key],	
					d.dept_key [dept_key],
					CASE WHEN p.valid_from >= ISNULL(d.valid_from,''9999-01-01'')	
							THEN p.valid_from
						 ELSE
							d.valid_from
						 END AS [valid_from],
					(CASE WHEN p.valid_to <= ISNULL(d.valid_to,''9999-01-01'')
							THEN ISNULL(p.valid_to,''9999-01-01'')
						 ELSE ISNULL(d.valid_to,''9999-01-01'') 
						 END) AS [valid_to]
				FROM [dw].[DIM_OBJ_PERSON] p
				CROSS APPLY (SELECT dept.dept_key, dept.valid_from, dept.valid_to 
							FROM [dw].[DIM_OBJ_DEPARTMENT] dept 
							WHERE dept.id = p.parent_id
							AND (dept.valid_from >= (SELECT MAX(valid_from) 
										   FROM dw.DIM_OBJ_DEPARTMENT
										   WHERE id = p.parent_id 
												AND valid_from <= p.valid_from))
							AND dept.valid_from <= ISNULL(p.valid_to,''9999-01-01'')
							) d				
				WHERE p.guid = @guid
			) t
			GROUP BY 
				person_key,dept_key,valid_from
		)'		
		END
				
		SET @sql = @sql + '
		SELECT
		   per.[person_key]
		  ,ISNULL(per.[photo_key],-1) AS [photo_key]
		  ,per.[auto_brand]
		  ,per.[auto_number]
		  ,per.[begin_temp_level]
		  ,per.[card]
		  ,per.[card_date]
		  ,per.[card_loss]
		  ,per.[comment]
		  ,per.[drivers_licence]
		  ,per.[end_temp_level]
		  ,ISNULL([app].[ufn_TryConvertDate](per.expired),''1900/01/01'') AS [expired]
		  ,per.[external_id]
		  ,per.[facility_code]
		  ,per.[flags]
		  ,ISNULL(per.[guid],''00000000-0000-0000-0000-000000000000'') as [guid]
		  ,per.[id]
		  ,per.[is_active_temp_level]
		  ,ISNULL(per.is_apb,0) AS [is_apb]
		  ,ISNULL(per.[is_locked] ,0) AS [is_locked]
		  ,per.[level_id]
		  ,per.[levels_times]
		  ,per.[name]
		  ,per.[parent_id]
		  ,per.[passport]
		  ,per.[patronymic]
		  ,per.[phone]
		  ,per.[pin]
		  ,per.[post]
		  ,per.[pur]
		  ,per.[schedule_id]
		  ,ISNULL([app].[ufn_TryConvertDate](per.started_at),''1900/01/01'') AS [started_at]
		  ,per.[surname]
		  ,per.[tabnum]
		  ,per.[temp_card]
		  ,per.[temp_level_id]
		  ,per.[temp_levels_times]
		  ,per.[who_card]
		  ,per.[who_level]
		  ,ISNULL(per.[pnet3_alarm],0) AS [pnet3_alarm]
		  ,ISNULL(per.[pnet3_block],0) AS [pnet3_block]
          ,ISNULL(per.[pnet3_guard],0) AS [pnet3_guard]
		  ,ISNULL(per.is_locked,0) AS [is_locked]
		  ,per.[valid_from] AS [per_valid_from]
		  ,per.[valid_to] AS [per_valid_to]
		  ,dep.[name] AS [department]
		  ,dep.[level_id] AS [department_level_id]
		  ,dep.valid_from AS [dep_valid_from]
		  ,dep.valid_to AS [dep_valid_to]
		  ,PersonAndDept.valid_from AS [valid_from]
		  ,PersonAndDept.valid_to AS [valid_to] 
			
		FROM PersonAndDept
		JOIN [dw].[DIM_OBJ_PERSON] per ON (per.person_key = PersonAndDept.person_key)
		LEFT JOIN [dw].[DIM_OBJ_DEPARTMENT] dep ON (dep.dept_key =PersonAndDept.dept_key)'		

		PRINT @sql	
		SET @params_definition = N'@person_key int, @person_id varchar(60), @guid AS uniqueidentifier, @show_person_history bit, @valid_date datetime'
			EXEC sp_executesql @sql, @params_definition, @person_key=@person_key, @person_id=@person_id,@guid=@guid, @show_person_history=@show_person_history, @valid_date=@valid_date
	END
	ELSE
	BEGIN
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_GetPerson'
		EXEC @C_SP_CMD @person_id=@person_id, @guid=@guid
	END
END
GO
--*/



--показать события доступа
IF OBJECT_ID('app.usp_GetAccessEvents', 'P') IS NOT NULL 
	DROP PROC app.usp_GetAccessEvents
GO
CREATE PROC app.usp_GetAccessEvents	 
	@app_build AS varchar(10) = NULL
	--,@mode AS varchar(60)
	,@persons AS varchar(max) = NULL
	,@departments AS varchar(max) = NULL
	,@access_points varchar(max) = NULL
	,@events varchar(max) = NULL
	,@date_start AS datetime
	,@date_end AS datetime	
	,@use_oper_db AS bit = 0
	,@only_last_10_events_for_day AS bit = 0
	,@facility_code varchar(3) = NULL
	,@card varchar(6) = NULL
	,@person_id varchar(60) = NULL
	,@computer_name [varchar] (255) = NULL
	--,@rowcount AS int OUTPUT	
WITH EXECUTE AS OWNER
AS	
BEGIN	
	SET ARITHABORT ON
	--SET DATEFORMAT dmy
	
	PRINT '----REGION1----'
	PRINT '@persons: ' + ISNULL(@persons,'')
	PRINT '@events: ' + ISNULL(@events,'')
	PRINT '@access_points: ' + ISNULL(@access_points,'')
	PRINT '@departments: ' + ISNULL(@departments,'')
	PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
	PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
	PRINT '@use_oper_db: ' + CAST(@use_oper_db AS NVARCHAR(5))
	PRINT '@facility_code: ' + ISNULL(@facility_code,'')
	PRINT '@card: ' + ISNULL(@card,'')
	PRINT '@person_id: ' + ISNULL(@person_id,'')
	PRINT '@only_last_10_events_for_day: ' + CAST(@only_last_10_events_for_day AS NVARCHAR(5))
	
	
	
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_id AS int
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit

	DECLARE	@SeeAccessEventsOverSixMonths AS bit = 0
	DECLARE	@SeeAccessEventsOPKPersonOverSevenDays AS bit = 0
				
	DECLARE @date_start_for_opk AS datetime = @date_start
	DECLARE @rowcount AS int = 0
	DECLARE @rowcount_limit AS int = 100000
	
	DECLARE @person_keys_tbl AS app.TableOfKeys
	DECLARE @department_keys_tbl AS app.TableOfKeys
	

	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	--REVERT
	
					
	--EXECUTE AS CALLER
			
		SET @SeeAccessEventsOverSixMonths = app.ufn_CheckUserPermission('SeeAccessEventsOverSixMonths')
		SET @SeeAccessEventsOPKPersonOverSevenDays = app.ufn_CheckUserPermission('SeeAccessEventsOPKPersonOverSevenDays')
		PRINT '@SeeAccessEventsOverSixMonths: ' + CAST(@SeeAccessEventsOverSixMonths AS NVARCHAR(5))
		PRINT '@SeeAccessEventsOPKPersonOverSevenDays: ' + CAST(@SeeAccessEventsOPKPersonOverSevenDays AS NVARCHAR(5))
		
			--IF(@use_oper_db=0 OR (CAST(@date_start AS DATE) >= DATEADD(DAY,-1,CAST(GETDATE() AS date))))
			--BEGIN
				--SET @extension = 'use_oper_db=' + CAST(@use_oper_db AS nvarchar(5)) + ',only_last_10_events_for_day=' + CAST(@only_last_10_events_for_day AS nvarchar(5))
				IF (ISNULL(@person_id,'') <>'') SET  @persons = @person_id
				IF((ISNULL(@facility_code,'') <>'') OR (ISNULL(@card,'') <>''))
					SET @extension = ISNULL(@extension,'') + 'facility_code=' + ISNULL(@facility_code,'') + ',card=' + ISNULL(@card,'')
				EXEC app.usp_LogAuditEvent
							@group = 'db_query'
							,@action = 'persons_access'				
							,@date_start = @date_start
							,@date_end = @date_end
							,@events = @events
							,@persons = @persons
							,@departments=@departments
							,@access_points = @access_points
							,@app_build = @app_build
							,@extension = @extension
							,@computer_name = @computer_name
			--END
	
	REVERT

	
	IF(@use_oper_db=0)
	BEGIN
		--IF(@date_end < CAST(GETDATE() AS date)) SET @date_end = DATEADD(DAY,1, @date_end)

		IF(@SeeAccessEventsOverSixMonths <> 1) 
		BEGIN
			IF(@date_start < DATEADD(MONTH, -6, GETDATE())) SET @date_start = DATEADD(MONTH, -6, GETDATE())
		END
	
		IF(@SeeAccessEventsOPKPersonOverSevenDays <> 1)
		BEGIN
			IF(@date_start < DATEADD(DAY, -7, GETDATE())) SET @date_start_for_opk = DATEADD(DAY, -7, GETDATE())
		END
	
		PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
		PRINT '@date_start_for_opk: ' + CAST(@date_start_for_opk AS NVARCHAR(20))
		PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))

		
		SET @persons = ISNULL(@persons,'')
		
		SET @sql = ''
		
		SET @sql = @sql + 
		' 
		SELECT'
		
		IF(@only_last_10_events_for_day = 1) 
		BEGIN
			SET @sql = @sql + ' TOP(10)'
		END
		ELSE
			SET @sql = @sql + ' TOP(' + CAST(@rowcount_limit AS nvarchar(20)) + ')'
		
		SET @sql = @sql + '
		     factProc.date AS [date]
			,ISNULL(factProc.person_key,-1) AS [person_key] 
			,dimEv.description AS [event]
			,ISNULL(dimPer.id,'''') AS [person_id]
			,CASE WHEN (ISNULL(factProc.person_key,-1) = -1)
				  THEN 
						 factProc.params				  
				  ELSE						
					        RTRIM(ISNULL(dimPer.name,'''') 
						+ '' '' + ISNULL(dimPer.surname,'''')
						+ '' '' + ISNULL(dimPer.patronymic,'''') 
						+ '' '' + ISNULL(factProc.params,''''))
						-- + '' ('' + dimPer.id + '')''
				  END AS [person]
			,dimDep.name AS [department]
			,dimNC32K.id AS [nc32k_id]
			,dimNC32K.name AS [nc32k]
			--,CASE WHEN (ISNULL(dimPer.person_key,-1) = -1) THEN
			--	factProc.params
			--  ELSE ''('' + ISNULL(dimPer.facility_code,'''') + '') '' + ISNULL(dimPer.card,'''')
			--  END AS [card]
			,'''' AS [card]
		FROM [dw].[FACT_PROTOCOL] factProc'
		IF(    (@persons !='') 
			OR (ISNULL(@departments,'')!='')
			OR ((ISNULL(@person_id,'') <>'') OR (ISNULL(@card,'')<>'') OR (ISNULL(@facility_code,'')<>'')) 
		   ) 
			SET @sql = @sql + ' with (index(idx_FACT_PROTOCOL_person_nc))'
		
		SET @sql = @sql + '		
		JOIN [dw].[DIM_EVENT] dimEv ON dimEv.event_key = factProc.event_key
		JOIN [dw].[DIM_OBJ_PNET3_NC32K] dimNC32K ON dimNC32K.nc32k_key = factProc.nc32k_key
		'
		
		IF(  (      (@persons ='') 
				AND (ISNULL(@departments,'')='')
			 )				
			    OR ((ISNULL(@person_id,'') <>'') OR (ISNULL(@card,'')<>'') OR (ISNULL(@facility_code,'')<>'')) 
		   ) 
			SET @sql = @sql + 
			'LEFT '
		SET @sql = @sql + 
		'JOIN [dw].[DIM_OBJ_PERSON] dimPer ON (dimPer.person_key = factProc.person_key)
		'

		IF(   (ISNULL(@departments,'')='')
		   OR ((ISNULL(@person_id,'') <>'') OR (ISNULL(@card,'')<>'') OR (ISNULL(@facility_code,'')<>'')) 
		   ) SET @sql = @sql + '
		LEFT '
		SET @sql = @sql + 
		'JOIN [dw].[DIM_OBJ_DEPARTMENT] dimDep ON dimDep.dept_key = factProc.dept_key'
		
			
		SET @sql = @sql + 
		' 
		WHERE 1=1'
		
		IF((ISNULL(@person_id,'') = '') AND (ISNULL(@card,'')='') AND (ISNULL(@facility_code,'')=''))		    
		BEGIN
			--IF(@persons <>'') SET @sql = @sql + ' 
			--	AND (dimPer.person_key IN (SELECT person_key FROM @person_keys_tbl))'
			IF(@persons <>'') SET @sql = @sql + ' 
				AND factProc.person_key IN 
					(
						SELECT DISTINCT person_key 
						FROM [dw].[DIM_OBJ_PERSON] per2 
						INNER JOIN (SELECT StringValue FROM [app].[ufn_StringListToTable](@persons,'','')) table_names
								ON app.ufn_RemoveUnnecessaryChars(ISNULL(per2.name,'''') + '' '' + ISNULL(per2.surname,'''') + '' '' + ISNULL(per2.patronymic,'''')) 
								LIKE (''%'' + REPLACE(app.ufn_RemoveUnnecessaryChars(table_names.StringValue),'' '',''%'') + ''%'')
					)
				'
			
			IF(ISNULL(@departments,'') <>'') SET @sql = @sql + '  
				AND factProc.person_key IN 
					(
						SELECT DISTINCT person_key 
						FROM [dw].[DIM_OBJ_PERSON] per3
						JOIN dw.DIM_OBJ_DEPARTMENT dep4 ON dep4.id = per3.parent_id
							AND (dep4.valid_from = (SELECT MAX(valid_from) 
								FROM dw.DIM_OBJ_DEPARTMENT  with (nolock)
								WHERE id = per3.parent_id AND valid_from <= per3.valid_from))
						INNER JOIN (SELECT StringValue FROM [app].[ufn_StringListToTable](@departments,'','')) table_names
									ON app.ufn_RemoveUnnecessaryChars(ISNULL(dep4.name,'''')) 
										LIKE (''%'' + REPLACE(app.ufn_RemoveUnnecessaryChars(table_names.StringValue),'' '',''%'') + ''%'')					
						
					)
				'				
		END
		ELSE
		BEGIN
			IF(ISNULL(@person_id,'') <> '')
				SET @sql = @sql + '
				AND factProc.person_key IN (SELECT [person_key] FROM [dw].[DIM_OBJ_PERSON] WHERE [id] = @person_id)'
			
			ELSE IF((ISNULL(@facility_code,'') <>'') OR (ISNULL(@card,'') <>'')) 
			BEGIN
				SET @sql = @sql + ' 
				AND 					
					( 
						factProc.person_key IN 
						  (
								SELECT DISTINCT person_key 
								FROM [dw].[DIM_OBJ_PERSON] per4
								WHERE (1=1)'
								IF(ISNULL(@facility_code,'') <>'') SET @sql = @sql + '
								  AND (LTRIM(RTRIM(ISNULL(per4.facility_code,'''')))=@facility_code)'
								IF(ISNULL(@card,'') <>'') SET @sql = @sql + '
								  AND (LTRIM(RTRIM(ISNULL(per4.card,'''')))=@card)
						   )'
						SET @sql = @sql + '							
						OR
						(
						  factProc.params LIKE ''('
							IF(ISNULL(@facility_code,'') <>'') SET @sql = @sql + ''' + @facility_code + '')'
							ELSE SET @sql = @sql + '%)'
							
							IF(ISNULL(@card,'') <>'') SET @sql = @sql + ' '' + @card'
							ELSE SET @sql = @sql + '%''' 
							  
							SET @sql = @sql + '
						)		
					)'
			END			
		END		
		
		IF((@SeeAccessEventsOPKPersonOverSevenDays <> 1) AND (@date_start < DATEADD(DAY, -7, GETDATE())))
		BEGIN
			SET @sql = @sql + 
			' 
			AND
				(
					  (	
						(factProc.date BETWEEN  @date_start AND @date_end) 
						 AND ((dimDep.id IS NULL) OR ((dimDep.id IS NOT NULL) AND (dimDep.name NOT LIKE ''%погранич%'')))
					  )
					
					  OR
					  (
						(factProc.date BETWEEN @date_start_for_opk AND @date_end)
						AND ((dimDep.id IS NOT NULL) AND (dimDep.name LIKE ''%погранич%''))
					  )
				) '
		END
		ELSE
			SET @sql = @sql + ' 
			AND factProc.date BETWEEN @date_start AND @date_end'	
		

		IF(ISNULL(@access_points,'') <>'') SET @sql = @sql + '  
			AND (dimNC32K.id IN (SELECT StringValue FROM [app].[ufn_StringListToTable](@access_points,'','')))'


		IF(ISNULL(@events,'') <>'') SET @sql = @sql + ' 
			AND (dimEv.objtype = ''PNET3_NC32K'' 
				 AND dimEv.action IN (SELECT StringValue FROM [app].[ufn_StringListToTable](@events,'','')))'

			
		IF(@only_last_10_events_for_day = 1) 
		BEGIN
			SET @sql = @sql + ' 
			ORDER BY factProc.date DESC'
		END	
		
		--SET @sql = @sql + ' 
		--	SELECT @rowcount=@@ROWCOUNT'

		PRINT @sql	
		
		DECLARE @ParamsDefinition nvarchar(4000) = N'@date_start datetime, @date_end datetime, @date_start_for_opk datetime, 
													  @events varchar(max), @access_points varchar(max),
													  @person_keys_tbl app.TableOfKeys READONLY, @department_keys_tbl app.TableOfKeys READONLY,
													 @facility_code varchar(3), @card varchar(6), @person_id varchar(60),
													 @persons varchar(max), @departments varchar(max)'
				
			EXEC sp_executesql @sql, @ParamsDefinition, @date_start=@date_start, @date_end=@date_end, @date_start_for_opk=@date_start_for_opk, 
														@events=@events, @access_points=@access_points,
														@person_keys_tbl =@person_keys_tbl, @department_keys_tbl=@department_keys_tbl,
														@facility_code=@facility_code, @card=@card, @person_id=@person_id,
														@persons=@persons, @departments=@departments
		
	END
	ELSE
	BEGIN
		--IF(CAST(@date_start AS date) < DATEADD(DAY,-1,CAST(GETDATE() AS date))) SET @date_start = DATEADD(DAY,-1,CAST(GETDATE() AS date))
		--SET @date_end = DATEADD(Day,1, @date_start)
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_GetAccessEvents'
			PRINT '----REGION2----'
			PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
			PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
						
			EXEC @C_SP_CMD @date_start = @date_start, @date_end = @date_end, @persons = @persons, @only_last_10_events_for_day = @only_last_10_events_for_day
						  ,@access_points=@access_points,@events=@events,@departments=@departments,@rowcount_limit=@rowcount_limit
						  ,@facility_code=@facility_code, @card=@card, @person_id=@person_id, @rowcount=@rowcount OUTPUT
	END
	/*
	IF(@rowcount = @rowcount_limit)
	BEGIN
		SET @extension = 'row_count=' + CAST(@rowcount AS nvarchar(30))
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
						@group = 'others'
						,@action = 'row_count_limit_exceeded'				
						,@date_start = @date_start
						,@date_end = @date_end
						,@events = @events
						,@persons = @persons
						,@departments=@departments
						,@access_points = @access_points
						,@app_build = @app_build
			REVERT
	END
	*/	
END
GO

/*
DECLARE @date_start as datetime = DATEADD(day,-1,GETDATE())
DECLARE @date_end  as datetime = DATEADD(day,-0,GETDATE())
EXEC app.usp_GetAccessEvents 
	--@app_build  = '1.0.0.0'
	--,@mode = 'ByName'
	@use_oper_db = 0
	--,@events=''
	--,@access_points='1.255'
	--,@events='ACCESS_IN'
	--,@access_points=default
	--,@events='EVENTA2'
	--,@departments=default
	--,@facility_code=default
	--,@card=default
	--,@person_id='5944'
	--,@access_points = '1.209,1.255'
	--,@facility_code = '200'
	--,@card  = '7853'
	--,@departments = 'Ариал'
	--,@persons = 'матве'
	--,@person_id = '3884'
	--,@date_start = @date_start
	--,@date_end = @date_end
	,@date_start = '17.12.2019 0:00:00'
	,@date_end = '17.12.2019 23:59:59' 
	,@only_last_10_events_for_day = 1
*/


--получить уровни доступа
IF OBJECT_ID('app.usp_GetLevels', 'P') IS NOT NULL 
	DROP PROC app.usp_GetLevels
GO
CREATE PROC app.usp_GetLevels	 
	@use_oper_db AS bit = 0
	,@levels as varchar(max) = NULL
	,@valid_from as datetime = '1753/01/01'
	,@is_department_levels AS bit = 0
	,@nc32k_id as varchar(60) = NULL
	,@show_full_access_level AS bit = 0
	,@name AS varchar(255) = NULL
WITH EXECUTE AS OWNER
AS	
BEGIN
	DECLARE @is_permitted AS bit = 1
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @user_id AS int
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit
	DECLARE @extension AS varchar(8000)	
	SET @extension = 'procedure=GetLevels' +  ',user_login=' +  SUSER_NAME() 

	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
			
		IF((app.ufn_CheckUserPermission('SeeFullLevels') = 0)
			AND @show_full_access_level = 1) 
			SET @is_permitted=0
		
		
		IF (app.ufn_CheckUserPermission('SeeLevels')=0)
			SET @is_permitted=0
		
		IF(@is_permitted=0)
		BEGIN
			EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@extension = @extension
			
			
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	REVERT
	
	
	--SELECT @user_id = u.id FROM app.DIM_USER u WHERE u.login=SUSER_NAME() AND u.valid_to IS NULL


	IF((@levels IS NOT NULL) AND (@valid_from = '1753/01/01'))   
		BEGIN
			SET @msg_str = 'Неверные параметры для операции!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END

	
	IF(ISNULL(@levels,'null')='') SET @levels = ','
	PRINT '@levels: ' + ISNULL(@levels,'')
	SET @sql = ''
	
	IF(@use_oper_db = 0)
	BEGIN
		SET @sql = @sql + '
			
			WITH Levels (id, name, valid_from) AS
			(
				 SELECT 
					id [id]
					,name [name]
					,valid_from [valid_from]
				 FROM dw.DIM_OBJ_LEVEL'
		IF (@levels IS NULL) SET  @sql = @sql + '
				 WHERE valid_to IS NULL'		
		SET  @sql = @sql + '
				 UNION ALL'			  
		IF(@is_department_levels = 0) SET @sql = @sql + '			    
				 SELECT '''', ''Общий доступ'',@valid_from'
		ELSE SET @sql = @sql + '
				 SELECT '''', ''Доступ запрещен'',@valid_from'
		SET @sql = @sql + ' 
				 UNION ALL 
				 SELECT ''-'', ''Доступ запрещен'',@valid_from'				   		   
		IF(@show_full_access_level = 1 AND (@nc32k_id IS NULL)) 
		SET @sql = @sql + '
			     UNION ALL 
				 SELECT ''*'', ''Полный доступ'',@valid_from'		
		SET @sql = @sql + '	
		    )
			
			SELECT  
				l.name AS [name]
				,le.description AS [description]
				,le.type AS [type]
				,ISNULL(le.rank,999) AS [rank]
				,l.id AS [id]
				,ISNULL(le.level_num,999) AS [num]
				,l.valid_from
			FROM Levels l'	
		
		IF(ISNULL(@nc32k_id,'')<>'') SET @sql = @sql + '
			JOIN [dw].[DIM_OBJ_LEVEL_READER] lr ON lr.[reader_type] = ''PNET3_NC32K''
											AND lr.reader_id = @nc32k_id
											AND lr.main_id = l.id
											AND lr.valid_to IS NULL'
		
		
		IF(ISNULL(@levels,'null')<>'null') SET @sql = @sql + '
			JOIN (SELECT StringValue FROM [app].[ufn_StringListToTable](@levels,'','')) l2 
					ON l2.StringValue = l.id
					AND (l.valid_from = (SELECT MAX(valid_from)	
										 FROM Levels
										 WHERE id = l2.StringValue 
											AND valid_from <= @valid_from)
				  )'		
		
		SET @sql = @sql + '
			LEFT JOIN dw.LEVEL_EXTANDED le ON le.level_id = l.id 
			WHERE 1=1'
			--AND  l.name LIKE ''Уровень доступа %'''
		
		IF(ISNULL(@name,'') <> '')
			SET @sql = @sql + ' 
				AND (l.name LIKE ''%' + @name + '%'' OR  le.description LIKE ''%' + @name + '%'')'
		
		PRINT @sql	
		DECLARE @ParamsDefinition nvarchar(4000) = N'@nc32k_id varchar(60), @levels varchar(max), @valid_from datetime, @name varchar(255)'
			EXEC sp_executesql @sql, @ParamsDefinition, @nc32k_id=@nc32k_id, @levels=@levels, @valid_from=@valid_from, @name=@name
	END
	ELSE
	BEGIN		
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_GetLevels'
									
		EXEC @C_SP_CMD  @nc32k_id=@nc32k_id, @show_full_access_level=@show_full_access_level, 
						@levels=@levels,@is_department_levels=@is_department_levels, @name=@name
	END	
		
END
GO

--exec app.usp_GetLevels 


--управление уровнем доступа
IF OBJECT_ID('app.usp_ManageLevel', 'P') IS NOT NULL 
	DROP PROC app.usp_ManageLevel
GO
CREATE PROC app.usp_ManageLevel	 
	@use_oper_db AS bit = 0
	,@action AS nvarchar(255)
	,@level_id AS varchar(60)
	,@level_num AS int
	,@description AS varchar(8000) = NULL
	,@type AS varchar(255) = NULL
	,@rank AS float = NULL
	
WITH EXECUTE AS OWNER
AS
BEGIN	
	DECLARE @ErrorMessage NVARCHAR(4000)  
	DECLARE @ErrorSeverity INT  
	DECLARE @ErrorState INT
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit
	DECLARE @extension AS varchar(8000)	
	SET @extension = 'procedure=ManageLevel' +  
					  ',use_oper_db=' + CAST(@use_oper_db AS varchar(1)) +
					  ',action=' +  @action +  
					  ',level_id=' + @level_id +
					  ',level_num=' + CAST(@level_num AS VARCHAR(3)) +
					  ',description=' + ISNULL(@description,'') +
					  ',type=' + ISNULL(@type,'') +
					  ',rank=' + CAST(ISNULL(@rank,'') AS varchar(10))
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
			
		IF ((app.ufn_CheckUserPermission('ManageLevel')=0)
			OR (app.ufn_CheckUserForSecurityAdmin()=0))
		BEGIN
			EXEC app.usp_LogAuditEvent
				@group = 'others'
				,@action = 'permission_fauled'				
				,@extension = @extension
			
			
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
		RETURN
	END
	REVERT
	
	IF(@action NOT IN ('Add','Remove','Modify'))   
		BEGIN
			SET @msg_str = 'Неверные параметры для операции!'
			RAISERROR (@msg_str,11,-1)
			RETURN
		END
	
	IF(@action = 'Modify')
	BEGIN
		EXECUTE AS CALLER
			EXEC app.usp_LogAuditEvent
				@group = 'objects_managment'
				,@action = 'modify_level'				
				,@extension = @extension
		REVERT

		IF(@use_oper_db = 0)
		BEGIN	
			IF NOT EXISTS 
				(SELECT 1 
				 FROM [dw].[LEVEL_EXTANDED]
				 WHERE level_id = @level_id)
			BEGIN
				INSERT INTO [dw].[LEVEL_EXTANDED] 
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
				UPDATE [dw].[LEVEL_EXTANDED]
				SET 
					[level_num] = @level_num,
					[description] = @description,
					[type] = @type,
					[rank] = @rank
				WHERE [level_id] = @level_id
			END 
		END
	END
	
	IF(@use_oper_db = 1)
	BEGIN		
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_ManageLevel'
									
		EXEC @C_SP_CMD  @action=@action
						,@level_id=@level_id
						,@level_num=@level_num
						,@description=@description
						,@type=@type
						,@rank=@rank
	END
END
GO


--выбрать владельцев карт
IF OBJECT_ID('app.usp_GetPersonPhoto', 'P') IS NOT NULL 
	DROP PROC app.usp_GetPersonPhoto
GO

CREATE PROC app.usp_GetPersonPhoto 
	@person_key AS int
WITH EXECUTE AS OWNER
AS	
BEGIN
	DECLARE @is_permitted AS bit = 1
	DECLARE @msg_str AS nvarchar(255)
	--DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit
	
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
	EXECUTE AS CALLER
		
		--IF(app.ufn_CheckUserPermission('SeePersons') <> 1) SET @is_permitted=0
			
		IF(@is_permitted=0)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = 'procedure=GetPersonPhoto'
			REVERT

			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
	REVERT
	
	--IF(@person_key BETWEEN 0 AND 100000)
	--BEGIN
	--		SET @msg_str = 'Ошибка'
	--		RAISERROR (@msg_str,14,-1)
	--		RETURN
	--END


	SELECT photo
	FROM [dw].[photo]
	WHERE photo_key = (SELECT photo_key FROM [dw].[DIM_OBJ_PERSON]
						WHERE person_key = @person_key)
END
GO


--получить точки доступа
IF OBJECT_ID('app.usp_GetAccessPoints', 'P') IS NOT NULL 
	DROP PROC app.usp_GetAccessPoints
GO
CREATE PROC app.usp_GetAccessPoints	 
	@valid_date datetime
	,@use_oper_db AS bit = 0
	,@only_worked AS BIT = 0
	,@level_id AS varchar(60) = NULL
	,@person_id AS varchar(60) = NULL
	,@show_full_access_level AS bit = 0
	,@name AS varchar(255) = NULL		
WITH EXECUTE AS OWNER
AS	
BEGIN	
	--PRINT '----REGION1----'
	--PRINT '@persons: ' + @persons
	--PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
	--PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
	DECLARE @is_permitted AS bit = 1
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000) = ''
	DECLARE @result AS bit

		
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN

		IF((app.ufn_CheckUserPermission('SeeFullLevels') = 0)
			AND @show_full_access_level = 1) 
			SET @is_permitted=0
		
		
		IF ((app.ufn_CheckUserPermission('SeeLevels')=0)
				AND ISNULL(@person_id,'')<>'')
			SET @is_permitted=0


		IF(@is_permitted=0)
		BEGIN
			EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = @extension			
			
			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END		
	REVERT
	
	--IF(@use_oper_db=0 OR @only_exists = 0)
	IF(@use_oper_db=0)
	BEGIN	
		
		IF(ISNULL(@person_id,'') <> '') SET @sql = @sql + '
		DECLARE @person_level_id AS varchar(max)
		DECLARE @person_parent_id AS varchar(40)
		SELECT 
			@person_level_id=level_id			 
		FROM [dw].[DIM_OBJ_PERSON] 
		WHERE id = @person_id
			AND valid_from = (SELECT max(valid_from) FROM [dw].[DIM_OBJ_PERSON] WHERE id = @person_id AND valid_from <= @valid_date)

		IF @person_level_id = '''' SET @person_level_id = '',''

		DECLARE @person_levels_tbl table
					([level_id] nvarchar(40))

		INSERT INTO @person_levels_tbl 
					SELECT StringValue 
					FROM [app].[ufn_StringListToTable](@person_level_id,'','')

		IF EXISTS (SELECT 1 FROM @person_levels_tbl WHERE level_id = '''')
		BEGIN
			DECLARE @dept_level_id AS varchar(max)
	
			SELECT @dept_level_id=level_id 
			FROM [dw].[DIM_OBJ_DEPARTMENT] 
			WHERE id = @person_parent_id
				AND valid_from = (SELECT max(valid_from) FROM [dw].[DIM_OBJ_DEPARTMENT] WHERE id = @person_parent_id AND valid_from <= @valid_date)
	
			INSERT INTO @person_levels_tbl
				SELECT StringValue 
					FROM [app].[ufn_StringListToTable](@dept_level_id,'','')
		END'
		
		SET @sql = @sql + '		
		
		SELECT nc32k.[nc32k_key]
		  ,nc32k.[guid]
		  ,nc32k.[id]
		  ,nc32k.[name]
		  FROM [IntellectDW].[dw].[DIM_OBJ_PNET3_NC32K] nc32k
		  WHERE nc32k.[nc32k_key] IN (SELECT MAX(nc32k_key) 
									  FROM [IntellectDW].[dw].[DIM_OBJ_PNET3_NC32K] 
									  WHERE valid_from < @valid_date
									  GROUP BY id)'
	
		IF(@only_worked = 1)
			SET @sql = @sql + ' 
		AND ISNULL(nc32k.[flags],0) <> 1'

		IF(@level_id IS NOT NULL)
			SET @sql = @sql + ' 
		AND nc32k.[id] IN (SELECT reader_id FROM [IntellectDW].[dw].[DIM_OBJ_LEVEL_READER]
											   WHERE reader_type=''PNET3_NC32K''
											   AND main_id=@level_id
											   AND valid_to IS NULL)'
		IF(ISNULL(@person_id,'') <> '')
		BEGIN
			SET @sql = @sql + ' 
			AND nc32k.[id] IN 
			(
				SELECT DISTINCT lr.reader_id 
				FROM
					(
						SELECT reader_id, main_id, time_zone 
						FROM [dw].[DIM_OBJ_LEVEL_READER]
						WHERE level_reader_key IN (SELECT MAX(level_reader_key) 
												  FROM [dw].[DIM_OBJ_LEVEL_READER] 
												  WHERE valid_from < @valid_date
												  GROUP BY main_id, reader_id, time_zone)'
					
			IF(@show_full_access_level = 1) 
				SET @sql = @sql + '					
						UNION ALL
						SELECT id, ''*'',''*''
						FROM [dw].[DIM_OBJ_PNET3_NC32K]
						WHERE nc32k_key IN (SELECT MAX(nc32k_key) 
										  FROM [IntellectDW].[dw].[DIM_OBJ_PNET3_NC32K] 
										  WHERE valid_from < @valid_date
										  GROUP BY id)'
			SET @sql = @sql + '
					) lr			 
				JOIN 
					(SELECT DISTINCT level_id 
					 FROM @person_levels_tbl) l on l.level_id = lr.main_id
			
				WHERE lr.time_zone = ''*''
			)'
		END
	    IF(ISNULL(@name,'') <> '')
	       SET @sql = @sql + ' 
		   AND nc32k.[name] LIKE ''%' + @name + '%'' '
		
		PRINT @sql	
		DECLARE @ParamsDefinition nvarchar(4000) = N'@level_id varchar(60), @person_id varchar(60), @valid_date datetime, @name varchar(255)'
			EXEC sp_executesql @sql, @ParamsDefinition, @level_id=@level_id, @person_id=@person_id, @valid_date=@valid_date, @name=@name
	END
	ELSE
	BEGIN		
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_GetAccessPoints'
			--PRINT '----REGION2----'
			--PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
			--PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
						
			EXEC @C_SP_CMD @only_worked=@only_worked, @level_id=@level_id, @person_id=@person_id, @name=@name
	END	
END
GO


--получить типы событий
IF OBJECT_ID('app.usp_GetEvents', 'P') IS NOT NULL 
	DROP PROC app.usp_GetEvents
GO
CREATE PROC app.usp_GetEvents	 
	@objtype AS varchar(60)
WITH EXECUTE AS OWNER
AS	
BEGIN	
	--PRINT '----REGION1----'
	--PRINT '@persons: ' + @persons
	--PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
	--PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
	
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit

		
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT
	
		
	SET @sql = 
		
	N'
	SELECT 
		[objtype]
	,[action]
	,[description]
	FROM [IntellectDW].[dw].[DIM_EVENT]
	WHERE objtype=@objtype
	AND LEN(ISNULL(description,'''')) > 3'
	
		
	PRINT @sql	
	DECLARE @ParamsDefinition nvarchar(4000) = N'@objtype varchar(60)'
		EXEC sp_executesql @sql, @ParamsDefinition, @objtype=@objtype --@date_start=@date_start, @date_end=@date_end, @date_start_for_opk=@date_start_for_opk, @persons=@persons
	
END
GO


--получить отделы
IF OBJECT_ID('app.usp_GetDepartments', 'P') IS NOT NULL 
	DROP PROC app.usp_GetDepartments
GO
CREATE PROC app.usp_GetDepartments	 
	@use_oper_db AS bit = 0
	,@only_exists AS bit = 1
	,@only_worked AS BIT = 0
WITH EXECUTE AS OWNER
AS	
BEGIN	
	
	
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit
	DECLARE @is_permitted AS bit=1
		
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT

	EXECUTE AS CALLER
		
		--IF(app.ufn_CheckUserPermission('SeePersons') <> 1) SET @is_permitted=0
			
		IF(@is_permitted=0)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = 'procedure=GetDepartmens'
			REVERT

			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
	REVERT
	
		
	IF((@use_oper_db=0) OR (@only_exists = 0))
	BEGIN	
		SET @sql = 
		
		N'
		  SELECT dept.[dept_key]
		  ,dept.[guid]
		  ,dept.[id]
		  ,dept.[name]
		  FROM [IntellectDW].[dw].[DIM_OBJ_DEPARTMENT] dept
		  WHERE dept.name <> ''#Операторы Интеллект''
			--AND dept.name <> ''Временные пропуска'''
	
	IF(@only_exists = 1)
		SET @sql = @sql + ' 
		AND dept.valid_to IS NULL'
	
	IF(@only_worked = 1)
		SET @sql = @sql + ' 
		AND ISNULL(dept.[flags],0) <> 1'
		
		PRINT @sql	
		--DECLARE @ParamsDefinition nvarchar(4000) = N'@date_start datetime, @date_end datetime, @date_start_for_opk datetime, @persons varchar(max)'
			EXEC sp_executesql @sql --, @ParamsDefinition, @date_start=@date_start, @date_end=@date_end, @date_start_for_opk=@date_start_for_opk, @persons=@persons
	END
	ELSE
	BEGIN		
		DECLARE @RemoteServer AS SYSNAME = 'DOM2SERVERSKUD'
		DECLARE @RemoteDatabase AS SYSNAME = 'intellect'
		DECLARE @C_SP_CMD nvarchar(50) =  QUOTENAME(@RemoteServer) + N'.'+@RemoteDatabase +N'.opk.usp_GetDepartments'
			--PRINT '----REGION2----'
			--PRINT '@date_start: ' + CAST(@date_start AS NVARCHAR(20))
			--PRINT '@date_end: ' + CAST(@date_end AS NVARCHAR(20))
						
			EXEC @C_SP_CMD @only_worked=@only_worked 
	END	
	
END
GO


--получить настройки программы
IF OBJECT_ID('app.usp_GetSettings', 'P') IS NOT NULL 
	DROP PROC app.usp_GetSettings
GO
CREATE PROC app.usp_GetSettings	 
	@host_name AS varchar(255)
WITH EXECUTE AS OWNER
AS	
BEGIN	
	DECLARE @msg_str AS nvarchar(255)
	DECLARE @extension AS varchar(8000)
	DECLARE @sql AS nvarchar(4000)
	DECLARE @result AS bit
	DECLARE @is_permitted AS bit=1
		
	EXECUTE AS CALLER
		DECLARE @procName AS sysname = OBJECT_NAME(@@PROCID)
		EXEC @result = app.usp_CheckUser @procedure = @procName
			IF(@result <> 0) RETURN
	REVERT

	EXECUTE AS CALLER
		
		--IF(app.ufn_CheckUserPermission('SeePersons') <> 1) SET @is_permitted=0
			
		IF(@is_permitted=0)
		BEGIN
			EXECUTE AS CALLER
				EXEC app.usp_LogAuditEvent
					@group = 'others'
					,@action = 'permission_fauled'				
					,@extension = 'procedure=GetSettings'
			REVERT

			SET @msg_str = 'Отсутствует разрешение на выполнение операции'
			RAISERROR (@msg_str,14,-1)
			RETURN
		END
	
	REVERT
	
		
	BEGIN	
		SET @sql = 
		
		N'
		  SELECT
		    [host_name], 
			[is_iidk_enable],
			[iidk_managed_slave],
			[iidk_map],
			[iidk_monitor]
		  FROM [IntellectDW].[app].[SETTINGS]
		  WHERE [host_name] = @host_name'	
	
		PRINT @sql	
		DECLARE @ParamsDefinition nvarchar(4000) = N'@host_name varchar(255)'
			EXEC sp_executesql @sql, @ParamsDefinition, @host_name=@host_name
	END
END
GO



--/*
--проверить соединение с оперативной базой
IF OBJECT_ID('app.usp_CheckOperDbConnection', 'P') IS NOT NULL 
	DROP PROC app.usp_CheckOperDbConnection
GO

CREATE PROC app.usp_CheckOperDbConnection
WITH EXECUTE AS OWNER
AS	
BEGIN	
	EXEC DOM2SERVERSKUD.master.dbo.sp_executesql N'SELECT 1'
	--DECLARE @TSQL nvarchar(100)
    --SELECT  @TSQL = 'SELECT * FROM OPENQUERY(DOM2SERVERSKUD,''SELECT 1'')'
    --EXEC (@TSQL)
END
GO
--exec app.usp_CheckOperDbConnection