package projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher {
  import flash.events.IEventDispatcher;

  public interface IDialogWindowsDispatcherService extends IEventDispatcher {
    function isOpen() : Boolean;
    function open() : void;
    function close() : void;
    function forciblyClose() : void;
  }
}
