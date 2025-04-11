package projects.tanks.client.panel.model.emailreminder {
  public interface IEmailReminderModelBase {
    function activateMessage(param1:String) : void;
    function notifyEmailIsBusy(param1:String) : void;
    function notifyEmailIsForbidden(param1:String) : void;
    function notifyEmailIsFree(param1:String) : void;
    function openConfirmEmailReminder(param1:String) : void;
    function openEnterEmailReminder() : void;
    function openThanksForConfirmationEmailWindow() : void;
  }
}
