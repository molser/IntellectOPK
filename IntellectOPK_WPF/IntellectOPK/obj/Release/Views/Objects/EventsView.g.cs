﻿#pragma checksum "..\..\..\..\Views\Objects\EventsView.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "08270B71EF0D77AD7F696FD6609F85DE138D2F9C"
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
    /// EventsView
    /// </summary>
    public partial class EventsView : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 33 "..\..\..\..\Views\Objects\EventsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button uncheckAllButton;
        
        #line default
        #line hidden
        
        
        #line 43 "..\..\..\..\Views\Objects\EventsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Primitives.ToggleButton showOnlyCheckedButton;
        
        #line default
        #line hidden
        
        
        #line 54 "..\..\..\..\Views\Objects\EventsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox FindTextBox;
        
        #line default
        #line hidden
        
        
        #line 104 "..\..\..\..\Views\Objects\EventsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.FrameworkElement dummyElement;
        
        #line default
        #line hidden
        
        
        #line 107 "..\..\..\..\Views\Objects\EventsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid eventsDataGrid;
        
        #line default
        #line hidden
        
        
        #line 161 "..\..\..\..\Views\Objects\EventsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.StackPanel rowsCountStackPanel;
        
        #line default
        #line hidden
        
        
        #line 163 "..\..\..\..\Views\Objects\EventsView.xaml"
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
            System.Uri resourceLocater = new System.Uri("/IntellectOPK;component/views/objects/eventsview.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\Views\Objects\EventsView.xaml"
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
            
            #line 14 "..\..\..\..\Views\Objects\EventsView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).CanExecute += new System.Windows.Input.CanExecuteRoutedEventHandler(this.FindCommand_CanExecute);
            
            #line default
            #line hidden
            
            #line 14 "..\..\..\..\Views\Objects\EventsView.xaml"
            ((System.Windows.Input.CommandBinding)(target)).Executed += new System.Windows.Input.ExecutedRoutedEventHandler(this.FindCommand_Executed);
            
            #line default
            #line hidden
            return;
            case 2:
            this.uncheckAllButton = ((System.Windows.Controls.Button)(target));
            
            #line 37 "..\..\..\..\Views\Objects\EventsView.xaml"
            this.uncheckAllButton.Click += new System.Windows.RoutedEventHandler(this.uncheckAllButton_Click);
            
            #line default
            #line hidden
            return;
            case 3:
            this.showOnlyCheckedButton = ((System.Windows.Controls.Primitives.ToggleButton)(target));
            
            #line 46 "..\..\..\..\Views\Objects\EventsView.xaml"
            this.showOnlyCheckedButton.Click += new System.Windows.RoutedEventHandler(this.showOnlyCheckedButton_Click);
            
            #line default
            #line hidden
            return;
            case 4:
            this.FindTextBox = ((System.Windows.Controls.TextBox)(target));
            return;
            case 5:
            this.dummyElement = ((System.Windows.FrameworkElement)(target));
            return;
            case 6:
            this.eventsDataGrid = ((System.Windows.Controls.DataGrid)(target));
            
            #line 126 "..\..\..\..\Views\Objects\EventsView.xaml"
            this.eventsDataGrid.LoadingRow += new System.EventHandler<System.Windows.Controls.DataGridRowEventArgs>(this.dataGrid_LoadingRow);
            
            #line default
            #line hidden
            
            #line 127 "..\..\..\..\Views\Objects\EventsView.xaml"
            this.eventsDataGrid.TargetUpdated += new System.EventHandler<System.Windows.Data.DataTransferEventArgs>(this.DataGrid_TargetUpdated);
            
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
            
            #line 170 "..\..\..\..\Views\Objects\EventsView.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.CloseWindow_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

