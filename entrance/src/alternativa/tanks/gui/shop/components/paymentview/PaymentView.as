package alternativa.tanks.gui.shop.components.paymentview {
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import base.DiscreteSprite;

  public class PaymentView extends DiscreteSprite {
    public var window:ShopWindow;

    public function PaymentView() {
      super();
    }

    public function render(param1:int, param2:int) : void {
    }

    public function destroy() : void {
      this.window = null;
    }

    public function postRender() : void {
    }
  }
}
