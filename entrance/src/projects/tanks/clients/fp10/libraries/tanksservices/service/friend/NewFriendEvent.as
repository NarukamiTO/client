package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.Event;

  public class NewFriendEvent extends Event {
    public static const ACCEPTED_CHANGE:String = "NewFriendEvent.ACCEPTED_CHANGE";
    public static const INCOMING_CHANGE:String = "NewFriendEvent.INCOMING_CHANGE";

    public var userId:Long;

    public function NewFriendEvent(param1:String, param2:Long, param3:Boolean = false, param4:Boolean = false) {
      this.userId = param2;
      super(param1,param3,param4);
    }
  }
}
