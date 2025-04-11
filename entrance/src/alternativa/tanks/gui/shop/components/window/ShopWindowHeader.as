package alternativa.tanks.gui.shop.components.window {
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class ShopWindowHeader extends DiscreteSprite {
    public static const WINDOW_MARGIN:int = 11;
    public static const WINDOW_VERTICAL_MARGIN:int = 5;

    private static const crystalsImageClass:Class = ShopWindowHeader_crystalsImageClass;
    private static const crystalsImage:BitmapData = new crystalsImageClass().bitmapData;

    private var headerIcon:Bitmap;
    private var header:LabelBase;
    private var headerInner:TankWindowInner;

    public function ShopWindowHeader(param1:String) {
      super();
      this.headerInner = new TankWindowInner(0,0,TankWindowInner.TRANSPARENT);
      addChild(this.headerInner);
      this.headerIcon = new Bitmap(crystalsImage);
      addChild(this.headerIcon);
      this.headerIcon.x = WINDOW_MARGIN;
      this.headerIcon.y = WINDOW_VERTICAL_MARGIN;
      this.header = new LabelBase();
      addChild(this.header);
      this.header.multiline = true;
      this.header.wordWrap = true;
      this.header.x = this.headerIcon.x + this.headerIcon.width + WINDOW_MARGIN;
      this.header.htmlText = param1;
    }

    public function resize(param1:int) : void {
      this.headerInner.width = param1;
      this.headerInner.height = this.headerIcon.height + WINDOW_VERTICAL_MARGIN;
      this.header.width = param1 - this.header.x - WINDOW_MARGIN;
      this.header.y = this.headerIcon.height - this.header.textHeight >> 1;
    }

    override public function get height() : Number {
      return this.headerInner.height;
    }
  }
}
