package projects.tanks.client.battlefield.models.battle.gui.chat {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface IBattleChatModelBase {
    function addMessage(param1:Long, param2:String, param3:BattleTeam) : void;
    function addSpectatorTeamMessage(param1:String, param2:String) : void;
    function addSystemMessage(param1:String) : void;
    function addTeamMessage(param1:Long, param2:String, param3:BattleTeam) : void;
    function updateTeamHeader(param1:String) : void;
  }
}
