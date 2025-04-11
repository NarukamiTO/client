package alternativa.tanks.model.item.temporary {
  import alternativa.tanks.service.temporaryitem.ITemporaryItemService;
  import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.temporary.ITemporaryItemModelBase;
  import projects.tanks.client.garage.models.item.temporary.TemporaryItemModelBase;

  [ModelInfo]
  public class TemporaryItemModel extends TemporaryItemModelBase implements ITemporaryItemModelBase, ITemporaryItem, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var temporaryItemService:ITemporaryItemService;

    [Inject]
    public static var temporaryItemNotifyService:ITemporaryItemNotifyService;

    public function TemporaryItemModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:int = getInitParam().remainingTimeInSec;
      if(local1 > 0) {
        this.startTemporaryItem(object,local1);
      }
    }

    public function objectUnloaded() : void {
      temporaryItemService.stopItem(object);
    }

    public function getStopDate() : Date {
      return new Date(new Date().getTime() + temporaryItemService.getCurrentTimeRemainingMSec(object));
    }

    public function getTimeRemainingInMSec() : Number {
      return temporaryItemService.getCurrentTimeRemainingMSec(object);
    }

    public function startTiming(param1:int) : void {
      this.startTemporaryItem(object,getInitParam().lifeTimeInSec + param1);
    }

    public function setRemainingTime(param1:int) : void {
      this.startTemporaryItem(object,param1);
    }

    public function getLifeTimeInSec() : int {
      return getInitParam().lifeTimeInSec;
    }

    public function isInfinityLifeTimeItem() : Boolean {
      return getInitParam().infinityLifetimeItem;
    }

    public function markAsInfinityLifeTimeItem() : void {
      getInitParam().infinityLifetimeItem = true;
    }

    private function startTemporaryItem(param1:IGameObject, param2:int) : void {
      temporaryItemService.startItem(param1,param2);
    }
  }
}
