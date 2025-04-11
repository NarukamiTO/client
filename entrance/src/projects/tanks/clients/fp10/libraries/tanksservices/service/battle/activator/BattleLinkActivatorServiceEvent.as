package projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator {
  import alternativa.types.Long;
  import flash.events.Event;

  public class BattleLinkActivatorServiceEvent extends Event {
    public static const ACTIVATE_LINK:String = "BattleLinkActivatorServiceEvent.ACTIVATE_LINK";
    public static const CONFIRMED_NAVIGATE:String = "BattleLinkActivatorServiceEvent.CONFIRMED_NAVIGATE";
    public static const NOT_CONFIRMED_NAVIGATE:String = "BattleLinkActivatorServiceEvent.NOT_CONFIRMED_NAVIGATE";

    public var battleId:Long;

    public function BattleLinkActivatorServiceEvent(param1:String, param2:Long = null) {
      super(param1);
      this.battleId = param2;
    }
  }
}
