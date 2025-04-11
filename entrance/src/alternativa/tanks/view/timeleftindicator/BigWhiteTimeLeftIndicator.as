package alternativa.tanks.view.timeleftindicator {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.PixelSnapping;

  public class BigWhiteTimeLeftIndicator extends TimeLeftIndicator {
    private static const emptyMarkerClass:Class = BigWhiteTimeLeftIndicator_emptyMarkerClass;
    private static const emptyMarkerBitmapData:BitmapData = new emptyMarkerClass().bitmapData;
    private static const fullMarkerClass:Class = BigWhiteTimeLeftIndicator_fullMarkerClass;
    private static const fullMarkerBitmapData:BitmapData = new fullMarkerClass().bitmapData;

    public function BigWhiteTimeLeftIndicator() {
      imageFull = new Bitmap(fullMarkerBitmapData,PixelSnapping.AUTO,true);
      addChild(new Bitmap(emptyMarkerBitmapData,PixelSnapping.AUTO,true));
      super();
    }
  }
}
