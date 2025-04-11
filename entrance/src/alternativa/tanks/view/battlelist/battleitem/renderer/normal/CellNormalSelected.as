package alternativa.tanks.view.battlelist.battleitem.renderer.normal {
  import controls.cellrenderer.CellRendererDefault;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class CellNormalSelected extends CellRendererDefault {
    private static const normalLeft:Class = CellNormalSelected_normalLeft;
    private static const normalLeftData:BitmapData = Bitmap(new normalLeft()).bitmapData;
    private static const normalCenter:Class = CellNormalSelected_normalCenter;
    private static const normalCenterData:BitmapData = Bitmap(new normalCenter()).bitmapData;
    private static const normalRight:Class = CellNormalSelected_normalRight;
    private static const normalRightData:BitmapData = Bitmap(new normalRight()).bitmapData;

    public function CellNormalSelected() {
      super();
      bmpLeft = normalLeftData;
      bmpCenter = normalCenterData;
      bmpRight = normalRightData;
    }
  }
}
