

using System.Windows;
namespace IntellectOPK.MessageService
{
    interface IMessageService
    {
        void ShowMessage(string title, string message);
        void ShowExclamation(string title, string exclamation);
        void ShowError(string title, string error);
        MessageBoxResult ShowDialogExclamation(string message, string title = null, Window owner = null);
    }
}
