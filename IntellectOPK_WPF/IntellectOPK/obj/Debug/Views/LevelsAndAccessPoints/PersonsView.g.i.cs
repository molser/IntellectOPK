﻿#pragma checksum "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "5589D7F80BEE27585A415EF8284B8CEA"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

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
    /// PersonsView
    /// </summary>
    public partial class PersonsView : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 31 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button uncheckAllButton;
        
        #line default
        #line hidden
        
        
        #line 49 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Primitives.ToggleButton showOnlyCheckedButton;
        
        #line default
        #line hidden
        
        
        #line 68 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox cbDepartmentFilter;
        
        #line default
        #line hidden
        
        
        #line 86 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.FrameworkElement dummyElement;
        
        #line default
        #line hidden
        
        
        #line 87 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid dgPersons;
        
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
            System.Uri resourceLocater = new System.Uri("/IntellectOPK;component/views/levelsandaccesspoints/personsview.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
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
            this.uncheckAllButton = ((System.Windows.Controls.Button)(target));
            
            #line 34 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
            this.uncheckAllButton.Click += new System.Windows.RoutedEventHandler(this.uncheckAllButton_Click);
            
            #line default
            #line hidden
            return;
            case 2:
            this.showOnlyCheckedButton = ((System.Windows.Controls.Primitives.ToggleButton)(target));
            
            #line 52 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
            this.showOnlyCheckedButton.Click += new System.Windows.RoutedEventHandler(this.showOnlyCheckedButton_Click);
            
            #line default
            #line hidden
            return;
            case 3:
            this.cbDepartmentFilter = ((System.Windows.Controls.ComboBox)(target));
            
            #line 71 "..\..\..\..\Views\LevelsAndAccessPoints\PersonsView.xaml"
            this.cbDepartmentFilter.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.cbDepartmentFilter_SelectionChanged);
            
            #line default
            #line hidden
            return;
            case 4:
            this.dummyElement = ((System.Windows.FrameworkElement)(target));
            return;
            case 5:
            this.dgPersons = ((System.Windows.Controls.DataGrid)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}

