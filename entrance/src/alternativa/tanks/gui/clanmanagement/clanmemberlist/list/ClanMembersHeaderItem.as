package alternativa.tanks.gui.clanmanagement.clanmemberlist.list {
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import controls.statassets.StatLineHeader;
  import flash.text.TextFieldAutoSize;

  public class ClanMembersHeaderItem extends DiscreteSprite {
    private var _bg:StatLineHeader = new StatLineHeader();
    private var _label:LabelBase = new LabelBase();

    protected var _selected:Boolean = false;
    protected var _width:int = 100;
    protected var _height:int = 20;

    public function ClanMembersHeaderItem(param1:String) {
      super();
      this._bg.width = this._width;
      this._bg.height = this._height;
      addChild(this._bg);
      addChild(this._label);
      this._label.color = 860685;
      this._label.x = 0;
      this._label.y = 0;
      this._label.mouseEnabled = false;
      this._label.autoSize = TextFieldAutoSize.NONE;
      this._label.align = param1;
      this._label.height = 18;
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

    public function setLabelPosX(param1:int) : void {
      this._label.x = param1;
    }
  }
}
