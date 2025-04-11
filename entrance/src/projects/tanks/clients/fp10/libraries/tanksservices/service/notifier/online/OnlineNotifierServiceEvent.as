package projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online {
  import flash.events.Event;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.ClientOnlineNotifierData;

  public class OnlineNotifierServiceEvent extends Event {
    public static const SET_ONLINE:String = "OnlineNotifierServiceEvent.SET_ONLINE";

    public var users:Vector.<ClientOnlineNotifierData>;

    public function OnlineNotifierServiceEvent(param1:String, param2:Vector.<ClientOnlineNotifierData>, param3:Boolean = false, param4:Boolean = false) {
      this.users = param2;
      super(param1,param3,param4);
    }
  }
}
