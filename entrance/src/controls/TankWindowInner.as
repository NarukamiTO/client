package controls {
  import assets.windowinner.bitmaps.WindowComboBG;
  import assets.windowinner.elemets.WindowInnerBlink;
  import base.DiscreteSprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.geom.Rectangle;

  public class TankWindowInner extends DiscreteSprite {
    [Embed(source="/resources/inner_L.png")]
    private static const leftClass:Class = TankWindowInner_leftClass;

    [Embed(source="/resources/inner_R.png")]
    private static const rightClass:Class = TankWindowInner_rightClass;

    [Embed(source="/resources/inner_B.png")]
    private static const bottomClass:Class = TankWindowInner_bottomClass;

    [Embed(source="/resources/inner_T.png")]
    private static const topClass:Class = TankWindowInner_topClass;

    [Embed(source="/resources/inner_TL.png")]
    private static const topLeftClass:Class = TankWindowInner_topLeftClass;

    [Embed(source="/resources/inner_TR.png")]
    private static const topRightClass:Class = TankWindowInner_topRightClass;

    [Embed(source="/resources/inner_BL.png")]
    private static const bottomLeftClass:Class = TankWindowInner_bottomLeftClass;

    [Embed(source="/resources/inner_BR.png")]
    private static const bottomRightClass:Class = TankWindowInner_bottomRightClass;

    public static const RED:uint = 4284618496;
    public static const BLUE:uint = 4278201433;
    public static const GREEN:uint = 4278985229;
    public static const TRANSPARENT:uint = 16744512;

    private static var topBMP:BitmapData = new topClass().bitmapData;
    private static var bottomBMP:BitmapData = new bottomClass().bitmapData;
    private static var leftBMP:BitmapData = new leftClass().bitmapData;
    private static var rightBMP:BitmapData = new rightClass().bitmapData;
    private static var topLeftBMP:BitmapData = new topLeftClass().bitmapData;
    private static var topRightBMP:BitmapData = new topRightClass().bitmapData;
    private static var bottomLeftBMP:BitmapData = new bottomLeftClass().bitmapData;
    private static var bottomRightBMP:BitmapData = new bottomRightClass().bitmapData;

    private var _width:int;
    private var _height:int;
    private var bgBMP:BitmapData;
    private var blink:WindowInnerBlink = new WindowInnerBlink();
    private var bg:Sprite = new Sprite();
    private var top:Bitmap;
    private var left:Bitmap;
    private var right:Bitmap;
    private var bottom:Bitmap;
    private var topLeft:Bitmap;
    private var topRight:Bitmap;
    private var bottomRight:Bitmap;
    private var bottomLeft:Bitmap;
    private var _color:uint;

    public function TankWindowInner(param1:int = -1, param2:int = -1, param3:uint = 0) {
      super();
      this._width = param1;
      this._height = param2;
      this.bgBMP = param3 == 100 ? new WindowComboBG() as BitmapData : new BitmapData(1,1,true,param3);
      this.ConfigUI();
      this.draw();
      this._color = param3;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.draw();
    }

    override public function set height(param1:Number) : void {
      this._height = Math.floor(param1);
      this.draw();
    }

    private function ConfigUI() : void {
      this._width = this._width == -1 ? int(scaleX * 100) : this._width;
      this._height = this._height == -1 ? int(scaleY * 100) : this._height;
      scaleX = 1;
      scaleY = 1;
      addChild(this.bg);
      this.top = new Bitmap(topBMP);
      addChild(this.top);
      this.bottom = new Bitmap(bottomBMP);
      addChild(this.bottom);
      this.left = new Bitmap(leftBMP);
      addChild(this.left);
      this.right = new Bitmap(rightBMP);
      addChild(this.right);
      this.topLeft = new Bitmap(topLeftBMP);
      addChild(this.topLeft);
      this.topRight = new Bitmap(topRightBMP);
      addChild(this.topRight);
      this.bottomLeft = new Bitmap(bottomLeftBMP);
      addChild(this.bottomLeft);
      this.bottomRight = new Bitmap(bottomRightBMP);
      addChild(this.bottomRight);
    }

    private function draw() : void {
      var local1:Rectangle = new Rectangle(0,0,this._width - 2,this._height - 2);
      graphics.clear();
      graphics.beginBitmapFill(this.bgBMP);
      graphics.drawRect(1,1,this._width - 2,this._height - 2);
      graphics.endFill();
      this.top.x = 6;
      this.top.y = 0;
      this.top.width = this._width - 12;
      this.bottom.x = 6;
      this.bottom.y = this._height - 6;
      this.bottom.width = this._width - 12;
      this.left.x = 0;
      this.left.y = 6;
      this.left.height = this._height - 12;
      this.right.x = this._width - 6;
      this.right.y = 6;
      this.right.height = this._height - 12;
      this.topLeft.x = 0;
      this.topRight.x = this._width - 6;
      this.bottomRight.y = this.bottomLeft.y = this._height - 6;
      this.bottomLeft.x = 0;
      this.bottomRight.x = this._width - 6;
      this.blink.width = this._width - 2;
      this.blink.height = 174 * ((this._width - 2) / 310);
      this.bg.scrollRect = local1;
    }

    public function set showBlink(param1:Boolean) : void {
      var local2:int = 0;
      if(param1) {
        this.bg.addChild(this.blink);
        this.blink.x = this.blink.y = 1;
        switch(this._color) {
          case GREEN:
            local2 = 1;
            break;
          case BLUE:
            local2 = 2;
            break;
          case RED:
            local2 = 3;
        }
        this.blink.gotoAndStop(local2);
      }
    }
  }
}
