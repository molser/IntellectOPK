   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.0.12, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  =#clr-namespace:IntellectOPK.CommandsIntellectOPK.Commands  #    IntellectOPK.Views.LevelsView   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     8commands#clr-namespace:IntellectOPK.Commands     $	��640��$	��540��   VS2012WindowStyle#��[    � 
ResizeMode$  CanResizeWithGrip=� � Title �� *Title+ J� CommandBindings )  #System.Windows.Input.CommandBinding  -      Command$" commands:CustomCommands.Find�� � 	Resources   boolToUIVisibilityConverter@  :IntellectOPK.Converters.BoolToUIVisibilityInverseConverter % !boolToUIVisibilityInvertConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter1  +IntellectOPK.Converters.NullToBoolConverter  nullToBoolConverter��%K   &	       &	      &	 
     &	      &	      ��         .��� $��
15,0,15,10q�$	��Top=� � RowDefinitions �� $��24 ��� $��* ��� $
��auto � � ColumnDefinitions �� .+��� $��0�� �� Orientation$ 
Horizontal=�.+�d� -    d�Name$ showOnlyCheckedButton��	 � ToolTip$8	 2Показать только выделенные��$��32��$��0,0,10,0q�y��� *IsSelectableMode+  bool2VisibilityConverter
 �� 	Converter#
 [ .���� $��15��$��15�� �� CornerRadius$ 0��  NormalBrush#��[ $��1q�  NormalBorderBrush#��[ ._�F� $��9��$��9�� J� SnapsToDevicePixels .   	 
GlyphBrush#��[	 $��2��"����     	= � 	=  z �@T�     	�� $��0,0,0,0q�$ 
Horizontal=�{��� *Events+#
 [ .+�� .+��� -    ��Name$ FindTextBox��$��0��$��0��$	��170��$��24��$��Stretch=�$��Center=�$	 
Найти��.�� J� InputBindings �� 
 �� Key$ Enter�� �� Command$" commands:CustomCommands.Find��.���� $��0��$��0�� J� IsHitTestVisible .  $��Найти...��$
��Left=�$��Center=�$��5,0,0,0q�
�����������  �� 
TargetType" ��.���  �� Property � y� �� Value$ 	Collapsed=� �� Triggers ��  �� Binding ��  �� Path$
 Text� �� ElementName$ EventsFindTextBox�� �� Value  .a���  � y�$ Visible=��� $��Right=�$��24��$��30��$��0,0,0,0q�$	 
Поиск��$"��commands:CustomCommands.Find�� 
 
FindCanvas#��[
 � $��1�� ��  �� .+�� -   $��dummyElement��$y�	Collapsed=�&   System.Windows.Controls.DataGrid  -     Name$ levelsDataGrid��$��0��$��0,5,0,0q�$��Stretch=�$	��Top=�   AutoGenerateColumns .     GridLinesVisibility$ 
Horizontal=�  DataGridLinesBrush   HorizontalGridLinesBrush# [    CanUserResizeRows .     CanUserAddRows .      HeadersVisibility$	  All=�!   SelectionMode$! Single=�"   EnableRowVirtualization" . !#   EnableColumnVirtualization# . $ %� VirtualizationMode$$ 	Recycling=�% �� IsTextSearchEnabled% . & w� TextPath$
& Name������ *Levels+' �� NotifyOnTargetUpdated' . y��� *Levels+#
 [ (   Columns( 4  .System.Windows.Controls.DataGridTemplateColumn  ,  &System.Windows.Controls.DataGridColumn)   Header$) 
Выбор��*   
IsReadOnly* .  +   CanUserSort+ . ,   SortMemberPath$, 	IsChecked��-   
Visibility- �� *DataContext.IsSelectableMode+. �� Source. %	  System.Windows.Markup.Reference	  *dummyElement+#
 [ /   HeaderTemplate/ �� .R�� .+��� $	 Выбрать все��$
��Left=�0 d� 	IsChecked0 �� *-+DataContext.AllAccessPointsCheckedUnchecked+1 �� Mode$1 TwoWay=�2 �� RelativeSource2 �� 3 �� AncestorType$3 WindowL�4 �� UpdateSourceTrigger$4 PropertyChanged=�5   CellTemplate5 �� .R�� .+��� $��Center=�$��4,0,4,0q�0 �� $ 	IsChecked�$4 PropertyChanged=�0
  *System.Windows.Controls.DataGridTextColumn
  $) Название��* . 1  +System.Windows.Controls.DataGridBoundColumn6   Binding6 �� $
 Name�7   ElementStyle7 �� " ��.���  � ��$ CharacterEllipsis=�
  $) Описание��* . 8   Width5  /System.Windows.Controls.DataGridLengthConverter$8 * 6 �� $ Description�7 �� " ��.���  � ��$ CharacterEllipsis=�9   	CellStyle9 �� *  $System.Windows.Controls.DataGridCell"    StandardDataGridCell: �� BasedOn#: [  ��  �� *Type+ основной.a���  � ��
 � � ���  �� *Type+  дополнительный.a���  � ��
 �<����  �� *Type+
 авк.a���  � ��
 ��  ��� -   $��rowsCountStackPanel��$��2��$ 
Horizontal=�$��Center=�.+��� $+��%Количество записей: ���� -   $��rowsCountTextBox���� $��2��$��0,5,0,0q�$ 
Horizontal=�$��Right=�.+��� $��26��$��60��$
��Left=�$��OK��; �� 	IsDefault; . ���� *ConfirmCommand+�� -   $
��Left=�< �� IsCancel< . $��Отмена��$��10,0,0,0q�$��26��$��60��