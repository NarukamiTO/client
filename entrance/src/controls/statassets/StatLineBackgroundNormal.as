package controls.statassets {
  import flash.display.Bitmap;
  import flash.display.Sprite;

  public class StatLineBackgroundNormal extends Sprite {
    public static var bg:Bitmap = new Bitmap();

    public function StatLineBackgroundNormal() {
      super();
      addChild(new Bitmap(bg.bitmapData));
    }
  }
}
