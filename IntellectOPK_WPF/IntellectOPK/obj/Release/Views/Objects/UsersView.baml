   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=nullA%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  "    IntellectOPK.Views.UsersView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     6conv%clr-namespace:IntellectOPK.Converters     $	��520��$	��600��  � SizeToContent$  Width=�   VS2012WindowStyle#��[   � 
ResizeMode$ CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter��%-   &	       &	      &	 
     ��     .��� $��15q� � RowDefinitions �� $	��165 ��� �� $
��auto � � ColumnDefinitions �� $
��auto ��� .+�� $��0��$��0�� �� $
��auto ��� .+��� $��0��$��Группы:��R� -    R�Name$ Roles��$��1��$��0,5,0,0q�$��2,2,20,2q�$
��Left=�$	��Top=����� *Roles+����  �� ItemsSource ��  �� Path$ Nodes�.R��� ���� *Role.Description+� $��0��$��1��$��10q� ��  �� .+��� $	��185��$��0��$��0��	 �� Orientation$	 Vertical=�$��Right=�$��5,12,0,0q�.+��� $��26��$-��'Создать пользователя������ *CreateUserCommand+y��� *!AppUserPermissions[ManageUsers]+
 �� 	Converter#
 [ �� $��26��$9��3Редактировать пользователя������ *ModifyUserCommand+y��� *AppUserPermissions[SeeUsers]+#
 [ �� $��26��$-��'Удалить пользователя������ *DeleteUserCommand+y��� *!AppUserPermissions[ManageUsers]+#
 [ �� $��26��$<��6Сбросить пароль пользователя������ *ResetUserPasswordCommand+y��� *!AppUserPermissions[ManageUsers]+#
 [ �� $��26��$-��'Редактировать группу������ *ModifyRoleCommand+y��� *AppUserPermissions[SeeUsers]+#
 [ � $��1��$��0��$��2��$��0,5,0,0q� �� $
��auto ��� .+��� $��0��$,��&Пользователи группы:��&   System.Windows.Controls.DataGrid  -     Name$ Users��$��1��$��0,5,0,0q�$
��Left=�$	��Top=�   AutoGenerateColumns .     GridLinesVisibility$ 
Horizontal=�  DataGridLinesBrush   HorizontalGridLinesBrush# [    CanUserResizeRows .     
IsReadOnly .    HeadersVisibility$	 All=�   SelectionMode$ Single=����� *Users+ �� SelectedItem �� $ CurrentUser� �� Mode$ OneWayToSource=�y��� *Users+#
 [    Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ 
Логин��1  +System.Windows.Controls.DataGridBoundColumn   Binding �� $ Login�  $ Имя�� �� $
 Name�4  .System.Windows.Controls.DataGridCheckBoxColumn  $  Администратор�� �� $ IsAdmin�  $ Заблокирован�� �� $ IsLocked��� $��2��$��2��$��0,5,0,0q�$	 
Horizontal=�$��Right=�.+��� -   $��26��$��60��$
��Left=�$��OK�� �� 	IsDefault . 