   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  +    %IntellectOPK.Views.ChangePasswordView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     $	��206��$��40��$	��260��$	��320��$��40��$	��320��  � WindowStartupLocation$  CenterScreen=�   VS2012WindowStyle#��[   � 
ResizeMode$ NoResize=� � Icon$' !/Resources/Icons/IntellectOPK.ico�� � Title �� *Title+.��� $��10,5,0,0q� � ColumnDefinitions �� $
��auto ��� $
��auto � � RowDefinitions �� $
��auto �.+��� $	��Top=�$��0��$��0��$��55��$��	25,25,0,0q�$@��:pack://application:,,,/Resources/Images/ChangePassword.png����  �� Orientation$ Vertical=�$��1��$
��Left=�$��18,0,0,0q�.+��� .+��� $��0,0,0,2q�$
��Wrap=�$��Новый пароль:��G� -   $��passwordBox��$��0,0,0,0q�$	��160��$��24��$
��Left=� � ToolTip$ Новый пароль���� $��0,0,0,2q�$
��Wrap=�$!��Подтверждение:��G� -   $��confirmPasswordBox��$��0,0,0,20q�$	��160��$��24��$
��Left=�$  Подтверждение���� $ 
Horizontal=�$��Right=�.+���  �� 	IsDefault . $��OK��$��0,0,0,0q�$��30��$��75������ *ChangePasswordCommand+�� 	 �� IsCancel	 . $��Отмена��$��10,0,0,0q�$��30��$��75��