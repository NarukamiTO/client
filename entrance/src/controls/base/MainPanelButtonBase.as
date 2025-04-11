package controls.base {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;

  public class MainPanelButtonBase extends TankBaseButton {
    private static const LABEL_POSITION_Y:int = 4;

    private var _labelBase:LabelBase;
    private var iconData:BitmapData;

    public function MainPanelButtonBase(param1:Class) {
      this.iconData = new param1().bitmapData;
      _icon = new Bitmap(this.iconData);
      setIconCoords(3,2);
      super();
      this._labelBase = new LabelBase();
      this._labelBase.x = 18;
      this._labelBase.y = LABEL_POSITION_Y;
      this._labelBase.width = this.width - 18;
      this._labelBase.autoSize = TextFieldAutoSize.CENTER;
      this._labelBase.mouseEnabled = false;
      addChild(this._labelBase);
    }

    override public function set label(param1:String) : void {
      this._labelBase.text = param1;
    }

    override protected function onMouseEvent(param1:MouseEvent) : void {
      super.onMouseEvent(param1);
      var local2:int = param1.type == MouseEvent.MOUSE_DOWN ? 1 : 0;
      this._labelBase.y = LABEL_POSITION_Y + local2;
    }
  }
}
