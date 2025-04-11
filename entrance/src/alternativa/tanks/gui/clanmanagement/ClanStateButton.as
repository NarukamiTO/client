package alternativa.tanks.gui.clanmanagement {
  import controls.base.TankDefaultButton;
  import flash.events.MouseEvent;

  public class ClanStateButton extends TankDefaultButton {
    private static const ButtonCenter:Class = ClanStateButton_ButtonCenter;
    private static const ButtonLeft:Class = ClanStateButton_ButtonLeft;
    private static const ButtonRight:Class = ClanStateButton_ButtonRight;
    private static const ButtonOverCenter:Class = ClanStateButton_ButtonOverCenter;
    private static const ButtonOverLeft:Class = ClanStateButton_ButtonOverLeft;
    private static const ButtonOverRight:Class = ClanStateButton_ButtonOverRight;
    private static const ButtonDownCenter:Class = ClanStateButton_ButtonDownCenter;
    private static const ButtonDownLeft:Class = ClanStateButton_ButtonDownLeft;
    private static const ButtonDownRight:Class = ClanStateButton_ButtonDownRight;
    private static const LABEL_MARGIN:int = 26;

    public function ClanStateButton() {
      super();
      this.init();
    }

    private function init() : void {
      stateUP.bmpLeft = new ButtonLeft().bitmapData;
      stateUP.bmpCenter = new ButtonCenter().bitmapData;
      stateUP.bmpRight = new ButtonRight().bitmapData;
      stateOVER.bmpLeft = new ButtonOverLeft().bitmapData;
      stateOVER.bmpCenter = new ButtonOverCenter().bitmapData;
      stateOVER.bmpRight = new ButtonOverRight().bitmapData;
      stateDOWN.bmpLeft = new ButtonDownLeft().bitmapData;
      stateDOWN.bmpCenter = new ButtonDownCenter().bitmapData;
      stateDOWN.bmpRight = new ButtonDownRight().bitmapData;
      stateOFF.bmpLeft = new ButtonDownLeft().bitmapData;
      stateOFF.bmpCenter = new ButtonDownCenter().bitmapData;
      stateOFF.bmpRight = new ButtonDownRight().bitmapData;
    }

    override protected function onMouseEvent(param1:MouseEvent) : void {
      if(enable) {
        switch(param1.type) {
          case MouseEvent.MOUSE_OVER:
            this.setState(2);
            break;
          case MouseEvent.MOUSE_OUT:
            this.setState(1);
            break;
          case MouseEvent.MOUSE_DOWN:
            this.setState(3);
            break;
          case MouseEvent.MOUSE_UP:
            this.setState(1);
        }
      }
    }

    override protected function setState(param1:int = 0) : void {
      switch(param1) {
        case 0:
          stateOFF.alpha = 1;
          stateUP.alpha = 0;
          stateOVER.alpha = 0;
          stateDOWN.alpha = 0;
          _label.y = 7;
          break;
        case 1:
          stateOFF.alpha = 0;
          stateUP.alpha = 1;
          stateOVER.alpha = 0;
          stateDOWN.alpha = 0;
          _label.y = 6;
          break;
        case 2:
          stateOFF.alpha = 0;
          stateUP.alpha = 0;
          stateOVER.alpha = 1;
          stateDOWN.alpha = 0;
          _label.y = 6;
          break;
        case 3:
          stateOFF.alpha = 0;
          stateUP.alpha = 0;
          stateOVER.alpha = 0;
          stateDOWN.alpha = 1;
          _label.y = 7;
      }
    }

    override public function set width(param1:Number) : void {
      var local2:int = Math.ceil(_label.textWidth) + LABEL_MARGIN;
      if(local2 > param1) {
        super.width = local2;
      } else {
        super.width = param1;
      }
    }
  }
}
