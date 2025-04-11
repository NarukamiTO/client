package controls.cellrenderer {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class CellUnavailable extends CellRendererDefault {
    private static const normalLeft:Class = CellUnavailable_normalLeft;
    private static const normalLeftData:BitmapData = Bitmap(new normalLeft()).bitmapData;
    private static const normalCenter:Class = CellUnavailable_normalCenter;
    private static const normalCenterData:BitmapData = Bitmap(new normalCenter()).bitmapData;
    private static const normalRight:Class = CellUnavailable_normalRight;
    private static const normalRightData:BitmapData = Bitmap(new normalRight()).bitmapData;

    public function CellUnavailable() {
      super();
      bmpLeft = normalLeftData;
      bmpCenter = normalCenterData;
      bmpRight = normalRightData;
    }
  }
}
