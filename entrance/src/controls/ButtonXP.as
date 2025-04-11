package controls {
  import assets.button.button_def_ACTIVE_CENTER;
  import assets.button.button_def_ACTIVE_LEFT;
  import assets.button.button_def_ACTIVE_RIGHT;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import fonts.TanksFontService;

  public class ButtonXP extends Sprite {
    private var bgLeftOFF:BitmapData = new button_def_ACTIVE_LEFT();
    private var bgCenterOFF:BitmapData = new button_def_ACTIVE_CENTER();
    private var bgRightOFF:BitmapData = new button_def_ACTIVE_RIGHT();
    private var bgLeftOVER:BitmapData = new goldButtonLeft_over();
    private var bgCenterOVER:BitmapData = new goldButtonCenter_over();
    private var bgRightOVER:BitmapData = new goldButtonRight_over();
    private var bgLeftDOWN:BitmapData = new goldButtonLeft_pressed();
    private var bgCenterDOWN:BitmapData = new goldButtonCenter_pressed();
    private var bgRightDOWN:BitmapData = new goldButtonRight_pressed();
    private var bgLeftUP:BitmapData = new goldButtonLeft();
    private var bgCenterUP:BitmapData = new goldButtonCenter();
    private var bgRightUP:BitmapData = new goldButtonRight();
    private var bmpL:Bitmap = new Bitmap();
    private var bmpC:Bitmap = new Bitmap();
    private var bmpR:Bitmap = new Bitmap();
    private var icon:Bitmap = new Bitmap(new IconXP());

    protected var _label:LabelBase = new LabelBase();

    private var _enable:Boolean = true;
    private var _width:int;

    public function ButtonXP() {
      super();
      this.configUI();
      this.enable = true;
      tabEnabled = false;
    }

    private function configUI() : void {
      addChild(this.bmpL);
      addChild(this.bmpC);
      addChild(this.bmpR);
      addChild(this._label);
      addChild(this.icon);
      this.icon.x = 3;
      this.icon.y = 3;
      this._label.embedFonts = TanksFontService.isEmbedFonts();
      this._label.align = TextFormatAlign.LEFT;
      this._label.autoSize = TextFieldAutoSize.LEFT;
      this._label.selectable = false;
      this._label.x = 24;
      this._label.y = 4;
      this._label.mouseEnabled = false;
      this._label.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
    }

    public function get label() : String {
      return this._label.text;
    }

    public function set label(param1:String) : void {
      this._label.text = param1;
      this._width = this._label.textWidth + 33;
      this.draw(false);
    }

    protected function onMouseEvent(param1:MouseEvent) : void {
      if(this._enable) {
        switch(param1.type) {
          case MouseEvent.MOUSE_OVER:
            this.setState(2);
            this.icon.y = 3;
            this._label.y = 4;
            break;
          case MouseEvent.MOUSE_OUT:
            this.setState(1);
            this.icon.y = 3;
            this._label.y = 4;
            break;
          case MouseEvent.MOUSE_DOWN:
            this.setState(3);
            this.icon.y = 4;
            this._label.y = 5;
            break;
          case MouseEvent.MOUSE_UP:
            this.setState(1);
            this.icon.y = 3;
            this._label.y = 4;
        }
      }
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

    protected function setState(param1:int = 0) : void {
      switch(param1) {
        case 0:
          this.bmpL.bitmapData = this.bgLeftOFF;
          this.bmpC.bitmapData = this.bgCenterOFF;
          this.bmpR.bitmapData = this.bgRightOFF;
          break;
        case 1:
          this.bmpL.bitmapData = this.bgLeftUP;
          this.bmpC.bitmapData = this.bgCenterUP;
          this.bmpR.bitmapData = this.bgRightUP;
          break;
        case 2:
          this.bmpL.bitmapData = this.bgLeftOVER;
          this.bmpC.bitmapData = this.bgCenterOVER;
          this.bmpR.bitmapData = this.bgRightOVER;
          break;
        case 3:
          this.bmpL.bitmapData = this.bgLeftDOWN;
          this.bmpC.bitmapData = this.bgCenterDOWN;
          this.bmpR.bitmapData = this.bgRightDOWN;
      }
      this.draw(param1 == 0);
    }

    private function draw(param1:Boolean) : void {
      this.bmpC.x = this.bmpL.width;
      this.bmpC.width = this._width - this.bmpL.width - (param1 ? this.bmpR.width - 1 : this.bmpR.width);
      this.bmpR.x = this._width - (param1 ? this.bmpR.width - 1 : this.bmpR.width);
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
  }
}
