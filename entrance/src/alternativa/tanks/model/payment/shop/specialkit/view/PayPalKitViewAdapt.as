package alternativa.tanks.model.payment.shop.specialkit.view {
  import platform.client.fp10.core.type.IGameObject;

  public class PayPalKitViewAdapt implements PayPalKitView {
    private var object:IGameObject;
    private var impl:PayPalKitView;

    public function PayPalKitViewAdapt(param1:IGameObject, param2:PayPalKitView) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
