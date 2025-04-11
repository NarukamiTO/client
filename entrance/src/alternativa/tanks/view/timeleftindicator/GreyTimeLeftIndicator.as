package alternativa.tanks.view.timeleftindicator {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.PixelSnapping;

  public class GreyTimeLeftIndicator extends TimeLeftIndicator {
    private static const emptyMarkerClass:Class = GreyTimeLeftIndicator_emptyMarkerClass;
    private static const emptyMarkerBitmapData:BitmapData = new emptyMarkerClass().bitmapData;
    private static const fullMarkerClass:Class = GreyTimeLeftIndicator_fullMarkerClass;
    private static const fullMarkerBitmapData:BitmapData = new fullMarkerClass().bitmapData;

    public function GreyTimeLeftIndicator() {
      imageFull = new Bitmap(fullMarkerBitmapData,PixelSnapping.AUTO,true);
      addChild(new Bitmap(emptyMarkerBitmapData,PixelSnapping.AUTO,true));
      super();
    }
  }
}
