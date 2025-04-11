package controls {
  import controls.base.TextFieldUtf8Base;
  import flash.display.GradientType;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import fonts.TanksFontService;
  import utils.FontParamsUtil;

  public class TextArea extends Sprite {
    private var shadow:Shape = new Shape();
    private var bg:TankWindowInner = new TankWindowInner(0);

    private const format:TextFormat = TanksFontService.getTextFormat(12);

    public var tf:TextFieldUtf8Base = new TextFieldUtf8Base();

    private var _width:int;
    private var _height:int;

    public function TextArea(param1:Boolean = true) {
      super();
      if(param1) {
        addChild(this.shadow);
        addChild(this.bg);
      }
      this.shadow.x = this.shadow.y = 1;
      addChild(this.tf);
      this.format.color = 16777215;
      this.tf.defaultTextFormat = this.format;
      this.tf.antiAliasType = AntiAliasType.ADVANCED;
      this.tf.gridFitType = GridFitType.PIXEL;
      this.tf.embedFonts = TanksFontService.isEmbedFonts();
      this.tf.sharpness = FontParamsUtil.SHARPNESS_TANK_INPUT_BASE;
      this.tf.thickness = FontParamsUtil.THICKNESS_TANK_INPUT_BASE;
      this.tf.x = this.tf.y = 5;
      this.tf.multiline = true;
      this.tf.wordWrap = true;
      this.tf.type = TextFieldType.INPUT;
      this.tf.selectable = true;
      this.tf.autoSize = TextFieldAutoSize.NONE;
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.bg.width = this._width;
      this.tf.width = this._width - 10;
      this.draw();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set height(param1:Number) : void {
      this._height = int(param1);
      this.bg.height = this._height;
      this.tf.height = this._height - 10;
      this.draw();
    }

    override public function get height() : Number {
      return this._height;
    }

    public function get text() : String {
      return this.tf.text;
    }

    public function set text(param1:String) : void {
      this.tf.text = param1;
    }

    private function draw() : void {
      var local1:Graphics = this.shadow.graphics;
      var local2:Matrix = new Matrix();
      local2.createGradientBox(this._width - 2,this._height - 2,Math.PI * 0.5);
      local1.clear();
      local1.beginGradientFill(GradientType.LINEAR,[0,0],[0.8,0],[0,255],local2);
      local1.drawRect(0,0,this._width - 2,this._height - 2);
      local1.endFill();
    }

    public function set maxChars(param1:int) : void {
      this.tf.maxChars = param1;
    }
  }
}
