package alternativa.tanks.gui.friends {
  import controls.base.DefaultButtonBase;

  public class FriendWindowButton extends DefaultButtonBase {
    private static const LABEL_MARGIN:int = 26;

    public function FriendWindowButton() {
      super();
    }

    override public function set width(param1:Number) : void {
      var local2:int = Math.ceil(_label.textWidth) + LABEL_MARGIN;
      if(local2 > param1) {
        super.width = local2;
      } else {
        super.width = param1;
      }
    }

    override public function get width() : Number {
      return _width;
    }
  }
}
