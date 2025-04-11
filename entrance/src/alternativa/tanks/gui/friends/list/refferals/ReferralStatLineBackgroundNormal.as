package alternativa.tanks.gui.friends.list.refferals {
  import flash.display.Bitmap;
  import flash.display.Sprite;

  public class ReferralStatLineBackgroundNormal extends Sprite {
    public static var bg:Bitmap = new Bitmap();

    public function ReferralStatLineBackgroundNormal() {
      super();
      addChild(new Bitmap(bg.bitmapData));
    }
  }
}
