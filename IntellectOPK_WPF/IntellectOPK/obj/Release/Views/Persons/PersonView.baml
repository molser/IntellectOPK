   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.0.12, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  V RIntellectOPK.ControlLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullnNclr-namespace:IntellectOPK.ControlLibrary;assembly=IntellectOPK.ControlLibraryIntellectOPK.ControlLibrary K*clr-namespace:IntellectOPK.ValidationRulesIntellectOPK.ValidationRules  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  #    IntellectOPK.Views.PersonView   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     amolserNclr-namespace:IntellectOPK.ControlLibrary;assembly=IntellectOPK.ControlLibrary     8v*clr-namespace:IntellectOPK.ValidationRules     6conv%clr-namespace:IntellectOPK.Converters     $	��530��$	��640��  � SizeToContent$  Width=�   VS2012WindowStyle#��[   � 
ResizeMode$ CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter1   +IntellectOPK.Converters.AsyncImageConverter  asyncImageConverter=   7IntellectOPK.Converters.DataBaseIconVisibilityConverter # dataBaseIconVisibilityConverter3   -IntellectOPK.Converters.DateToStringConverter  dateToStringConverter>  8IntellectOPK.Converters.BoolToUIVisibilityMultiConverter $  boolToUIVisibilityMultiConverter��%i   &	       &	      &	 
     &	      &	      &	      &	      ��             .��]� .+�� $��Bottom=�$��
