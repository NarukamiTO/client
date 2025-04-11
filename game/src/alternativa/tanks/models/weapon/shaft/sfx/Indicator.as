package alternativa.tanks.models.weapon.shaft.sfx {
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.geom.Matrix;

  public class Indicator extends Shape {
    private static const matrix:Matrix = new Matrix();

    public function Indicator() {
      super();
    }

    public function set bitmapData(param1:BitmapData) : void {
      matrix.tx = -param1.width / 2;
      graphics.clear();
      graphics.beginBitmapFill(param1,matrix,false,true);
      graphics.drawRect(matrix.tx,0,param1.width,param1.height);
      graphics.endFill();
    }
  }
}
