package alternativa.tanks.gui.payment.controls {
  import controls.base.BigButtonBase;
  import platform.client.fp10.core.resource.types.ImageResource;

  public class PaymentButton extends BigButtonBase {
    private var _url:String;

    public function PaymentButton(param1:ImageResource) {
      super();
      icon = param1.data;
      this.width = 155;
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      _info.width = _label.width = _width - 4;
      if(_icon != null) {
        _icon.x = int(_width / 2 - _icon.width / 2);
        _icon.y = int(25 - _icon.height / 2);
      }
    }

    public function get url() : String {
      return this._url;
    }

    public function set url(param1:String) : void {
      this._url = param1;
    }
  }
}
