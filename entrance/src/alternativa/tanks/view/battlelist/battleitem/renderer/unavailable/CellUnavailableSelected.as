package alternativa.tanks.view.battlelist.battleitem.renderer.unavailable {
  import controls.cellrenderer.CellRendererDefault;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class CellUnavailableSelected extends CellRendererDefault {
    private static const normalLeft:Class = CellUnavailableSelected_normalLeft;
    private static const normalLeftData:BitmapData = Bitmap(new normalLeft()).bitmapData;
    private static const normalCenter:Class = CellUnavailableSelected_normalCenter;
    private static const normalCenterData:BitmapData = Bitmap(new normalCenter()).bitmapData;
    private static const normalRight:Class = CellUnavailableSelected_normalRight;
    private static const normalRightData:BitmapData = Bitmap(new normalRight()).bitmapData;

    public function CellUnavailableSelected() {
      super();
      bmpLeft = normalLeftData;
      bmpCenter = normalCenterData;
      bmpRight = normalRightData;
    }
  }
}
