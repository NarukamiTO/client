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

    public function LabelBase() {
      super();
      sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
      this._autoSize = super.autoSize;
      this._correctCursorBehaviour = true;
    }

    override public function set autoSize(value:String) : void {
      super.autoSize = value;
      this._autoSize = super.autoSize;
    }

    override public function set htmlText(value:String) : void {
      var autoWidth:Number = NaN;
      super.autoSize = this._autoSize;
      super.htmlText = value;
      if(super.autoSize == TextFieldAutoSize.CENTER) {
        autoWidth = super.width;
        super.autoSize = TextFieldAutoSize.NONE;
        super.width = Math.ceil(autoWidth) + 1;
      }
    }

    override public function set selectable(value:Boolean) : void {
      super.selectable = value;
      this.arrangeEventListeners();
    }

    public function get correctCursorBehaviour() : Boolean {
      return this._correctCursorBehaviour;
    }

    public function set correctCursorBehaviour(value:Boolean) : void {
      this._correctCursorBehaviour = value;
      this.arrangeEventListeners();
    }

    private function arrangeEventListeners() : void {
      if(super.selectable && this._correctCursorBehaviour) {
        addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      } else {
        removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    private function onMouseOver(event:MouseEvent) : void {
      Mouse.cursor = MouseCursor.IBEAM;
    }

    private function onMouseOut(event:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
    }
  }
}
