package forms {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;

  public class CloseOrBackButton extends Sprite {
    private static const closeButtonClass:Class = CloseOrBackButton_closeButtonClass;
    private static const backButtonClass:Class = CloseOrBackButton_backButtonClass;
    private static const TYPE_BUTTON:int = 7;

    private var _closeBitmap:Bitmap;
    private var _backBitmap:Bitmap;

    public function CloseOrBackButton() {
      super();
      this.init();
    }

    private function init() : void {
      graphics.clear();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,25,25);
      graphics.endFill();
      this._backBitmap = new Bitmap(new backButtonClass().bitmapData);
      addChild(this._backBitmap);
      this._closeBitmap = new Bitmap(new closeButtonClass().bitmapData);
      addChild(this._closeBitmap);
      buttonMode = true;
      this.setEvent();
    }

    private function setEvent() : void {
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    protected function onMouseEvent(param1:MouseEvent) : void {
      switch(param1.type) {
        case MouseEvent.MOUSE_OVER:
        case MouseEvent.MOUSE_OUT:
        case MouseEvent.MOUSE_UP:
          this.y = 0;
          break;
        case MouseEvent.MOUSE_DOWN:
          this.y = 1;
      }
    }

    public function get type() : int {
      return TYPE_BUTTON;
    }

    public function get enable() : Boolean {
      return true;
    }

    public function changeOnBackButton() : void {
      this._closeBitmap.visible = false;
      this._backBitmap.visible = true;
    }

    public function changeOnCloseButton() : void {
      this._closeBitmap.visible = true;
      this._backBitmap.visible = false;
    }

    public function show() : void {
      this.visible = true;
    }

    public function hide() : void {
      this.visible = false;
    }
  }
}
