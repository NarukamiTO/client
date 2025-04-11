package alternativa.tanks.gui.friends {
  import alternativa.tanks.gui.friends.button.friends.RequestCountIndicator;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;

  public class FriendsWindowStateSmallButton extends Sprite implements FriendsWindowButtonType {
    private static const normalStateClass:Class = FriendsWindowStateSmallButton_normalStateClass;
    private static const normalStateBitmapData:BitmapData = Bitmap(new normalStateClass()).bitmapData;
    private static const overStateClass:Class = FriendsWindowStateSmallButton_overStateClass;
    private static const overStateBitmapData:BitmapData = Bitmap(new overStateClass()).bitmapData;
    private static const pressedStateClass:Class = FriendsWindowStateSmallButton_pressedStateClass;
    private static const pressedStateBitmapData:BitmapData = Bitmap(new pressedStateClass()).bitmapData;
    private static const inboxClass:Class = FriendsWindowStateSmallButton_inboxClass;
    private static const inboxBitmapData:BitmapData = Bitmap(new inboxClass()).bitmapData;
    private static const sentClass:Class = FriendsWindowStateSmallButton_sentClass;
    private static const sentBitmapData:BitmapData = Bitmap(new sentClass()).bitmapData;

    public static const BUTTON_WIDTH:int = 30;

    private static const ICON_X:int = 6;
    private static const ICON_Y:int = 7;

    private var type:FriendsWindowState;
    private var requestCounter:RequestCountIndicator;
    private var _isPressed:Boolean;
    private var icon:Bitmap;
    private var buttonNormalState:Bitmap;
    private var buttonOverState:Bitmap;
    private var buttonPressedState:Bitmap;

    public function FriendsWindowStateSmallButton(param1:FriendsWindowState) {
      super();
      this.type = param1;
      this.buttonPressedState = new Bitmap(pressedStateBitmapData);
      addChild(this.buttonPressedState);
      this.buttonNormalState = new Bitmap(normalStateBitmapData);
      addChild(this.buttonNormalState);
      this.buttonOverState = new Bitmap(overStateBitmapData);
      addChild(this.buttonOverState);
      this.icon = new Bitmap(this.getButtonIcon());
      this.icon.x = ICON_X;
      this.icon.y = ICON_Y;
      addChild(this.icon);
      addEventListener(MouseEvent.CLICK,this.onClick);
      this.isPressed = false;
      mouseChildren = true;
      mouseEnabled = true;
      buttonMode = true;
      useHandCursor = true;
      this.requestCounter = new RequestCountIndicator();
      this.requestCounter.y = -5;
      addChild(this.requestCounter);
    }

    private function getButtonIcon() : BitmapData {
      if(this.type == FriendsWindowState.INCOMING) {
        return inboxBitmapData;
      }
      return sentBitmapData;
    }

    private function onClick(param1:MouseEvent) : void {
      this.isPressed = !this._isPressed;
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function destroy() : void {
      removeEventListener(MouseEvent.CLICK,this.onClick);
      if(!this._isPressed) {
        removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    public function set isPressed(param1:Boolean) : void {
      this._isPressed = param1;
      if(this._isPressed) {
        this.icon.y = ICON_Y + 1;
        removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
        this.setState(3);
      } else {
        this.icon.y = ICON_Y;
        this.setState(1);
        addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    private function setState(param1:int) : void {
      switch(param1) {
        case 1:
          this.buttonNormalState.visible = true;
          this.buttonOverState.visible = false;
          this.buttonPressedState.visible = false;
          break;
        case 2:
          this.buttonOverState.visible = true;
          break;
        case 3:
          this.buttonNormalState.visible = false;
          this.buttonOverState.visible = false;
          this.buttonPressedState.visible = true;
      }
    }

    private function onMouseOver(param1:MouseEvent) : void {
      this.setState(2);
    }

    private function onMouseOut(param1:MouseEvent) : void {
      this.setState(1);
    }

    public function setRequestCount(param1:int, param2:int) : void {
      this.alignRequestCounter();
      this.requestCounter.setRequestCount(param1,param2);
    }

    public function set currentRequestCount(param1:int) : void {
      this.alignRequestCounter();
      this.requestCounter.currentCount = param1;
    }

    public function set newRequestCount(param1:int) : void {
      this.alignRequestCounter();
      this.requestCounter.newCount = param1;
    }

    private function alignRequestCounter() : void {
      this.requestCounter.x = BUTTON_WIDTH - this.requestCounter.width + 20;
    }

    override public function get width() : Number {
      return BUTTON_WIDTH;
    }

    public function getType() : FriendsWindowState {
      return this.type;
    }
  }
}
