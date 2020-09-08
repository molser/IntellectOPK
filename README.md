	#######################################
	The IntellectOPK software package is an addition to the Intellect software product by ITV.
	#######################################
	
	
	The package performs the following main functions:
	1. Creation of a data warehouse to perform the following tasks:
		a) unloading the main Intellect database (ITV) from high-load SQL queries;
		b) accumulation of historical changes in the system for subsequent analysis.
	2. Providing specialized reports on the accumulated data.
	3. Data export.
	4. Interaction with the Intellect core (ITV) to optimize the daily tasks of the system operator.
	5. Providing additional tools to optimize the work of the system operator.
	
	The package consists of the following main elements:
	
	1. Database (IntellectDW) Microsoft SQL Server, developed as a data warehouse.
		Data comes to it from the Intellect database (ITV). It stores data according to the principle of accumulating information,
		that is, any changes supplement the existing information, no previously added information in IntellectDW is not deleted.
		Thus, historical tracking of data changes is implemented.
		Also, the package includes SQL scripts that add additions to the Intellect database (ITV)
		in order to accumulate the necessary information with its subsequent transfer to the data warehouse.
	
	2. Scripts (JavaScript) for the automation of the Intellect core (ITV) 
		in order to generate additional information with its subsequent transfer to the data warehouse.
	
	3. Microsoft SQL Server Integration Services packages ,
		with the help of which data is extracted from the Intellect (ITV) database and loaded into the IntellectDW database.
	
	4. Client (C#, WPF) for Microsoft Windows.
	

	#######################################
	Программный комплекс “IntellectOPK” разработан как дополнение к программному продукту “Intellect” компании ITV.
	#######################################


	Программный комплекс выполняет следующие основные функции:
		1. Создание хранилища данных, для выполнения следующих задач:
			а) разгрузка основной базы данных Intellect (ITV) от высоконагруженных SQL запросов;
			б) накопление исторических изменений в системе, для последующего анализа.
		2. Предоставление специализированных отчетов по накопленным данным.
		3. Экспорт данных.
		4. Взаимодействие с ядром Intellect (ITV) для оптимизации повседневных задач оператора системы.
		5. Предоставление дополнительных инструментов для оптимизации работы оператора системы.
	
	Пакет состоит из следующих основных элементов:
	
	1. База данных (IntellectDW) Microsoft SQL Server, разработанная по типу хранилища данных. 
		Данные поступают в нее из базы данных Intellect (ITV). В ней осуществлено хранение данных по принципу накопления информации, 
		то есть любые изменения дополняют существующую информацию, никакая ранее добавленная информация в IntellectDW не удаляется. 
		Таким образом реализовано историческое отслеживание изменений данных.	
		Также, в пакет включены SQL скрипты, которые вносят дополнения в базу данных Intellect (ITV) 
		с целью накопления необходимой информации с последующей передачей ее в хранилище данных.
	
	2. Скрипты (JavaScript) автоматизации работы ядра Intellect (ITV) 
		с целью генерации дополнительной информации с последующей передачей ее в хранилище данных.
	
	3. Пакеты Microsoft SQL Server Integration Services, 
		с помощью которых осуществляется извлечение данных из базы данных Intellect (ITV) и загрузка их в базу данных IntellectDW.
	
	4. Клиент (C#, WPF) для Microsoft Windows.

