package alternativa.tanks.gui.frames {
  import flash.display.BitmapData;
  import utils.FlipBitmapDataUtils;

  public class FrameSkin {
    protected var _leftTopCorner:BitmapData;
    protected var _frameLinePoint:BitmapData;

    private var _leftBottomCorner:BitmapData;
    private var _rightTopCorner:BitmapData;
    private var _rightBottomCorner:BitmapData;

    public function FrameSkin(param1:Class, param2:Class) {
      super();
      this._leftTopCorner = new param1().bitmapData;
      this._leftBottomCorner = FlipBitmapDataUtils.flipW(this._leftTopCorner);
      this._rightTopCorner = FlipBitmapDataUtils.flipH(this._leftTopCorner);
      this._rightBottomCorner = FlipBitmapDataUtils.flipW(this._rightTopCorner);
      this._frameLinePoint = new param2().bitmapData;
    }

    public function get leftTopCorner() : BitmapData {
      return this._leftTopCorner;
    }

    public function get frameLinePoint() : BitmapData {
      return this._frameLinePoint;
    }

    public function get leftBottomCorner() : BitmapData {
      return this._leftBottomCorner;
    }

    public function get rightTopCorner() : BitmapData {
      return this._rightTopCorner;
    }

    public function get rightBottomCorner() : BitmapData {
      return this._rightBottomCorner;
    }
  }
}
