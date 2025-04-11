package alternativa.tanks.models.battle.gui {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInterface]
  public interface BattlefieldGUI {
    function logUserAction(param1:Long, param2:UserAction, param3:Long) : void;
    function setIndicatorState(param1:BattleTeam, param2:int) : void;
    function setBothIndicatorsState(param1:int, param2:int) : void;
    function showBattleMessage(param1:uint, param2:String) : void;
    function showPointBattleLogMessage(param1:String, param2:UserAction) : void;
    function showUserBattleLogMessage(param1:Long, param2:UserAction) : void;
    function showBattleLogMessage(param1:UserAction) : void;
    function addWidget(param1:Widget) : void;
    function logKillAction(param1:Long, param2:Long, param3:DamageType) : void;
  }
}
