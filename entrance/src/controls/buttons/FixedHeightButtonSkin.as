package controls.buttons {
  public class FixedHeightButtonSkin {
    private var _up:FixedHeightRectangleSkin;
    private var _over:FixedHeightRectangleSkin;
    private var _down:FixedHeightRectangleSkin;
    private var _disabled:FixedHeightRectangleSkin;

    public function FixedHeightButtonSkin(param1:FixedHeightRectangleSkin, param2:FixedHeightRectangleSkin, param3:FixedHeightRectangleSkin, param4:FixedHeightRectangleSkin) {
      super();
      this._up = param1;
      this._over = param2;
      this._down = param3;
      this._disabled = param4;
    }

    public function get up() : FixedHeightRectangleSkin {
      return this._up;
    }

    public function get over() : FixedHeightRectangleSkin {
      return this._over;
    }

    public function get down() : FixedHeightRectangleSkin {
      return this._down;
    }

    public function get disabled() : FixedHeightRectangleSkin {
      return this._disabled;
    }
  }
}
