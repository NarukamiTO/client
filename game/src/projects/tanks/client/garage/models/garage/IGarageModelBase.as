package projects.tanks.client.garage.models.garage {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public interface IGarageModelBase {
    function initDepot(param1:Vector.<IGameObject>) : void;
    function initMarket(param1:Vector.<IGameObject>) : void;
    function initMounted(param1:Vector.<IGameObject>) : void;
    function reloadGarage(param1:String, param2:int) : void;
    function removeDepotItem(param1:IGameObject) : void;
    function select(param1:IGameObject) : void;
    function selectFirstItemInDepot() : void;
    function showCategory(param1:ItemViewCategoryEnum) : void;
    function unmountDrone() : void;
    function updateDepotItem(param1:IGameObject, param2:int) : void;
    function updateMountedItems(param1:Vector.<IGameObject>) : void;
    function updateTemporaryItem(param1:IGameObject, param2:int) : void;
  }
}
