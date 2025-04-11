package projects.tanks.clients.flash.commons.services.notification {
  import alternativa.types.Long;
  import org.osflash.signals.Signal;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class NotificationService implements INotificationService, OnConnectionClosedServiceListener {
    private var _lobbyLayoutService:ILobbyLayoutService;
    private var _queue:Array;
    private var _showNotification:INotification;

    public function NotificationService(param1:ILobbyLayoutService) {
      super();
      this._lobbyLayoutService = param1;
      this.init();
    }

    private function init() : void {
      this._queue = [];
      this._lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      this.updateQueue();
    }

    public function addNotification(param1:INotification, param2:Boolean = false) : void {
      if(param2) {
        this._queue.unshift(param1);
      } else {
        this._queue.push(param1);
      }
      this.updateQueue();
    }

    private function updateQueue() : void {
      var local1:Signal = null;
      if(this.canShow()) {
        this._showNotification = this._queue.shift();
        local1 = new Signal();
        local1.addOnce(this.onCloseNotification);
        this._showNotification.show(local1);
      }
    }

    private function canShow() : Boolean {
      return this._showNotification == null && this._queue.length != 0 && !this._lobbyLayoutService.isSwitchInProgress();
    }

    private function onCloseNotification() : void {
      this._showNotification = null;
      this.updateQueue();
    }

    public function hasNotification(param1:Long, param2:String) : Boolean {
      var local3:Boolean = false;
      var local6:INotification = null;
      if(this.isShowNotification(param1,param2)) {
        return true;
      }
      var local4:int = int(this._queue.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = this._queue[local5];
        if(local6.userId == param1 && local6.message == param2) {
          local3 = true;
          break;
        }
        local5++;
      }
      return local3;
    }

    private function isShowNotification(param1:Long, param2:String) : Boolean {
      return this._showNotification != null && this._showNotification.userId == param1 && this._showNotification.message == param2;
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      if(Boolean(this._showNotification)) {
        this._showNotification.destroy();
        this._showNotification = null;
      }
      this._queue.length = 0;
    }
  }
}
