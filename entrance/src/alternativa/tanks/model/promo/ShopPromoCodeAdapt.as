package alternativa.tanks.model.promo {
  import alternativa.tanks.gui.shop.payment.promo.PromoCodeActivateForm;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopPromoCodeAdapt implements ShopPromoCode {
    private var object:IGameObject;
    private var impl:ShopPromoCode;

    public function ShopPromoCodeAdapt(param1:IGameObject, param2:ShopPromoCode) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getForm() : PromoCodeActivateForm {
      var result:PromoCodeActivateForm = null;
      try {
        Model.object = this.object;
        result = this.impl.getForm();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
