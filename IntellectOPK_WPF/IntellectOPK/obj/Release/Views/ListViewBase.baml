   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.0.12, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  =#clr-namespace:IntellectOPK.CommandsIntellectOPK.Commands  %    IntellectOPK.Views.ListViewBase   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     8commands#clr-namespace:IntellectOPK.Commands     $	��630��  � SizeToContent$  Width=�   VS2012WindowStyle#��[   � 
ResizeMode$ CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter@  :IntellectOPK.Converters.BoolToUIVisibilityInverseConverter & "boolToUIVisibilityInverseConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter>  8IntellectOPK.Converters.BoolToUIVisibilityMultiConverter $  boolToUIVisibilityMultiConverter1   +IntellectOPK.Converters.AsyncImageConverter  asyncImageConverter=   7IntellectOPK.Converters.DataBaseIconVisibilityConverter # dataBaseIconVisibilityConverter1  +IntellectOPK.Converters.NullToBoolConverter  nullToBoolConverter>   8IntellectOPK.Converters.BoolToHeadersVisibilityConverter $	  boolToHeadersVisibilityConverter5	   /IntellectOPK.Converters.ObjectToObjectConverter 
 objectToObjectConverter��%�   &	       &	      &	 
     &	      &	      &	      &	      &	 #     &		 (     &	
 -     ��                 	   J� CommandBindings )
  #System.Windows.Input.CommandBinding
  -    
  Command$" commands:CustomCommands.Find��.��� $��
15,0,15,10q�$	��Top=� � RowDefinitions �� $��24 ��� $��* ��� $
��auto � � ColumnDefinitions �� .+��� $��0�� �� Orientation$ 
Horizontal=�.+��� -   	 ��Name$	 uncheckAllButton��$��0,0,10,0q�
 � ToolTip$1
 +Снять выделение со всех��$��32��y��� *IsSelectableMode+  bool2VisibilityConverter �� 	Converter# [ ����  �� 
TargetType" ��  UncheckButton �� BasedOn# [ d� -    d�Name$ showOnlyCheckedButton��$8
 2Показать только выделенные��$��32��$��0,0,10,0q�y��� *IsSelectableMode+# [ ���� " d�  ShowCheckedButton# [ �� $��Отдел:��$��Center=�$��0,0,10,0q��� -    ��Name$ filterListComboBox��$��24��$��80��$��Stretch=� �� SelectedIndex$ 0��$��0,0,10,0q�$��Center=����� *Departments+ �� SelectedItem �� *FilterListValue+�� $��0,0,10,0q�$ 
Horizontal=�{��� *	Persons+# [ .+�� .+��� -    ��Name$ findTextBox��$��0��$��0��$��80��$��24��$��Stretch=�$��Center=�$
 
Найти�� �� TextWrapping$
 Wrap=����� *FilterFindValue+ �� UpdateSourceTrigger$ PropertyChanged=�.�� J� InputBindings �� 
 �� Key$ Enter�� �� Command$" commands:CustomCommands.Find��.���� $��0��$��0�� J� IsHitTestVisible .  $��Найти...��$
��Left=�$��Center=�$��5,0,0,0q�
����������� " ��.���  �� Property � y� �� Value$ 	Collapsed=� �� Triggers ��  �� Binding ��  �� Path$
 Text� �� ElementName$ PersonsFindTextBox�� �� Value  .a���  � y�$ Visible=��� $��Right=�$��24��$��30��$��0,0,0,0q�$
 
Поиск��$"��commands:CustomCommands.Find��  
FindCanvas#��[ �� $��32��$.
 (Экспортировать в MS Excel��  ^� ShowOnDisabled  .   MsExcelCanvas#��[ ���� *ExportToMSExcelCommand+y��� *IsExportEnable+# [ � $��1�� ��  �� .+�� -   $��dummyElement��$y�	Collapsed=�&   System.Windows.Controls.DataGrid  -   !  Name$! itemsDataGrig��$��0��$��0,5,0,0q�$��Stretch=�$	��Top=�"   AutoGenerateColumns" .  #   GridLinesVisibility$# 
Horizontal=�  DataGridLinesBrush$   HorizontalGridLinesBrush#$ [ %   CanUserResizeRows% .  &   CanUserAddRows& .  '   SelectionMode$' Single=�(   EnableRowVirtualization( . !)   EnableColumnVirtualization) . * %� IsVirtualizing* . + %� VirtualizationMode$+ 	Recycling=�, �� IsTextSearchEnabled, . - w� TextPath$
- Name��.   	RowHeight$. 80Q����� *Items+/ �� NotifyOnTargetUpdated/ .  �� *SelectedItem+y��� *Items+# [ 0   HeadersVisibility0 �� *IsSelectableMode+1 �� Mode$1 OneWay=�# [	 2   Columns2 4  .System.Windows.Controls.DataGridTemplateColumn  ,  &System.Windows.Controls.DataGridColumn3   Header$3 
Выбор��4   
IsReadOnly4 .  5   CanUserSort5 . 6   SortMemberPath$6 	IsChecked��7   
Visibility7 �� *DataContext.IsSelectableMode+8 �� Source8 %  System.Windows.Markup.Reference  *dummyElement+# [ 9   CellTemplate9 �� .R��  �� $
��auto �.+��� $��0��$��0,0,0,0q�$��24��$��24��$��Center=�$��Center=�  ScaledCheckBox#��[ : d� 	IsChecked: �� $ 	IsChecked�$ PropertyChanged=�  $3 Фото��4 . ;   Width5  /System.Windows.Controls.DataGridLengthConverter$; 80 <   MinWidth$< 80Q�9 �� .R�� .+�� = � DataContext= �� $ DataContext�> �� RelativeSource> �� *FindAncestor+? �� AncestorType"? �# [ .+�(� $��60��$��Center=�$��Bottom=�.����   
PersonPath#��[   PersonPathBrush#��[ �� $��Center=�$��Center=�
�������$��загрузка...��y��� *IsNotCompleted+# [ �� $��Center=�$��Center=�
���  ��$��ошибка��y��� *	IsFaulted+# [ �� $��Center=�$��Bottom=����� *Result+(� $��14��$
��Left=�$��Bottom=�$J
 DДанные из дополнительной базы данных��y��� # [ .���� 
�������@ �� Padding$@ 7q�._���   DataBasePath#��[ 
��� ���  $3 Данные��5 . $
6 Name��9 �� .R�� .+��� $ Vertical=�$
��Left=�.+��� A ��Name$A content������ $
 Name��� ���� $ Surname��� ���� $ 
Patronymic��� $��Italic$����� $ 
Department��� $	 personInfoButton��$��0,0,10,0q�$y�	Collapsed=�  DataGridSelectedCellBrush#��[ $��Right=�$	��Top=�$��22��$��22��$+
 %Показать сотрудника��  InfoViewbox#��[ ���� *#!DataContext.ShowPersonViewCommand+> �� *FindAncestor+"?  B �� TriggersB �� $
 True�� �� *
IsSelected+> �� *FindAncestor+*  $System.Windows.Controls.DataGridCell"?  .a��� C �� 
TargetName$C personInfoButton�� � y�$ Visible=�0  *System.Windows.Controls.DataGridTextColumn  $3 ID��4 . 1  +System.Windows.Controls.DataGridBoundColumnD   BindingD �� $ ID�E � ContextMenuE �� .@�m� $*��$Показать сотрудникa��F m� CommandF �� *ShowPersonViewCommand+m� $��Копировать��$
F Copy�� d� G d� Gesture$G LeftDoubleClicka� �� *ShowPersonViewCommand+�� -   $��rowsCountStackPanel��$��2��$ 
Horizontal=�$��Center=�y��� *IsSelectableMode+$1 OneWay=�# [ .+��� $+��%Количество записей: ���� -	   $��rowsCountTextBox���� $��2��$��0,5,0,0q�$ 
Horizontal=�$��Right=�.+��� $��26��$��60��$
��Left=�$��OK��H �� 	IsDefaultH . ���� *ConfirmCommand+�� -
   $
��Left=�I �� IsCancelI . $��Отмена��$��10,0,0,0q�$��26��$��60��