package controls.statassets {
  import flash.display.Bitmap;
  import flash.display.Sprite;

  public class StatLineBackgroundSelected extends Sprite {
    public static var bg:Bitmap = new Bitmap();

    public function StatLineBackgroundSelected() {
      super();
      addChild(new Bitmap(bg.bitmapData));
    }
  }
}
