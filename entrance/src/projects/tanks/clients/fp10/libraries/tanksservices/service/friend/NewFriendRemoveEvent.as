package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.Event;

  public class NewFriendRemoveEvent extends Event {
    public static const ACCEPTED:String = "NewFriendRemoveEvent.ACCEPTED";
    public static const INCOMING:String = "NewFriendRemoveEvent.INCOMING";

    public var userId:Long;

    public function NewFriendRemoveEvent(param1:String, param2:Long, param3:Boolean = false, param4:Boolean = false) {
      this.userId = param2;
      super(param1,param3,param4);
    }
  }
}
