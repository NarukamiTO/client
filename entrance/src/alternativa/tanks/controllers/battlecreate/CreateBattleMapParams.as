package alternativa.tanks.controllers.battlecreate {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class CreateBattleMapParams {
    public var index:Object;
    public var id:Long;
    public var gameName:String;
    public var minRank:int;
    public var maxRank:int;
    public var currentRank:int;
    public var maxPeople:int;
    public var battleModes:Vector.<BattleMode>;
    public var themeName:String;
    public var enabled:Boolean;
    public var previewResource:ImageResource;
    public var theme:MapTheme;
    public var defaultTheme:MapTheme;
    public var matchmakingMark:Boolean;

    public function CreateBattleMapParams() {
      super();
    }
  }
}
