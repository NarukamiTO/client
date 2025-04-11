package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class BattleLinkData {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var reconnectService:ReconnectService;

    private var _userId:Long;
    private var battleData:BattleInfoData;
    private var _mapName:String;

    public function BattleLinkData(param1:Long, param2:BattleNotifierData) {
      super();
      this._userId = param1;
      this.battleData = param2.battleData;
      if(!this.battleData.inGroup) {
        this._mapName = this.battleData.mapName;
      }
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function get battleId() : Long {
      return this.battleData.battleId;
    }

    public function get range() : Range {
      return this.battleData.range;
    }

    public function getBattleData() : BattleInfoData {
      return this.battleData;
    }

    public function isSelfBattle() : Boolean {
      var local1:Long = userInfoService.getCurrentUserId();
      var local2:IUserInfoLabelUpdater = userInfoService.getOrCreateUpdater(local1);
      if(local2.battleLink != null) {
        return int(this.battleId.toString()) != 0 && local2.battleLink.battleId == this.battleId;
      }
      return false;
    }

    public function isShowBattle() : Boolean {
      var local1:Boolean = true;
      if(this.battleData.privateBattle) {
        local1 = this.isSelfBattle();
      }
      return local1;
    }

    public function availableRank() : Boolean {
      var local1:int = int(userPropertiesService.rank);
      return this.battleData.inGroup || this.isShowBattle() && (local1 >= this.battleData.range.min && local1 <= this.battleData.range.max);
    }

    public function isClickable() : Boolean {
      return this.battleData.proBattle && !this.isSelfBattle() && this.isShowBattle();
    }

    public function get proBattle() : Boolean {
      return this.battleData.proBattle;
    }

    public function get inGroup() : Boolean {
      return this.battleData.inGroup;
    }

    public function get mapName() : String {
      return this._mapName;
    }
  }
}
