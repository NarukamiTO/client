package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.Event;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;

  public class FriendStateChangeEvent extends Event {
    public static const CHANGE:String = "FriendsStateChangeEvent.CHANGE";

    public var userId:Long;
    public var state:FriendState;
    public var prevState:FriendState;

    public function FriendStateChangeEvent(param1:String, param2:Long, param3:FriendState, param4:FriendState, param5:Boolean = false, param6:Boolean = false) {
      this.userId = param2;
      this.state = param3;
      this.prevState = param4;
      super(param1,param5,param6);
    }
  }
}
