USE [master]
GO
/****** Object:  Database [IntellectSTG]    Script Date: 11/28/2018 18:02:46 ******/
CREATE DATABASE [IntellectSTG] ON  PRIMARY 
( NAME = N'IntellectSTG', FILENAME = N'C:\IntellectDW\STG\IntellectSTG.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [DEFAULT_FG]  DEFAULT 
( NAME = N'default', FILENAME = N'C:\IntellectDW\STG\default.ndf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [MAIN_DATA] 
( NAME = N'main', FILENAME = N'C:\IntellectDW\STG\main_data.ndf' , SIZE = 1277888KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [MAIN_INDEX] 
( NAME = N'main_index', FILENAME = N'C:\IntellectDW\STG\main_index.ndf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'IntellectSTG_log', FILENAME = N'C:\IntellectDW\STG\IntellectSTG_log.LDF' , SIZE = 1475328KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [IntellectSTG] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IntellectSTG].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IntellectSTG] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [IntellectSTG] SET ANSI_NULLS OFF
GO
ALTER DATABASE [IntellectSTG] SET ANSI_PADDING OFF
GO
ALTER DATABASE [IntellectSTG] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [IntellectSTG] SET ARITHABORT OFF
GO
ALTER DATABASE [IntellectSTG] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [IntellectSTG] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [IntellectSTG] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [IntellectSTG] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [IntellectSTG] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [IntellectSTG] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [IntellectSTG] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [IntellectSTG] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [IntellectSTG] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [IntellectSTG] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [IntellectSTG] SET  ENABLE_BROKER
GO
ALTER DATABASE [IntellectSTG] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [IntellectSTG] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [IntellectSTG] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [IntellectSTG] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [IntellectSTG] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [IntellectSTG] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [IntellectSTG] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [IntellectSTG] SET  READ_WRITE
GO
ALTER DATABASE [IntellectSTG] SET RECOVERY FULL
GO
ALTER DATABASE [IntellectSTG] SET  MULTI_USER
GO
ALTER DATABASE [IntellectSTG] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [IntellectSTG] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'IntellectSTG', N'ON'
GO
USE [IntellectSTG]
GO
/****** Object:  User [intellectDW]    Script Date: 11/28/2018 18:02:46 ******/
CREATE USER [intellectDW] FOR LOGIN [intellectDW] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [DOM2VIDEOSRV7\Администратор]    Script Date: 11/28/2018 18:02:46 ******/
CREATE USER [DOM2VIDEOSRV7\Администратор] FOR LOGIN [DOM2VIDEOSRV7\Администратор] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [stg]    Script Date: 11/28/2018 18:02:46 ******/
CREATE SCHEMA [stg] AUTHORIZATION [dbo]
GO
/****** Object:  Table [stg].[PROTOCOL]    Script Date: 11/28/2018 18:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[PROTOCOL](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[objtype] [varchar](50) NULL,
	[objid] [varchar](50) NULL,
	[action] [varchar](50) NULL,
	[param0] [varchar](255) NULL,
	[param1] [varchar](60) NULL,
	[param2] [varchar](255) NULL,
	[param3] [varchar](255) NULL,
	[param4] [varchar](400) NULL,
	[date] [datetime] NULL,
	[server_date] [datetime] NOT NULL,
	[owner] [varchar](50) NULL,
	[pk] [uniqueidentifier] NOT NULL,
	[person_id] [varchar](50) NULL,
	[person_name] [varchar](255) NULL,
	[person_surname] [varchar](255) NULL,
	[person_patronymic] [varchar](255) NULL,
	[person_parent_id] [varchar](40) NULL,
	[person_dept_name] [varchar](255) NULL,
	[user_id] [varchar](50) NULL,
	[user_name] [varchar](255) NULL,
	[user_surname] [varchar](255) NULL,
	[user_patronymic] [varchar](255) NULL,
	[user_parent_id] [varchar](40) NULL,
 CONSTRAINT [PK__OBJ__STG_PROTOCOL] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [MAIN_DATA]
) ON [MAIN_DATA]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__PROTOCOL__server__date]    Script Date: 11/28/2018 18:02:46 ******/
ALTER TABLE [stg].[PROTOCOL] ADD  CONSTRAINT [DF__PROTOCOL__server__date]  DEFAULT (getdate()) FOR [server_date]
GO


/****** Object:  Table [stg].[OBJ_SLAVE]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_SLAVE](
	[arch_days] [int] NULL,
	[connection] [nvarchar](30) NULL,
	[disable_protocol] [int] NULL,
	[display_id] [nvarchar](40) NULL,
	[drives] [ntext] NULL,
	[drives_a] [nvarchar](80) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[is_backup] [int] NULL,
	[is_load] [int] NULL,
	[local_protocol] [int] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[password] [nvarchar](30) NULL,
	[sync_time] [int] NULL,
	[user_id] [nvarchar](40) NULL,
	[username] [nvarchar](30) NULL,
	[is64bit] [int] NULL,
	[speaker_id] [nvarchar](50) NULL,
	[client] [int] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_SLAVE__id__u_nc] ON [stg].[OBJ_SLAVE] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_RIGHTS_PERSON]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_RIGHTS_PERSON](
	[change_first] [int] NULL,
	[change_last] [nvarchar](60) NULL,
	[change_months] [int] NULL,
	[change_user] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[login] [ntext] NULL,
	[main_id] [nvarchar](60) NULL,
	[md5] [ntext] NULL,
	[passwd] [nvarchar](60) NULL,
	[person] [nvarchar](60) NULL,
	[supervisor] [nvarchar](60) NULL,
	[windows] [nvarchar](255) NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_RIGHTS_PERSON__main_id__person__u_nc] ON [stg].[OBJ_RIGHTS_PERSON] 
(
	[main_id] ASC,
	[person] ASC
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_RIGHTS_OBJECT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_RIGHTS_OBJECT](
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](400) NULL,
	[level] [int] NULL,
	[main_id] [nvarchar](40) NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_RIGHTS_OBJECT__main_id__id__u_nc] ON [stg].[OBJ_RIGHTS_OBJECT] 
(
	[main_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_RIGHTS]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_RIGHTS](
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
	[id] [nvarchar](40) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[allow_export_files] [nvarchar](2) NULL,
	[allow_protect_files] [int] NULL,
	[allow_unprotect_files] [int] NULL,
	[exit_if_inactivity] [int] NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_RIGHTS__id__u_nc] ON [stg].[OBJ_RIGHTS] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PNET3_NC32K]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PNET3_NC32K](
	[alarm_time] [int] NULL,
	[channel_com] [nvarchar](60) NULL,
	[channel_com_type] [nvarchar](60) NULL,
	[channel_ip] [nvarchar](60) NULL,
	[com_addr] [int] NULL,
	[door_time] [int] NULL,
	[ex1_opt] [int] NULL,
	[ex2_opt] [int] NULL,
	[exit_time] [int] NULL,
	[external_ip] [nvarchar](15) NULL,
	[global_apb] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hardware_opt] [int] NULL,
	[id] [nvarchar](60) NULL,
	[interface] [int] NULL,
	[lock_time] [int] NULL,
	[mode_opt] [int] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](60) NULL,
	[region_id] [nvarchar](60) NULL,
	[region_in] [nvarchar](60) NULL,
	[region_out] [nvarchar](60) NULL,
	[relay_delay_time] [int] NULL,
	[relay_opt] [int] NULL,
	[relay_time] [int] NULL,
	[flags] [int] NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PNET3_NC32K__id__u_nc] ON [stg].[OBJ_PNET3_NC32K] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PNET3_IP_GATE]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PNET3_IP_GATE](
	[channel_ip] [nvarchar](60) NULL,
	[external_ip] [nvarchar](15) NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](60) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](60) NULL,
	[region_id] [nvarchar](60) NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PNET3_IP_GATE__id__u_nc] ON [stg].[OBJ_PNET3_IP_GATE] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PNET3_AC_PART]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PNET3_AC_PART](
	[active] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](60) NULL,
	[name] [nvarchar](60) NULL,
	[number] [int] NULL,
	[parent_id] [nvarchar](60) NULL,
	[parsec_name] [nvarchar](14) NULL,
	[region_id] [nvarchar](60) NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PNET3_AC_PART__id__u_nc] ON [stg].[OBJ_PNET3_AC_PART] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PNET3_AC]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PNET3_AC](
	[channel_com] [nvarchar](60) NULL,
	[channel_com_type] [nvarchar](60) NULL,
	[com_addr] [int] NULL,
	[ex1_opt] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](60) NULL,
	[keypad_addr] [int] NULL,
	[light_time] [int] NULL,
	[name] [nvarchar](60) NULL,
	[off_time] [int] NULL,
	[parent_id] [nvarchar](60) NULL,
	[parsec_name] [nvarchar](14) NULL,
	[region_id] [nvarchar](60) NULL,
	[flags] [int] NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PNET3_AC__id__u_nc] ON [stg].[OBJ_PNET3_AC] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PHOTO_IDENT_BUTTONS]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PHOTO_IDENT_BUTTONS](
	[button_name] [nvarchar](255) NULL,
	[color] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[line_id] [int] NULL,
	[main_id] [nvarchar](40) NULL,
	[obj_id] [nvarchar](40) NULL,
	[obj_react] [nvarchar](255) NULL,
	[obj_type] [nvarchar](255) NULL,
	[text] [nvarchar](255) NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PHOTO_IDENT_BUTTONS__main_id__line_id__button_name__u_nc] ON [stg].[OBJ_PHOTO_IDENT_BUTTONS] 
(
	[main_id] ASC,
	[line_id] ASC,
	[button_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PHOTO_IDENT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PHOTO_IDENT](
	[archive_max] [int] NULL,
	[fixed_layout] [int] NULL,
	[flags] [int] NULL,
	[focus_on_event] [int] NULL,
	[grid_columns] [ntext] NULL,
	[guid] [uniqueidentifier] NULL,
	[h] [int] NULL,
	[id] [nvarchar](40) NULL,
	[lines_count] [int] NULL,
	[name] [nvarchar](60) NULL,
	[num_last_event] [int] NULL,
	[parent_id] [nvarchar](40) NULL,
	[protocol_event] [int] NULL,
	[remove_events] [int] NULL,
	[show_on_event] [int] NULL,
	[show_time] [int] NULL,
	[w] [int] NULL,
	[x] [int] NULL,
	[y] [int] NULL,
	[monitor] [int] NULL,
	[event_expire] [int] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PHOTO_IDENT__id__u_nc] ON [stg].[OBJ_PHOTO_IDENT] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_PERSON]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_PERSON](
	[all_param] [nvarchar](32) NULL,
	[area_id] [nvarchar](40) NULL,
	[auto_brand] [nvarchar](32) NULL,
	[auto_number] [nvarchar](100) NULL,
	[auto_pass_type] [int] NULL,
	[begin] [nvarchar](25) NULL,
	[begin_temp_level] [nvarchar](25) NULL,
	[card] [nvarchar](255) NULL,
	[card_date] [nvarchar](25) NULL,
	[card_loss] [int] NULL,
	[card_type] [int] NULL,
	[comment] [ntext] NULL,
	[department] [nvarchar](255) NULL,
	[drivers_licence] [nvarchar](120) NULL,
	[email] [nvarchar](60) NULL,
	[end_temp_level] [nvarchar](25) NULL,
	[expired] [nvarchar](25) NULL,
	[external_id] [nvarchar](40) NULL,
	[facility_code] [nvarchar](255) NULL,
	[finished_at] [datetime] NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[is_active_temp_level] [smallint] NULL,
	[is_apb] [smallint] NULL,
	[is_locked] [smallint] NULL,
	[level2_id] [nvarchar](40) NULL,
	[level_id] [ntext] NULL,
	[levels_times] [ntext] NULL,
	[location] [nvarchar](16) NULL,
	[marketing_info] [ntext] NULL,
	[name] [nvarchar](255) NULL,
	[parent_id] [nvarchar](40) NULL,
	[passport] [nvarchar](120) NULL,
	[patronymic] [nvarchar](255) NULL,
	[person] [nvarchar](50) NULL,
	[phone] [nvarchar](60) NULL,
	[pin] [nvarchar](255) NULL,
	[post] [nvarchar](255) NULL,
	[pur] [int] NULL,
	[rubeg8_zone_id] [nvarchar](40) NULL,
	[schedule_id] [nvarchar](40) NULL,
	[started_at] [datetime] NULL,
	[surname] [nvarchar](255) NULL,
	[tabnum] [nvarchar](60) NULL,
	[teleph_work] [nvarchar](16) NULL,
	[temp_card] [nvarchar](15) NULL,
	[temp_level_id] [ntext] NULL,
	[temp_levels_times] [ntext] NULL,
	[visit_birthplace] [nvarchar](120) NULL,
	[visit_document] [nvarchar](120) NULL,
	[visit_purpose] [nvarchar](120) NULL,
	[visit_reg] [nvarchar](120) NULL,
	[when_area_id_changed] [datetime] NULL,
	[whence] [nvarchar](60) NULL,
	[who_card] [nvarchar](60) NULL,
	[who_level] [nvarchar](60) NULL,
	[owner_person_id] [nvarchar](40) NULL,
	[pnet3_alarm] [bit] NULL,
	[pnet3_block] [bit] NULL,
	[pnet3_guard] [bit] NULL,
	[pnet3_guest] [bit] NULL,
	[pnet3_2cards_mask] [smallint] NULL,
	[pnet3_acs_counter] [smallint] NULL,
	[pnet3_black] [bit] NULL,
	[pnet3_counter] [bit] NULL,
	[pnet3_master] [bit] NULL,
	[pnet3_no_entry] [bit] NULL,
	[pnet3_no_exit] [bit] NULL,
	[pnet3_sound] [bit] NULL,
	[pnet3_temp] [bit] NULL,
	[pnet3_exit_block] [bit] NULL,
	[pnet3_exit_prof] [bit] NULL,
	[pnet3_priv] [bit] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_PERSON__id__u_nc] ON [stg].[OBJ_PERSON] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_LEVEL_READER]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_LEVEL_READER](
	[arm] [nvarchar](1) NULL,
	[disarm] [nvarchar](1) NULL,
	[guid] [uniqueidentifier] NULL,
	[main_id] [nvarchar](40) NULL,
	[not_download_cards] [smallint] NULL,
	[parent_id] [nvarchar](40) NULL,
	[reader_id] [nvarchar](40) NULL,
	[reader_type] [nvarchar](32) NULL,
	[time_zone] [nvarchar](40) NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_LEVEL_READER__main_id__reader_id__time_zone__u_nc] ON [stg].[OBJ_LEVEL_READER] 
(
	[main_id] ASC,
	[reader_id] ASC,
	[time_zone] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_LEVEL]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_LEVEL](
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[name] [nvarchar](120) NULL,
	[parent_id] [nvarchar](40) NULL,
	[am_folder_guid] [uniqueidentifier] NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_LEVEL__id__u_nc] ON [stg].[OBJ_LEVEL] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_GRABBER]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_GRABBER](
	[auth] [nvarchar](30) NULL,
	[brand] [ntext] NULL,
	[chan] [int] NULL,
	[codec] [nvarchar](60) NULL,
	[flags] [int] NULL,
	[format] [nvarchar](8) NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[ip] [ntext] NULL,
	[ip_port] [nvarchar](16) NULL,
	[mode] [nvarchar](3) NULL,
	[model] [ntext] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[password] [nvarchar](60) NULL,
	[resolution] [nvarchar](8) NULL,
	[type] [nvarchar](100) NULL,
	[useconfigurebyweb] [int] NULL,
	[username] [nvarchar](60) NULL,
	[watchdog] [int] NULL,
	[firmware] [ntext] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_GRABBER__id__u_nc] ON [stg].[OBJ_GRABBER] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_DEPARTMENT]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_DEPARTMENT](
	[external_id] [nvarchar](255) NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[level2_id] [nvarchar](40) NULL,
	[level_id] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[owner_id] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[region_id] [nvarchar](40) NULL,
	[schedule_id] [nvarchar](40) NULL,
	[type] [smallint] NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_DEPARTMENT__id__u_nc] ON [stg].[OBJ_DEPARTMENT] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO
/****** Object:  Table [stg].[OBJ_CAM]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[OBJ_CAM](
	[activity] [smallint] NULL,
	[additional_info] [nvarchar](100) NULL,
	[alarm_rec] [smallint] NULL,
	[arch_days] [int] NULL,
	[audio_id] [nvarchar](40) NULL,
	[audio_type] [nvarchar](16) NULL,
	[blinding] [int] NULL,
	[bosch_ptz_protocol] [ntext] NULL,
	[bright] [smallint] NULL,
	[color] [smallint] NULL,
	[compression] [smallint] NULL,
	[compressor] [nvarchar](40) NULL,
	[config_id] [nvarchar](40) NULL,
	[contrast] [smallint] NULL,
	[decoder] [int] NULL,
	[decompressor] [nvarchar](40) NULL,
	[flags] [int] NULL,
	[fps] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hot_rec_period] [int] NULL,
	[hot_rec_time] [int] NULL,
	[id] [nvarchar](40) NULL,
	[ifreg] [smallint] NULL,
	[manual] [smallint] NULL,
	[mask0] [nvarchar](250) NULL,
	[mask1] [nvarchar](250) NULL,
	[mask2] [nvarchar](250) NULL,
	[mask3] [nvarchar](250) NULL,
	[mask4] [nvarchar](200) NULL,
	[md_contrast] [smallint] NULL,
	[md_mode] [smallint] NULL,
	[md_size] [smallint] NULL,
	[motion] [smallint] NULL,
	[multistreaming_mode] [smallint] NULL,
	[mux] [int] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[password_crc] [int] NULL,
	[pre_rec_time] [int] NULL,
	[priority] [int] NULL,
	[proc_time] [int] NULL,
	[rec_priority] [int] NULL,
	[region_id] [nvarchar](40) NULL,
	[resolution] [int] NULL,
	[rotate] [smallint] NULL,
	[rotateAngle] [nvarchar](40) NULL,
	[sat_u] [smallint] NULL,
	[source_folder] [ntext] NULL,
	[stream_analitic] [nvarchar](40) NULL,
	[stream_archive] [nvarchar](40) NULL,
	[stream_client] [nvarchar](40) NULL,
	[telemetry_id] [nvarchar](40) NULL,
	[type] [int] NULL,
	[yuv] [smallint] NULL,
	[stream_alarm] [nvarchar](40) NULL,
	[arch_days_type] [int] NULL,
	[arch_hours_max] [int] NULL,
	[arch_hours_max_type] [int] NULL,
	[dewarp_lens] [int] NULL,
	[dewarp_position] [int] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_CAM__id__u_nc] ON [stg].[OBJ_CAM] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO


/****** Object:  Table [dbo].[OBJ_DISPLAY]    Script Date: 12/03/2018 12:27:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_DISPLAY](
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL
) ON [MAIN_DATA]

GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_DISPLAY__id__u_nc] ON [stg].[OBJ_DISPLAY] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO


/****** Object:  Table [dbo].[OBJ_MAP]    Script Date: 12/03/2018 12:27:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_MAP](
	[alarm_top] [smallint] NULL,
	[auto] [smallint] NULL,
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[h] [int] NULL,
	[id] [nvarchar](40) NULL,
	[interpolation_mode] [int] NULL,
	[monitor] [int] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[recurs] [smallint] NULL,
	[shortest] [int] NULL,
	[w] [int] NULL,
	[x] [int] NULL,
	[y] [int] NULL,
	[tracking_monitor_id] [ntext] NULL,
	[show_last_events] [int] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]

GO

CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_MAP__id__u_nc] ON [stg].[OBJ_MAP] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO



/****** Object:  Table [dbo].[OBJ_MAPLAYER]    Script Date: 12/03/2018 12:55:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_MAPLAYER](
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[layer_file] [ntext] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[version] [int] NULL,
	[xml] [ntext] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]

GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_MAPLAYER__id__u_nc] ON [stg].[OBJ_MAPLAYER] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO




/****** Object:  Table [stg].[OBJ_MACRO]    Script Date: 12/04/2018 15:32:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_MACRO](
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[hidden] [int] NULL,
	[id] [nvarchar](40) NULL,
	[local] [int] NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[state] [nvarchar](30) NULL,
	[delay] [int] NULL,
	[hotkey] [ntext] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]

GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_MACRO__id__u_nc] ON [stg].[OBJ_MACRO] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO


/****** Object:  Table [stg].[OBJ_SCRIPT]    ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_SCRIPT](
	[flags] [int] NULL,
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL,
	[script] [ntext] NULL,
	[time_zone] [nvarchar](16) NULL,
	[type] [int] NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [MAIN_DATA]

GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_SCRIPT__id__u_nc] ON [stg].[OBJ_MACRO] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO



/****** Object:  Table [stg].[photo_temp]    Script Date: 04/20/2018 12:36:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [stg].[photo_temp](
	[photo] [varbinary](max) NULL
) ON [MAIN_DATA] TEXTIMAGE_ON [DEFAULT_FG]
GO
SET ANSI_PADDING OFF
GO

USE [intellect]
GO

/****** Object:  Table [dbo].[OBJ_CAM_AUDIO]    Script Date: 11/24/2019 08:39:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_CAM_AUDIO](
	[main_id] [nvarchar](40) NULL,
	[mic_id] [nvarchar](40) NULL
) ON [MAIN_DATA]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_CAM_AUDIO__main_id__mic_id__u_nc] ON [stg].[OBJ_CAM_AUDIO] 
(
	[main_id] ASC,
	[mic_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]


/****** Object:  Table [dbo].[OBJ_LINK]    Script Date: 11/24/2019 08:55:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_LINK](
	[guid] [uniqueidentifier] NULL,
	[id] [nvarchar](40) NULL,
	[name] [nvarchar](60) NULL,
	[parent_id] [nvarchar](40) NULL
) ON [MAIN_DATA]

GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_LINK__id__u_nc] ON [stg].[OBJ_LINK] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]
GO

/****** Object:  Table [dbo].[OBJ_LINK_OBJECTS]    Script Date: 11/24/2019 08:59:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OBJ_LINK_OBJECTS](
	[guid] [uniqueidentifier] NULL,
	[main_id] [nvarchar](40) NULL,
	[objid] [nvarchar](40) NULL,
	[objtype] [nvarchar](60) NULL
) ON [MAIN_DATA]

GO
CREATE UNIQUE NONCLUSTERED INDEX [idx__STG__OBJ_LINK_OBJECTS__main_id__objtype__objid__u_nc] ON [stg].[OBJ_LINK_OBJECTS] 
(
	[main_id] ASC,
	[objtype] ASC,
	[objid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [MAIN_INDEX]