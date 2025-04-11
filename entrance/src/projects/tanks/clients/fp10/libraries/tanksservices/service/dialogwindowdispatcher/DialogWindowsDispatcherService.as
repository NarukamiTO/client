package projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher {
  import flash.events.EventDispatcher;

  public class DialogWindowsDispatcherService extends EventDispatcher implements IDialogWindowsDispatcherService {
    private var _isOpen:Boolean;

    public function DialogWindowsDispatcherService() {
      super();
    }

    public function isOpen() : Boolean {
      return this._isOpen;
    }

    public function open() : void {
      this._isOpen = true;
      dispatchEvent(new DialogWindowsDispatcherServiceEvent(DialogWindowsDispatcherServiceEvent.OPEN));
    }

    public function close() : void {
      this._isOpen = false;
      dispatchEvent(new DialogWindowsDispatcherServiceEvent(DialogWindowsDispatcherServiceEvent.CLOSE));
    }

    public function forciblyClose() : void {
      this._isOpen = false;
      dispatchEvent(new DialogWindowsDispatcherServiceEvent(DialogWindowsDispatcherServiceEvent.FORCIBLY_CLOSE));
    }
  }
}
