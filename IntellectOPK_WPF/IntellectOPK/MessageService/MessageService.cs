using IntellectOPK.Utilities;
using System;
using System.Windows;

namespace IntellectOPK.MessageService
{
    public class Message
    {
        private static string _assemblyName = AssemlyInfoHelper.AssemblyName;

        private static void showMessage(Window owner, 
                                        string message, 
                                        string title,                                         
                                        MessageBoxImage image,
                                        MessageBoxButton button = MessageBoxButton.OK)
        {
            if (owner != null)
            {
                if (title != null) MessageBox.Show(owner, message, title + " - " + _assemblyName, button, image);
                else MessageBox.Show(owner, message, _assemblyName, button, image);
            }
            else
            {
                if (title != null) MessageBox.Show(message, title + " - " + _assemblyName, button, image);
                else MessageBox.Show(message, _assemblyName, button, image);
            }             
        }
        
        public static void ShowMessage(string message, string title = null, Window owner = null)
        {
            showMessage(owner, message, title, MessageBoxImage.Information);                      
        }
        public static void ShowExclamation(string message, string title = null, Window owner = null)
        {
            showMessage(owner, message, title, MessageBoxImage.Exclamation);
                         
        }
        public static void ShowError(string message, string title = null, Window owner = null)
        {
            showMessage(owner, message, title, MessageBoxImage.Error);                        
        }
        public static MessageBoxResult ShowDialogExclamation(string message, string title = null, Window owner = null)
        {
            if (owner != null)
            {
                if (title != null) return MessageBox.Show(owner, message, title + " - " + _assemblyName, MessageBoxButton.YesNo, MessageBoxImage.Exclamation, MessageBoxResult.No);
                else return MessageBox.Show(owner, message, _assemblyName, MessageBoxButton.YesNo, MessageBoxImage.Exclamation, MessageBoxResult.No);
            }
            else
            {
                if (title != null) return MessageBox.Show(message, title + " - " + _assemblyName, MessageBoxButton.YesNo, MessageBoxImage.Exclamation, MessageBoxResult.No);
                else return MessageBox.Show(message, _assemblyName, MessageBoxButton.YesNo, MessageBoxImage.Exclamation, MessageBoxResult.No);
            }
        }
    }    
}
