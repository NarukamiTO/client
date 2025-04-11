package controls.base {
  import controls.Label;
  import flash.display.Bitmap;
  import flash.display.MovieClip;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class TankBaseButton extends MovieClip {
    private static const WIDTH:int = 90;
    private static const Button:Class = TankBaseButton_Button;
    private static const ButtonOver:Class = TankBaseButton_ButtonOver;
    private static const ButtonDown:Class = TankBaseButton_ButtonDown;
    private static const ButtonSelected:Class = TankBaseButton_ButtonSelected;

    public var stateNORMAL:Bitmap = new Bitmap(Bitmap(new Button()).bitmapData);
    public var stateOVER:Bitmap = new Bitmap(Bitmap(new ButtonOver()).bitmapData);
    public var stateDOWN:Bitmap = new Bitmap(Bitmap(new ButtonDown()).bitmapData);
    public var stateSELECTED:Bitmap = new Bitmap(Bitmap(new ButtonSelected()).bitmapData);

    protected var _label:Label = new Label();

    private var _short:Boolean = false;

    public var type:int = 0;

    private var _enable:Boolean = true;
    private var _labeltext:String;

    protected var _icon:Bitmap;

    private var _selected:Boolean;
    private var iconX:int;
    private var iconY:int;

    public function TankBaseButton() {
      super();
      this.configUI();
      this.enable = true;
      tabEnabled = false;
    }

    protected function setIconCoords(param1:int, param2:int) : void {
      this.iconX = param1;
      this.iconY = param2;
      this._icon.x = this.iconX;
      this._icon.y = this.iconY;
    }

    protected function configUI() : void {
      addChild(this.stateSELECTED);
      addChild(this.stateDOWN);
      addChild(this.stateOVER);
      addChild(this.stateNORMAL);
      addChild(this._icon);
      addChild(this._label);
      this._icon.x = 3;
      this._icon.y = 2;
      this.stateOVER.visible = false;
      this.stateSELECTED.visible = false;
      this.stateDOWN.visible = false;
      this.stateNORMAL.visible = true;
    }

    public function set enable(param1:Boolean) : void {
      this._enable = param1;
      if(this._enable) {
        this.enableButton();
      } else {
        this.disableButton();
      }
    }

    public function get enable() : Boolean {
      return this._enable;
    }

    private function enableButton() : void {
      this.addListeners();
      this.stateNORMAL.visible = true;
      this.stateSELECTED.visible = false;
      this.stateOVER.visible = false;
      this.stateDOWN.visible = false;
    }

    private function disableButton() : void {
      this.removeListeners();
      this.stateSELECTED.visible = true;
      this.stateOVER.visible = false;
      this.stateDOWN.visible = false;
      this.stateNORMAL.visible = false;
    }

    public function set short(param1:Boolean) : void {
      this._short = param1;
      this._label.visible = !this._short;
      this._label.width = this._short ? 1 : WIDTH - this._label.x - 3;
      this._label.text = this._short ? "" : this._labeltext;
      this.enable = this._enable;
    }

    public function set label(param1:String) : void {
      this._label.autoSize = TextFieldAutoSize.NONE;
      this._label.align = TextFormatAlign.CENTER;
      this._label.height = 19;
      this._label.x = this._icon.x + this._icon.width - 3;
      this._label.y = 4;
      this._label.width = WIDTH - this._label.x - 3;
      this._label.mouseEnabled = false;
      this._label.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      this._label.text = param1;
      this._labeltext = param1;
    }

    protected function addListeners() : void {
      buttonMode = true;
      mouseEnabled = true;
      mouseChildren = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    protected function removeListeners() : void {
      this._label.y = 4;
      buttonMode = false;
      mouseEnabled = false;
      mouseChildren = false;
      removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    protected function onMouseEvent(param1:MouseEvent) : void {
      this.stateOVER.visible = false;
      this.stateSELECTED.visible = false;
      this.stateDOWN.visible = false;
      this.stateNORMAL.visible = false;
      switch(param1.type) {
        case MouseEvent.MOUSE_OVER:
          this._label.y = 4;
          this._icon.y = this.iconY;
          this.stateOVER.visible = true;
          break;
        case MouseEvent.MOUSE_OUT:
          this._label.y = 4;
          this._icon.y = this.iconY;
          this.stateNORMAL.visible = true;
          break;
        case MouseEvent.MOUSE_DOWN:
          this._label.y = 5;
          this._icon.y = this.iconY + 1;
          this.stateDOWN.visible = true;
          break;
        case MouseEvent.MOUSE_UP:
          this.stateNORMAL.visible = true;
          this._label.y = 4;
          this._icon.y = this.iconY;
      }
    }

    public function get selected() : Boolean {
      return this._selected;
    }

    public function set selected(param1:Boolean) : void {
      this._selected = param1;
      if(this.selected) {
        this.stateSELECTED.visible = true;
        this.stateOVER.visible = false;
        this.stateDOWN.visible = false;
        this.stateNORMAL.visible = false;
        buttonMode = true;
        mouseEnabled = true;
        mouseChildren = true;
      }
    }
  }
}
