package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.Event;

  public class FriendActionServiceUidEvent extends Event {
    public static const ADD:String = "FriendActionServiceUidEvent.ADD";
    public static const REQUEST_ACCEPTED:String = "FriendActionServiceUidEvent.REQUEST_ACCEPTED";

    public var uid:String;
    public var userId:Long;

    public function FriendActionServiceUidEvent(param1:String, param2:String = null, param3:Long = null, param4:Boolean = false, param5:Boolean = false) {
      this.uid = param2;
      this.userId = param3;
      super(param1,param4,param5);
    }
  }
}
