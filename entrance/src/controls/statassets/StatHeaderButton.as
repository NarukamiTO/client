package controls.statassets {
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class StatHeaderButton extends Sprite {
    private var _bg:StatLineHeader = new StatLineHeader();
    private var _label:LabelBase = new LabelBase();

    public var numSort:int = 0;

    protected var _selected:Boolean = false;
    protected var _width:int = 100;
    protected var _height:int = 20;

    public function StatHeaderButton(param1:Boolean = true) {
      super();
      this._bg.width = this._width;
      this._bg.height = this._height;
      addChild(this._bg);
      addChild(this._label);
      this._label.color = 860685;
      this._label.x = 2;
      this._label.y = 0;
      this._label.mouseEnabled = false;
      this._label.autoSize = TextFieldAutoSize.NONE;
      this._label.align = param1 ? TextFormatAlign.RIGHT : TextFormatAlign.LEFT;
      this._label.height = 19;
    }

    public function set selected(param1:Boolean) : void {
      this._selected = param1;
      this._bg.selected = this._selected;
    }

    public function set label(param1:String) : void {
      this._label.text = param1;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this._bg.width = param1;
      this._label.width = this._width - 4;
    }

    override public function set height(param1:Number) : void {
      this._height = Math.floor(param1);
      this._bg.height = param1;
    }
  }
}
