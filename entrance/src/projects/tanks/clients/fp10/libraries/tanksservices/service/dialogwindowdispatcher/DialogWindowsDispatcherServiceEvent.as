package projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher {
  import flash.events.Event;

  public class DialogWindowsDispatcherServiceEvent extends Event {
    public static const OPEN:String = "DialogWindowsDispatcherServiceEvent.OPEN";
    public static const CLOSE:String = "DialogWindowsDispatcherServiceEvent.CLOSE";
    public static const FORCIBLY_CLOSE:String = "DialogWindowsDispatcherServiceEvent.FORCIBLY_CLOSE";

    public function DialogWindowsDispatcherServiceEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
