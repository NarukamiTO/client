package alternativa.tanks.service.temporaryitem {
  import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyService;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public class TemporaryItemService implements ITemporaryItemService {
    [Inject]
    public static var temporaryItemNotifyService:ITemporaryItemNotifyService;

    private var items:Dictionary;

    public function TemporaryItemService() {
      super();
      this.items = new Dictionary();
    }

    public function getCurrentTimeRemainingMSec(param1:IGameObject) : Number {
      var local2:ItemTimer = this.items[param1];
      if(local2 != null) {
        return local2.currentTimeRemainingMSec;
      }
      return 0;
    }

    public function startItem(param1:IGameObject, param2:int) : void {
      this.stopItem(param1);
      var local3:ItemTimer = new ItemTimer(param1,param2);
      this.items[param1] = local3;
      local3.addEventListener(Event.COMPLETE,this.onItemTimerCompleted);
    }

    public function stopItem(param1:IGameObject) : void {
      var local2:ItemTimer = this.items[param1];
      if(local2 != null) {
        local2.removeEventListener(Event.COMPLETE,this.onItemTimerCompleted);
        local2.destroy();
        delete this.items[param1];
      }
    }

    private function onItemTimerCompleted(param1:Event) : void {
      var local2:IGameObject = ItemTimer(param1.target).item;
      temporaryItemNotifyService.notifyTimeIsUp(local2);
      delete this.items[local2];
    }
  }
}
