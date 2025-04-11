package alternativa.tanks.gui {
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public interface IGarageWindow extends IEventDispatcher {
    function mountItem(param1:IGameObject) : void;
    function unmountItem(param1:IGameObject) : void;
    function updateDiscount(param1:IGameObject) : void;
    function getSelectedItem() : IGameObject;
    function getItemInfoPanel() : ItemInfoPanel;
    function addItemToStore(param1:IGameObject) : void;
    function itemFullUpgraded(param1:IGameObject) : void;
    function removeItemFromStore(param1:IGameObject) : void;
    function removeItemFromDepot(param1:IGameObject) : void;
    function getTimersKitCouldBeBoughtContext() : Vector.<TimerKitCouldBeBoughtContext>;
    function showCategory(param1:ItemViewCategoryEnum) : void;
    function showItemInCategory(param1:IGameObject) : void;
    function isItemInStore(param1:IGameObject) : Boolean;
    function isItemInDepot(param1:IGameObject) : Boolean;
    function addItemToDepot(param1:IGameObject) : void;
    function setCategoryButtonVisibility(param1:ItemViewCategoryEnum, param2:Boolean) : void;
  }
}
