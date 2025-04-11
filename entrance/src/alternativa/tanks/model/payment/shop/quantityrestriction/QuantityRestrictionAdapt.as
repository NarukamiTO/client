package alternativa.tanks.model.payment.shop.quantityrestriction {
  import platform.client.fp10.core.type.IGameObject;

  public class QuantityRestrictionAdapt implements QuantityRestriction {
    private var object:IGameObject;
    private var impl:QuantityRestriction;

    public function QuantityRestrictionAdapt(param1:IGameObject, param2:QuantityRestriction) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
