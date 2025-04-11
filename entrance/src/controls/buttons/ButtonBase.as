package controls.buttons {
  import base.DiscreteSprite;
  import controls.Label;
  import flash.display.DisplayObject;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.Dictionary;
  import utils.FontParamsUtil;

  public class ButtonBase extends DiscreteSprite {
    private var _labelPositionY:int = 15;
    private var _labelHeight:int = 24;
    private var _labelSize:int = 14;
    private var _enabled:Boolean;
    private var upState:DisplayObject;
    private var overState:DisplayObject;
    private var downState:DisplayObject;
    private var disabledState:DisplayObject;

    protected var _label:Label = new Label();
    protected var _innerLayer:DiscreteSprite = new DiscreteSprite();

    private var state2view:Dictionary = new Dictionary();
    private var currentState:ButtonStates = ButtonStates.UP;

    public function ButtonBase(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:DisplayObject) {
      super();
      this.upState = param1;
      this.overState = param2;
      this.downState = param3;
      this.disabledState = param4;
      this._enabled = true;
      addChild(param1);
      addChild(param2);
      addChild(param3);
      addChild(param4);
      addChild(this._innerLayer);
      this._innerLayer.addChild(this._label);
      this._innerLayer.mouseEnabled = false;
      this._innerLayer.mouseChildren = false;
      this._label.align = TextFormatAlign.CENTER;
      this._label.autoSize = TextFieldAutoSize.NONE;
      this._label.selectable = false;
      this._label.x = 2;
      this._label.y = this._labelPositionY;
      this._label.height = this._labelHeight;
      this._label.size = this._labelSize;
      this._label.mouseEnabled = false;
      this._label.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      this._label.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      this._label.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
      param1.visible = true;
      param2.visible = false;
      param3.visible = false;
      param4.visible = false;
      this.state2view[ButtonStates.UP] = param1;
      this.state2view[ButtonStates.DOWN] = param3;
      this.state2view[ButtonStates.OVER] = param2;
      this.state2view[ButtonStates.DISABLED] = param4;
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
      this.width = 120;
    }

    override public function set width(param1:Number) : void {
      param1 = int(param1);
      this.upState.width = param1;
      this.overState.width = param1;
      this.downState.width = param1;
      this.disabledState.width = param1;
      this._label.width = param1 - 4;
    }

    public function set label(param1:String) : void {
      this._label.text = param1;
    }

    public function get label() : String {
      return this._label.text;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
      buttonMode = this._enabled;
      mouseEnabled = this._enabled;
      mouseChildren = this._enabled;
      if(this._enabled) {
        this.setState(ButtonStates.UP);
        this.onEnable();
      } else {
        this.setState(ButtonStates.DISABLED);
        this.onDisable();
      }
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function setState(param1:ButtonStates) : void {
      var local2:DisplayObject = null;
      var local3:DisplayObject = null;
      if(this.currentState != param1) {
        local2 = this.state2view[this.currentState];
        local3 = this.state2view[param1];
        this.currentState = param1;
        local3.visible = true;
        local2.visible = false;
        this.onStateChanged();
      }
    }

    protected function onMouseEvent(param1:MouseEvent) : void {
      if(this._enabled) {
        switch(param1.type) {
          case MouseEvent.MOUSE_OVER:
            this.setState(ButtonStates.OVER);
            break;
          case MouseEvent.MOUSE_OUT:
          case MouseEvent.MOUSE_UP:
            this.setState(ButtonStates.UP);
            break;
          case MouseEvent.MOUSE_DOWN:
            this.setState(ButtonStates.DOWN);
        }
      }
    }

    public function getState() : ButtonStates {
      return this.currentState;
    }

    protected function onStateChanged() : void {
      this._innerLayer.y = this.getState() == ButtonStates.DOWN || !this.enabled ? 1 : 0;
    }

    protected function onEnable() : void {
    }

    protected function onDisable() : void {
    }

    public function set labelPositionY(param1:int) : void {
      this._labelPositionY = param1;
      this._label.y = param1;
    }

    public function set labelHeight(param1:int) : void {
      this._labelHeight = param1;
      this._label.height = param1;
    }

    public function set labelSize(param1:int) : void {
      this._labelSize = param1;
      this._label.size = param1;
    }
  }
}
