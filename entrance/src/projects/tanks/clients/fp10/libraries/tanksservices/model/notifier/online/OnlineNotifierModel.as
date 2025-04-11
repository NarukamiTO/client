package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online {
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.online.IOnlineNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierData;
  import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;

  [ModelInfo]
  public class OnlineNotifierModel extends OnlineNotifierModelBase implements IOnlineNotifierModelBase, UserRefresh {
    [Inject]
    public static var onlineNotifierService:IOnlineNotifierService;

    public function OnlineNotifierModel() {
      super();
    }

    private static function convertToClientData(param1:OnlineNotifierData) : ClientOnlineNotifierData {
      return new ClientOnlineNotifierData(param1.userId,param1.online,param1.serverNumber);
    }

    public function setOnline(param1:Vector.<OnlineNotifierData>) : void {
      var local5:ClientOnlineNotifierData = null;
      var local2:Vector.<ClientOnlineNotifierData> = new Vector.<ClientOnlineNotifierData>(param1.length);
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = convertToClientData(param1[local4]);
        this.setAndUpdateConsumer(local5);
        local2[local4] = local5;
        local4++;
      }
      onlineNotifierService.setOnline(local2);
    }

    private function setAndUpdateConsumer(param1:ClientOnlineNotifierData) : void {
      var local4:UserInfoConsumer = null;
      var local2:Long = param1.userId;
      onlineNotifierService.addUserOnlineData(param1);
      var local3:UserNotifier = UserNotifier(object.adapt(UserNotifier));
      if(local3.hasDataConsumer(local2)) {
        local4 = local3.getDataConsumer(local2);
        local4.setOnline(param1.online,param1.serverNumber);
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      var local3:ClientOnlineNotifierData = null;
      if(onlineNotifierService.hasUserOnlineData(param1)) {
        local3 = onlineNotifierService.getUserOnlineData(param1);
        param2.setOnline(local3.online,local3.serverNumber);
      }
    }

    public function remove(param1:Long) : void {
      onlineNotifierService.removeUserOnlineData(param1);
    }
  }
}
