package projects.tanks.client.battlefield.models.user.spawn {
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface ITankSpawnerModelBase {
    function prepareToSpawn(param1:Vector3d, param2:Vector3d) : void;
    function spawn(param1:BattleTeam, param2:Vector3d, param3:Vector3d, param4:int, param5:int) : void;
  }
}
