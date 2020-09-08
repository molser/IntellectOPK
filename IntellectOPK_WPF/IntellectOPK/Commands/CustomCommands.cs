using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace IntellectOPK.Commands
{
    public static class CustomCommands
    {
        public static readonly RoutedUICommand Find = new RoutedUICommand
            (
                "Find",
                "Find",
                typeof(CustomCommands)//,
                                      //new InputGestureCollection()
                                      //{
                                      //    new KeyGesture(Key.F4, ModifierKeys.Alt)
                                      //}
            );

        public static readonly RoutedUICommand FindCancel = new RoutedUICommand
           (
               "FindCancel",
               "FindCancel",
               typeof(CustomCommands)
           );

    }
}
