package projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator {
  import alternativa.types.Long;
  import flash.events.Event;

  public class BattleLinkAliveEvent extends Event {
    public static const IS_ALIVE:String = "BattleLinkAliveEvent.IS_ALIVE";
    public static const ALIVE:String = "BattleLinkAliveEvent.ALIVE";
    public static const DEAD:String = "BattleLinkAliveEvent.DEAD";

    public var battleId:Long;

    public function BattleLinkAliveEvent(param1:String, param2:Long, param3:Boolean = false, param4:Boolean = false) {
      this.battleId = param2;
      super(param1,param3,param4);
    }
  }
}
