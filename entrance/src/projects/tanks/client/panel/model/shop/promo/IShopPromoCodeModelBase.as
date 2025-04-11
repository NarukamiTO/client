package projects.tanks.client.panel.model.shop.promo {
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;

  public interface IShopPromoCodeModelBase {
    function codeActivated(param1:Vector.<GoodInfoData>) : void;
    function codeActivationBlocked() : void;
    function codeIsInvalid() : void;
  }
}
