package controls.lifeindicator {
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.geom.Matrix;

  public class HorizontalBar extends Shape {
    private static var drawMatrix:Matrix = new Matrix();

    private var left:BitmapData;
    private var middle:BitmapData;
    private var right:BitmapData;
    private var _width:int = 0;

    public function HorizontalBar(param1:BitmapData, param2:BitmapData, param3:BitmapData) {
      super();
      this.left = param1;
      this.middle = param2;
      this.right = param3;
    }

    public function setWidth(param1:int) : void {
      if(param1 == this._width) {
        return;
      }
      this._width = param1;
      this.draw(this._width);
    }

    private function draw(param1:int) : void {
      graphics.clear();
      if(param1 <= 0) {
        return;
      }
      var local2:int = this.left.width;
      var local3:int = this.left.height;
      var local4:int = param1 >> 1;
      var local5:int = 2 * local2;
      if(param1 <= local5) {
        graphics.beginBitmapFill(this.left);
        local4 = param1 >> 1;
        graphics.drawRect(0,0,local4,local3);
        drawMatrix.tx = local4;
        graphics.beginBitmapFill(this.right,drawMatrix);
        graphics.drawRect(local4,0,param1 - local4,local3);
        graphics.endFill();
      } else {
        graphics.beginBitmapFill(this.left);
        graphics.drawRect(0,0,local2,local3);
        drawMatrix.tx = local2;
        local4 = param1 - local5;
        graphics.beginBitmapFill(this.middle,drawMatrix);
        graphics.drawRect(local2,0,local4,local3);
        drawMatrix.tx = local2 + local4;
        graphics.beginBitmapFill(this.right,drawMatrix);
        graphics.drawRect(drawMatrix.tx,0,local2,local3);
        graphics.endFill();
      }
    }
  }
}
