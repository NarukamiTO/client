package alternativa.tanks.model.payment.paymentstate {
  import alternativa.tanks.gui.shop.windows.ShopWindowParams;
  import platform.client.fp10.core.type.IGameObject;

  public interface PaymentWindowService {
    function buildWindow(param1:ShopWindowParams) : void;
    function show() : void;
    function render() : void;
    function switchToBeginning() : void;
    function destroy() : void;
    function getChosenItem() : IGameObject;
    function getChosenPayMode() : IGameObject;
    function saveScrollPosition(param1:int) : void;
    function getScrollPosition() : int;
    function isStoppedOnPaymentForm() : Boolean;
    function isSingleItemPayment() : Boolean;
    function hasBonusForItem(param1:IGameObject) : Boolean;
    function hasBonusForCategory(param1:IGameObject) : Boolean;
  }
}
