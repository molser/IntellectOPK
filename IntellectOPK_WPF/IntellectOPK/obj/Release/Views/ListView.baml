   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  I EMolserControls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG4clr-namespace:MolserControls;assembly=MolserControlsMolserControls A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  O,clr-namespace:IntellectOPK.TemplateSelectorsIntellectOPK.TemplateSelectors  =#clr-namespace:IntellectOPK.CommandsIntellectOPK.Commands  !    IntellectOPK.Views.ListView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     Gmolser4clr-namespace:MolserControls;assembly=MolserControls     6conv%clr-namespace:IntellectOPK.Converters     JtemplateSelectors,clr-namespace:IntellectOPK.TemplateSelectors     8commands#clr-namespace:IntellectOPK.Commands     $
��1920��$
��1080��$	��640��$	��550��  � SizeToContent$  Manual=�   VS2012WindowStyle#��[   � 
ResizeMode$ CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter@  :IntellectOPK.Converters.BoolToUIVisibilityInverseConverter & "boolToUIVisibilityInverseConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter>  8IntellectOPK.Converters.BoolToUIVisibilityMultiConverter $  boolToUIVisibilityMultiConverter1   +IntellectOPK.Converters.AsyncImageConverter  asyncImageConverter=   7IntellectOPK.Converters.DataBaseIconVisibilityConverter # dataBaseIconVisibilityConverter1  +IntellectOPK.Converters.NullToBoolConverter  nullToBoolConverter>   8IntellectOPK.Converters.BoolToHeadersVisibilityConverter $	  boolToHeadersVisibilityConverter��%�   &	       &	      &	 
     &	      &	      &	      &	      &	 #     &		 (     ��                  J� CommandBindings )	  #System.Windows.Input.CommandBinding	  -    	  Command$" commands:CustomCommands.Find��	  -   $( "commands:CustomCommands.FindCancel��.��� $��
