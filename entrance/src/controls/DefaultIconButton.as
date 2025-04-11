package controls {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;

  public class DefaultIconButton extends DefaultButton {
    protected var _icon:Bitmap;

    private var _releaseIcon:BitmapData;
    private var _hoveredIcon:BitmapData;
    private var _pressedIcon:BitmapData;

    public function DefaultIconButton(param1:BitmapData, param2:BitmapData, param3:BitmapData) {
      super();
      this.icon = param1;
      this._releaseIcon = param1;
      this._hoveredIcon = param2;
      this._pressedIcon = param3;
      this.width = 70;
      removeChild(stateUP);
      removeChild(stateDOWN);
      removeChild(stateOFF);
      removeChild(stateOVER);
    }

    public function set icon(param1:BitmapData) : void {
      this._icon = new Bitmap(param1);
      addChild(this._icon);
      this._icon.x = 3;
      this._icon.y = 3;
      this.width = _width;
    }

    override public function set width(param1:Number) : void {
      _width = int(param1);
      stateDOWN.width = stateOFF.width = stateOVER.width = stateUP.width = _width;
      if(this._icon != null) {
        _label.x = 20;
        _label.width = _width - 22;
      } else {
        _label.x = 2;
        _label.width = _width - 4;
      }
    }

    override protected function onMouseEvent(param1:MouseEvent) : void {
      if(enable) {
        switch(param1.type) {
          case MouseEvent.MOUSE_OVER:
            setState(2);
            this.icon = this._hoveredIcon;
            break;
          case MouseEvent.MOUSE_OUT:
            setState(1);
            this.icon = this._releaseIcon;
            break;
          case MouseEvent.MOUSE_DOWN:
            setState(3);
            this.icon = this._pressedIcon;
            break;
          case MouseEvent.MOUSE_UP:
            setState(1);
            this.icon = this._releaseIcon;
        }
      }
    }
  }
}
