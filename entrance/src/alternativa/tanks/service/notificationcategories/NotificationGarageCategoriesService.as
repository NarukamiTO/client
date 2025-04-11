package alternativa.tanks.service.notificationcategories {
  import flash.events.EventDispatcher;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class NotificationGarageCategoriesService extends EventDispatcher implements INotificationGarageCategoriesService {
    [Inject]
    public static var storageService:IStorageService;

    private static const NEW_ITEM_NOTIFICATION_SHARED_KEY:String = "NEW_ITEM_NOTIFICATION_IN_CATEGORY";

    public function NotificationGarageCategoriesService() {
      super();
    }

    public function notifyAboutAvailableItems(param1:Vector.<GarageItemInfo>) : void {
      var local4:ItemViewCategoryEnum = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3].itemViewCategory;
        if(!this.isNeedShowNewItemNotification(local4)) {
          this.markAsNeedShowNewItemNotification(local4);
        }
        local3++;
      }
      dispatchEvent(new NotificationGarageCategoriesEvent(NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE));
    }

    private function markAsNeedShowNewItemNotification(param1:ItemViewCategoryEnum) : void {
      storageService.getStorage().data[this.getNewItemNotificationSharedKey(param1)] = true;
    }

    public function categoryShowed(param1:ItemViewCategoryEnum) : void {
      storageService.getStorage().data[this.getNewItemNotificationSharedKey(param1)] = false;
    }

    public function isNeedShowNewItemNotification(param1:ItemViewCategoryEnum) : Boolean {
      var local2:Boolean = false;
      var local3:String = this.getNewItemNotificationSharedKey(param1);
      if(storageService.getStorage().data.hasOwnProperty(local3)) {
        local2 = Boolean(storageService.getStorage().data[local3]);
      }
      return local2;
    }

    private function getNewItemNotificationSharedKey(param1:ItemViewCategoryEnum) : String {
      return NEW_ITEM_NOTIFICATION_SHARED_KEY + param1.value;
    }

    public function notifyAboutNewItemsInCategory(param1:ItemViewCategoryEnum) : void {
      this.markAsNeedShowNewItemNotification(param1);
    }
  }
}
