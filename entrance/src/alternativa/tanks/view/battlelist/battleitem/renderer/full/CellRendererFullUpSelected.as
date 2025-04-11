package alternativa.tanks.view.battlelist.battleitem.renderer.full {
  import controls.cellrenderer.CellRendererDefault;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class CellRendererFullUpSelected extends CellRendererDefault {
    private static const cellFullLeft:Class = CellRendererFullUpSelected_cellFullLeft;
    private static const cellFullLeftData:BitmapData = Bitmap(new cellFullLeft()).bitmapData;
    private static const cellFullCenter:Class = CellRendererFullUpSelected_cellFullCenter;
    private static const cellFullCenterData:BitmapData = Bitmap(new cellFullCenter()).bitmapData;
    private static const cellFullRight:Class = CellRendererFullUpSelected_cellFullRight;
    private static const cellFullRightData:BitmapData = Bitmap(new cellFullRight()).bitmapData;

    public function CellRendererFullUpSelected() {
      super();
      bmpLeft = cellFullLeftData;
      bmpCenter = cellFullCenterData;
      bmpRight = cellFullRightData;
    }
  }
}
