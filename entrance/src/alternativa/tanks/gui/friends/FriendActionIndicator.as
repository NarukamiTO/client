package alternativa.tanks.gui.friends {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;

  public class FriendActionIndicator extends Sprite {
    private static var yesIconClass:Class = FriendActionIndicator_yesIconClass;
    private static var yesIconBitmapData:BitmapData = Bitmap(new yesIconClass()).bitmapData;
    private static var noIconClass:Class = FriendActionIndicator_noIconClass;
    private static var noIconBitmapData:BitmapData = Bitmap(new noIconClass()).bitmapData;

    public static const YES:int = 0;
    public static const NO:int = 1;

    public function FriendActionIndicator(param1:int) {
      var local2:Bitmap = null;
      super();
      this.tabChildren = false;
      this.tabEnabled = false;
      this.buttonMode = this.useHandCursor = true;
      switch(param1) {
        case YES:
          local2 = new Bitmap(yesIconBitmapData);
          break;
        case NO:
          local2 = new Bitmap(noIconBitmapData);
      }
      addChild(local2);
    }
  }
}
