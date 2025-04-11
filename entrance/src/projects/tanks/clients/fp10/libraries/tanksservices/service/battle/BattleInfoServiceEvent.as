package projects.tanks.clients.fp10.libraries.tanksservices.service.battle {
  import flash.events.Event;

  public class BattleInfoServiceEvent extends Event {
    public static const SELECTION_BATTLE:String = "BattleInfoServiceEvent.SELECTION_BATTLE";
    public static const RESET_SELECTION_BATTLE:String = "BattleInfoServiceEvent.RESET_SELECTION_BATTLE";
    public static const BATTLE_RESTART:String = "BattleInfoServiceEvent.BATTLE_RESTART";
    public static const BATTLE_LOAD:String = "BattleInfoServiceEvent.BATTLE_LOAD";
    public static const BATTLE_UNLOAD:String = "BattleInfoServiceEvent.BATTLE_UNLOAD";
    public static const BATTLE_START:String = "BattleInfoServiceEvent.BATTLE_START";

    public function BattleInfoServiceEvent(param1:String) {
      super(param1);
    }
  }
}
