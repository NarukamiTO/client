package controls.base {
  import assets.button.button_OFF_CENTER;
  import assets.button.button_OFF_LEFT;
  import assets.button.button_OFF_RIGHT;
  import assets.button.button_blue_DOWN_CENTER;
  import assets.button.button_blue_DOWN_LEFT;
  import assets.button.button_blue_DOWN_RIGHT;
  import assets.button.button_blue_OVER_CENTER;
  import assets.button.button_blue_OVER_LEFT;
  import assets.button.button_blue_OVER_RIGHT;
  import assets.button.button_blue_UP_CENTER;
  import assets.button.button_blue_UP_LEFT;
  import assets.button.button_blue_UP_RIGHT;
  import assets.button.button_def_DOWN_CENTER;
  import assets.button.button_def_DOWN_LEFT;
  import assets.button.button_def_DOWN_RIGHT;
  import assets.button.button_def_OVER_CENTER;
  import assets.button.button_def_OVER_LEFT;
  import assets.button.button_def_OVER_RIGHT;
  import assets.button.button_def_UP_CENTER;
  import assets.button.button_def_UP_LEFT;
  import assets.button.button_def_UP_RIGHT;
  import assets.button.button_red_DOWN_CENTER;
  import assets.button.button_red_DOWN_LEFT;
  import assets.button.button_red_DOWN_RIGHT;
  import assets.button.button_red_OVER_CENTER;
  import assets.button.button_red_OVER_LEFT;
  import assets.button.button_red_OVER_RIGHT;
  import assets.button.button_red_UP_CENTER;
  import assets.button.button_red_UP_LEFT;
  import assets.button.button_red_UP_RIGHT;
  import base.DiscreteMovieClip;
  import controls.ButtonState;
  import controls.Hint;
  import controls.Label;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
  import fonts.TanksFontService;

  public class TankColorButton extends DiscreteMovieClip {
    public static const DEFAULT:String = "def";
    public static const RED:String = "red";
    public static const BLUE:String = "blue";

    public var stateUP:ButtonState = new ButtonState();
    public var stateOVER:ButtonState = new ButtonState();
    public var stateDOWN:ButtonState = new ButtonState();
    public var stateOFF:ButtonState = new ButtonState();

    protected var _label:Label = new Label();
    protected var _hint:Hint;

    public var labelColor:uint = 16777215;

    private var format:TextFormat = TanksFontService.getTextFormat(12);
    private var _enable:Boolean = true;
    private var _width:int;
    private var _height:int;

    public function TankColorButton() {
      super();
      this.configUI();
      this.enable = true;
      tabEnabled = false;
    }

    public function get label() : String {
      return this._label.text;
    }

    public function set label(param1:String) : void {
      this._label.text = param1;
    }

    public function set hint(param1:String) : void {
      if(this._hint != null) {
        this._hint.text = param1;
        return;
      }
      this._hint = new Hint();
      this._hint.text = param1;
      addChild(this._hint);
      this._hint.visible = false;
      this._hint.y = -this._hint.height;
      addEventListener(MouseEvent.MOUSE_OVER,this.showHint);
      addEventListener(MouseEvent.MOUSE_OUT,this.hideHint);
    }

    private function showHint(param1:Event) : void {
      this._hint.visible = true;
    }

    private function hideHint(param1:Event) : void {
      this._hint.visible = false;
    }

    public function set enable(param1:Boolean) : void {
      this._enable = param1;
      if(this._enable) {
        this.addListeners();
      } else {
        this.removeListeners();
      }
    }

    public function get enable() : Boolean {
      return this._enable;
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.stateDOWN.width = this.stateOFF.width = this.stateOVER.width = this.stateUP.width = this._width;
      this._label.width = this._width - 4;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
    }

    public function configUI() : void {
      addChild(this.stateOFF);
      addChild(this.stateDOWN);
      addChild(this.stateOVER);
      addChild(this.stateUP);
      addChild(this._label);
      this.format.align = TextFormatAlign.CENTER;
      this.format.color = this.labelColor;
      this._label.embedFonts = TanksFontService.isEmbedFonts();
      this._label.align = TextFormatAlign.CENTER;
      this._label.autoSize = TextFieldAutoSize.NONE;
      this._label.selectable = false;
      this._label.x = 2;
      this._label.y = 6;
      this._label.width = 92;
      this._label.height = 22;
      this._label.mouseEnabled = false;
      this._label.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
    }

    protected function addListeners() : void {
      this.setState(1);
      buttonMode = true;
      mouseEnabled = true;
      mouseChildren = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    protected function removeListeners() : void {
      this.setState(0);
      buttonMode = false;
      mouseEnabled = false;
      mouseChildren = false;
      removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    protected function onMouseEvent(param1:MouseEvent) : void {
      if(this._enable) {
        switch(param1.type) {
          case MouseEvent.MOUSE_OVER:
            this.setState(2);
            this._label.y = 6;
            break;
          case MouseEvent.MOUSE_OUT:
            this.setState(1);
            this._label.y = 6;
            break;
          case MouseEvent.MOUSE_DOWN:
            this.setState(3);
            this._label.y = 7;
            break;
          case MouseEvent.MOUSE_UP:
            this.setState(1);
            this._label.y = 6;
        }
      }
    }

    protected function setState(param1:int = 0) : void {
      switch(param1) {
        case 0:
          this.stateOFF.alpha = 1;
          this.stateUP.alpha = 0;
          this.stateOVER.alpha = 0;
          this.stateDOWN.alpha = 0;
          break;
        case 1:
          this.stateOFF.alpha = 0;
          this.stateUP.alpha = 1;
          this.stateOVER.alpha = 0;
          this.stateDOWN.alpha = 0;
          break;
        case 2:
          this.stateOFF.alpha = 0;
          this.stateUP.alpha = 0;
          this.stateOVER.alpha = 1;
          this.stateDOWN.alpha = 0;
          break;
        case 3:
          this.stateOFF.alpha = 0;
          this.stateUP.alpha = 0;
          this.stateOVER.alpha = 0;
          this.stateDOWN.alpha = 1;
      }
    }

    public function setStyle(param1:String = "def") : void {
      var local3:String = null;
      var local2:String = "button_" + param1 + "_";
      local3 = "UP";
      this.stateUP.bmpLeft = this.getBitmapByName(local2 + local3 + "_LEFT");
      this.stateUP.bmpCenter = this.getBitmapByName(local2 + local3 + "_CENTER");
      this.stateUP.bmpRight = this.getBitmapByName(local2 + local3 + "_RIGHT");
      local3 = "OVER";
      this.stateOVER.bmpLeft = this.getBitmapByName(local2 + local3 + "_LEFT");
      this.stateOVER.bmpCenter = this.getBitmapByName(local2 + local3 + "_CENTER");
      this.stateOVER.bmpRight = this.getBitmapByName(local2 + local3 + "_RIGHT");
      local3 = "DOWN";
      this.stateDOWN.bmpLeft = this.getBitmapByName(local2 + local3 + "_LEFT");
      this.stateDOWN.bmpCenter = this.getBitmapByName(local2 + local3 + "_CENTER");
      this.stateDOWN.bmpRight = this.getBitmapByName(local2 + local3 + "_RIGHT");
      local3 = "OFF";
      local2 = "button_";
      this.stateOFF.bmpLeft = this.getBitmapByName(local2 + local3 + "_LEFT");
      this.stateOFF.bmpCenter = this.getBitmapByName(local2 + local3 + "_CENTER");
      this.stateOFF.bmpRight = this.getBitmapByName(local2 + local3 + "_RIGHT");
      this.width = 96;
    }

    private function getBitmapByName(param1:String) : BitmapData {
      var local2:BitmapData = new BitmapData(1,1);
      switch(param1) {
        case "button_def_UP_LEFT":
          local2 = new button_def_UP_LEFT(1,1);
          break;
        case "button_def_UP_CENTER":
          local2 = new button_def_UP_CENTER(1,1);
          break;
        case "button_def_UP_RIGHT":
          local2 = new button_def_UP_RIGHT(1,1);
          break;
        case "button_def_OVER_LEFT":
          local2 = new button_def_OVER_LEFT(1,1);
          break;
        case "button_def_OVER_CENTER":
          local2 = new button_def_OVER_CENTER(1,1);
          break;
        case "button_def_OVER_RIGHT":
          local2 = new button_def_OVER_RIGHT(1,1);
          break;
        case "button_def_DOWN_LEFT":
          local2 = new button_def_DOWN_LEFT(1,1);
          break;
        case "button_def_DOWN_CENTER":
          local2 = new button_def_DOWN_CENTER(1,1);
          break;
        case "button_def_DOWN_RIGHT":
          local2 = new button_def_DOWN_RIGHT(1,1);
          break;
        case "button_red_UP_LEFT":
          local2 = new button_red_UP_LEFT(1,1);
          break;
        case "button_red_UP_CENTER":
          local2 = new button_red_UP_CENTER(1,1);
          break;
        case "button_red_UP_RIGHT":
          local2 = new button_red_UP_RIGHT(1,1);
          break;
        case "button_red_OVER_LEFT":
          local2 = new button_red_OVER_LEFT(1,1);
          break;
        case "button_red_OVER_CENTER":
          local2 = new button_red_OVER_CENTER(1,1);
          break;
        case "button_red_OVER_RIGHT":
          local2 = new button_red_OVER_RIGHT(1,1);
          break;
        case "button_red_DOWN_LEFT":
          local2 = new button_red_DOWN_LEFT(1,1);
          break;
        case "button_red_DOWN_CENTER":
          local2 = new button_red_DOWN_CENTER(1,1);
          break;
        case "button_red_DOWN_RIGHT":
          local2 = new button_red_DOWN_RIGHT(1,1);
          break;
        case "button_blue_UP_LEFT":
          local2 = new button_blue_UP_LEFT(1,1);
          break;
        case "button_blue_UP_CENTER":
          local2 = new button_blue_UP_CENTER(1,1);
          break;
        case "button_blue_UP_RIGHT":
          local2 = new button_blue_UP_RIGHT(1,1);
          break;
        case "button_blue_OVER_LEFT":
          local2 = new button_blue_OVER_LEFT(1,1);
          break;
        case "button_blue_OVER_CENTER":
          local2 = new button_blue_OVER_CENTER(1,1);
          break;
        case "button_blue_OVER_RIGHT":
          local2 = new button_blue_OVER_RIGHT(1,1);
          break;
        case "button_blue_DOWN_LEFT":
          local2 = new button_blue_DOWN_LEFT(1,1);
          break;
        case "button_blue_DOWN_CENTER":
          local2 = new button_blue_DOWN_CENTER(1,1);
          break;
        case "button_blue_DOWN_RIGHT":
          local2 = new button_blue_DOWN_RIGHT(1,1);
          break;
        case "button_OFF_LEFT":
          local2 = new button_OFF_LEFT(1,1);
          break;
        case "button_OFF_CENTER":
          local2 = new button_OFF_CENTER(1,1);
          break;
        case "button_OFF_RIGHT":
          local2 = new button_OFF_RIGHT(1,1);
      }
      return local2;
    }
  }
}
