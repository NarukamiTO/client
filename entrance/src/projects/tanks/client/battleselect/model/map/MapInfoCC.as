package projects.tanks.client.battleselect.model.map {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class MapInfoCC {
    private var _defaultTheme:MapTheme;
    private var _enabled:Boolean;
    private var _mapId:Long;
    private var _mapName:String;
    private var _matchmakingMark:Boolean;
    private var _maxPeople:int;
    private var _preview:ImageResource;
    private var _rankLimit:Range;
    private var _supportedModes:Vector.<BattleMode>;
    private var _theme:MapTheme;

    public function MapInfoCC(param1:MapTheme = null, param2:Boolean = false, param3:Long = null, param4:String = null, param5:Boolean = false, param6:int = 0, param7:ImageResource = null, param8:Range = null, param9:Vector.<BattleMode> = null, param10:MapTheme = null) {
      super();
      this._defaultTheme = param1;
      this._enabled = param2;
      this._mapId = param3;
      this._mapName = param4;
      this._matchmakingMark = param5;
      this._maxPeople = param6;
      this._preview = param7;
      this._rankLimit = param8;
      this._supportedModes = param9;
      this._theme = param10;
    }

    public function get defaultTheme() : MapTheme {
      return this._defaultTheme;
    }

    public function set defaultTheme(param1:MapTheme) : void {
      this._defaultTheme = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function get mapId() : Long {
      return this._mapId;
    }

    public function set mapId(param1:Long) : void {
      this._mapId = param1;
    }

    public function get mapName() : String {
      return this._mapName;
    }

    public function set mapName(param1:String) : void {
      this._mapName = param1;
    }

    public function get matchmakingMark() : Boolean {
      return this._matchmakingMark;
    }

    public function set matchmakingMark(param1:Boolean) : void {
      this._matchmakingMark = param1;
    }

    public function get maxPeople() : int {
      return this._maxPeople;
    }

    public function set maxPeople(param1:int) : void {
      this._maxPeople = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function get rankLimit() : Range {
      return this._rankLimit;
    }

    public function set rankLimit(param1:Range) : void {
      this._rankLimit = param1;
    }

    public function get supportedModes() : Vector.<BattleMode> {
      return this._supportedModes;
    }

    public function set supportedModes(param1:Vector.<BattleMode>) : void {
      this._supportedModes = param1;
    }

    public function get theme() : MapTheme {
      return this._theme;
    }

    public function set theme(param1:MapTheme) : void {
      this._theme = param1;
    }

    public function toString() : String {
      var local1:String = "MapInfoCC [";
      local1 += "defaultTheme = " + this.defaultTheme + " ";
      local1 += "enabled = " + this.enabled + " ";
      local1 += "mapId = " + this.mapId + " ";
      local1 += "mapName = " + this.mapName + " ";
      local1 += "matchmakingMark = " + this.matchmakingMark + " ";
      local1 += "maxPeople = " + this.maxPeople + " ";
      local1 += "preview = " + this.preview + " ";
      local1 += "rankLimit = " + this.rankLimit + " ";
      local1 += "supportedModes = " + this.supportedModes + " ";
      local1 += "theme = " + this.theme + " ";
      return local1 + "]";
    }
  }
}
