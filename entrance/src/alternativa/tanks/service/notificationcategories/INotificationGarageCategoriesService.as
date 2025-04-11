package alternativa.tanks.service.notificationcategories {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public interface INotificationGarageCategoriesService extends IEventDispatcher {
    function notifyAboutAvailableItems(param1:Vector.<GarageItemInfo>) : void;
    function notifyAboutNewItemsInCategory(param1:ItemViewCategoryEnum) : void;
    function isNeedShowNewItemNotification(param1:ItemViewCategoryEnum) : Boolean;
    function categoryShowed(param1:ItemViewCategoryEnum) : void;
  }
}
