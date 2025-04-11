package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.types.Long;
  import flash.events.Event;

  public class InviteUserEvent extends Event {
    public static const TYPE:String = "InviteUserEvent";

    private var userId:Long;

    public function InviteUserEvent(param1:Long) {
      this.userId = param1;
      super(TYPE,true);
    }

    public function getUserId() : Long {
      return this.userId;
    }
  }
}
