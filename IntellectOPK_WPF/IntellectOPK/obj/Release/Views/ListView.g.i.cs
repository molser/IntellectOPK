﻿#pragma checksum "..\..\..\Views\ListView.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "DA71E75DD85E5E0F31C34E8AC712FA11F0E08395"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using IntellectOPK.Commands;
using IntellectOPK.Converters;
using IntellectOPK.TemplateSelectors;
using IntellectOPK.Views;
using MolserControls;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace IntellectOPK.Views {
    
    
    /// <summary>
    /// ListView
    /// </summary>
    public partial class ListView : System.Windows.Window, System.Windows.Markup.IComponentConnector, System.Windows.Markup.IStyleConnector {
        
        
        #line 57 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Primitives.ToggleButton showOnlyCheckedButton;
        
        #line default
        #line hidden
        
        
        #line 78 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal MolserControls.MsTextBox findTextBox;
        
        #line default
        #line hidden
        
        
        #line 108 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox filterListComboBox;
        
        #line default
        #line hidden
        
        
        #line 135 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.FrameworkElement dummyElement;
        
        #line default
        #line hidden
        
        
        #line 136 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox dummyCheckAllCheckBox;
        
        #line default
        #line hidden
        
        
        #line 137 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid itemsDataGrig;
        
        #line default
        #line hidden
        
        
        #line 398 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.StackPanel rowsCountStackPanel;
        
        #line default
        #line hidden
        
        
        #line 403 "..\..\..\Views\ListView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock rowsCountTextBox;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/IntellectOPK;component/views/listview.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\Views\ListView.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal System.Delegate _CreateDelegate(System.Type delegateType, string handler) {
            return System.Delegate.CreateDelegate(delegateType, this, handler);
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            
            #line 34 "..\..\..\Views\ListView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).CanExecute += new System.Windows.Input.CanExecuteRoutedEventHandler(this.FindCommand_CanExecute);
            
            #line default
            #line hidden
            
            #line 34 "..\..\..\Views\ListView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).Executed += new System.Windows.Input.ExecutedRoutedEventHandler(this.FindCommand_Executed);
            
            #line default
            #line hidden
            return;
            case 2:
            
            #line 35 "..\..\..\Views\ListView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).Executed += new System.Windows.Input.ExecutedRoutedEventHandler(this.FindCancelCommand_Executed);
            
            #line default
            #line hidden
            return;
            case 3:
            this.showOnlyCheckedButton = ((System.Windows.Controls.Primitives.ToggleButton)(target));
            
            #line 59 "..\..\..\Views\ListView.xaml"
            this.showOnlyCheckedButton.Checked += new System.Windows.RoutedEventHandler(this.showOnlyCheckedButton_Checked);
            
            #line default
            #line hidden
            
            #line 60 "..\..\..\Views\ListView.xaml"
            this.showOnlyCheckedButton.Unchecked += new System.Windows.RoutedEventHandler(this.showOnlyCheckedButton_Unchecked);
            
            #line default
            #line hidden
            return;
            case 4:
            this.findTextBox = ((MolserControls.MsTextBox)(target));
            
            #line 87 "..\..\..\Views\ListView.xaml"
            this.findTextBox.MouseDoubleClick += new System.Windows.Input.MouseButtonEventHandler(this.selectAllTextBox);
            
            #line default
            #line hidden
            
            #line 88 "..\..\..\Views\ListView.xaml"
            this.findTextBox.GotKeyboardFocus += new System.Windows.Input.KeyboardFocusChangedEventHandler(this.selectAllTextBox);
            
            #line default
            #line hidden
            
            #line 89 "..\..\..\Views\ListView.xaml"
            this.findTextBox.PreviewMouseLeftButtonDown += new System.Windows.Input.MouseButtonEventHandler(this.selectivelyIgnoreMouseButton);
            
            #line default
            #line hidden
            
            #line 90 "..\..\..\Views\ListView.xaml"
            this.findTextBox.TextChanged += new System.Windows.Controls.TextChangedEventHandler(this.findTextBox_TextChanged);
            
            #line default
            #line hidden
            return;
            case 5:
            this.filterListComboBox = ((System.Windows.Controls.ComboBox)(target));
            
            #line 114 "..\..\..\Views\ListView.xaml"
            this.filterListComboBox.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.filterListComboBox_SelectionChanged);
            
            #line default
            #line hidden
            return;
            case 6:
            this.dummyElement = ((System.Windows.FrameworkElement)(target));
            return;
            case 7:
            this.dummyCheckAllCheckBox = ((System.Windows.Controls.CheckBox)(target));
            return;
            case 8:
            this.itemsDataGrig = ((System.Windows.Controls.DataGrid)(target));
            
            #line 150 "..\..\..\Views\ListView.xaml"
            this.itemsDataGrig.LoadingRow += new System.EventHandler<System.Windows.Controls.DataGridRowEventArgs>(this.dataGrid_LoadingRow);
            
            #line default
            #line hidden
            
            #line 154 "..\..\..\Views\ListView.xaml"
            this.itemsDataGrig.TargetUpdated += new System.EventHandler<System.Windows.Data.DataTransferEventArgs>(this.DataGrid_TargetUpdated);
            
            #line default
            #line hidden
            return;
            case 10:
            this.rowsCountStackPanel = ((System.Windows.Controls.StackPanel)(target));
            return;
            case 11:
            this.rowsCountTextBox = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 12:
            
            #line 414 "..\..\..\Views\ListView.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.CloseWindow_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        void System.Windows.Markup.IStyleConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 9:
            
            #line 197 "..\..\..\Views\ListView.xaml"
            ((System.Windows.Controls.CheckBox)(target)).Click += new System.Windows.RoutedEventHandler(this.CheckAllCheckBox_Click);
            
            #line default
            #line hidden
            break;
            }
        }
    }
}

