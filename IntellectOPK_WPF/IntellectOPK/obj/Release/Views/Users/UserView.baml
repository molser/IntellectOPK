   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.0.12, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  !    IntellectOPK.Views.UserView   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     $	��600��$	��580��  � SizeToContent$  Width=�   VS2012WindowStyle#��[   � 
ResizeMode$ CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter��%-   &	       &	      &	 
     ��     .��]� .+��� $��Bottom=�$��
0,10,15,15q� �� Orientation$ 
Horizontal=�$��Right=�$��Bottom=�.+��� $��26��$��60��$	��Top=�$
��Left=�$��OK�� �� 	IsDefault . ���� *ConfirmCommand+�� $	��Top=�$
��Left=� �� IsCancel . $��Отмена��$��10,0,0,0q�$��26��$��60��� $��
25,15,25,0q�$	��Top=� � RowDefinitions �� $
��auto ���  � ColumnDefinitions �� �� $
��auto �.+�� $��0��$��1��$��0,0,15,0q� �� $
��auto � �� $
��auto �.+��� $ Vertical=�.+��� $��0��$��0��$��Логин:���� -   $��Login��$��0��$��1��$
��Left=�$	��230��$��24��$��0,0,0,2q�	 �� TextWrapping$
	 Wrap=�{��� *!AppUserPermissions[ManageUsers]+.������ 
 �� Mode$
 TwoWay=� �� Path$ 
User.Login� �� UpdateSourceTrigger$ PropertyChanged=� �� ValidatesOnDataErrors . .������  �� 
TargetType" ��  StandardTextBox �� BasedOn# [  �� Triggers P�  P� Property �@=�HasError P� Value . . ���  �� Property �@�ToolTip �� Value ��  �� Self �� RelativeSource# Z $) #(Validation.Errors)[0].ErrorContent�.���� $��1��$��0��$��Имя:���� -   $��UserName��$��1��$��1��$
��Left=�$	��230��$��24��$��0,0,0,2q�$
	 Wrap=�{��� *!AppUserPermissions[ManageUsers]+.������ $
 TwoWay=�$ 	User.Name�$ PropertyChanged=� . .���� $��2��$��0��$��Комментарий:���� -   $��Comment��$��2��$��1��$
	 Wrap=�$
��Left=�$	��230��$��0,0,0,2q�{��� *!AppUserPermissions[ManageUsers]+.������ $
 TwoWay=�$ User.Comment�$ PropertyChanged=� . .���� $ 
Horizontal=�.+��� -   $��IsAdmin��$��3��$��1��$
��Left=�$��0,0,0,0q�{��� *&$AppUserPermissions[ManageAdminUsers]+ d� 	IsChecked �� $
 TwoWay=�$ UserIsAdmin�$ PropertyChanged=� . �� $��5,0,0,0q�$��3��$��0��$ ��Администратор���� $ 
Horizontal=�.+��� -   $��IsLocked��$��3��$��1��$
��Left=�$��0,0,0,0q�{��� *!AppUserPermissions[ManageUsers]+ �� $
 TwoWay=�$ User.IsLocked�$ PropertyChanged=� . �� $��5,0,0,0q�$��2��$��0��$��Заблокирован��� $��0��$��1��$��0,0,0,0q�$��Right=� �� $
��auto ��� $	��160 � �� �� .+��� $��0��$,��&Группы пользователя:��&   System.Windows.Controls.DataGrid  -     Name$ 	UserRoles��$��1��$��0��$��2��$��0,5,0,0q�$
��Left=�$	��Top=�   AutoGenerateColumns .     GridLinesVisibility$ 
Horizontal=�  DataGridLinesBrush   HorizontalGridLinesBrush# [    CanUserResizeRows .     CanUserAddRows .     HeadersVisibility$ Column=�   SelectionMode$ Single=����� *	UserRoles+y��� *	UserRoles+  �� 	Converter#  [ !   Columns! 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn"   Header$" Группа��#   
IsReadOnly# . 1  +System.Windows.Controls.DataGridBoundColumn$   Binding$ �� $ Description�%   ElementStyle% �� " ��.���  � ��$ CharacterEllipsis=�4  .System.Windows.Controls.DataGridTemplateColumn  &   CanUserSort& . '   SortMemberPath$' 	IsChecked��(   CellTemplate( �� .R�� .+��� $
��Left=�$��4,0,4,0q� �� $ 	IsChecked�$ PropertyChanged=�{��� *1/DataContext.AppUserPermissions[ManageUserRoles]+ �� ) �� AncestorType$) WindowL�*   HeaderTemplate* �� .R�� .+��� + � ToolTip$+ Выбрать все��$
��Left=� �� **(DataContext.AllUserRolesCheckedUnchecked+$
 TwoWay=� �� $) WindowL�$ PropertyChanged=�{��� *1/DataContext.AppUserPermissions[ManageUserRoles]+ �� $) WindowL�� $��1��$��0��$��2��$��0,15,0,0q� �� $
��auto ���  �� .+��� $��0��$��0��$*��$Права пользователя:��  -   $ UserPermissions��$��1��$��0,5,0,0q�$
��Left=�$	��Top=� .  $ 
Horizontal=�# [  .   .  $ Column=�$ Single=����� *UserPermissions+y��� *UserPermissions+#  [ !   $" 
Право��# . $ �� $ Description�% �� " ��.���  � ��$ CharacterEllipsis=�  # . & . $' 	IsChecked��( �� .R�� .+��� {�.  $
��Left=�$��4,0,4,0q� �� $ 	IsChecked�$ PropertyChanged=� *  $System.Windows.Controls.DataGridCell  StandardDataGridCell�� %�   '        7  �� "  8   .���  � �� Z� ��  � �� Z� ��  � ��
 ����� P�  �@ 
IsSelected . . ���  � ��
 �������  � ��
 �iii���  � �� Z� 