package forms.contextmenu {
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.GlowFilter;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;

  public class ContextMenuLabel extends Sprite {
    private var glowFilter:GlowFilter = new GlowFilter(5898034,0.9,4,4,0);
    private var fltrs:Array = [this.glowFilter];

    protected var _label:LabelBase;

    private var _locked:Boolean;

    public function ContextMenuLabel() {
      super();
      this.init();
    }

    protected function init() : void {
      this.tabChildren = false;
      this.tabEnabled = false;
      this._label = new LabelBase();
      this._label.mouseEnabled = false;
      this._label.autoSize = TextFieldAutoSize.LEFT;
      addChild(this._label);
      buttonMode = useHandCursor = true;
      this.locked = false;
    }

    private function setEvents() : void {
      if(!hasEventListener(MouseEvent.MOUSE_OVER)) {
        addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      if(!hasEventListener(MouseEvent.MOUSE_OUT)) {
        addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    private function removeEvents() : void {
      if(hasEventListener(MouseEvent.MOUSE_OVER)) {
        removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      if(hasEventListener(MouseEvent.MOUSE_OUT)) {
        removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    public function destroy() : void {
      this.removeEvents();
      if(this._label != null && this.contains(this._label)) {
        removeChild(this._label);
      }
      this._label = null;
    }

    private function onMouseOver(param1:MouseEvent) : void {
      this.glowFilter.strength = 1;
      filters = this.fltrs;
    }

    private function onMouseOut(param1:MouseEvent = null) : void {
      this.glowFilter.strength = 0;
      filters = this.fltrs;
    }

    public function set text(param1:String) : void {
      this._label.text = param1;
    }

    public function get locked() : Boolean {
      return this._locked;
    }

    public function set locked(param1:Boolean) : void {
      this._locked = param1;
      if(this._locked) {
        this.removeEvents();
        this.onMouseOut();
      } else {
        this.setEvents();
      }
      mouseChildren = mouseEnabled = !this._locked;
      this._label.color = this._locked ? ColorConstants.ACCESS_LABEL : ColorConstants.CHAT_LABEL;
    }
  }
}
