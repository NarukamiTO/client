package alternativa.tanks.models.battle.commonflag {
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;

  [ModelInterface]
  public interface IFlagModeInitilizer {
    function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void;
  }
}
