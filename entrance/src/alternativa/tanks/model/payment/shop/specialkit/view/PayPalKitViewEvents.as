package alternativa.tanks.model.payment.shop.specialkit.view {
  import platform.client.fp10.core.type.IGameObject;

  public class PayPalKitViewEvents implements PayPalKitView {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayPalKitViewEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
