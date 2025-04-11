package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
  import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.battle.IBattleNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;

  [ModelInfo]
  public class BattleNotifierModel extends BattleNotifierModelBase implements IBattleNotifierModelBase, UserRefresh, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleNotifierService:IBattleNotifierService;

    private var battleLinkData:Dictionary;

    public function BattleNotifierModel() {
      super();
    }

    public function objectLoaded() : void {
      this.battleLinkData = new Dictionary();
    }

    public function objectUnloaded() : void {
      this.battleLinkData = null;
    }

    public function setBattle(param1:Vector.<BattleNotifierData>) : void {
      var local5:BattleNotifierData = null;
      var local2:Vector.<BattleLinkData> = new Vector.<BattleLinkData>(param1.length);
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        local2[local4] = this.setAndUpdateConsumer(local5);
        local4++;
      }
      battleNotifierService.setBattle(local2);
    }

    private function setAndUpdateConsumer(param1:BattleNotifierData) : BattleLinkData {
      var local2:Long = param1.userId;
      var local3:BattleLinkData = new BattleLinkData(local2,param1);
      this.battleLinkData[local2] = local3;
      this.setBattleLinkForConsumer(local2,local3);
      return local3;
    }

    private function setBattleLinkForConsumer(param1:Long, param2:BattleLinkData) : void {
      var local4:UserInfoConsumer = null;
      var local3:UserNotifier = UserNotifier(object.adapt(UserNotifier));
      if(local3.hasDataConsumer(param1)) {
        local4 = local3.getDataConsumer(param1);
        local4.setBattleUrl(param2);
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      if(param1 in this.battleLinkData) {
        param2.setBattleUrl(this.battleLinkData[param1]);
      }
    }

    public function remove(param1:Long) : void {
      delete this.battleLinkData[param1];
      this.setBattleLinkForConsumer(param1,null);
    }

    public function leaveBattle(param1:Long) : void {
      battleNotifierService.leaveBattle(param1);
      this.remove(param1);
    }

    public function leaveGroup(param1:Long) : void {
      this.remove(param1);
    }
  }
}
