   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.0.12, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  =#clr-namespace:IntellectOPK.CommandsIntellectOPK.Commands  )    #IntellectOPK.Views.AccessPointsView   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     8commands#clr-namespace:IntellectOPK.Commands     $	��640��$	��560��   VS2012WindowStyle#��[    � 
ResizeMode$  CanResizeWithGrip=� � Title �� *Title+ J� CommandBindings )  #System.Windows.Input.CommandBinding  -      Command$" commands:CustomCommands.Find�� � 	Resources   boolToUIVisibilityConverter@  :IntellectOPK.Converters.BoolToUIVisibilityInverseConverter % !boolToUIVisibilityInvertConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter1  +IntellectOPK.Converters.NullToBoolConverter  nullToBoolConverter��%K   &	       &	      &	 
     &	      &	      ��         .��� $��
15,0,15,10q�$	��Top=� � RowDefinitions �� $��24 ��� $��* ��� $
��auto � � ColumnDefinitions �� .+��� $��0�� �� Orientation$ 
Horizontal=�.+��� -    ��Name$ uncheckAllButton��$��0,0,10,0q�	 � ToolTip$1	 +Снять выделение со всех��$��32��y��� *IsSelectableMode+  bool2VisibilityConverter
 �� 	Converter#
 [ ����  �� 
TargetType" ��  UncheckButton �� BasedOn# [ d� -    d�Name$ showOnlyCheckedButton��$8	 2Показать только выделенные��$��32��$��0,0,10,0q�y��� *IsSelectableMode+#
 [ .���� $��15��$��15�� �� CornerRadius$ 0��  NormalBrush#��[ $��1q� 	 NormalBorderBrush#��[	 ._�F� $��9��$��9�� J� SnapsToDevicePixels .   
 
GlyphBrush#��[
 $��2��"����     	= � 	=  z �@T�     	�� $��0,0,10,0q�$ 
Horizontal=�{��� *AccessPoints+#
 [ .+�� .+��� -    ��Name$ FindTextBox��$��0��$��0��$	��170��$��24��$��Stretch=�$��Center=�$	 
Найти��.�� J� InputBindings �� 
 �� Key$ Enter�� �� Command$" commands:CustomCommands.Find��.���� $��0��$��0�� J� IsHitTestVisible .  $��Найти...��$
��Left=�$��Center=�$��5,0,0,0q�
����������� " ��.���  �� Property � y� �� Value$ 	Collapsed=� �� Triggers ��  �� Binding ��  �� Path$
 Text� �� ElementName$ FindTextBox�� �� Value  .a���  � y�$ Visible=��� $��Right=�$��24��$��30��$��0,0,10,0q�$	 
Поиск��$"��commands:CustomCommands.Find��  
FindCanvas#��[ �� $��32��$.	 (Экспортировать в MS Excel�� ^� ShowOnDisabled .   MsExcelCanvas#��[ ���� *ExportToMSExcelCommand+y��� *IsExportEnable+#
 [ � $��1�� ��  �� .+�� -   $��dummyElement��$y�	Collapsed=�&   System.Windows.Controls.DataGrid  -     Name$ accessPointsDataGrid��$��0��$��0,5,0,0q�$��Stretch=�$	��Top=�   AutoGenerateColumns .     GridLinesVisibility$ 
Horizontal=�  DataGridLinesBrush    HorizontalGridLinesBrush#  [ !   CanUserResizeRows! .  "   CanUserAddRows" .  #   HeadersVisibility$	# All=�$   SelectionMode$$ Single=�%   EnableRowVirtualization% . !&   EnableColumnVirtualization& . ' %� VirtualizationMode$' 	Recycling=�( �� IsTextSearchEnabled( . ) w� TextPath$
) Name������ *AccessPoints+* �� NotifyOnTargetUpdated* . y��� *AccessPoints+#
 [ +   Columns+ 4  .System.Windows.Controls.DataGridTemplateColumn  ,  &System.Windows.Controls.DataGridColumn,   Header$, 
Выбор��-   
IsReadOnly- .  .   CanUserSort. . /   SortMemberPath$/ 	IsChecked��0   
Visibility0 �� *DataContext.IsSelectableMode+1 �� Source1 %	  System.Windows.Markup.Reference	  *dummyElement+#
 [ 2   HeaderTemplate2 �� .R�� .+��� $	 Выбрать все��$
��Left=�3 d� 	IsChecked3 �� *-+DataContext.AllAccessPointsCheckedUnchecked+4 �� Mode$4 TwoWay=�5 �� RelativeSource5 �� 6 �� AncestorType$6 WindowL�7 �� UpdateSourceTrigger$7 PropertyChanged=�8   CellTemplate8 �� .R�� .+��� $��Center=�$��4,0,4,0q�3 �� $ 	IsChecked�$7 PropertyChanged=�0
  *System.Windows.Controls.DataGridTextColumn
  $, Название��- . 1  +System.Windows.Controls.DataGridBoundColumn9   Binding9 �� $
 Name�:   ElementStyle: �� " ��.���  � ��$ CharacterEllipsis=�
  $, ID��- . ;   Width5  /System.Windows.Controls.DataGridLengthConverter$; * 9 �� $ ID��� -   $��rowsCountStackPanel��$��2��$ 
Horizontal=�$��Center=�.+��� $+��%Количество записей: ���� -   $��rowsCountTextBox���� $��2��$��0,5,0,0q�$ 
Horizontal=�$��Right=�.+��� $��26��$��60��$
��Left=�$��OK��< �� 	IsDefault< . ���� *ConfirmCommand+�� -	   $
��Left=�= �� IsCancel= . $��Отмена��$��10,0,0,0q�$��26��$��60��