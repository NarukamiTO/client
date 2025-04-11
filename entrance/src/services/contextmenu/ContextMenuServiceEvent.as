package services.contextmenu {
  import alternativa.types.Long;
  import flash.events.Event;

  public class ContextMenuServiceEvent extends Event {
    public static const WRITE_IN_PUBLIC:String = "ContextMenuServiceEvent.WRITE_IN_PUBLIC";
    public static const WRITE_IN_PRIVATE:String = "ContextMenuServiceEvent.WRITE_IN_PRIVATE";
    public static const REMOVE_FROM_FRIENDS:String = "ContextMenuServiceEvent.REMOVE_FROM_FRIENDS";
    public static const REJECT_REQUEST:String = "ContextMenuServiceEvent.REJECT_REQUEST";
    public static const FOCUS_ON_USER:String = "ContextMenuServiceEvent.FOCUS_ON_USER";
    public static const SHOW_CLAN:String = "ContextMenuServiceEvent.SHOW_CLAN";
    public static const VOTE_USER:String = "ContextMenuServiceEvent.VOTE_USER";

    public var userId:Long;
    public var uid:String;
    public var clanId:Long;

    public function ContextMenuServiceEvent(param1:String, param2:Long, param3:String = null, param4:Long = null) {
      this.userId = param2;
      this.uid = param3;
      this.clanId = param4;
      super(param1);
    }
  }
}
