package alternativa.tanks.controllers.battlecreate {
  import flash.events.Event;
  import projects.tanks.client.battleservice.BattleCreateParameters;

  public class CreateBattleEvent extends Event {
    public static const CREATE_BATTLE:String = "CreateBattleEvent.CREATE_BATTLE";

    public var battleCreateParams:BattleCreateParameters;

    public function CreateBattleEvent(param1:BattleCreateParameters) {
      super(CREATE_BATTLE);
      this.battleCreateParams = param1;
    }
  }
}
