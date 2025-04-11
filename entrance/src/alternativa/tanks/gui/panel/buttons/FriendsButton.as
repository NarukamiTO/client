package alternativa.tanks.gui.panel.buttons {
  import alternativa.tanks.gui.friends.button.friends.NewRequestIndicator;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class FriendsButton extends MainPanelSmallButton {
    private static const SHOW_FRIENDS_BITMAP:Class = FriendsButton_SHOW_FRIENDS_BITMAP;
    private static const SHOW_FRIENDS_BITMAP_DATA:BitmapData = Bitmap(new SHOW_FRIENDS_BITMAP()).bitmapData;

    public function FriendsButton() {
      super(SHOW_FRIENDS_BITMAP_DATA,1,1);
      var local1:NewRequestIndicator = new NewRequestIndicator();
      addChild(local1);
      local1.x = 10;
      local1.y = -4;
    }
  }
}
