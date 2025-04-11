package alternativa.tanks.gui.shop.paymentform.item {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.components.item.GridItemBase;
  import controls.TankWindow;

  public class PaymentFormItemBase extends GridItemBase {
    private static var WINDOW_PADDING:int = 25;

    private var form:PayModeForm;
    private var background:TankWindow;

    public function PaymentFormItemBase(param1:PayModeForm) {
      super();
      this.background = new TankWindow();
      addChild(this.background);
      this.form = param1;
      addChild(param1);
      this.render();
    }

    private function render() : void {
      this.form.x = this.form.y = WINDOW_PADDING;
      this.background.width = this.width;
      this.background.height = this.height;
    }

    override public function destroy() : void {
      super.destroy();
      this.form = null;
      this.background = null;
    }

    override public function get width() : Number {
      return this.form.width + (WINDOW_PADDING << 1);
    }

    override public function get height() : Number {
      return this.form.height + (WINDOW_PADDING << 1);
    }
  }
}
