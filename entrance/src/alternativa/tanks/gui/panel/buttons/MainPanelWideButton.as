package alternativa.tanks.gui.panel.buttons {
  import controls.base.LabelBase;
  import controls.panel.BaseButton;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;

  public class MainPanelWideButton extends BaseButton {
    private static const LABEL_POSITION_Y:int = 4;

    private var _icon:Bitmap;
    private var _buttonOverBitmap:Bitmap;
    private var _buttonNormalBitmap:Bitmap;
    private var _labelBase:LabelBase;
    private var _x:int;
    private var _y:int;

    protected var previousY:int;

    public function MainPanelWideButton(param1:Bitmap, param2:int, param3:int, param4:Bitmap, param5:Bitmap) {
      this._icon = param1;
      this._buttonNormalBitmap = param5;
      this._buttonOverBitmap = param4;
      this._x = param2;
      this._y = param3;
      super();
      this.createLabel();
    }

    private function createLabel() : void {
      this._labelBase = new LabelBase();
      this._labelBase.x = 18;
      this._labelBase.y = LABEL_POSITION_Y;
      this._labelBase.width = this.width - 18;
      this._labelBase.autoSize = TextFieldAutoSize.CENTER;
      this._labelBase.mouseEnabled = false;
      addChild(this._labelBase);
    }

    override protected function configUI() : void {
      addChild(this._buttonNormalBitmap);
      addChild(this._buttonOverBitmap);
      this._buttonOverBitmap.visible = false;
      this._icon.x = this._x;
      this._icon.y = this._y;
      addChild(this._icon);
    }

    override protected function addListeners() : void {
      buttonMode = true;
      mouseEnabled = true;
      mouseChildren = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    override protected function removeListeners() : void {
      buttonMode = false;
      mouseEnabled = false;
      mouseChildren = false;
      removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    override protected function onMouseEvent(param1:MouseEvent) : void {
      switch(param1.type) {
        case MouseEvent.MOUSE_OVER:
          this.previousY = y;
          this._buttonOverBitmap.visible = true;
          break;
        case MouseEvent.MOUSE_OUT:
          y = this.previousY;
          this._buttonOverBitmap.visible = false;
          break;
        case MouseEvent.MOUSE_DOWN:
          y = this.previousY + 1;
          this._buttonOverBitmap.visible = false;
          break;
        case MouseEvent.MOUSE_UP:
          y = this.previousY;
          this._buttonOverBitmap.visible = false;
      }
    }

    override public function set label(param1:String) : void {
      this._labelBase.htmlText = param1;
    }
  }
}
