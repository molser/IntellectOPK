   M S B A M L   `   `   `  ���� I  EMolserControls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG4clr-namespace:MolserControls;assembly=MolserControlsMolserControls   IntellectOPK*   $IntellectOPK.Views.CardConverterView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Gmolser4clr-namespace:MolserControls;assembly=MolserControls     $	��230��$	��210��   VS2012WindowStyle#��[    � 
ResizeMode$  CanMinimize=� � Icon$' !/Resources/Icons/IntellectOPK.ico�� � Title �� *Title+ � 	Resources   CardConverterMsTextBox �� 
TargetType   MolserControls.MsTextBox �� Property �� Value-  'System.Windows.Input.KeyboardNavigation �� 
TargetType ��Name	 �� CornerRadius
 �� Padding  LightBorderBrush �Name � ColumnDefinitions ��Name ��Name J� IsHitTestVisible �� Padding �� RelativeSource �� Path ��Name � ToolTip  CrosshairButton �� Triggers P� Property P� Value �� 
TargetName  SolidBorderBrush  DisabledForegroundBrush��%�  &	       7  7  7  7  7  �� "  .���  �@J�SnapsToDevicePixels . ��  �@�OverridesDefaultStyle . ��  �@ TabNavigation$
 None=���  �@�FocusVisualStyle Z� ��  � ��$ 10����  � ��$ 10����  �@J�	AllowDrop . ��  � �� �� "  .R��� $ Border��$	 0��$
 2q�#��z��8��  $��1q�._�� $ 
LayoutGrid�� �� $��* ��� $
��auto �.+��� $ PART_ContentHost��$��0��$��0q��� $ 	Watermark��$��0��$y�	Collapsed=�
������� .  $
��Left=�$��Center=�$ 2,0,0,0q�����  �� *TemplatedParent+$ 	Watermark��� $ PART_ClearButton��$��1��$ Очистить��8��  P�  �@J�IsKeyboardFocused . . ��� $ Border��8   � ��P�  �@J�IsMouseOver . . ��� $ Border��8   � ��P�  �@J�IsMouseOver .  . ��� $ PART_ClearButton�� � y�$ 	Collapsed=�P�  � ��$  ��. ��� $ PART_ClearButton�� � y�$ 	Collapsed=��� $ 	Watermark�� � y�$ Visible=�P�  �@��
IsReadOnly . . ��� $ PART_ClearButton�� � y�$ 	Collapsed=�P�  � {� .  . ��� 8   � ���� $ PART_ClearButton�� � y�$ 	Collapsed=�.����   WindowBackgroundBrush#��[ $
 	30,10,0,0q�._���  �� Orientation$ Vertical=�.+��� $ Vertical=�$��0,5,0,0q�.+��� $��0,0,0,0q�$
��Wrap=�$��Полный номер:��  -   $��
FullNumber��$
��Left=�$	��125��$��0,0,0,0q�.������  �� Mode$ TwoWay=�$ 
FullNumber� �� UpdateSourceTrigger$ PropertyChanged=� �� ValidatesOnDataErrors . .���� $ Vertical=�$��0,10,0,0q�.+��� $
��Wrap=�$+��%Фасилити код / номер:���� $ 
Horizontal=�.+�  -   $��FacilityCod��$
��Left=�$��55��$��0,0,0,0q����	#FFFFFDCA#��[ .������ $ TwoWay=�$ FacilityCod�$ PropertyChanged=� . .��  -   $��
CardNumber��$
��Left=�$��65��$��5,0,0,0q����	#FFFFFDCA#��[ .������ $ TwoWay=�$ 
CardNumber�$ PropertyChanged=� . .���� $ Vertical=�$��0,10,0,0q�.+��� $��0,0,0,0q�$
��Wrap=�$��
Hikvision:��  -   $��HikvisionNumber��$
��Left=�$	��125��$��0,0,0,0q�
�������#��[ .������ $ TwoWay=�$ HikvisionNumber�$ PropertyChanged=� . .��