15,0,15,10q�$	��Top=� � RowDefinitions �� $��30 ��� $��* ��� $
��auto � � ColumnDefinitions �� .+�c� $��0��.@�d� -    d�Name$ showOnlyCheckedButton��$��32��$��0,0,10,0q�	 d� 	IsChecked	 �� *IsOnlyCheckedShowed+y��� *IsSelectableMode+ 
 bool2VisibilityConverter
 �� 	Converter#
 [
 .���� $��0q�
������  �� Padding$ 2q�._���   FilterOnlyCheckedViewbox#��[ ����  �� 
TargetType" d�  ToolBarButtonBaseStyle �� BasedOn# [ .���  �� Property �@�ToolTip �� Value$8 2Показать только выделенные�� �� Triggers P�  P� Property �@d�	IsChecked P� Value$
 TrueY�. ���  �@�ToolTip$8 2Показаны только выделенные��� .+�
  MolserControls.MsTextBox
  -    
 Name$ findTextBox��$��0,0,20,0q�$��0��$��0��$	��160��$��Stretch=�$��Center=� � ToolTip$ 
Найти�� �� TextWrapping$
 Wrap=� 
  	Watermark$ Найти...������ *FilterFindValue+ �� UpdateSourceTrigger$ PropertyChanged=�.�� J� InputBindings �� 
 �� Key$ Enter�� �� Command$" commands:CustomCommands.Find��.���� $��10,0,0,0q� �� Orientation$ 
Horizontal=�y��� *IsFilterListEnable+ �� Mode$ OneWay=�#
 [ .+��� $��Отдел:��$��Center=�$��0,0,10,0q��� -    ��Name$ filterListComboBox��$��80��$��Stretch=� �� SelectedIndex$ 0��$��0,0,10,0q�$��Center=����� *Departments+ �� SelectedItem �� *FilterListValue+�� $��32��$. (Экспортировать в MS Excel��  ^� ShowOnDisabled  .   MsExcelCanvas#��[ ���� *ExportToMSExcelCommand+y��� *IsExportEnable+#
 [ � $��1�� ��  �� .+�� -   $��dummyElement��$y�	Collapsed=��� -   ! ��Name$! dummyCheckAllCheckBox��$y�	Collapsed=�&   System.Windows.Controls.DataGrid  -   "  Name$" itemsDataGrig��$��0��$��0,5,0,0q�$��Stretch=�$	��Top=�#   AutoGenerateColumns# .  $   GridLinesVisibility$$ 
Horizontal=�  DataGridLinesBrush%   HorizontalGridLinesBrush#% [ &   CanUserResizeRows& .  '   CanUserAddRows' .  (   SelectionMode$( Single=�)   EnableRowVirtualization) . !*   EnableColumnVirtualization* . + %� VirtualizationMode$+ 	Recycling=�$
��1920��$
��1080��, �� IsTextSearchEnabled, . - w� TextPath$
- Name��.   
IsReadOnly. . ���� *Items+/ �� NotifyOnTargetUpdated/ .  �� *SelectedItem+y��� *Items+#
 [ 0   HeadersVisibility0 �� *IsStatisticsHidden+$ OneWay=�#
 [	   # StandardCheckedCellDataTemplate1 �� Path2 �� IsAsync ! PersonCheckedCellDataTemplate��%@  &	       &	 �     �� .R��  �� $
��auto �.+��� $��0��$��0,0,0,0q�$
��Left=�$��Center=�	 �� $1 	IsChecked�2 . $ PropertyChanged=��� .R��  �� $
��auto �.+��� $��0��$��0,0,0,0q�$��18��$��18��$
��Left=�$��Center=�	 �� $1 	IsChecked�2 . $ PropertyChanged=�3   Columns3 4  .System.Windows.Controls.DataGridTemplateColumn  ,  &System.Windows.Controls.DataGridColumn4   Header$4  ��5   
IsReadOnly5 .  6   CanUserSort6 . 7   SortMemberPath$7 	IsChecked��8   
Visibility8 �� *DataContext.IsSelectableMode+9 �� Source9 %  System.Windows.Markup.Reference  *dummyElement+#
 [ :   HeaderTemplate: �� .R�� $��0,0,0,0q�.+��� $! checkAllCheckBox��-	   $
��Left=�	 �� *	IsChecked+; �� ElementName$; dummyCheckAllCheckBox������ " ��  StandardCheckBox# [ .���  �@�ToolTip$ Выбрать все�� P�  �@d�	IsChecked$
 TrueY�. ���  �@�ToolTip$1 +Снять выделение со всех��<   CellTemplateSelector< @  :IntellectOPK.TemplateSelectors.CheckedCellTemplateSelector  &=   StandardCheckedCellDataTemplate#= [ $>   PersonCheckedCellDataTemplate#> [   $4 Фото��5 . ?   Width5  /System.Windows.Controls.DataGridLengthConverter$? 60 @   MinWidth$@ 60Q�8 �� *)'DataContext.ItemProperties[PersonPhoto]+9   *dummyElement+#
 [ A   CellTemplateA �� .R�� B � DataContextB �� $1 DataContext�C �� RelativeSourceC �� *FindAncestor+D �� AncestorType"D �#
 [ .+�(� .����   
PersonPath#��[   PersonPathBrush#��[ ���� " (�.���  � y�$ Hidden=� �� E �� BindingE �� *Result+F �� ValueF Z� .a���  � y�$ Visible=�(� .���� $��Center=�$��Center=�
�������$��загрузка...��y��� *IsNotCompleted+#
 [
 (� .���� $��Center=�$��Center=�
���  ��$��ошибка��y��� *	IsFaulted+#
 [
 �� G ��Name$G PersonPhoto��$��Center=�$��Bottom=����� *Result+(� $��14��$
��Left=�$��Bottom=�$J DДанные из дополнительной базы данных��y��� #
 [ .���� 
�������$ 7q�._���   DataBasePath#��[ 
��� ���  $4 Данные��6 . $
7 Name��8 �� *(&DataContext.ItemProperties[PersonData]+9   *dummyElement+#
 [ A �� .R�� .+��� $ Vertical=�$
��Left=�.+��� H ��Name$H content������ $
1 Name�2 .  �� ���� $1 Surname�2 .  �� ���� $1 
Patronymic�2 .  �� $��Italic$����� $1 
Department�2 .  �� I ��Name$I personInfoButton��$��0,0,10,0q�$y�	Collapsed=�  DataGridSelectedCellBrush#��[ $��Right=�$	��Top=�$��22��$��22��$+ %Показать сотрудника��  InfoViewbox#��[ ���� *#!DataContext.ShowPersonViewCommand+C �� *FindAncestor+"D  J �� TriggersJ �� $
F True��E �� *
IsSelected+C �� *FindAncestor+*  $System.Windows.Controls.DataGridCell"D  .a��� K �� 
TargetName$K personInfoButton�� � y�$ Visible=�0  *System.Windows.Controls.DataGridTextColumn  $4 Название��5 . 1  +System.Windows.Controls.DataGridBoundColumnL   BindingL �� $
1 Name�2 .  8 �� *" DataContext.ItemProperties[Name]+9   *dummyElement+#
 [ M   ElementStyleM �� " ��.���  � ��$ CharacterEllipsis=�  $4 Описание��5 . L �� $1 Description�2 .  8 �� *)'DataContext.ItemProperties[Description]+9   *dummyElement+#
 [ M �� " ��.���  � ��$ CharacterEllipsis=�  $4 ID��5 . L �� $1 Id�2 .  N   	CellStyleN �� "    StandardDataGridCell# [  �� E �� *Type+2 .  F основной.a���  � ��
 � � ��� E �� *Type+2 .   F дополнительный.a���  � ��
 �<���� E �� *Type+2 .  
F авк.a���  � ��
 ��  �O � ContextMenuO �� .@�m� $*��$Показать сотрудникa��P m� CommandP �� *ShowPersonViewCommand+m� $��Копировать��$
P Copy�� d� Q d� Gesture$Q LeftDoubleClicka� �� *ShowPersonViewCommand+� $��2��$��0,5,0,0q� �� $
��auto ��� .+��� $��0��$��10,0,0,0q�$ 
Horizontal=�$	��Top=�y�`� R `� Mode$R OneWay=�S `� 	Converter#S [ .1��� $ OneWay=�$1 IsSelectableMode��� $ OneWay=�$1 IsStatisticsHidden�#
 [ .+��� $��Выбрано: ���� ���� *SelectedItemsCount+�� -
   $��rowsCountStackPanel��$��5,0,0,0q�$��1��$ 
Horizontal=�$	��Top=�y��� *IsStatisticsHidden+$ OneWay=�#
 [ .+��� $��Показано: ���� -   $��rowsCountTextBox������ $1 Items.Count�$; itemsDataGrig���� $��5,0,0,0q�$��Всего: ���� ���� *Items.Count+�� $��2��$��0,5,0,0q�$ 
Horizontal=�$��Right=�$	��Top=�.+��� $��26��$��60��$
��Left=�$��OK��T �� 	IsDefaultT . ���� *ConfirmCommand+�� -   $
��Left=�U �� IsCancelU . $��Отмена��$��10,0,0,0q�$��26��$��60��