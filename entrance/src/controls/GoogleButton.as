package controls {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class GoogleButton extends DefaultIconButton {
    private static const releaseBitmapGoogle:Class = GoogleButton_releaseBitmapGoogle;
    private static const releaseGoogle:BitmapData = (new releaseBitmapGoogle() as Bitmap).bitmapData;
    private static const pressedBitmapGoogle:Class = GoogleButton_pressedBitmapGoogle;
    private static const pressedGoogle:BitmapData = (new pressedBitmapGoogle() as Bitmap).bitmapData;
    private static const hoveredBitmapGoogle:Class = GoogleButton_hoveredBitmapGoogle;
    private static const hoveredGoogle:BitmapData = (new hoveredBitmapGoogle() as Bitmap).bitmapData;

    public function GoogleButton() {
      super(releaseGoogle,hoveredGoogle,pressedGoogle);
    }
  }
}
