package alternativa.tanks.model.payment.shop.quantityrestriction {
  import platform.client.fp10.core.type.IGameObject;

  public class QuantityRestrictionEvents implements QuantityRestriction {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function QuantityRestrictionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
