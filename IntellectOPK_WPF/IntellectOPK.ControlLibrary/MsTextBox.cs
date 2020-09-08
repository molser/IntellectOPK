using System;
using System.Windows;
using System.Windows.Controls;

namespace IntellectOPK.ControlLibrary
{
    [TemplatePart(Name = MsTextBox.ElemenetClearButton, Type = typeof(Button))]
    public class MsTextBox : TextBox
    {
        private const string ElemenetClearButton = "PART_ClearButton";
       
        private Button clearButton;
        public static DependencyProperty WatermarkProperty =
            DependencyProperty.Register(
                "Watermark",
                typeof(string),
                typeof(MsTextBox));
        public string Watermark
        {
            get { return (string)GetValue(WatermarkProperty); }
            set { SetValue(WatermarkProperty, value); }
        }
        //private static DependencyPropertyKey HasTextPropertyKey =
        //                                    DependencyProperty.RegisterReadOnly(
        //                                        "HasText",
        //                                        typeof(bool),
        //                                        typeof(MsTextBox),
        //                                        new PropertyMetadata());

        //public static DependencyProperty HasTextProperty = HasTextPropertyKey.DependencyProperty;
        static MsTextBox()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(MsTextBox), new FrameworkPropertyMetadata(typeof(MsTextBox)));           
        }
        //public bool HasText
        //{
        //    get { return (bool)GetValue(HasTextProperty); }
        //    private set { SetValue(HasTextPropertyKey, value); }
        //}        

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            //textBox = GetTemplateChild(ElemenetTextBox) as TextBox;
            clearButton = GetTemplateChild(ElemenetClearButton) as Button;

            //double buttonWidth = clearButton.Width;
            //double textButtonSpace = clearButton.Width / 10;
            //textBox.Padding = new Thickness(0, 0, buttonWidth + textButtonSpace, 0);

            if (clearButton != null)
            {
                clearButton.Click += new RoutedEventHandler(clearButton_Click);
            }
            this.PreviewMouseLeftButtonDown += MsTextBox_PreviewMouseLeftButtonDown;
            this.GotKeyboardFocus += MsTextBox_GotKeyboardFocus;
        }

        private void MsTextBox_GotKeyboardFocus(object sender, System.Windows.Input.KeyboardFocusChangedEventArgs e)
        {
            var textBox = e.OriginalSource as TextBox;
            if (textBox != null)
                textBox.SelectAll();
        }

        private void MsTextBox_PreviewMouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            var textbox = (sender as TextBox);
            if (textbox != null && !textbox.IsKeyboardFocusWithin)
            {
                //string originalSourseName = e.OriginalSource.GetType().Name;
                if (e.OriginalSource.GetType().Name == "TextBoxView")
                {
                    e.Handled = true;
                    textbox.Focus();
                }
                else
                {
                    Button clearButton = VisualHelper.GetParent<Button>(e.OriginalSource as DependencyObject);
                    if(clearButton != null)
                    {
                        if(clearButton.Name == ElemenetClearButton)
                        {
                            this.Text = String.Empty;
                        }
                    }
                }                
            }
        }

        //protected override void OnTextChanged(TextChangedEventArgs e)
        //{
        //    base.OnTextChanged(e);
        //    HasText = Text.Length != 0;            
        //}

        void clearButton_Click(object sender, RoutedEventArgs e)
        {
            //this.textBox.Text = null;
            this.Text = String.Empty;
        }
    }
}
