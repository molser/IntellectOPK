   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  !    IntellectOPK.Views.RoleView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     $	��450��$	��600��  � SizeToContent$  Width=�   VS2012WindowStyle#��[   � 
ResizeMode$ CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter��%-   &	       &	      &	 
     ��     .��]� .+��� $��Bottom=�$��
0,10,15,15q� �� Orientation$ 
Horizontal=�$��Right=�$��Bottom=�.+��� $��26��$��60��$	��Top=�$
��Left=�$��OK�� �� 	IsDefault . ���� *ConfirmCommand+�� $	��Top=�$
��Left=� �� IsCancel . $��Отмена��$��10,0,0,0q�$��26��$��60��� $��	15,0,15,0q�$	��Top=� � RowDefinitions �� ��  � ColumnDefinitions �� .+�� $��0��$��1�� �� $
��auto ���  �� .+��� $��0��$��0��$��Права группы:��&   System.Windows.Controls.DataGrid  -   	  Name$	 RolePermissions��$��1��$��0,5,0,0q�$
��Left=�$	��Top=�
   AutoGenerateColumns
 .     GridLinesVisibility$ 
Horizontal=�  DataGridLinesBrush   HorizontalGridLinesBrush# [    CanUserResizeRows .     CanUserAddRows .     HeadersVisibility$ Column=�   SelectionMode$ Single=����� *RolePermissions+y��� *RolePermissions+ �� 	Converter# [    Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ 
Право��   
IsReadOnly . 1  +System.Windows.Controls.DataGridBoundColumn   Binding ��  �� Path$ Description�   ElementStyle ��  �� 
TargetType" ��.���  �� Property � �� �� Value$ CharacterEllipsis=�4  .System.Windows.Controls.DataGridTemplateColumn   .     CanUserSort .    SortMemberPath$ 	IsChecked��   CellTemplate �� .R�� .+��� $
��Left=�$��4,0,4,0q� d� 	IsChecked �� $ 	IsChecked� �� UpdateSourceTrigger$ PropertyChanged=�{��� *75DataContext.AppUserPermissions[ManageRolePermissions]+  �� RelativeSource  �� ! �� AncestorType$! WindowL�"   HeaderTemplate" �� .R�� .+��� # � ToolTip$# Выбрать все��$
��Left=� �� *0.DataContext.AllRolePermissionsCheckedUnchecked+$ �� Mode$$ TwoWay=�  �� $! WindowL�$ PropertyChanged=�{��� *75DataContext.AppUserPermissions[ManageRolePermissions]+  �� $! WindowL�� $��1��$��0��$��0,15,0,0q� �� $
��auto ���  �� .+��� $��0��$,��&Пользователи группы:��  -   $	 	RoleUsers��$��1��$��0,5,0,0q�$
��Left=�$	��Top=�
 .  $ 
Horizontal=�# [  .   .  $	 All=�$ Single=����� *	RoleUsers+y��� *	RoleUsers+# [    $ 
Логин�� .  �� $ Login�  $ Имя�� .  �� $
 Name�   .   . $ 	IsChecked�� �� .R�� .+��� $
��Left=�$��4,0,4,0q� �� $ 	IsChecked�$ PropertyChanged=�{��� *1/DataContext.AppUserPermissions[ManageUserRoles]+  �� $! WindowL�" �� .R�� .+��� $# Выбрать все��$
��Left=� �� **(DataContext.AllRoleUsersCheckedUnchecked+$$ TwoWay=�  �� $! WindowL�$ PropertyChanged=�{��� *1/DataContext.AppUserPermissions[ManageUserRoles]+  �� $! WindowL