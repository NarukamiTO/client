package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInterface]
  public interface ICommonFacility {
    function getPosition() : Vector3;
    function getCenter() : Vector3;
    function getTeam() : BattleTeam;
    function getOwner() : IGameObject;
  }
}
