package forms.base {
  import base.DiscreteSprite;
  import forms.TankWindowWithHeader;

  public class BaseForm extends DiscreteSprite {
    private var _window:TankWindowWithHeader;

    public function BaseForm(param1:int, param2:int) {
      super();
      this._window = new TankWindowWithHeader();
      this._window.width = param1;
      this._window.height = param2;
      addChild(this._window);
    }

    public function get window() : TankWindowWithHeader {
      return this._window;
    }
  }
}
