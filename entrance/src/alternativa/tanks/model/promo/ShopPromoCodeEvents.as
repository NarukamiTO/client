package alternativa.tanks.model.promo {
  import alternativa.tanks.gui.shop.payment.promo.PromoCodeActivateForm;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopPromoCodeEvents implements ShopPromoCode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopPromoCodeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getForm() : PromoCodeActivateForm {
      var result:PromoCodeActivateForm = null;
      var i:int = 0;
      var m:ShopPromoCode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopPromoCode(this.impl[i]);
          result = m.getForm();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
