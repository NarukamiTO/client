package projects.tanks.clients.fp10.libraries.tanksservices.service.premium {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;

  public class BattleUserPremiumServiceImpl extends EventDispatcher implements BattleUserPremiumService {
    private var usersPremium:Dictionary = new Dictionary();

    public function BattleUserPremiumServiceImpl() {
      super();
    }

    public function setUsersPremium(param1:Vector.<UserInfo>) : * {
      var local3:Boolean = false;
      var local4:Long = null;
      var local2:int = 0;
      while(local2 < param1.length) {
        local3 = param1[local2].hasPremium;
        local4 = param1[local2].user;
        this.usersPremium[local4] = local3;
        local2++;
      }
    }

    public function hasUserPremium(param1:Long) : Boolean {
      return this.usersPremium[param1] != null ? Boolean(this.usersPremium[param1]) : false;
    }

    public function resetUserPremium(param1:Long) : * {
      delete this.usersPremium[param1];
    }

    public function removeUsersPremium() : void {
      this.usersPremium = new Dictionary();
    }
  }
}
