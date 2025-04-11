package alternativa.tanks.service.battle {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleUserInfoService implements IBattleUserInfoService {
    [Inject]
    public static var logService:LogService;

    private var battleUsers:Dictionary = new Dictionary();

    public function BattleUserInfoService() {
      super();
    }

    public function userInBattle(param1:Long) : Boolean {
      return param1 in this.battleUsers;
    }

    public function getBattle(param1:Long) : IGameObject {
      return this.battleUsers[param1];
    }

    public function connect(param1:Long, param2:IGameObject) : void {
      this.battleUsers[param1] = param2;
    }

    public function disconnect(param1:Long) : void {
      delete this.battleUsers[param1];
    }

    public function deleteBattleItem(param1:IGameObject) : void {
      var local2:* = undefined;
      var local3:Long = null;
      for(local2 in this.battleUsers) {
        local3 = this.battleUsers[local2].id;
        if(local3 == param1.id) {
          this.disconnect(local2);
        }
      }
    }
  }
}
