package controls.base {
  import base.DiscreteSprite;
  import controls.TextFieldUtf8;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.events.MouseEvent;
  import flash.system.Capabilities;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import fonts.TanksFontService;
  import utils.FontParamsUtil;

  public class TankInput extends DiscreteSprite {
    private static const centerClass:Class = TankInput_centerClass;
    private static const centerWrongClass:Class = TankInput_centerWrongClass;
    private static const leftClass:Class = TankInput_leftClass;
    private static const leftWrondClass:Class = TankInput_leftWrondClass;
    private static const rightClass:Class = TankInput_rightClass;
    private static const rightWrongClass:Class = TankInput_rightWrongClass;

    public static const BORDER_THICKNESS:int = 5;
    public static const DEFAULT_INPUT_HEIGHT:int = 30;
    public static const DEFAULT_INPUT_WIDTH:int = 212;

    private static const TEXT_FIELD_INTERNAL_X:int = 3;
    private static const TEXT_FIELD_INTERNAL_Y:int = 7;
    private static const VERSION_PATTERN:RegExp = /^(\w*) (\d*),(\d*),(\d*),(\d*)$/;

    private const format:TextFormat = TanksFontService.getTextFormat(12);
    private const bg:DiscreteSprite = new DiscreteSprite();
    private const leftBorder:Shape = new Shape();
    private const centerBorder:Shape = new Shape();
    private const rightBorder:Shape = new Shape();
    private const bmpLeft:BitmapData = new leftClass().bitmapData;
    private const bmpCenter:BitmapData = new centerClass().bitmapData;
    private const bmpRight:BitmapData = new rightClass().bitmapData;
    private const bmpLeftWrong:BitmapData = new leftWrondClass().bitmapData;
    private const bmpCenterWrong:BitmapData = new centerWrongClass().bitmapData;
    private const bmpRightWrong:BitmapData = new rightWrongClass().bitmapData;

    public var textField:TextField;

    private var _hidden:Boolean;
    private var _valid:Boolean = true;
    private var _width:int;
    private var _height:int;

    public function TankInput() {
      super();
      addChild(this.bg);
      this.bg.addChild(this.leftBorder);
      this.bg.addChild(this.centerBorder);
      this.bg.addChild(this.rightBorder);
      this.addInternalTextField();
      this.height = DEFAULT_INPUT_HEIGHT;
      this.width = DEFAULT_INPUT_WIDTH;
    }

    private function addInternalTextField() : void {
      var local1:String = Capabilities.version;
      var local2:Object = VERSION_PATTERN.exec(local1);
      if(local2 != null && Number(local2[2] + "." + local2[3]) < 10.1) {
        this.textField = new TextFieldUtf8();
      } else {
        this.textField = new TextField();
      }
      this.textField.defaultTextFormat = this.format;
      this.textField.antiAliasType = AntiAliasType.ADVANCED;
      this.textField.gridFitType = GridFitType.PIXEL;
      this.textField.embedFonts = TanksFontService.isEmbedFonts();
      this.textField.type = TextFieldType.INPUT;
      this.textField.x = TEXT_FIELD_INTERNAL_X;
      this.textField.y = TEXT_FIELD_INTERNAL_Y;
      this.setTextFieldHeight();
      this.textField.sharpness = FontParamsUtil.SHARPNESS_TANK_INPUT_BASE;
      this.textField.thickness = FontParamsUtil.THICKNESS_TANK_INPUT_BASE;
      this.textField.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      this.textField.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      addChild(this.textField);
    }

    private function setTextFieldHeight() : void {
      this.textField.height = this._height - 2 * BORDER_THICKNESS;
    }

    private function onMouseOver(param1:MouseEvent) : void {
      Mouse.cursor = MouseCursor.IBEAM;
    }

    private function onMouseOut(param1:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
    }

    public function set enable(param1:Boolean) : void {
      this.textField.type = param1 ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
      this.textField.selectable = param1;
      this.textField.mouseEnabled = param1;
      this.textField.mouseWheelEnabled = param1;
      this.textField.tabEnabled = param1;
    }

    override public function set x(param1:Number) : void {
      super.x = int(param1);
    }

    override public function set y(param1:Number) : void {
      super.y = int(param1);
    }

    override public function set width(param1:Number) : void {
      this._width = Math.ceil(param1);
      this.textField.width = this._width - 6;
      this.draw();
    }

    override public function set height(param1:Number) : void {
      this._height = Math.ceil(param1);
      this.setTextFieldHeight();
      this.draw();
    }

    public function set align(param1:String) : void {
      this.format.align = param1;
      this.updateTextFormat();
    }

    private function updateTextFormat() : void {
      this.textField.defaultTextFormat = this.format;
      this.textField.setTextFormat(this.format);
    }

    public function clear() : void {
      this.textField.text = "";
      this.validValue = true;
    }

    override public function set tabIndex(param1:int) : void {
      this.textField.tabIndex = param1;
    }

    public function set restrict(param1:String) : void {
      this.textField.restrict = param1;
    }

    public function set maxChars(param1:int) : void {
      this.textField.maxChars = param1;
    }

    public function get value() : String {
      return this.textField.text;
    }

    public function set value(param1:String) : void {
      this.textField.text = param1;
    }

    public function set hidden(param1:Boolean) : void {
      this._hidden = param1;
      this.textField.displayAsPassword = this._hidden;
    }

    public function get hidden() : Boolean {
      return this._hidden;
    }

    public function set validValue(param1:Boolean) : void {
      this._valid = param1;
      this.draw();
    }

    public function get validValue() : Boolean {
      return this._valid;
    }

    private function draw() : void {
      var local1:Graphics = this.leftBorder.graphics;
      local1.clear();
      local1.beginBitmapFill(this._valid ? this.bmpLeft : this.bmpLeftWrong);
      local1.drawRect(0,0,BORDER_THICKNESS,this._height);
      local1.endFill();
      this.leftBorder.x = 0;
      this.leftBorder.y = 0;
      var local2:Graphics = this.centerBorder.graphics;
      local2.clear();
      local2.beginBitmapFill(this._valid ? this.bmpCenter : this.bmpCenterWrong);
      local2.drawRect(0,0,this._width - 2 * BORDER_THICKNESS,this._height);
      local2.endFill();
      this.centerBorder.x = BORDER_THICKNESS;
      this.centerBorder.y = 0;
      var local3:Graphics = this.rightBorder.graphics;
      local3.clear();
      local3.beginBitmapFill(this._valid ? this.bmpRight : this.bmpRightWrong);
      local3.drawRect(0,0,BORDER_THICKNESS,this._height);
      local3.endFill();
      this.rightBorder.x = this._width - BORDER_THICKNESS;
      this.rightBorder.y = 0;
    }
  }
}
