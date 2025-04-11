package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage {
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;

  public interface UserGarageActionsService extends IEventDispatcher {
    function selectItem(param1:IGameObject) : void;
    function equipItem(param1:IGameObject) : void;
    function unmountItem(param1:IGameObject) : void;
    function buyItem(param1:IGameObject) : void;
    function buyItemModification(param1:IGameObject) : void;
    function upgradeItem(param1:IGameObject) : void;
    function chooseItemCount(param1:IGameObject) : void;
    function notEnoughCrystalsForBuying(param1:IGameObject) : void;
    function purchaseAccepted(param1:IGameObject) : void;
    function purchaseDeclined(param1:IGameObject) : void;
  }
}
