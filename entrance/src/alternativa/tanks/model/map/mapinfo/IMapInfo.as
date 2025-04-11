package alternativa.tanks.model.map.mapinfo {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  [ModelInterface]
  public interface IMapInfo {
    function getName() : String;
    function getMapId() : Long;
    function getMaxPeople() : int;
    function getMaxRank() : int;
    function getMinRank() : int;
    function getThemeName() : String;
    function getTheme() : MapTheme;
    function getDefaultTheme() : MapTheme;
    function getSupportedBattleModes() : Vector.<BattleMode>;
    function isEnabled() : Boolean;
    function hasMatchmakingMark() : Boolean;
    function getPreviewResource() : ImageResource;
  }
}
