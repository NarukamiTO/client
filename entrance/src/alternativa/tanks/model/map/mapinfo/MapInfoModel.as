package alternativa.tanks.model.map.mapinfo {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.map.IMapInfoModelBase;
  import projects.tanks.client.battleselect.model.map.MapInfoModelBase;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  [ModelInfo]
  public class MapInfoModel extends MapInfoModelBase implements IMapInfoModelBase, IMapInfo, IObjectLoadListener {
    private static var maps:Vector.<IGameObject> = new Vector.<IGameObject>();

    public function MapInfoModel() {
      super();
    }

    public static function getMaps() : Vector.<IGameObject> {
      return maps;
    }

    public function getName() : String {
      return getInitParam().mapName;
    }

    public function getMapId() : Long {
      return getInitParam().mapId;
    }

    public function getMaxPeople() : int {
      return getInitParam().maxPeople;
    }

    public function getMaxRank() : int {
      return getInitParam().rankLimit.max;
    }

    public function getMinRank() : int {
      return getInitParam().rankLimit.min;
    }

    public function getThemeName() : String {
      return getInitParam().theme.toString();
    }

    public function getTheme() : MapTheme {
      return getInitParam().theme;
    }

    public function getDefaultTheme() : MapTheme {
      return getInitParam().defaultTheme;
    }

    public function getSupportedBattleModes() : Vector.<BattleMode> {
      return getInitParam().supportedModes;
    }

    public function isEnabled() : Boolean {
      return getInitParam().enabled;
    }

    public function getPreviewResource() : ImageResource {
      return getInitParam().preview;
    }

    public function objectLoaded() : void {
      if(this.isEnabled()) {
        maps.push(object);
      }
    }

    public function objectLoadedPost() : void {
    }

    public function objectUnloaded() : void {
      var local1:int = int(maps.lastIndexOf(object));
      if(local1 != -1) {
        maps.splice(local1,1);
      }
    }

    public function objectUnloadedPost() : void {
    }

    public function hasMatchmakingMark() : Boolean {
      return getInitParam().matchmakingMark;
    }
  }
}
