   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=null7 clr-namespace:IntellectOPK.ViewsIntellectOPK.Views  A%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  "    IntellectOPK.Views.LevelView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     2local clr-namespace:IntellectOPK.Views     6conv%clr-namespace:IntellectOPK.Converters     $	��270��$	��500��   VS2012WindowStyle#��[    � 
ResizeMode$  CanResizeWithGrip=� � Title �� *Title+ � 	Resources   boolToUIVisibilityConverter7  1IntellectOPK.Converters.NullToVisibilityConverter  nullToVisibilityConverter8   2IntellectOPK.Converters.BoolToBoolInverseConverter  inverseBooleanConverter��%-   &	       &	      &	 
     ��     .��]� .+��� $��Bottom=�$��
0,10,25,20q� �� Orientation$ 
Horizontal=�$��Right=�$��Bottom=�.+��� $��26��$��60��$	��Top=�$
��Left=�$��OK�� �� 	IsDefault . ���� *ConfirmCommand+����  �� 
TargetType" ��  StandardButton �� BasedOn# [ .���  �� Property � {� �� Value .  	 �� Triggers	 ^� 
 ^� 
Conditions
 ��  �� Binding ��  �� Path$ (Validation.HasError)� �� ElementName$ 
NumTextBox�� �� Value	 False��  �� $ (Validation.HasError)�$ RankTextBox��	 False.0���  � {� . �� $	��Top=�$
��Left=� �� IsCancel . $��Отмена��$��10,0,0,0q�$��26��$��60��� $��
25,15,25,0q�$	��Top=� � RowDefinitions �� $
��auto � � ColumnDefinitions �� $
��auto ��� $
��auto �.+��� $ Vertical=�$��0�� �� 
LineHeight$ 22��.+��� $	��ID:���� $��Название:���� $��Описание:���� $&�� Порядковый номер:���� $��	Ранг:���� $��Тип:���� $ Vertical=�$��1��$��10,0,0,0q�.+��� -   $��	IDTextBox��$
��Left=�$��60��$��0,0,0,0q� �� TextWrapping$
 Wrap=�{�.  ���� $ Level.Id� �� Mode$ OneWay=�.���� -   $��NameTextBox��$��Stretch=�$	��310��$��0,0,0,0q�$ NoWrap=�{�.  ���� $ 
Level.Name�$ OneWay=�.���� -   $��DescriptionTextBox��$
��Left=�$	��310��$��0,0,0,0q�$ NoWrap=����� $ Level.Description�$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=� �� ValidatesOnDataErrors . .���� -   $��
NumTextBox��$
��Left=�$��60��$��0,0,0,0q�$ NoWrap=����� $ 	Level.Num�$ TwoWay=�$ PropertyChanged=� . .���� -   $��RankTextBox��$
��Left=�$��60��$��0,0,0,0q�$ NoWrap=����� $ 
Level.Rank�$ TwoWay=�$ PropertyChanged=� �� StringFormat$ N2�� . .���� -   $��TypeTextBox��$
��Left=�$	��310��$��0,0,0,0q�$ NoWrap=����� $ 
Level.Type�$ TwoWay=�$ PropertyChanged=� . .��