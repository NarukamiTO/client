package alternativa.tanks.model.info {
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;

  [ModelInterface]
  public interface IBattleInfo {
    function getConstructor() : BattleInfoCC;
    function getPreviewResource() : ImageResource;
  }
}
