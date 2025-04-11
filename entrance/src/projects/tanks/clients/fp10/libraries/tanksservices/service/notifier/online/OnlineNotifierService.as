package projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.ClientOnlineNotifierData;

  public class OnlineNotifierService extends EventDispatcher implements IOnlineNotifierService, OnConnectionClosedServiceListener {
    private var usersOnlineStatus:Dictionary = new Dictionary();

    public function OnlineNotifierService() {
      super();
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      this.usersOnlineStatus = new Dictionary();
    }

    public function setOnline(param1:Vector.<ClientOnlineNotifierData>) : void {
      dispatchEvent(new OnlineNotifierServiceEvent(OnlineNotifierServiceEvent.SET_ONLINE,param1));
    }

    public function addUserOnlineData(param1:ClientOnlineNotifierData) : void {
      this.usersOnlineStatus[param1.userId] = param1;
    }

    public function removeUserOnlineData(param1:Long) : void {
      delete this.usersOnlineStatus[param1];
    }

    public function hasUserOnlineData(param1:Long) : Boolean {
      return param1 in this.usersOnlineStatus;
    }

    public function getUserOnlineData(param1:Long) : ClientOnlineNotifierData {
      return this.usersOnlineStatus[param1];
    }
  }
}
