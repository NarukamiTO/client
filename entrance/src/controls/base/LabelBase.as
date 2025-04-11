package controls.base {
  import controls.Label;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import utils.FontParamsUtil;

  public class LabelBase extends Label {
    private var _autoSize:String;
    private var _correctCursorBehaviour:Boolean;
    private var isButtonMode:Boolean = false;

    public function LabelBase() {
      super();
      sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
      this._autoSize = super.autoSize;
      this._correctCursorBehaviour = true;
    }

    override public function set autoSize(param1:String) : void {
      super.autoSize = param1;
      this._autoSize = super.autoSize;
    }

    override public function set htmlText(param1:String) : void {
      var local2:Number = NaN;
      super.autoSize = this._autoSize;
      super.htmlText = param1;
      if(super.autoSize == TextFieldAutoSize.CENTER) {
        local2 = super.width;
        super.autoSize = TextFieldAutoSize.NONE;
        super.width = Math.ceil(local2) + 1;
      }
    }

    public function set buttonMode(param1:Boolean) : void {
      this.isButtonMode = param1;
      this.selectable = param1;
    }

    override public function set selectable(param1:Boolean) : void {
      super.selectable = param1;
      this.arrangeEventListeners();
    }

    public function get correctCursorBehaviour() : Boolean {
      return this._correctCursorBehaviour;
    }

    public function set correctCursorBehaviour(param1:Boolean) : void {
      this._correctCursorBehaviour = param1;
      this.arrangeEventListeners();
    }

    private function arrangeEventListeners() : void {
      if(super.selectable && this._correctCursorBehaviour) {
        addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      } else {
        removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
        removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
    }

    private function onMouseOver(param1:MouseEvent) : void {
      Mouse.cursor = this.isButtonMode ? MouseCursor.BUTTON : MouseCursor.IBEAM;
    }

    private function onMouseOut(param1:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
    }
  }
}
