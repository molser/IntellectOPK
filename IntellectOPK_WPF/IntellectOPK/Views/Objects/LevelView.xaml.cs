using IntellectOPK.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace IntellectOPK.Views
{
    /// <summary>
    /// Interaction logic for UserView.xaml
    /// </summary>
    public partial class LevelView : Window
    {
        public bool IsMinimizeButtonHidden { get { return true; } }
        public LevelView()
        {
            InitializeComponent();
            this.SourceInitialized += (x, y) =>
            {
                WindowHelper.HideMinimizeButton(this);
            };
        }
        public LevelViewModel ViewModel
        {
            get { return this.DataContext as LevelViewModel; }
            set { this.DataContext = value; }
        }
        
    }
}
