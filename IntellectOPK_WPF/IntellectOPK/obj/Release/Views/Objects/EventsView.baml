   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.0.12, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  =#clr-namespace:IntellectOPK.CommandsIntellectOPK.Commands  #    IntellectOPK.Views.EventsView   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     8commands#clr-namespace:IntellectOPK.Commands     $	��640��$	��500��   VS2012WindowStyle#��[    � 
ResizeMode$  CanResizeWithGrip=� � Title �� *Title+ J� CommandBindings )  #System.Windows.Input.CommandBinding  -      Command$" commands:CustomCommands.Find�� � 	Resources   boolToUIVisibilityConverter@  :IntellectOPK.Converters.BoolToUIVisibilityInverseConverter % !boolToUIVisibilityInvertConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter1  +IntellectOPK.Converters.NullToBoolConverter  nullToBoolConverter��%K   &	       &	      &	 
     &	      &	      ��         .��� $��
15,0,15,10q�$	��Top=� � RowDefinitions �� $��24 ��� $��* ��� $
��auto � � ColumnDefinitions �� .+��� $��0�� �� Orientation$ 
Horizontal=�.+��� -    ��Name$ uncheckAllButton��$��0,0,10,0q�	 � ToolTip$1	 +Снять выделение со всех��$��32��y��� *IsSelectableMode+  bool2VisibilityConverter
 �� 	Converter#
 [ ����  �� 
TargetType" ��  UncheckButton �� BasedOn# [ d� -    d�Name$ showOnlyCheckedButton��$8	 2Показать только выделенные��$��32��$��0,0,10,0q����� " d�  ShowCheckedButton# [ �� $��0,0,0,0q�$ 
Horizontal=�{��� *Events+#
 [ .+�� .+��� -    ��Name$ FindTextBox��$��0��$��0��$	��170��$��24��$��Stretch=�$��Center=�$	 
Найти��.�� J� InputBindings �� 
 �� Key$ Enter�� �� Command$" commands:CustomCommands.Find��.���� $��0��$��0�� J� IsHitTestVisible .  $��Найти...��$
��Left=�$��Center=�$��5,0,0,0q�
����������� " ��.���  �� Property � y� �� Value$ 	Collapsed=� �� Triggers ��  �� Binding ��  �� Path$
 Text� �� ElementName$ EventsFindTextBox�� �� Value  .a���  � y�$ Visible=��� $��Right=�$��24��$��30��$��0,0,0,0q�$	 
Поиск��$"��commands:CustomCommands.Find�� 	 
FindCanvas#��[	 � $��1�� ��  �� .+�� -   $��dummyElement��$y�	Collapsed=�&   System.Windows.Controls.DataGrid  -     Name$ eventsDataGrid��$��0��$��0,5,0,0q�$��Stretch=�$	��Top=�   AutoGenerateColumns .     GridLinesVisibility$ 
Horizontal=� 
 DataGridLinesBrush   HorizontalGridLinesBrush# [
    CanUserResizeRows .     CanUserAddRows .      HeadersVisibility$	  All=�!   SelectionMode$! Single=�"   EnableRowVirtualization" . !#   EnableColumnVirtualization# . $ %� VirtualizationMode$$ 	Recycling=�% �� IsTextSearchEnabled% . & w� TextPath$
& Name������ *Events+' �� NotifyOnTargetUpdated' . y��� *Events+#
 [ (   Columns( 4  .System.Windows.Controls.DataGridTemplateColumn  ,  &System.Windows.Controls.DataGridColumn)   Header$) 
Выбор��*   
IsReadOnly* .  +   CanUserSort+ . ,   SortMemberPath$, 	IsChecked��-   HeaderTemplate- �� .R�� .+��� $	 Выбрать все��$
��Left=�. d� 	IsChecked. �� *'%DataContext.AllEventsCheckedUnchecked+/ �� Mode$/ TwoWay=�0 �� RelativeSource0 �� 1 �� AncestorType$1 WindowL�2 �� UpdateSourceTrigger$2 PropertyChanged=�3   CellTemplate3 �� .R�� .+��� $��Center=�$��4,0,4,0q�. �� $ 	IsChecked�$2 PropertyChanged=�0	  *System.Windows.Controls.DataGridTextColumn	  $) Название��* . 4   Width5
  /System.Windows.Controls.DataGridLengthConverter$4 *
 1  +System.Windows.Controls.DataGridBoundColumn5   Binding5 �� $ Description�6   ElementStyle6 �� " ��.���  � ��$ CharacterEllipsis=��� -   $��rowsCountStackPanel��$��2��$ 
Horizontal=�$��Center=�.+��� $+��%Количество записей: ���� -   $��rowsCountTextBox���� $��2��$��0,5,0,0q�$ 
Horizontal=�$��Right=�.+��� $��26��$��60��$
��Left=�$��OK��7 �� 	IsDefault7 . ���� *ConfirmCommand+�� -	   $
��Left=�8 �� IsCancel8 . $��Отмена��$��10,0,0,0q�$��26��$��60��