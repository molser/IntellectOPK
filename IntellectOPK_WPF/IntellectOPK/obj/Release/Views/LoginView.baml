   M S B A M L   `   `   `  ���� H  DIntellectOPK, Version=1.2.2.21, Culture=neutral, PublicKeyToken=nullA%clr-namespace:IntellectOPK.ConvertersIntellectOPK.Converters  K*clr-namespace:IntellectOPK.ValidationRulesIntellectOPK.ValidationRules  I EMolserControls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG4clr-namespace:MolserControls;assembly=MolserControlsMolserControls "    IntellectOPK.Views.LoginView   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     6conv%clr-namespace:IntellectOPK.Converters     8v*clr-namespace:IntellectOPK.ValidationRules     ;xctk*http://schemas.xceed.com/wpf/ xaml/toolkit     Gmolser4clr-namespace:MolserControls;assembly=MolserControls     $	��206��$��40��$	��260��$	��320��$��40��$	��320��  � WindowStartupLocation$  CenterScreen=�   VS2012WindowStyle#��[   � 
ResizeMode$ NoResize=� � Icon$' !/Resources/Icons/IntellectOPK.ico�� � Title �� *Title+ � 	Resources 9   3IntellectOPK.Converters.BoolToUIVisibilityConverter  boolToUIVisibilityConverter@  :IntellectOPK.Converters.BoolToUIVisibilityInverseConverter % !boolToUIVisibilityInvertConverter  ProgressBarIndicatorBrush �� EndPoint �� 
StartPoint � Color � Offset  ProgressBarStyle1	 �� 
TargetType
 �� Property �� Value �� 
TargetType � 	Resources  Key g� RepeatBehavior �� 
TargetName �� TargetProperty O� KeyTime O� Value g� 	BeginTime g� Duration R� KeyTime  System.Windows.Visibility   Visible R� Value ��Name �� CornerRadius J� Opacity ��Name �� RadiusX �� RadiusY �Name K� ZIndex  � MappingMode! � SpreadMethod" �� 	Transform# T� X$ �� AngleX% J� IsHitTestVisible& �� Triggers' P� Property( P� Value) �� 
TargetName* N� ExitActions+ �� BeginStoryboardName, N� EnterActions- ��Name  IndeterminateOn��%  &	       &	      &	 
     &	 �     7      �� $ 0.5,1&�$ 0.5,0&�.��� $ 	#FFC6D6EC��$ 0Q�� $ 	#FFBDD6FF��$ 0.502Q�� $ 	#FF71A7FD��$ 0.522Q�� $ 	#FF94BDFD��$ 0.763Q�� $ 	#FFA9CAFF��$ 1Q��� "	 �.��� 
 � �� �� " � ���� IndeterminateOn $ Forever��.��U� $ IndeterminateGradientFill��$C =(Shape.Fill).(Brush.Transform).(TransformGroup.Children)[0].X�$ Forever��.\��� $ 0��$ 0Q��� $ 00:00:.5��$ 20Q�T� $ 00:00:00X�$ 00:00:00.0010000D�$ IndeterminateRoot��$ (UIElement.Visibility)�..�i� $ 00:00:00��# Z .R�� .+��� $ 
PART_Track��$��1q�$ 3��$ 0.825Q����� $ 0.5,1&�$ 0.5,0&�.��� $ 	#FFFFFFFF��� $ 	#FFD8D8D8��$ 0.327Q�� $ 	#FFDADADA��$ 0.488Q�� $ 	#FFBEBEBE��$ 0.539Q�� $ 	#FFD6D6D6��$
 0.77Q�� $ 	#FFFFFFFF��$ 1Q����� $ 0.5,1&�$ 0.5,0&�.��� $ 	#FFBBBBBB��$ 0Q�� $ 	#FF7E7E7E��$ 1Q��� $ PART_Indicator��$��1q�$	 1.5��$	 1.5��$
��Left=�$
 0.83Q�#���  � $ IndeterminateRoot��$y�	Collapsed=�.+��� $ IndeterminateSolidFill��$��1q����	#FF6EA4FD$ 2��$ 2��$
��Auto���� $ ProgressBarRootGradient��$��1q�$ 1��$	 1.5��$	 1.5������ $ 0.5,1&�$ 0.5,0&�.��� $ 	#F6BCD5FF��$ 0.046Q�� $ 	#96D4E4FF��$
 0.18Q�� $ 	#4FFFFFFF��$ 0.512Q�� $ 	#00D6D6D6��$ 0.521Q�� $ 	#BABCD5FF��$ 1Q��� $ IndeterminateGradientFill��$��1q�$��1��$ 2��$ 2��$	 0.7Q����� $	 0,1&�$
 20,1&�$  Absolute=�$! Repeat=�" V� .~�T� $# 0Q��� $	$ -10Q�.��� $ 	#FFBCD5FF��$ 0.088Q�� $ 	#006EA4FD��$ 0.475Q�� $ 	#FFBCD5FF��$ 0.899Q��� $ DisabledVisualElement��% .  ���	#A5FFFFFF���	#66FFFFFF$��1q�$ 0Q�& P� ' � {�( .  . ��� $) DisabledVisualElement��
 �@J�Opacity$ 1Q�P� ' �@�IsIndeterminate( . * �� $%+ IndeterminateOn_BeginStoryboard��, �� $%- IndeterminateOn_BeginStoryboard��8��  . ��� $) 
PART_Track��
 � y�$ 	Collapsed=��� $) PART_Indicator��
 � y�$ 	Collapsed=�.��� $��10,5,0,0q�. � ColumnDefinitions. �� $
��auto ��� $
��auto �/ � RowDefinitions/ �� $
��auto �.+��� $	��Top=�$��0��$��0��$��55��$��	25,25,0,0q�$7��1pack://application:,,,/Resources/Images/Login.png���� 0 �� Orientation$0 Vertical=�$��1��$
��Left=�$��18,0,0,0q�.+��� y��� *IsBusy+1 �� 	Converter#1 [ .+��� $��0,0,0,2q�$
��Wrap=�$��Логин:��  MolserControls.MsTextBox  -   $��Login��$
��Left=�$	��160��$��24��$��0,0,0,0q�2 �� TextWrapping$
2 Wrap=�.������ 3 �� Mode$3 TwoWay=�4 �� Path$4 LoginParams.User.Login�5 �� UpdateSourceTrigger$5 PropertyChanged=�6 �� ValidatesOnDataErrors6 . .������ "	    StandardMsTextBox7 �� BasedOn#7 [ .��� 
 �@�ToolTip$ 
Логин��8 �� Triggers8 P� ' �@=�HasError( . . ��� 
 �@�ToolTip �� 9 �� Self: �� RelativeSource#: Z9 $)4 #(Validation.Errors)[0].ErrorContent�.���� $��0,5,0,2q�$
��Wrap=�$��Пароль:��G� -   $��passwordBox��$��0,0,0,20q�$	��160��$��24��$
��Left=�; � ToolTip$; Пароль���� $0 
Horizontal=�$��Right=�.+��� < �� 	IsDefault< . $��OK��$��0,0,0,0q�$��30��$��75������ *SetLoginCommand+���� = �� ElementName$= passwordBox���� > �� IsCancel> . $��Отмена��$��10,0,0,0q�$��30��$��75��