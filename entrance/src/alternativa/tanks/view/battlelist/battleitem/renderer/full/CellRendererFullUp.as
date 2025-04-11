package alternativa.tanks.view.battlelist.battleitem.renderer.full {
  import controls.cellrenderer.CellRendererDefault;
  import flash.display.BitmapData;

  public class CellRendererFullUp extends CellRendererDefault {
    private static const TRANSPARENT_WHITE:uint = 16777215;

    public function CellRendererFullUp() {
      super();
      bmpLeft = new BitmapData(5,20,true,TRANSPARENT_WHITE);
      bmpCenter = new BitmapData(4,20,true,TRANSPARENT_WHITE);
      bmpRight = new BitmapData(5,20,true,TRANSPARENT_WHITE);
    }
  }
}
