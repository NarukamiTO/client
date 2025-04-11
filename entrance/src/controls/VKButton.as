package controls {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class VKButton extends DefaultIconButton {
    private static const releaseBitmapVK:Class = VKButton_releaseBitmapVK;
    private static const releaseVK:BitmapData = (new releaseBitmapVK() as Bitmap).bitmapData;
    private static const pressedBitmapVK:Class = VKButton_pressedBitmapVK;
    private static const pressedVK:BitmapData = (new pressedBitmapVK() as Bitmap).bitmapData;
    private static const hoveredBitmapVK:Class = VKButton_hoveredBitmapVK;
    private static const hoveredVK:BitmapData = (new hoveredBitmapVK() as Bitmap).bitmapData;

    public function VKButton() {
      super(releaseVK,hoveredVK,pressedVK);
    }
  }
}
