package controls {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class FBButton extends DefaultIconButton {
    private static const releaseBitmapFB:Class = FBButton_releaseBitmapFB;
    private static const releaseFB:BitmapData = (new releaseBitmapFB() as Bitmap).bitmapData;
    private static const pressedBitmapFB:Class = FBButton_pressedBitmapFB;
    private static const pressedFB:BitmapData = (new pressedBitmapFB() as Bitmap).bitmapData;
    private static const hoveredBitmapFB:Class = FBButton_hoveredBitmapFB;
    private static const hoveredFB:BitmapData = (new hoveredBitmapFB() as Bitmap).bitmapData;

    public function FBButton() {
      super(releaseFB,hoveredFB,pressedFB);
    }
  }
}
