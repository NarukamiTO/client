package alternativa.tanks.models.statistics {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoListener;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class BattleUserInfoServiceImpl implements BattleUserInfoService, AutoClosable {
    private const userInfoListeners:Vector.<BattleUserInfoListener> = new Vector.<BattleUserInfoListener>();

    private var battleObject:IGameObject;

    public function BattleUserInfoServiceImpl(param1:IGameObject) {
      super();
      this.battleObject = param1;
      OSGi.getInstance().registerService(BattleUserInfoService,this);
    }

    public function getUserName(param1:Long) : String {
      var local2:ShortUserInfo = this.getShortUserInfo(param1);
      return local2 != null ? local2.uid : "";
    }

    public function getUserRank(param1:Long) : int {
      var local2:ShortUserInfo = this.getShortUserInfo(param1);
      return local2 != null ? local2.rank : -1;
    }

    public function isUserSuspected(param1:Long) : Boolean {
      var local2:ShortUserInfo = this.getShortUserInfo(param1);
      return local2 != null ? local2.suspicious : false;
    }

    public function getChatModeratorLevel(param1:Long) : ChatModeratorLevel {
      var local2:ShortUserInfo = this.getShortUserInfo(param1);
      return local2 != null ? local2.chatModeratorLevel : ChatModeratorLevel.NONE;
    }

    public function hasUserPremium(param1:Long) : Boolean {
      var local2:ShortUserInfo = this.getShortUserInfo(param1);
      return local2 != null ? local2.hasPremium : false;
    }

    public function addBattleUserInfoListener(param1:BattleUserInfoListener) : void {
      var local2:int = int(this.userInfoListeners.indexOf(param1));
      if(local2 < 0) {
        this.userInfoListeners.push(param1);
      }
    }

    public function removeBattleUserInfoListener(param1:BattleUserInfoListener) : void {
      var local2:int = int(this.userInfoListeners.indexOf(param1));
      if(local2 >= 0) {
        this.userInfoListeners.splice(local2,1);
      }
    }

    public function dispatchStatChange(param1:ShortUserInfo) : void {
      var local2:BattleUserInfoListener = null;
      for each(local2 in this.userInfoListeners) {
        local2.userInfoChanged(param1.userId,param1.uid,param1.rank,param1.suspicious);
      }
    }

    public function dispatchRankChange(param1:Long, param2:int) : void {
      var local3:BattleUserInfoListener = null;
      for each(local3 in this.userInfoListeners) {
        local3.userRankChanged(param1,param2);
      }
    }

    public function dispatchSuspiciousnessChange(param1:Long, param2:Boolean) : void {
      var local3:BattleUserInfoListener = null;
      for each(local3 in this.userInfoListeners) {
        local3.userSuspiciousnessChanged(param1,param2);
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.battleObject = null;
      this.userInfoListeners.length = 0;
      OSGi.getInstance().unregisterService(BattleUserInfoService);
    }

    public function getUsersCount() : int {
      var local1:IClientUserInfo = IClientUserInfo(this.battleObject.adapt(IClientUserInfo));
      return local1.getUsersCount();
    }

    private function getShortUserInfo(param1:Long) : ShortUserInfo {
      var local2:IClientUserInfo = IClientUserInfo(this.battleObject.adapt(IClientUserInfo));
      return local2.getShortUserInfo(param1);
    }
  }
}
