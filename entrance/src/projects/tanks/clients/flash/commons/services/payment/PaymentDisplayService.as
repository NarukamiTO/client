package projects.tanks.clients.flash.commons.services.payment {
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public interface PaymentDisplayService extends IEventDispatcher {
    function openPayment() : void;
    function openPaymentAt(param1:ShopCategoryEnum) : void;
    function openPaymentForGarageItem(param1:IGameObject) : void;
    function openPaymentForShopItem(param1:IGameObject) : void;
    function closePayment() : void;
    function loadPayment() : void;
    function reloadPayment() : void;
    function handlePaymentLoadingComplete() : void;
    function handlePaymentUnloadingComplete() : void;
    function isPaymentDisplayed() : Boolean;
  }
}