0,10,15,10q�.+���  �� Orientation$ 
Horizontal=�$��Right=�$��Bottom=�.+��� $��26��$��60��$	��Top=�$
��Left=�$��OK��{�.  ���� *ConfirmCommand+�� -   $	��Top=�$
��Left=� �� IsCancel . $��Отмена��$��10,0,0,0q�$��26��$��60��� $
��Left=�$��	20,0,20,0q� � RowDefinitions ��  � ColumnDefinitions �� �� $
��Auto ��� $��20��$
��auto ��� $��20��$
��auto �.+�� $��0��$��0��$
��Left=�.+�(�  (� Stretch$ Uniform=�$	��Top=�.���� -   $��photoCanvas��$��81��$	��108��.+���   
PersonPath#��[  	 PersonPathBrush#��[	 	 �� Bottom$	 0��$��81��� ���� *ActualWidth+
 �� ElementName$
 photoCanvas������ *ActualHeight+$
 photoCanvas��.+��� $��5(�$��Center=�$��Center=�
���  ��$��ошибка��y��� *PersonPhotoSetter.IsFaulted+ 
 bool2VisibilityConverter �� 	Converter# [
 ,  &IntellectOPK.ControlLibrary.MolserWait  $��Center=�$��Center=�$��16��$��16��$��0,0,0,0q�y��� *" PersonPhotoSetter.IsNotCompleted+# [
 (� $��81��.���� $��Center=�$��Bottom=����� *PersonPhoto+(� $��7��$
��Left=�$��Bottom=� � ToolTip$J DДанные из дополнительной базы данных��y��� *Person+# [ .���� 
������� �� Padding$ 2q�._���   DataBasePath#��[ 
��� ���� $��0��$��1��$��20,0,0,0q�$
��Left=�.+��� $ Vertical=�.+��� $��Фамилия:���� -   $��
PersonName��$��Stretch=�$��0,0,0,2q� �� TextWrapping$ NoWrap=� �� 
IsReadOnly . ����  �� Path$ Person.Name� �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=� �� ValidatesOnDataErrors . .���� $��Имя:���� -   $��Surname��$��0,0,0,2q�$ NoWrap=� . ���� $ Person.Surname�$ TwoWay=�$ PropertyChanged=� . .���� $��Отчество:���� -   $��
Patronimic��$ NoWrap=�$��0,0,0,2q� . ���� $ Person.Patronymic�$ TwoWay=�$ PropertyChanged=� . .���� $��Должность:���� -   $
��Post��$ NoWrap=�$��0,0,0,2q� . ���� $ Person.Post�$ TwoWay=�$ PropertyChanged=� . .���� $��Отдел:���� -   $��
Department��$ NoWrap=�$��0,0,0,2q� . ���� $ Person.Department�$ TwoWay=�$ PropertyChanged=� . .���� $ 
Horizontal=�$��0,4,0,0q�.+��� -   $��ID��$
 Wrap=�$��0,0,0,2q� . ���� $ 	Person.ID�$ TwoWay=�$ PropertyChanged=� . .���� $�� - ID���� $ 
Horizontal=�$��0,10,0,0q�.+��� $
��Left=�$��40��$ Экспорт фото������ *ExportPersonPhotoCommand+y��� * AppUserPermissions[ExportData]+# [ ���� $��26��$��26��  ExportPhotoViewbox#��[ �� $��5,0,0,0q�$
��Left=�$��40��$0 *Показать точки доступа������ *ShowAccessPointsViewCommand+y��� *AppUserPermissions[SeeLevels]+# [ ���� $��26��$��24��  AccessPointViewbox#��[ 9� -	   $��extendedDataExpander��$��0��$��2��$��10,0,0,0q� 9� ExpandDirection$ Right=�$	��Top=�$/ )Дополнительные данные�� 9� 
IsExpanded �� *IsExtendedMode+y��� * AppUserPermissions[SeePersons]+# [ .���  �� $	��235 ��� �� .+��� $��0��$ Vertical=�.+��� $ 
Horizontal=�$��0,0,0,2q�.+��� $ Vertical=�.+��� $$��Табельный номер:���� $��Stretch=�$
 Wrap=� . ���� $ Person.Tabnum�$ TwoWay=�$ PropertyChanged=� . .���� $ Vertical=�$��10,0,0,0q�.+��� $��Паспорт:���� $��Stretch=�$
 Wrap=� . ���� $ Person.Passport�$ TwoWay=�$ PropertyChanged=� . .���� $ Vertical=�$��10,0,0,0q�.+��� $��Комментарий:���� $��Stretch=�$
 Wrap=� . ���� $ Person.Comment�$ TwoWay=�$ PropertyChanged=� . .���� $ 
Horizontal=�.+��� $ Vertical=�.+��� $��Код:���� $��Stretch=�$
 Wrap=� . ���� $ Person.FacilityCode�$ TwoWay=�$ PropertyChanged=� . .���� $ Vertical=�$��5,0,0,0q�.+��� $��Карта:���� $��Stretch=�$
 Wrap=� . ���� $ Person.Card�$ TwoWay=�$ PropertyChanged=� . .���� $ Vertical=�$��10,0,0,0q�.+��� $
��PIN:���� $��Stretch=�$
 Wrap=� . ���� $ 
Person.Pin�$ TwoWay=�$ PropertyChanged=� . .���� $ 
Horizontal=�$��10,0,0,0q�.+��� $ Vertical=�$��0,0,0,0q�.+��� $#��Срок действия с:��(  "System.Windows.Controls.DatePicker  {�.     SelectedDate �� $ TwoWay=�$ Person.StartedAt�$ PropertyChanged=� .  �� ValidationRules 5	   /IntellectOPK.ValidationRules.DateValidationRule	  �� $ Vertical=�$��10,0,0,0q�.+��� $%��Срок действия по:��  {�.   �� $ TwoWay=�$ Person.Expired�$ PropertyChanged=� .  	  �� $ Vertical=�$��0,0,0,2q�.+��� $%��Кем выдана карта:���� $��Stretch=�$
 Wrap=� . ���� $ Person.WhoCard�$ TwoWay=�$ PropertyChanged=� . .���� $ Vertical=�$��0,0,0,2q�.+��� $#��Кто присвоил УД:���� $��Stretch=�$
 Wrap=� . ���� $ Person.WhoLevel�$ TwoWay=�$ PropertyChanged=� . .���� $ 
Horizontal=�$��0,5,0,0q�.+��� -
   $��IsLocked��$��0,0,0,0q�{�.   d� 	IsChecked �� $ Person.IsLocked�$ TwoWay=�$ PropertyChanged=� . �� $��0,0,0,0q�$!�� - Заблокирован���� $ 
Horizontal=�$��0,0,0,0q�.+��� $��0,0,0,0q�{�.   �� $ Person.IsApb�$ TwoWay=�$ PropertyChanged=� . �� $��0,0,0,0q�$5��/ - Двойной проход запрещен���� $ Vertical=�.+��� $ 
Horizontal=�$��0,0,0,0q�.+��� $��0,0,0,0q�{�.   �� $ Person.Pnet3Guard�$ TwoWay=�$ PropertyChanged=� . �� $��0,0,0,0q�$,��& - Управление охраной���� $ 
Horizontal=�$��0,0,0,0q�.+��� 
���  ��$��0,0,0,0q�{�.   �� $ Person.Pnet3Block�$ TwoWay=�$ PropertyChanged=� . �� $��0,0,0,0q�$1��+ - Проход при блокировке��� $��1��$	��Top=�$��0,0,0,2q� �� $
��auto ��� .+��� $��0��$/��)Уровни доступа отдела:���� -   $��departmentlevelsListView��$��1�� �� SelectionMode$ Single=����� *Person.DepartmentLevels+y��� *AppUserPermissions[SeeLevels]+# [   �� 
TargetType �� Property �� Value��%<   '��       �� " ��.���  � ��$ CharacterEllipsis=����� " ��  StandardListViewItem �� BasedOn# [  �� Triggers ��  �� Binding �� *Type+  �� Value  основной.a���  � ��
 � � ���  �� *Type+   дополнительный.a���  � ��
 �<����  �� *Type+
  авк.a���  � ��
 ��  �! �� View! �� P��� $��Название��" �� DisplayMemberBinding" �� $
 Name��� $��Описание��" �� $ Description�� $��2��$	��Top=�$��0,0,0,2q� �� $
��auto ��� .+��� $��0��$7��1Уровни доступа сотрудника:���� -   $��levelsListView��$��1��$ Single=����� *Person.Levels+y��� *AppUserPermissions[SeeLevels]+# [  ��%<   '��       �� " ��.���  � ��$ CharacterEllipsis=����� " ��# [  ��  �� *Type+  основной.a���  � ��
 � � ���  �� *Type+   дополнительный.a���  � ��
 �<����  �� *Type+
  авк.a���  � ��
 ��  �! �� P��� $��Название��" �� $
 Name��� $��Описание��" �� $ Description�9� -   $��historyExpander��$��0��$��3��$��10,0,0,0q�$ Right=� .  $' !История изменений��y�`� # `� 	Converter## [ .1��� $* $AppUserPermissions[SeePersonHistory]��� $ IsPersonHistoryAvailable�.���  �� $
��auto ��� .+��� $��0��$(��"История изменений:���� -   $��personHistoryListView��$��1��$ Single=����� *	Persons+$ �� SelectedItem$ �� *Person+$ TwoWay=�! �� P��� $��Начало��" �� $ 	ValidFrom�# [ �� $��Окончание��" �� $ ValidTo�# [ 