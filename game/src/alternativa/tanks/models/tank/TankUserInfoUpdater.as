package alternativa.tanks.models.tank {
  import alternativa.tanks.display.usertitle.UserTitle;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoListener;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  public class TankUserInfoUpdater implements BattleUserInfoListener {
    [Inject]
    public static var usersRegistry:TankUsersRegistry;

    public function TankUserInfoUpdater() {
      super();
    }

    public function userInfoChanged(param1:Long, param2:String, param3:int, param4:Boolean) : void {
      var local6:UserInfo = null;
      var local7:UserTitle = null;
      var local5:ITankModel = this.getTankModel(param1);
      if(local5 != null) {
        local6 = local5.getUserInfo();
        local6.name = param2;
        local6.rank = param3;
        local7 = local5.getTitle();
        if(local7 != null) {
          local7.setLabelText(param2);
          local7.setRank(param3);
          local7.setSuspicious(param4);
        }
      }
    }

    public function userSuspiciousnessChanged(param1:Long, param2:Boolean) : void {
      var local4:ITankModel = null;
      var local5:UserTitle = null;
      var local3:IGameObject = usersRegistry.getUser(param1);
      if(local3 != null) {
        local4 = ITankModel(local3.adapt(ITankModel));
        local5 = local4.getTitle();
        if(local5 != null) {
          local5.setSuspicious(param2);
        }
      }
    }

    public function userRankChanged(param1:Long, param2:int) : void {
      var local4:UserInfo = null;
      var local5:UserTitle = null;
      var local3:ITankModel = this.getTankModel(param1);
      if(local3 != null) {
        local4 = local3.getUserInfo();
        local4.rank = param2;
        local5 = local3.getTitle();
        if(local5 != null) {
          local5.setRank(param2);
        }
      }
    }

    private function getTankModel(param1:Long) : ITankModel {
      var local2:IGameObject = usersRegistry.getUser(param1);
      if(local2 != null) {
        return ITankModel(local2.adapt(ITankModel));
      }
      return null;
    }
  }
}
