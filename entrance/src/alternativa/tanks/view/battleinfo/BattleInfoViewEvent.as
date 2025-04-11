package alternativa.tanks.view.battleinfo {
  import flash.events.Event;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleInfoViewEvent extends Event {
    public static const ENTER_BATTLE:String = "BattleInfoViewEvent.ENTER_BATTLE";
    public static const ENTER_SPECTATOR:String = "BattleInfoViewEvent.ENTER_SPECTATOR";
    public static const BUY_PRO_ABONEMENT:String = "BattleInfoViewEvent.BUY_PRO_ABONEMENT";

    public var team:BattleTeam;

    public function BattleInfoViewEvent(param1:String, param2:BattleTeam = null) {
      super(param1);
      this.team = param2;
    }

    override public function clone() : Event {
      return new BattleInfoViewEvent(type,this.team);
    }
  }
}
