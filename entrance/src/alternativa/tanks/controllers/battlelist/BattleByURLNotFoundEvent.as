package alternativa.tanks.controllers.battlelist {
  import alternativa.types.Long;
  import flash.events.Event;

  public class BattleByURLNotFoundEvent extends Event {
    public static const BATTLE_BY_URL_NOT_FOUND:String = "BattleListControllerEvent.BATTLE_BY_URL_NOT_FOUND";

    public var battleId:Long;

    public function BattleByURLNotFoundEvent(param1:String, param2:Long, param3:Boolean = false, param4:Boolean = false) {
      super(param1,param3,param4);
      this.battleId = param2;
    }
  }
}
