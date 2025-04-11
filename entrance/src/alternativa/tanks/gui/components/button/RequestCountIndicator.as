package alternativa.tanks.gui.components.button {
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;

  public class RequestCountIndicator extends Sprite {
    private static var leftIconClass:Class = RequestCountIndicator_leftIconClass;
    private static var leftIconBitmapData:BitmapData = Bitmap(new leftIconClass()).bitmapData;
    private static var centerIconClass:Class = RequestCountIndicator_centerIconClass;
    private static var centerIconBitmapData:BitmapData = Bitmap(new centerIconClass()).bitmapData;
    private static var rightIconClass:Class = RequestCountIndicator_rightIconClass;
    private static var rightIconBitmapData:BitmapData = Bitmap(new rightIconClass()).bitmapData;

    private var _leftIcon:Bitmap;
    private var _centerIcon:Bitmap;
    private var _rightIcon:Bitmap;
    private var indicatorLabel:LabelBase;
    private var _count:int = 0;

    public function RequestCountIndicator() {
      super();
      this._leftIcon = new Bitmap(leftIconBitmapData);
      addChild(this._leftIcon);
      this._centerIcon = new Bitmap(centerIconBitmapData);
      addChild(this._centerIcon);
      this._rightIcon = new Bitmap(rightIconBitmapData);
      addChild(this._rightIcon);
      this.indicatorLabel = new LabelBase();
      addChild(this.indicatorLabel);
      this.visible = false;
      this.resize();
    }

    private function resize() : void {
      this._rightIcon.x = -5;
      this.indicatorLabel.x = -int(this.indicatorLabel.width) - 1;
      this._centerIcon.width = this.getCenterIconWidth();
      this._centerIcon.x = this._rightIcon.x - this._centerIcon.width;
      this._leftIcon.x = this._centerIcon.x - this._leftIcon.width;
    }

    private function getCenterIconWidth() : int {
      var local1:int = 0;
      var local2:int = this.indicatorLabel.text.length;
      if(local2 == 1) {
        local1 = 1;
      } else if(local2 > 1) {
        local1 = (local2 - 1) * 6;
      }
      return local1;
    }

    public function set count(param1:int) : void {
      this._count = param1;
      this.visible = this._count != 0;
      this.indicatorLabel.text = param1.toString();
      this.resize();
    }

    override public function set visible(param1:Boolean) : void {
      super.visible = param1;
    }
  }
}
