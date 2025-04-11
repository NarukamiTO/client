package controls.cellrenderer {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class CellNormal extends CellRendererDefault {
    private static const normalLeft:Class = CellNormal_normalLeft;
    private static const normalLeftData:BitmapData = Bitmap(new normalLeft()).bitmapData;
    private static const normalCenter:Class = CellNormal_normalCenter;
    private static const normalCenterData:BitmapData = Bitmap(new normalCenter()).bitmapData;
    private static const normalRight:Class = CellNormal_normalRight;
    private static const normalRightData:BitmapData = Bitmap(new normalRight()).bitmapData;

    public function CellNormal() {
      super();
      bmpLeft = normalLeftData;
      bmpCenter = normalCenterData;
      bmpRight = normalRightData;
    }
  }
}
