package projects.tanks.clients.flash.commons.services.autobattleenter {
  import flash.events.Event;

  public class AutomaticBattleEnterEvent extends Event {
    public static const SPECTATOR:String = "AutomaticBattleEnterEvent_spectator";
    public static const TANK:String = "AutomaticBattleEnterEvent_tank";

    public function AutomaticBattleEnterEvent(param1:String) {
      super(param1);
    }

    override public function clone() : Event {
      return new AutomaticBattleEnterEvent(type);
    }
  }
}
