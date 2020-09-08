--Данный скрипт необходимо запустить на каждом сервере, где установлена база данных Intellect (ITV)

USE [intellect]
--USE [intellect_protocol]
GO

--CREATE SCHEMA export --схема данных для экспорта
--GO

IF OBJECT_ID('[export].[PROTOCOL_EXP]','U') IS NOT NULL
	DROP TABLE [export].[PROTOCOL_EXP]
GO
CREATE TABLE [export].[PROTOCOL_EXP](
	[num] [int] identity (1,1) primary key,
	[objtype] [varchar](50) NULL,
	[objid] [varchar](50) NULL,
	[action] [varchar](50) NULL,
	--[region_id] [varchar](50) NULL,
	[param0] [varchar](255) NULL,
	[param1] [varchar](60) NULL,
	[param2] [varchar](255) NULL,
	[param3] [varchar](255) NULL,
	[param4] [varchar](255) NULL,
	--[user_param_double] [float] NULL,
	[date] [datetime] NULL,
	[server_date] [datetime] NOT NULL DEFAULT(GETDATE()),
	--[time] [datetime] NULL,
	--[time2] [datetime] NULL,
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
	[user_parent_id] [varchar](40) NULL	
		
) ON [PRIMARY]
go

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Tr_Insert_PROTOCOL_EXP]'))
DROP TRIGGER [dbo].[Tr_Insert_PROTOCOL_EXP]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER Tr_Insert_PROTOCOL_EXP  
ON dbo.PROTOCOL 
AFTER INSERT   
AS  
BEGIN
	DECLARE
		  @objtype [varchar](50), 
		  @objid [varchar](50),
		  @action [varchar](50),
		  @region_id [varchar] (50),
		  @param0 [varchar](255),
		  @param1 [varchar](60),
		  @param2 [varchar](255), 
		  @param3 [varchar](255),
		  @param4 [varchar](400),
		  @date [datetime],
		  @time [datetime],
		  @time2 [datetime],
		  @owner [varchar](50),
		  @pk [uniqueidentifier],
		  @person_id [varchar](50),
		  @person_name [varchar](255),
          @person_surname [varchar](255),
          @person_patronymic [varchar](255),
          @person_parent_id [varchar](40),
          @person_dept_name [varchar](255),
          @user_id [varchar](50),
          @user_name [varchar](255),
		  @user_surname [varchar](255),
	      @user_patronymic [varchar](255),
	      @user_parent_id [varchar](40)
	      
    SELECT
		  @objtype = [objtype],
		  @objid = [objid],
		  @action = [action],
		  @region_id = [region_id],
		  @param0 = [param0],
		  @param1 = [param1],
		  @param2 = [param2],
		  @param3 = [param3],
		  @date = [date],
		  @time = [time],
		  @time2 = [time2],
		  @owner = [owner],
		  @pk = [pk] from inserted
	
	BEGIN TRY
	--RAISERROR ('Ошибка записи данных в таблицу [export].[PROTOCOL_EXP].', --тестовая процедура для проверки блока catch 
	--16, -- Severity.  
	--1 -- State.  
	--)
		DECLARE @host_name [varchar](50)= HOST_NAME()
		
		IF(@host_name = @owner)
		BEGIN
			IF((@objtype IN ('PNET3_NC32K','PNET3_AC','PNET3_IP_GATE') AND @action <> 'SYSTEM_MESSAGE')
							OR (@objtype = 'PNET3_AC_PART' AND @action IN ('EVENT88','EVENTB3','EVENTB4','EVENTBF'))
							OR (@objtype = 'PERSON' AND @action IN ('REGISTERED','UNREGISTERED'))
							OR (@objtype = 'PHOTO_IDENT' AND @action = 'PUSH_BUTTON')
							OR (@objtype = 'MACRO' AND @objid ='2' AND @action = 'RUN')
							--OR (@objtype = 'SLAVE' AND @action IN ('CONNECTED','DISCONNECTED'))				
						   )
			BEGIN
				IF (@objtype = 'PNET3_NC32K')
				BEGIN			
					IF (ISNULL(@param1,'') <> '') -- добавляем инфо о пользователе и отделе
					BEGIN
						select @person_id = [id]
							 , @person_name = LTRIM(RTRIM([name]))
							 , @person_surname = LTRIM(RTRIM([surname]))
							 , @person_patronymic = LTRIM(RTRIM([patronymic]))
							 , @person_parent_id = parent_id 
						from dbo.OBJ_PERSON 
						where [ID] = @param1
						
						select @person_dept_name = LTRIM(RTRIM([name])) 
						from dbo.OBJ_DEPARTMENT 
						where [id] = @person_parent_id
					END
					IF (ISNULL(@param2,'') <> '') -- добавляем инфо о APB
						SET @param0 = @param0 + ' ' + @param2
				END
				
				ELSE IF (@objtype = 'PHOTO_IDENT') 
				BEGIN
					--парсим param3. Выдираем id сотрудника и пользователя
					--если в строке 5 делиметров
					IF LEN (@param3) - LEN(REPLACE(@param3,';','')) = 5
					BEGIN
						SET @user_id = SUBSTRING(@param3
											,CHARINDEX(';',@param3
												,CHARINDEX(';',@param3) + 1) + 1
													,CHARINDEX(';',@param3
														,CHARINDEX(';',@param3
															,CHARINDEX(';',@param3) +1) + 1) - CHARINDEX(';',@param3
																									,CHARINDEX(';',@param3) + 1) -1)
						SELECT @user_name = LTRIM(RTRIM([name]))
							 , @user_surname = LTRIM(RTRIM([surname]))
							 , @user_patronymic = LTRIM(RTRIM([patronymic]))
							 , @user_parent_id = parent_id 
						from dbo.OBJ_PERSON 
					    where [ID] = @user_id
						
						SET  @person_id = SUBSTRING(@param3
											,CHARINDEX(';',@param3
												,CHARINDEX(';',@param3
													,CHARINDEX(';',@param3) + 1) + 1) + 1
														,CHARINDEX(';',@param3
															,CHARINDEX(';',@param3
																,CHARINDEX(';',@param3
																	,CHARINDEX(';',@param3) + 1) + 1) + 1) - CHARINDEX(';',@param3
																												, CHARINDEX(';',@param3
																													,CHARINDEX(';',@param3) + 1) + 1) - 1)
						SELECT @person_name = LTRIM(RTRIM([name]))
						     , @person_surname = LTRIM(RTRIM([surname]))
						     , @person_patronymic = LTRIM(RTRIM([patronymic]))
						     , @person_parent_id = parent_id 
						from dbo.OBJ_PERSON 
						where [ID] = @person_id
						SELECT @person_dept_name = LTRIM(RTRIM([name])) FROM dbo.OBJ_DEPARTMENT WHERE [id] = @person_parent_id
					END	
					--если в строке 4 делиметра
					ELSE IF LEN (@param3) - LEN(REPLACE(@param3,';','')) = 4
					BEGIN
						SET @user_id = SUBSTRING(@param3
											,CHARINDEX(';',@param3
												,CHARINDEX(';',@param3) + 1) + 1
													,CHARINDEX(';',@param3
														,CHARINDEX(';',@param3
															,CHARINDEX(';',@param3) +1) + 1) - CHARINDEX(';',@param3
																									,CHARINDEX(';',@param3) + 1) -1)
						SELECT @user_name = LTRIM(RTRIM([name]))
						     , @user_surname = LTRIM(RTRIM([surname]))
						     , @user_patronymic = LTRIM(RTRIM([patronymic]))
						     , @user_parent_id = parent_id 
						from dbo.OBJ_PERSON 
						where [ID] = @user_id
						
						SET  @person_id = SUBSTRING(@param3
											,CHARINDEX(';',@param3
												,CHARINDEX(';',@param3
													,CHARINDEX(';',@param3) + 1) + 1) + 1
														,CHARINDEX(';',@param3
															,CHARINDEX(';',@param3
																,CHARINDEX(';',@param3
																	,CHARINDEX(';',@param3) + 1) + 1) + 1) - CHARINDEX(';',@param3
																												, CHARINDEX(';',@param3
																													,CHARINDEX(';',@param3) + 1) + 1) - 1)
						SELECT @person_name = LTRIM(RTRIM([name]))
							 , @person_surname = LTRIM(RTRIM([surname]))
							 , @person_patronymic = LTRIM(RTRIM([patronymic]))
							 , @person_parent_id = parent_id 
					    from dbo.OBJ_PERSON 
					    where [ID] = @person_id
						SELECT @person_dept_name = LTRIM(RTRIM([name])) FROM dbo.OBJ_DEPARTMENT WHERE [id] = @person_parent_id
					END		
					--парсим param2 а потом записываем в param4 инфо, необходимую, для уникальной идентификации клавиши
					IF LEN (@param2) - LEN(REPLACE(@param2,';','')) = 2
						BEGIN					
							DECLARE @obj_type VARCHAR(50)
							DECLARE @obj_id VARCHAR(50) 
							DECLARE @obj_react VARCHAR(50)
							
							DECLARE @main_id VARCHAR(40)
							DECLARE @line_id INT
							DECLARE @button_name VARCHAR(255)
							
							SET @obj_type = LEFT(@param2, CHARINDEX(';',@param2) - 1)
							SET @obj_id = SUBSTRING(@param2,
											CHARINDEX(';',@param2) + 1,
												CHARINDEX(';',@param2, 
													CHARINDEX(';',@param2) + 1) - CHARINDEX(';',@param2) - 1)
							SET @obj_react = SUBSTRING(@param2,
												CHARINDEX(';',@param2, 
													CHARINDEX(';',@param2) + 1) + 1,LEN(@param2))
							
							SELECT TOP(1) @main_id = main_id, @line_id = line_id, @button_name = button_name
							FROM dbo.OBJ_PHOTO_IDENT_BUTTONS WHERE obj_type = @obj_type AND obj_id = @obj_id AND obj_react = @obj_react 
							
							IF (@main_id IS NOT NULL) 
								SET @param4 = @main_id + ';' + CAST(@line_id AS VARCHAR) + ';' + @button_name	+ ';' + @obj_type + ';' + @obj_id + ';' + @obj_react			
						END	
				END
				
				ELSE IF (@objtype = 'PERSON')
				BEGIN			
					SELECT @user_id = [id]
						 , @user_name = LTRIM(RTRIM([name]))
						 , @user_surname = LTRIM(RTRIM([surname]))
						 , @user_patronymic = LTRIM(RTRIM([patronymic]))
						 , @user_parent_id = parent_id 
					FROM dbo.OBJ_PERSON WHERE [ID] = @objid								
				END
				
				
				ELSE IF ((@objtype = 'MACRO') AND (@objid ='2') AND (@action = 'RUN'))
				BEGIN			
					IF((ISNULL(@param0,'') <> '') AND (ISNULL(@param1,'') <> ''))
					BEGIN
						IF(@param0 = 'OPERATOR')
						BEGIN
							SELECT @user_id = [id]
								 , @user_name = LTRIM(RTRIM([name]))
								 , @user_surname = LTRIM(RTRIM([surname]))
								 , @user_patronymic = LTRIM(RTRIM([patronymic]))
								 , @user_parent_id = parent_id 
							FROM dbo.OBJ_PERSON WHERE [ID] = @param1	
						END
						ELSE IF(@param0 = 'PERSON')
						BEGIN
							select @person_id = [id]
							     , @person_name = LTRIM(RTRIM([name]))
							     , @person_surname = LTRIM(RTRIM([surname]))
							     , @person_patronymic = LTRIM(RTRIM([patronymic]))
							     , @person_parent_id = parent_id 
							from dbo.OBJ_PERSON where [ID] = @param1
							
							select @person_dept_name = LTRIM(RTRIM([name])) from dbo.OBJ_DEPARTMENT where [id] = @person_parent_id
						END
						ELSE IF(@param0 = 'DEPARTMENT')
						BEGIN
							SELECT @param4 = LTRIM(RTRIM([name])) FROM dbo.OBJ_DEPARTMENT where id = @param1
						END
						ELSE IF(@param0 = 'LEVEL')
						BEGIN
							SELECT @param4 = LTRIM(RTRIM([name])) FROM dbo.OBJ_LEVEL where id = @param1
						END
						ELSE IF(@param0 = 'RIGHTS')
						BEGIN
							SELECT @param4 = LTRIM(RTRIM([name])) FROM dbo.OBJ_RIGHTS where id = @param1
						END
						ELSE IF(@param0 = 'SCRIPT')
						BEGIN
							SELECT @param4 = LTRIM(RTRIM([name])) FROM dbo.OBJ_SCRIPT where id = @param1
						END
						ELSE IF(@param0 = 'MACRO')
						BEGIN
							SELECT @param4 = LTRIM(RTRIM([name])) FROM dbo.OBJ_MACRO where id = @param1
						END
					END
										
					
					IF LEN (@param3) - LEN(REPLACE(@param3,';','')) = 2
					BEGIN					
						SET @objtype = LEFT(@param3, CHARINDEX(';',@param3) - 1)
						SET @objid = SUBSTRING(@param3,
										CHARINDEX(';',@param3) + 1,
											CHARINDEX(';',@param3, 
												CHARINDEX(';',@param3) + 1) - CHARINDEX(';',@param3) - 1)
						SET @action = SUBSTRING(@param3,
											CHARINDEX(';',@param3, 
												CHARINDEX(';',@param3) + 1) + 1,LEN(@param3))
					END
					
					ELSE IF LEN (@param3) - LEN(REPLACE(@param3,';','')) = 3
					BEGIN
						SET @objtype = LEFT(@param3, CHARINDEX(';',@param3) - 1)
						SET @objid = SUBSTRING(@param3,
										CHARINDEX(';',@param3) + 1,
											CHARINDEX(';',@param3, 
												CHARINDEX(';',@param3) + 1) - CHARINDEX(';',@param3) - 1)
						SET @action = SUBSTRING(@param3
											,CHARINDEX(';',@param3
												,CHARINDEX(';',@param3) + 1) + 1
													,CHARINDEX(';',@param3
														,CHARINDEX(';',@param3
															,CHARINDEX(';',@param3) +1) + 1) - CHARINDEX(';',@param3
																									,CHARINDEX(';',@param3) + 1) -1)
						SET @param4 = SUBSTRING(@param3
											,CHARINDEX(';',@param3
												,CHARINDEX(';',@param3
													,CHARINDEX(';',@param3) + 1) + 1) + 1,LEN(@param3))							
					END
					
					IF LEN (@param2) - LEN(REPLACE(@param2,';','')) = 1
					BEGIN
						SET @param3 = SUBSTRING(@param2,
											CHARINDEX(';',@param2) + 1, LEN(@param2))
						
						SET @param2 = LEFT(@param2, CHARINDEX(';',@param2) - 1)
					END
					
					IF(@param3 <> '')
					BEGIN
						SELECT @user_id = [id]
						     , @user_name = LTRIM(RTRIM([name]))
						     , @user_surname = LTRIM(RTRIM([surname]))
						     , @user_patronymic = LTRIM(RTRIM([patronymic]))
						     , @user_parent_id = parent_id 
						FROM dbo.OBJ_PERSON WHERE [ID] = @param3
					END						
																	
				END
				
							
				INSERT INTO [export].[PROTOCOL_EXP] 
					([objtype],
					[objid],
					[action],
					[param0],
					[param1],
					[param2],
					[param3],
					[param4],
					[date],
					[owner],
					[pk],
					[person_id],
					[person_name],
					[person_surname],
					[person_patronymic],
					[person_parent_id],
					[person_dept_name],
					[user_id],
					[user_name],
					[user_surname],
					[user_patronymic],
					[user_parent_id])
				VALUES
					(@objtype,
					 @objid,
					 @action, 
					 @param0,
					 @param1, 
					 @param2,
					 @param3,
					 @param4,
					 @date,
					 @owner,
					 @pk,
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
					 @user_parent_id)
		   END	   
		END		
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);  
		DECLARE @ErrorSeverity INT;  
		DECLARE @ErrorState INT;  

		SELECT   
			@ErrorMessage = ERROR_MESSAGE(),  
			@ErrorMessage = 'IntellectDW. Ошибка записи данных в таблицу [export].[PROTOCOL_EXP]. ' + ' GUID строки: ' + CAST(@pk AS NVARCHAR(60)) + ' ' + @ErrorMessage,
			@ErrorSeverity = ERROR_SEVERITY(),  
			@ErrorState = ERROR_STATE(); 
			-- Use RAISERROR inside the CATCH block to return error  
			-- information about the original error that caused  
			-- execution to jump to the CATCH block.  
			RAISERROR (@ErrorMessage, -- Message text.  
					   @ErrorSeverity, -- Severity.  
					   @ErrorState -- State.  
					   )  WITH LOG --записываем ошибку в системный журнал
		
			--откатываем транзакцию и снова записываем данные в оригинальную таблицу
			ROLLBACK TRANSACTION
			INSERT INTO [dbo].[PROTOCOL] 
				([objtype],
				[objid],
				[action],
				[region_id],
				[param0],
				[param1],
				[param2],
				[param3],
				[date],
				[time],
				[time2],
				[owner],
				[pk]) 
			VALUES
				(@objtype,
				 @objid,
				 @action, 
				 @region_id,
				 @param0,
				 @param1, 
				 @param2,
				 @param3,
				 @date,
				 @time,
				 @time2,
				 @owner,
				 @pk)
	END CATCH			
END 

