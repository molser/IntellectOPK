   M S B A M L   `   `   `  ���� I  EMolserControls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG4clr-namespace:MolserControls;assembly=MolserControlsMolserControls  H DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=nullA%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters K*clr-namespace:IntellectOPK.ValidationRulesIntellectOPK.ValidationRules =#clr-namespace:IntellectOPK.CommandsIntellectOPK.Commands #   IntellectOPK.Views.MainWindow   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Gmolser4clr-namespace:MolserControls;assembly=MolserControls     6conv%clr-namespace:IntellectOPK.Converters     8v*clr-namespace:IntellectOPK.ValidationRules     8commands#clr-namespace:IntellectOPK.Commands     X TXceed.Wpf.Toolkit, Version=3.8.0.0, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  $	��600��$	��800��  � Icon$)  #..\Resources\Icons\IntellectOPK.ico��   VS2012WindowStyle#��[   � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter> 8IntellectOPK.Converters.BoolToUIVisibilityMultiConverter $  boolToUIVisibilityMultiConverter8  2IntellectOPK.Converters.BoolToBoolInverseConverter  boolToBoolInverseConverter6 0IntellectOPK.Converters.BoolToBoolMultiConverter  boolToBoolMultiConverter= 7IntellectOPK.Converters.EmptyStringToBoolMultiConverter # emptyStringToBoolMultiConverter7 1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter1 +IntellectOPK.Converters.NullToBoolConverter  nullToBoolConverter1  +IntellectOPK.Converters.AsyncImageConverter  asyncImageConverter=  7IntellectOPK.Converters.DataBaseIconVisibilityConverter #	 dataBaseIconVisibilityConverter3	  -IntellectOPK.Converters.DateToStringConverter 
 dateToStringConverter8
  2IntellectOPK.Converters.IntToUIVisibilityConverter  intToUIVisibilityConverter2  ,IntellectOPK.Converters.IntToStringConverter  intToStringConverter3 -IntellectOPK.Converters.StringToBoolConverter  stringToBoolConverter;  5IntellectOPK.Converters.AlarmToProgressStateConverter ! alarmToProgressStateConverter;  5IntellectOPK.Converters.AlarmToProgressValueConverter ! alarmToProgressValueConverter��%�   &	       &	      &	 
     &	      &	      &	      &	      &	 #     &		 (     &	
 -     &	 2     &	 7     &	 <     &	 A     &	 F     ��                 	  
          .��]� .+�o� -    o�Name$
 menu��$
��Left=�$	��Top=�$��0,0,0,0q�$	��Top=�.@�m� $��Файл�� m� StaysOpenOnClick . .@�m� $#��Изменить пароль�� m� Command �� *ChangePasswordCommand+y��� *!UserPermissions[ChangePassword]+ �� 	Converter# [ �� m� $��
Выход�� �� *CloseCommand+m� $��Инструменты�� . .@�m� $��Пользователи�� �� *ShowUsersViewCommand+y��� *UserIsSecurityAdmin+# [ m� $#��Отладочное окно�� �� *ShowIidkDebugViewCommand+y��� *IsIidkDebugEnabled+# [ m� $��Настройки�� �� *ShowSettingsViewCommand+m� $��Справка�� . .@�m� $��О программе�� �� *AboutCommand+c� $	��Top=�$��0,2,0,0q�.@���  � ToolTip$ Выполнить�� ^� ShowOnDisabled . 	 �� 	IsDefault	 . $��22������ *RunQueryCommand+���� 
 �� Orientation$
 
Horizontal=�.+���   	RunCanvas#��[ �� $��Center=�Выполнить�� $ Остановить�� . $��26��$��22��  
StopCanvas#��[ ���� *CancelQueryCommand+�� $��5,0,5,0q�y��� *UserPermissions[ExportData]+# [ �� $. (Экспортировать в MS Excel�� .   MsExcelCanvas#��[ ���� *ExportToMSExcelCommand+y��� *UserPermissions[ExportData]+# [ �� $��5,0,5,0q�y��� *#!UserPermissions[RunCardConverter]+# [ �� $! Конвертер карт�� . $��22��  CardConverterCanvas#��[ $��40������ *CardConverterCommand+{��� *IsCardConverterShowed+# [ y��� *#!UserPermissions[RunCardConverter]+# [ �� $��5,0,5,0q��� -    ��Name$ 
infoButton��$��5,0,0,0q�$��30��$��24��$H BПоказать дополнительную информацию������ *ShowInfoCommand+���� $��14��$��14��  InfoViewbox#��[ �� -   $ showOnMapButton��$��5,0,0,0q�$��30��$��24��$3 -Показать объект на карте������ *IidkShowObjectOnMapCommand+y�`�  `� Mode$ OneWay=� `� 	Converter# [ .1���  �� Mode$ OneWay=� �� Path$ IsIidkEnabled��� $ OneWay=�$ Settings.IidkMap�# [ ���� $��15��$��19��  LocationViewbox#��[ �� -   $ showOnCamButton��$��5,0,0,0q�$��30��$��24��$7 1Показать событие на камере������ *IidkShowEventOnCamCommand+y�`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$ Settings.IidkMonitor�# [ ���� $��10��$��17��  ShowOnCamViewbox#��[ �� $��Bottom=�$��Stretch=�$��Bottom=�$��4,0,0,0q�  TitleBarBackgroundBrush#��[ ���� .R��  � ColumnDefinitions �� $��* ��� $
��auto �.@��� -   $��rowsCountStackPanel��$
 
Horizontal=�.+��� $+��%Количество записей: ���� -   $��rowsCountTextBox���� $��1��.���� $
 
Horizontal=�.+�d� $��28��$��0,0,0,0q�  SoundToggleButton#��[  d� 	IsChecked �� *Settings.IsSoundDisabled+$ TwoWay=�(� -   $��14�� J� Opacity$
 0.75Q�$��5,0,0,0q�$��Center=�����  �� 
TargetType" (�.���  �� Property �@�ContextMenu �� Value �� .@�m� $E��?Использовать основную базу данных�� m� IsCheckable .  m� 	IsChecked �� *Settings.UseOperDB+$ TwoWay=�.����   DataBaseBorder#��[ ���� " ��.���  � ��
 � �����  �@�ToolTip$Q KИспользуется дополнительная база данных�� �� Triggers ��  �� Binding �� *Settings.UseOperDB+ �� Value true.a���  � ��
 �q�<���  �@�ToolTip$E ?Используется основная база данных��(� -    (�Name$ IidkViewBox��$��14��$
 0.75Q�$��10,0,0,0q�$��Center=�y��� *IsIidkEnabled+# [ $ OneWay=� �� *
IidkStatus+.����   IidkViewbox#��[ ���� " ��.���  � ��
 �q�<� ��  �� *IsIidkConnected+	 false.a���  � ��
 �  ��� -	    �Name$ iidkDisconnected��$	��Top=� � 	StaysOpen .   � PlacementTarget ��  �� ElementName$ IidkViewBox����`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$ IsIidkConnected�# [ .���� 
�����p�$��1q�
�������  �� Padding$  4q�._��� $
 
Horizontal=�.+��� $��24��$��22��  WarningViewbox#��[ �� -
   ! ��Name$! myLabel��$��5,0,0,0q�$6��0Нет связи с сервером Intellect!��
���   ��� $
 0.75Q��� -   $��2,2,2,1q�.@��� -   " ��Name$" AccessEvents����� $��-6,0,0,0q� �� $��18 ��� .+�   MolserControls.MolserWait  $��0��$��Bottom=�$
��Left=�$��0,0,0,0q�$��16��$��16��y��� *IsGettingAccessEvents+# [ �� $��1��$#��События доступа��.��� $��10,10,10,10q�# � RowDefinitions# �� $
��auto ��� $
��auto ��� $
��auto ��� $��* � �� $��* ����� " �.���  � {� .  ��  �� *IsGettingAccessEvents+ true.a���  � {� .  .+�]� $��0��{�`� # [ .1��� $ OneWay=�$$ AccessEventsFilter.FacilityCod��� $ OneWay=�$' !AccessEventsFilter.CardPartParsec��� $ OneWay=�$! AccessEventsFilter.PersonId�.+��� $��Right=�$��24��$��30��$��0,0,0,0q�$��FromAccessEvents��$+ %Выбрать сотрудников��  PersonCanvas#��[ ���� *ShowPersonsViewCommand+� $
��Left=�.+�   MolserControls.MsComboBox  -   $  Name$$ 
PersonsAEF��$��0��$��0��$��	40,0,40,0q�$��24��$��Stretch=�$��Center=�% �� 
IsEditable% . &   	Watermark$C& =Именные компоненты сотрудников...������ *AefPersonsHistory+' �� Text' �� $ TwoWay=�$  AccessEventsFilter.Persons�( �� UpdateSourceTrigger$( PropertyChanged=�) �� NotifyOnValidationError) . * �� ValidatesOnExceptions* . ���� "    StandardMsComboBox+ �� BasedOn#+ [ .���  �@�ToolTip$. (Фильтр по сотрудникам�� P� , P� Property, �@=�HasError- P� Value- . . ���  �@�ToolTip �� . �� RelativeSource. �� *Self+$) #(Validation.Errors)[0].ErrorContent�]� $��1��$��0,10,0,0q�{�`� # [ .1��� $ OneWay=�$$ AccessEventsFilter.FacilityCod��� $ OneWay=�$' !AccessEventsFilter.CardPartParsec��� $ OneWay=�$! AccessEventsFilter.PersonId�.+��� $��Right=�$��24��$��30��$��0,0,0,0q�$��FromAccessEvents��$! Выбрать отделы��  DepartmentCanvas#��[ ���� *ShowDepartmentsViewCommand+� $
��Left=�.+�   MolserControls.MsTextBox  -   /  Name$/ DepartmentsAEF��$��0��$��0��$��24��$��Stretch=�$��Center=�0   	Watermark$0 Отделы...��.��.���� $ TwoWay=�$$ AccessEventsFilter.Departments�$( PropertyChanged=�) . * . ���� "    StandardMsTextBox#+ [ .���  �@�ToolTip$&  Фильтр по отделам����  � {� .   P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent���  �� $
 Text�$ PersonIDTextBox��  .a���  � {� . .��]� $��Stretch=�$��2��$��0,10,0,0q�.+�d� $��30��$��24��$��0,0,0,0q�$	��Top=� �� $/ )AccessEventsFilter.OnlyLast10EventsForDay�$( PropertyChanged=�$ TwoWay=�����    Top10Viewbox#��[  $��10������ " d� ! StandardToggleButton#+ [! .���  �@�ToolTip$V PПоказать только последние 10 событий за день�� P� , �@d�	IsChecked$
- trueY�. ���  �@�ToolTip$^ XПоказываются только последние 10 событий за день��� $��5,0,0,0q�$
��Left=�$
��Left=�# �� $
��auto �.+�&   Xceed.Wpf.Toolkit.DateTimePicker  -   1  Name$1 StartDateAEF��$��0��$��0,0,0,0q�$��Center=�$��Center=�$	��130��$��12(�&   Xceed.Wpf.Toolkit.DateTimeUpDown2   Format$2 Custom=�3   FormatString$3 dd.MM.yyyy HH:mm���  �Xceed.Wpf.Toolkit.Primitives.UpDownBase`1[[System.Nullable`1[[System.DateTime, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]4   ShowButtonSpinner4 .  5   AutoCloseCalendar5 . {��� *+)AccessEventsFilter.OnlyLast10EventsForDay+# [ 6   Value6 �� $ TwoWay=�$" AccessEventsFilter.StartDate�$( PropertyChanged=�7 �� ValidatesOnDataErrors7 . ���� "   " StandardDateTimePicker#+ [" .���  �@�ToolTip$! Начальная дата�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�� $
��Left=�$��5,0,0,0q�$
��Left=�# �� $
��auto �.+�  -   $1 EndDateAEQP��$��Center=�$��Center=�$	��130��$��12(�$2 Custom=�$3 dd.MM.yyyy HH:mm��4 .  5 . {��� *+)AccessEventsFilter.OnlyLast10EventsForDay+# [ 6 �� $ TwoWay=�$  AccessEventsFilter.EndDate�$( PropertyChanged=�7 . ���� "  #+ [" .���  �@�ToolTip$ Конечная дата�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent��� $
 
Horizontal=�$
��Left=�$��10,0,0,0q�.+�d� -   $��30��$��24��$��0,0,0,0q�$	��Top=� # EventCanvas#��[#  �� *IsApplyAefEvents+
8 � Tag8 �� $ TwoWay=�$ AccessEventsFilter.Events�$( PropertyChanged=�) . * . ���� " d�#+ [! .���  �@�ToolTip$A ;Использовать фильтр по событиям�� P� , �@d�	IsChecked$
- trueY�. ���  �@�ToolTip$= 7Установлен фильтр по событиям��P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent��� $
��Left=�$
 
Horizontal=�$��10,0,0,0q�.+�d� -   $��24��$��30��$��0,0,0,0q�$	��Top=�$��FromAccessEvents�� $ AccessPointCanvas#��[$  �� *IsApplyAefAccessPoints+8 �� $ TwoWay=�$% AccessEventsFilter.AccessPoints�$( PropertyChanged=�) . * . ���� " d�#+ [! .���  �@�ToolTip$L FИспользовать фильтр по точкам доступа�� P� , �@d�	IsChecked$
- trueY�. ���  �@�ToolTip$H BУстановлен фильтр по точкам доступа��P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�� $
��Left=�$��10,0,0,0q�$
��Left=�# �� $
��auto �.+�  -   $/ PersonIDTextBox��$��24��$	��100��$ 0 ID сотрудника...��.��{�`� # [ .1��� $ OneWay=�$$ AccessEventsFilter.FacilityCod��� $ OneWay=�$' !AccessEventsFilter.CardPartParsec�.��.���� $ TwoWay=�$! AccessEventsFilter.PersonId�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$/ )Фильтр по ID сотрудника�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�.���� $
��Left=�$
 
Horizontal=�$��5,0,0,0q�y��� *UserPermissions[SeePersons]+# [ .+�� $
��Left=�# �� $
��auto �.+�  -   $/ FacilityCodTextBox��$��0��$��0��$��24��$��80��$
��Left=�$��Center=�$0 Код карты...��.��{�`� # [ .1��� $ OneWay=�$! AccessEventsFilter.PersonId�.��.���� $ TwoWay=�$$ AccessEventsFilter.FacilityCod�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$E ?Фильтр по коду карты (коду объекта)��.��� $
��Left=�$��5,0,0,0q�# �� $
��auto �.+�  -   $/ CardPartParsecTextBox��$��0��$��0��$��24��$��95��$
��Left=�$��Center=�$0 Номер карты...��.��{�`� # [ .1��� $ OneWay=�$! AccessEventsFilter.PersonId�.��.���� $ TwoWay=�$' !AccessEventsFilter.CardPartParsec�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$/ )Фильтр по номеру карты��.��&   System.Windows.Controls.DataGrid  -   9  Name$9 accessEvenetsDataGrid��$��3��$��0,10,0,0q�$	��Top=�:   AutoGenerateColumns: .  ;   GridLinesVisibility$; 
Horizontal=� % DataGridLinesBrush<   HorizontalGridLinesBrush#< [% =   CanUserResizeRows= .  >   
IsReadOnly> . ?   HeadersVisibility$	? All=�@   SelectionMode$@ Single=�A   SelectionUnit$A FullRow=����� *AccessEvents+B �� NotifyOnTargetUpdatedB . C �� SelectedItemC �� *CurrentProtocolItem+y��� *AccessEvents+# [ D   ColumnsD 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumnE   Header$E Дата��1  +System.Windows.Controls.DataGridBoundColumnF   BindingF �� $
 Date�G �� StringFormat$G {0:dd.MM.yy HH:mm:ss}��4  .System.Windows.Controls.DataGridTemplateColumn  $E Точка доступа��H   CanUserSortH . I   SortMemberPath$I 	Nc32kName��J   ClipboardContentBindingJ �� *	Nc32kName+K   CellTemplateK �� .R��� $
 
Horizontal=�.+��� L ��Name$L content������ $ 	Nc32kName�M �� TriggersM   $E Событие��H . $I Event��J �� *Event+K �� .R��� $
 
Horizontal=�.+��� $L content������ $ Event�  $E Информация��H . $I Information��J �� *Information+K �� .R��� $
 
Horizontal=�.+��� $L content������ $ Information�N   	CellStyleN �� *  $System.Windows.Controls.DataGridCell"   & StandardDataGridCell#+ [&  ��  �� *Event+: 6В доступе на вход отказано (APB).a���  � ��
 �� ����  �� *Event+< 8В доступе на выход отказано (APB).a���  � ��
 �� ��O � ContextMenuO �� .@�m� $+��%Показать информацию�� �� *ShowInfoCommand+P m� IconP �� $��16��$��16��#��[ m� $3��-Показать объект на карте�� �� *IidkShowObjectOnMapCommand+y�`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$ Settings.IidkMap�# [ P �� $��15��$��20��#��[ m� $7��1Показать событие на камере�� �� *IidkShowEventOnCamCommand+y�`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$ Settings.IidkMonitor�# [ P �� $��17��$��17��#��[ m� $��Копировать��$
 Copy��Q J� InputBindingsQ d� R d� Gesture$R LeftDoubleClicka�S �� CommandS �� *ShowInfoCommand+�� -   $" Persons��y��� *UserPermissions[SeePersons]+# [ ��� $��-6,0,0,0q� �� $��18 ��� .+�  $��0��$��Bottom=�$
��Left=�$��0,0,0,0q�$��16��$��16��y��� *IsGettingPersons+# [ �� $��1��$��Сотрудники��.��� $��10,10,10,10q�# �� $
��auto ��� $
��auto ��� $
��auto ��� $��* � �� $��* ����� " �.���  � {� .  ��  �� *IsGettingPersons+ true.a���  � {� .  .+�� $��0��{�`� # [ .1��� $ OneWay=�$ PersonsFilter.FacilityCod��� $ OneWay=�$" PersonsFilter.CardPartParsec��� $ OneWay=�$ PersonsFilter.PersonId�.+�  -   $/ PersonPF��$��0��$��0��$��24��$��Stretch=�$��Center=�$A0 ;Именные компоненты сотрудника...��.��.���� $ TwoWay=�$ PersonsFilter.Person�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$> 8Именные компоненты сотрудника�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�.��]� $��1��$��0,10,0,0q�{�`� # [ .1��� $ OneWay=�$ PersonsFilter.FacilityCod��� $ OneWay=�$" PersonsFilter.CardPartParsec��� $ OneWay=�$ PersonsFilter.PersonId�.+��� $��Right=�$��24��$��30��$��0,0,0,0q�$��FromPersons��$! Выбрать отделы��#��[ ���� *ShowDepartmentsViewCommand+� $
��Left=�.+�  -   $/ DepartmentsPF��$��0��$��0��$��24��$��Stretch=�$��Center=�$0 Отделы...��.��.���� $ TwoWay=�$ PersonsFilter.Departments�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$ Отделы�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�.���� $��2��$��0,10,0,0q�$
 
Horizontal=�.+�� $
��Left=�$��0,0,5,0q�$
��Left=�# �� $
��auto �.+�  -   $/ PersonsPersonIDTextBox��$��24��$	��100��$ 0 ID сотрудника...��.��{�`� # [ .1��� $ OneWay=�$ PersonsFilter.FacilityCod��� $ OneWay=�$" PersonsFilter.CardPartParsec�.��.���� $ TwoWay=�$ PersonsFilter.PersonId�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$/ )Фильтр по ID сотрудника�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�.���� $
��Left=�$
 
Horizontal=�$��0,0,10,0q�.+�� $
��Left=�# �� $
��auto �.+�  -   $/ PersonsFacilityCodTextBox��$��0��$��0��$��24��$��80��$
��Left=�$��Center=�$0 Код карты...��.��{�`� # [ .1��� $ OneWay=�$ PersonsFilter.PersonId�.��.���� $ TwoWay=�$ PersonsFilter.FacilityCod�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$E ?Фильтр по коду карты (коду объекта)��.��� $
��Left=�$��5,0,0,0q�# �� $
��auto �.+�  -   $"/ PersonsCardPartParsecTextBox��$��0��$��0��$��24��$��95��$
��Left=�$��Center=�$0 Номер карты...��.��{�`� # [ .1��� $ OneWay=�$ PersonsFilter.PersonId�.��.���� $ TwoWay=�$" PersonsFilter.CardPartParsec�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$/ )Фильтр по номеру карты��.���� $
 
Horizontal=�y��� *#!UserPermissions[SeePersonHistory]+# [ .+��� $: 4Учитывать историю изменений�� �� $% PersonsFilter.ShowPersonHistory�$( PropertyChanged=�$ TwoWay=��� $+��%Учитывать удаленных��$��5,0,10,0q��� $
 
Horizontal=�$��0,0,20,0q�.+��� $��Отдел:��$��0,0,10,0q�  -   $$ cbDepartmentFilter��$��24��$��Stretch=�T �� SelectedIndex$T 0��$��Center=����� *Departments+B .   -   $9 personsDataGrid��$��3��$��0,10,0,0q�$��Stretch=�$	��Top=�: .  $; 
Horizontal=�#< [% = .  U   CanUserAddRowsU .  $	? All=�$@ Single=�V   EnableRowVirtualizationV . !W   EnableColumnVirtualizationW . X %� IsVirtualizingX . Y %� VirtualizationMode$Y 	Recycling=�Z �� IsTextSearchEnabledZ . [ w� TextPath$[ FullName��\   	RowHeight$\ 80Q����� *	Persons+B . C �� *CurrentPerson+y��� *	Persons+# [ D   $E Фото��]   
IsReadOnly] . ^   Width5  /System.Windows.Controls.DataGridLengthConverter$^ 80 _   MinWidth$_ 80Q�K �� .R�� .+�� ` � DataContext` �� $ DataContext�. �� *FindAncestor+a �� AncestorType"a �# [ .+�(� $��60��$��Center=�$��Bottom=�.����  ' 
PersonPath#��['  ( PersonPathBrush#��[( �� $��Center=�$��Center=�
�������$��загрузка...��y��� *IsNotCompleted+ ) bool2VisibilityConverter# [) �� $��Center=�$��Center=�
���  ��$��ошибка��y��� *	IsFaulted+# [) �� $��Center=�$��Bottom=����� *Result+(� $��13��$
��Left=�$��Bottom=�$J DДанные из дополнительной базы данных��y��� # [	 .���� 
�������$  3q�._���  * DataBasePath#��[* 
��� ���  $E Фамилия��H . $
I Name��K �� .R�� # �� �� �� .+��� $L content��$��0������ $
 Name��� $��2��$��Italic$����� $ 
Department�  $E Имя��] . F �� $ Surname�  $E Отчество��] . F �� $ 
Patronymic�  $*E $Срок действия карты��] . F �� $ Expired�$G {0:dd.MM.yyyy}��  $E Заблокирован��] . H . $I IsLocked��K �� .R�� .+��� $��Center=�$��4,4,4,0q�{�.   �� $ IsLocked�$( PropertyChanged=�  $2E ,Двойной проход запрещен��] . H . $I IsApb��K �� .R�� .+��� $��Center=�$��4,4,4,0q�{�.   �� $ IsApb�$( PropertyChanged=�  $E ID��] . $^ * F �� $ Id�O �� .@�m� $+��%Показать информацию�� �� *ShowInfoCommand+P �� $��16��$��16��#��[ Q d� $R LeftDoubleClicka�S �� *ShowInfoCommand+�� -   $" AccessPoints����� $��-6,0,0,0q� �� $��18 ��� .+�  $��0��$��Bottom=�$
��Left=�$��0,0,0,0q�$��16��$��16��y��� *IsGettingAccessPoints+# [ �� $��1��$��Точки доступа��.��� $��10,10,10,10q�# �� $
��auto ��� .+��� $
 
Horizontal=�.+�� .+�  -    $/ AccessPointName��$��0��$��0��$��24��$	��200��$
��Left=�$��Center=�$0 Название...��.��.���� $ TwoWay=�$ AccessPointsFilter.Name�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$ Название�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�.���� $
��Left=�$��10,0,0,0q�$��24��$��30��$��FromAccessPoints��$- 'Показать сотрудников�� . #��[ ���� *ShowPersonsViewCommand+�� $
��Left=�$��24��$��30��$��10,0,0,0q�$��FromAccessPoints��$2 ,Показать уровни доступа�� .  + LevelCanvas#��[+ ���� *ShowLevelsViewCommand+y��� *UserPermissions[SeeLevels]+# [ �� $
 
Horizontal=�$��10,0,0,0q�y��� *IsIidkEnabled+# [   -!   $9 accessPointsDataGrid��$��1��$��0,10,0,0q�$��Stretch=�$	��Top=�: .  $; 
Horizontal=�#< [% = .  > . $	? All=�$@ Single=�$A FullRow=�Z . $
[ Name������ *AccessPoints+B . C �� *CurrentAccessPoint+y��� *AccessPoints+# [ D   $E Название��H . $
I Name��J �� *Name+K �� .R��� $
 
Horizontal=�.+��� $L content������ $
 Name�  $E ID��] . $^ * F �� $ Id�O �� .@�m� $-��'Показать сотрудников��b m� CommandParameter$b FromAccessPoints�� �� *ShowPersonsViewCommand+P �� $��15��$��15��#��[ m� $2��,Показать уровни доступа��$b FromAccessPoints�� �� *ShowLevelsViewCommand+y��� *UserPermissions[SeeLevels]+# [ P �� $��15��$��15��#��[+ m� $3��-Показать объект на карте�� �� *IidkShowObjectOnMapCommand+y�`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$ Settings.IidkMap�# [ P �� $��15��$��20��#��[ m� $
 Copy���� -"   $" Levels��y��� *UserPermissions[SeeLevels]+# [ ��� $��-6,0,0,0q� �� $��18 ��� .+�  $��0��$��Bottom=�$
��Left=�$��0,0,0,0q�$��16��$��16��y��� *IsGettingLevels+# [ �� $��1��$!��Уровни доступа��.��� $��10,10,10,10q� �� $
��161* ��� $
��409* �# �� $
��auto ��� .+��� $
 
Horizontal=�$��2��.+�� $��0,0,10,0q�.+�  -#   $/ 	LevelName��$��0��$��0��$��24��$	��200��$
��Left=�$��Center=�$0 Название...��.��.���� $ TwoWay=�$ LevelsFilter.Name�$( PropertyChanged=�) . * . ���� "  #+ [ .���  �@�ToolTip$ Название�� P� , �@=�HasError- . . ���  �@�ToolTip �� . �� *Self+$) #(Validation.Errors)[0].ErrorContent�.���� $
��Left=�$��0,0,10,0q�$��24��$��30��$��
FromLevels��$- 'Показать сотрудников�� . #��[ ���� *ShowPersonsViewCommand+�� $��0,0,10,0q�$
��Left=�$��24��$��30��$��
FromLevels��$0 *Показать точки доступа�� . #��[$ ���� *ShowAccessPointsViewCommand+�� $��0,0,10,0q�$
��Left=�$��24��$��30��$��
FromLevels��$< 6Peдактировать уровень доступа�� .  , 
EditCanvas#��[, ���� *ShowLevelViewCommand+y��� *UserIsSecurityAdmin+# [   -$   $9 levelsDataGrid��$��1��$��0,10,0,0q�$	��Top=�: .  $; 
Horizontal=�#< [% = .  > . $	? All=�$@ Single=�$A FullRow=�Z . $[ Description��$��2������ *Levels+B . C �� *CurrentLevel+y��� *Levels+# [ D   $E Название��F �� $
 Name�c   ElementStylec �� " ��.���  � ��$ CharacterEllipsis=�  $E Описание��F �� $ Description�c �� " ��.���  � ��$ CharacterEllipsis=�  $E Тип��F �� $
 Type�c �� " ��.���  � ��$ CharacterEllipsis=�  $E ID��] . $^ * F �� $ Id�O �� .@�m� $-��'Показать сотрудников��$b 
FromLevels�� �� *ShowPersonsViewCommand+P �� $��15��$��15��#��[ m� $0��*Показать точки доступа��$b 
FromLevels�� �� *ShowAccessPointsViewCommand+P �� $��15��$��15��#��[$ m� $ ��Редактировать��$b 
FromLevels�� �� *ShowLevelViewCommand+P �� $��15��$��15��#��[, m� $
 Copy��N �� "  #+ [&  ��  �� *Type+ основной.a���  � ��
 � � ���  �� *Type+  дополнительный.a���  � ��
 �<����  �� *Type+
 авк.a���  � ��
 ��  ��� -%   $" Notifications��y�`� # [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$' !UserPermissions[SeeNotifications]���� $��-7,0,0,0q� �� �� .+�A� -&   d A�Name$d alarmIndicator��$y�Hidden=�$��10��$��10��
��� E��(� -'   $ alarmIndicator2��$��16��$��16��$��Center=�$��Center=�.��� .+�A� $��16��$��16������ $
 Fill�$ alarmIndicator��e J� OpacityMaske 
� f 
� RadiusX$f 1Q�g 
� RadiusY$g 1Q�.��� h � Color$h Yellow��i � Offset$i 0Q�� $h Transparent��$i 1Q����� " (�.���  � y�$ Visible=� ��  �� *!NotificationsManager.IsAlarming+	 false.a���  � y�$ Hidden=�(� -(   $ alarmIndicator3��$��14��$��14��$��Center=�$��Center=�$. (Есть новые оповещения��y��� *'%NotificationsManager.UnconfirmedCount+# [ .��� # �� $
��auto �.+�A� $��14��$��14��
��� E��$��Center=�$��Center=��� 
�������$��0,1,0,0q�$��9(�$��Arial)�$��11��$��Center=�$��Center=����� *'%NotificationsManager.UnconfirmedCount+# [ �� $��1��$��3,0,0,0q�$��Оповещения��j � Triggersj :� k :� RoutedEvent$k Rectangle.Loaded��.[��� .���� l g� RepeatBehavior$l Forever��.���� m �� 
TargetName$m alarmIndicator��n �� TargetProperty$"n Fill.(SolidColorBrush.Color)�	o �� To$o TransparentX�p g� Duration$p 0:0:0D�q g� 	BeginTime$q 	0:0:0.500X��� $m alarmIndicator��$"n Fill.(SolidColorBrush.Color)�$o 	OrangeRedX�$p 0:0:0D�$q 0:0:1X�.��� $��10,10,10,10q� �� # �� $
��auto ��� .+��� $
 
Horizontal=�.+��� $
��Left=�$��0,0,10,0q�$��24��$��30��$��FromNotifications��$+ %Добавить оповещения�� . ���� *AddNotificationsCommand+���� $��16��$��20�� - 
AddViewbox#��[- �� $��0,0,10,0q�$
��Left=�$��24��$��30��$��FromNotifications��$) #Удалить оповещение�� . ���� *RemoveNotificationCommand+���� $��16��$��16�� . DeleteViewbox#��[. �� $��0,0,10,0q�$
��Left=�$��24��$��30��$��FromNotifications��$0 *Удалить все оповещения�� . ���� *RemoveAllNotificationsCommand+���� $��15��$��17�� / RecycleViewbox#��[/ �� $��0,0,10,0q�$
��Left=�$��24��$��30��$��FromNotifications��$- 'Сохранить оповещения�� . ���� *ExportNotificationsCommand+���� $��18�� 0 UploadViewbox#��[0 �� $��0,0,10,0q�$
��Left=�$��24��$��30��$��FromNotifications��$- 'Загрузить оповещения�� . ���� *ImportNotificationsCommand+���� $��18�� 1 DownloadViewbox#��[1 �� $��0,0,10,0q�$
��Left=�$��24��$��30��$��FromNotifications��$2 ,Подтвердить все тревоги�� . ���� * ConfirmAllNotificationsCommand+���� $��15��$��17�� 2 CheckAllViewbox#��[2   -)   $9 notificationsDataGrid��$��1��$��0,10,0,0q�$	��Top=�: .  $; 
Horizontal=�#< [% = .  > . $	? All=�$@ Single=�$A FullRow=�Z . $[ 
sourceName������ *$"NotificationsManager.Notifications+B . y��� *$"NotificationsManager.Notifications+# [ C �� *CurrentNotification+D   $E Управление��] .  H . $I 
IsDisabled��r   HeaderTemplater �� .R��  �� $
��auto ��� K �� .R��� $
 
Horizontal=�.+�d� -*   $��5,0,0,0q�$��14��s �� 	ClickMode$s Press=� �� $ 
IsDisabled�$ OneWay=����� " d� 3 LightbulbToggleButton#+ [3 .���  �@�ToolTip$% Тревога включена����  � ��
 � ��� P� , �@d�	IsChecked$
- TrueY�. ���  �@�ToolTip$' !Тревога отключена����  � ��
 �������  �� *IsUnconfirmed+ truea���  � ��
 � E����  �� *
IsAlarming+ truea���  � �� �� *Fill+$ alarmIndicator��  $E Имя��F �� $
 Name�c �� " ��.���  � ��$ CharacterEllipsis=�  $E Дата��F �� $
 Date�# [
 $G {0:dd.MM.yy HH:mm:ss}��  $E Информация��] . $^ * F �� $ Information�c �� " ��.���  � ��$ CharacterEllipsis=�O �� .@�m� $+��%Показать информацию�� �� *ShowInfoCommand+P �� $��16��$��16��#��[ m� $3��-Показать объект на карте�� �� *IidkShowObjectOnMapCommand+y�`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$ Settings.IidkMap�# [ P �� $��15��$��20��#��[ m� $7��1Показать событие на камере�� �� *IidkShowEventOnCamCommand+y�`� $ OneWay=�# [ .1��� $ OneWay=�$ IsIidkEnabled��� $ OneWay=�$&  Settings.AppSettings.IidkMonitor�# [ P �� $��17��$��17��#��[ m� $��Копировать��$
 Copy��Q d� $R LeftDoubleClicka�S �� *ShowInfoCommand+t � TaskbarItemInfot *  $System.Windows.Shell.TaskbarItemInfo  -+   taskBarItemInfo��u   ProgressStateu �� *'%NotificationsManager.UnconfirmedCount+# [ v   ProgressValuev �� *'%NotificationsManager.UnconfirmedCount+# [ 