package alternativa.tanks.view.battlelist.modefilter {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import projects.tanks.client.battleservice.BattleMode;

  public class BattleModeCheckBox extends Sprite {
    private static const normalStateClass:Class = BattleModeCheckBox_normalStateClass;
    private static const normalStateBitmapData:BitmapData = Bitmap(new normalStateClass()).bitmapData;
    private static const overStateClass:Class = BattleModeCheckBox_overStateClass;
    private static const overStateBitmapData:BitmapData = Bitmap(new overStateClass()).bitmapData;
    private static const pressedStateClass:Class = BattleModeCheckBox_pressedStateClass;
    private static const pressedStateBitmapData:BitmapData = Bitmap(new pressedStateClass()).bitmapData;

    private var _isPressed:Boolean;
    private var _icon:Bitmap;
    private var _battleMode:BattleMode;
    private var _buttonNormalState:Bitmap;
    private var _buttonOverState:Bitmap;
    private var _buttonPressedState:Bitmap;

    public function BattleModeCheckBox(param1:BattleMode) {
      super();
      this._battleMode = param1;
      this._buttonPressedState = new Bitmap(pressedStateBitmapData);
      addChild(this._buttonPressedState);
      this._buttonNormalState = new Bitmap(normalStateBitmapData);
      addChild(this._buttonNormalState);
      this._buttonOverState = new Bitmap(overStateBitmapData);
      addChild(this._buttonOverState);
      this._icon = new Bitmap(BattleModeIcons.getIcon(param1));
      addChild(this._icon);
      this._icon.x = (width - this._icon.width) / 2;
      this._icon.y = (height - this._icon.height) / 2;
      addEventListener(MouseEvent.CLICK,this.onClick);
      this.isPressed = false;
      this.lock = false;
    }

    private function onClick(param1:MouseEvent) : void {
      this.isPressed = !this._isPressed;
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function get isPressed() : Boolean {
      return this._isPressed;
    }

    public function destroy() : void {
      if(hasEventListener(MouseEvent.CLICK)) {
        removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      if(hasEventListener(MouseEvent.MOUSE_OVER)) {
        removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      if(hasEventListener(MouseEvent.MOUSE_OUT)) {
        removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    public function set isPressed(param1:Boolean) : void {
      this._isPressed = param1;
      if(this._isPressed) {
        this._icon.y = (height - this._icon.height) / 2 + 1;
        removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
        this.setState(3);
      } else {
        this._icon.y = (height - this._icon.height) / 2;
        this.setState(1);
        addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    private function setState(param1:int) : void {
      switch(param1) {
        case 1:
          this._buttonNormalState.visible = true;
          this._buttonOverState.visible = false;
          this._buttonPressedState.visible = false;
          break;
        case 2:
          this._buttonOverState.visible = true;
          break;
        case 3:
          this._buttonNormalState.visible = false;
          this._buttonOverState.visible = false;
          this._buttonPressedState.visible = true;
      }
    }

    private function onMouseOver(param1:MouseEvent) : void {
      this.setState(2);
    }

    private function onMouseOut(param1:MouseEvent) : void {
      this.setState(1);
    }

    public function get battleMode() : BattleMode {
      return this._battleMode;
    }

    public function set lock(param1:Boolean) : void {
      this.mouseChildren = !param1;
      this.mouseEnabled = !param1;
      this.buttonMode = !param1;
      this.useHandCursor = !param1;
    }
  }
}
