﻿#pragma checksum "..\..\..\..\Views\Persons\DepartmentsView.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "0827D03893D120C3965A33D2F86726D0F03792B6"
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
using IntellectOPK.Views;
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
    /// DepartmentsView
    /// </summary>
    public partial class DepartmentsView : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 33 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button uncheckAllButton;
        
        #line default
        #line hidden
        
        
        #line 48 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Primitives.ToggleButton showOnlyCheckedButton;
        
        #line default
        #line hidden
        
        
        #line 69 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox DepartmetsFindTextBox;
        
        #line default
        #line hidden
        
        
        #line 125 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.FrameworkElement dummyElement;
        
        #line default
        #line hidden
        
        
        #line 128 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid departmentsDataGrid;
        
        #line default
        #line hidden
        
        
        #line 182 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.StackPanel rowsCountStackPanel;
        
        #line default
        #line hidden
        
        
        #line 184 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
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
            System.Uri resourceLocater = new System.Uri("/IntellectOPK;component/views/persons/departmentsview.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
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
            
            #line 21 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).CanExecute += new System.Windows.Input.CanExecuteRoutedEventHandler(this.FindCommand_CanExecute);
            
            #line default
            #line hidden
            
            #line 21 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).Executed += new System.Windows.Input.ExecutedRoutedEventHandler(this.FindCommand_Executed);
            
            #line default
            #line hidden
            return;
            case 2:
            this.uncheckAllButton = ((System.Windows.Controls.Button)(target));
            
            #line 37 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            this.uncheckAllButton.Click += new System.Windows.RoutedEventHandler(this.uncheckAllButton_Click);
            
            #line default
            #line hidden
            return;
            case 3:
            this.showOnlyCheckedButton = ((System.Windows.Controls.Primitives.ToggleButton)(target));
            
            #line 51 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            this.showOnlyCheckedButton.Click += new System.Windows.RoutedEventHandler(this.showOnlyCheckedButton_Click);
            
            #line default
            #line hidden
            return;
            case 4:
            this.DepartmetsFindTextBox = ((System.Windows.Controls.TextBox)(target));
            return;
            case 5:
            this.dummyElement = ((System.Windows.FrameworkElement)(target));
            return;
            case 6:
            this.departmentsDataGrid = ((System.Windows.Controls.DataGrid)(target));
            
            #line 147 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            this.departmentsDataGrid.LoadingRow += new System.EventHandler<System.Windows.Controls.DataGridRowEventArgs>(this.dataGrid_LoadingRow);
            
            #line default
            #line hidden
            
            #line 148 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            this.departmentsDataGrid.TargetUpdated += new System.EventHandler<System.Windows.Data.DataTransferEventArgs>(this.DataGrid_TargetUpdated);
            
            #line default
            #line hidden
            return;
            case 7:
            this.rowsCountStackPanel = ((System.Windows.Controls.StackPanel)(target));
            return;
            case 8:
            this.rowsCountTextBox = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 9:
            
            #line 191 "..\..\..\..\Views\Persons\DepartmentsView.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.CloseWindow_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

