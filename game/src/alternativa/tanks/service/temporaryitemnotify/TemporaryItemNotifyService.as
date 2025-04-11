package alternativa.tanks.service.temporaryitemnotify {
  import platform.client.fp10.core.type.IGameObject;

  public class TemporaryItemNotifyService implements ITemporaryItemNotifyService {
    private var listeners:Vector.<ITemporaryItemNotifyServiceListener>;

    public function TemporaryItemNotifyService() {
      super();
      this.listeners = new Vector.<ITemporaryItemNotifyServiceListener>();
    }

    public function addListener(param1:ITemporaryItemNotifyServiceListener) : void {
      if(this.listeners.indexOf(param1) == -1) {
        this.listeners.push(param1);
      }
    }

    public function removeListener(param1:ITemporaryItemNotifyServiceListener) : void {
      var local2:Number = Number(this.listeners.indexOf(param1));
      if(local2 >= 0) {
        this.listeners.splice(local2,1);
      }
    }

    public function notifyTimeIsUp(param1:IGameObject) : void {
      var local2:int = 0;
      while(local2 < this.listeners.length) {
        this.listeners[local2].temporaryItemTimeIsUp(param1);
        local2++;
      }
    }
  }
}
