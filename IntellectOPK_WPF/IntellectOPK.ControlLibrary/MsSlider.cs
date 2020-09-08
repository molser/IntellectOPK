using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;

namespace IntellectOPK.ControlLibrary
{
    public class MsSlider : Slider
    {
        public static DependencyProperty DefaultValueProperty =
            DependencyProperty.Register(
                "DefaultValue",
                typeof(double),
                typeof(MsSlider));
        public double DefaultValue
        {
            get { return (double)GetValue(DefaultValueProperty); }
            set { SetValue(DefaultValueProperty, value); }
        }
        static MsSlider()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(MsSlider), new FrameworkPropertyMetadata(typeof(MsSlider)));           
        }
        
        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();           
            this.MouseDoubleClick += MsSlider_MouseDoubleClick;            
        }

        private void MsSlider_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            MsSlider slider = sender as MsSlider;
            Thumb thumb = VisualHelper.GetParent<Thumb>(e.OriginalSource as DependencyObject);
            if (thumb != null)
            {
                //slider.Value = (Math.Abs(slider.Maximum) - Math.Abs(slider.Minimum)) / 2;
                slider.Value = slider.DefaultValue;
            }
        }
    }
}
