using System;
using System.Windows;
using System.Windows.Controls;

namespace IntellectOPK.ControlLibrary
{
    [TemplatePart(Name = MsComboBox.ElemenetClearButton, Type = typeof(Button))]
    public class MsComboBox : ComboBox
    {
        private const string ElemenetClearButton = "PART_ClearButton";
        private Button clearButton;
        public static DependencyProperty WatermarkProperty =
            DependencyProperty.Register(
                "Watermark",
                typeof(string),
                typeof(MsComboBox));
        public string Watermark
        {
            get { return (string)GetValue(WatermarkProperty); }
            set { SetValue(WatermarkProperty, value); }
        }
        static MsComboBox()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(MsComboBox), new FrameworkPropertyMetadata(typeof(MsComboBox)));           
        }
        
        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();            
            clearButton = GetTemplateChild(ElemenetClearButton) as Button;            

            if (clearButton != null)
            {
                clearButton.Click += new RoutedEventHandler(clearButton_Click);
            }            
        }
        void clearButton_Click(object sender, RoutedEventArgs e)
        {            
            this.Text = String.Empty;
        }
    }
}
