package alternativa.tanks.display {
  import alternativa.engine3d.core.Camera3D;
  import flash.display.Shape;

  public class AxisIndicator extends Shape {
    private const axis1:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0]);

    private var _size:int;

    public function AxisIndicator(param1:int) {
      super();
      this._size = param1;
    }

    public function update(param1:Camera3D) : void {
      var local5:Number = NaN;
      var local6:Number = NaN;
      graphics.clear();
      param1.composeMatrix();
      this.axis1[0] = param1.ma;
      this.axis1[1] = param1.mb;
      this.axis1[2] = param1.me;
      this.axis1[3] = param1.mf;
      this.axis1[4] = param1.mi;
      this.axis1[5] = param1.mj;
      var local2:int = this._size / 2;
      var local3:int = 0;
      var local4:int = 16;
      while(local3 < 6) {
        local5 = this.axis1[local3] + 1;
        local6 = this.axis1[int(local3 + 1)] + 1;
        graphics.lineStyle(0,255 << local4);
        graphics.moveTo(local2,local2);
        graphics.lineTo(local2 * local5,local2 * local6);
        local3 += 2;
        local4 -= 8;
      }
    }

    public function get size() : int {
      return this._size;
    }
  }
}
