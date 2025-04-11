package alternativa.tanks.view.timeleftindicator {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.PixelSnapping;

  public class GreenTimeLeftIndicator extends TimeLeftIndicator {
    private static const emptyMarkerClass:Class = GreenTimeLeftIndicator_emptyMarkerClass;
    private static const emptyMarkerBitmapData:BitmapData = new emptyMarkerClass().bitmapData;
    private static const fullMarkerClass:Class = GreenTimeLeftIndicator_fullMarkerClass;
    private static const fullMarkerBitmapData:BitmapData = new fullMarkerClass().bitmapData;

    public function GreenTimeLeftIndicator() {
      imageFull = new Bitmap(fullMarkerBitmapData,PixelSnapping.AUTO,true);
      addChild(new Bitmap(emptyMarkerBitmapData,PixelSnapping.AUTO,true));
      super();
    }
  }
}
