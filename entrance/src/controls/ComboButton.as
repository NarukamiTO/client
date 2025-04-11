package controls {
  import assets.combo.ComboButtonState;
  import assets.combo.ComboDownButton;
  import assets.combo.ComboOffButton;
  import assets.combo.ComboOverButton;
  import assets.combo.ComboUpButton;
  import flash.display.MovieClip;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  [Embed(source="/_assets/assets.swf", symbol="symbol613")]
  public class ComboButton extends MovieClip {
    public var stateUP:ComboButtonState = new ComboUpButton();
    public var stateOVER:ComboButtonState = new ComboOverButton();
    public var stateDOWN:ComboButtonState = new ComboDownButton();
    public var stateOFF:ComboButtonState = new ComboOffButton();
    public var _label:Label = new Label();
    public var labelColor:uint = 16777215;

    private var _enable:Boolean = true;
    private var _width:int;

    public function ComboButton() {
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

    public function set enable(param1:Boolean) : void {
      this._enable = param1;
      if(this._enable) {
        this.addListeners();
      } else {
        this.removeListeners();
      }
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.stateDOWN.width = this.stateOFF.width = this.stateOVER.width = this.stateUP.width = this._width;
      this._label.width = this._width - 37;
    }

    public function configUI() : void {
      addChild(this.stateOFF);
      addChild(this.stateDOWN);
      addChild(this.stateOVER);
      addChild(this.stateUP);
      addChild(this._label);
      this._label.color = this.labelColor;
      this._label.align = TextFormatAlign.LEFT;
      this._label.autoSize = TextFieldAutoSize.NONE;
      this._label.selectable = false;
      this._label.x = 5;
      this._label.y = 6;
      this._label.width = 92;
      this._label.height = 22;
      this._label.mouseEnabled = false;
      this._label.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
    }

    private function addListeners() : void {
      this.setState(1);
      buttonMode = true;
      mouseEnabled = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    private function removeListeners() : void {
      this.setState(0);
      buttonMode = false;
      mouseEnabled = false;
      removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    private function onMouseEvent(param1:MouseEvent) : void {
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

    private function setState(param1:int = 0) : void {
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
  }
}
