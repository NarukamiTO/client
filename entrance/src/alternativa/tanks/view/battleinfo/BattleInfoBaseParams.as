package alternativa.tanks.view.battleinfo {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;

  public class BattleInfoBaseParams {
    public var battle:IGameObject;
    public var createParams:BattleCreateParameters;
    public var battleUrl:String;
    public var mapName:String;
    public var customName:String;
    public var endTime:int;
    public var roundStarted:Boolean;
    public var matchmakingMark:Boolean;
    public var previewResource:ImageResource;
    public var suspicionLevel:BattleSuspicionLevel;
    public var friends:int;
    public var userToInfo:UserToInfoMap = new UserToInfoMap();

    public function BattleInfoBaseParams() {
      super();
    }

    public function get battleId() : Long {
      return this.battle.id;
    }
  }
}
