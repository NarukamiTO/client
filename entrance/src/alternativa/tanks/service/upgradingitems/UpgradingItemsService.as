package alternativa.tanks.service.upgradingitems {
  import alternativa.tanks.model.garage.upgradingitems.UpgradingItem;
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public interface UpgradingItemsService {
    function init(param1:Vector.<GarageItemInfo>, param2:UpgradingItem) : void;
    function add(param1:GarageItemInfo, param2:CountDownTimer) : void;
    function remove(param1:IGameObject) : void;
    function reset() : void;
    function getCountDownTimer(param1:IGameObject) : CountDownTimer;
    function onMount(param1:IGameObject, param2:IGameObject) : void;
    function informServerAboutUpgradedItem(param1:IGameObject) : void;
  }
}
