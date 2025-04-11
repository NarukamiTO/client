package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.types.Long;
  import flash.events.Event;
  import flash.events.EventDispatcher;

  public class ClansListEvent extends Event {
    private static var dispatcher:EventDispatcher;

    public static const REMOVE:String = "ClansListEvent.REMOVE";
    public static const ADD:String = "ClansListEvent.ADD";
    public static const INCOMING:String = "ClansListEvent.INCOMING";
    public static const OUTGOING:String = "ClansListEvent.OUTGOING";

    public var clanId:Long;

    public function ClansListEvent(param1:String, param2:Long, param3:Boolean = false, param4:Boolean = false) {
      super(param1,param3,param4);
      this.clanId = param2;
    }

    public static function getDispatcher() : EventDispatcher {
      if(dispatcher == null) {
        dispatcher = new EventDispatcher();
      }
      return dispatcher;
    }
  }
}
