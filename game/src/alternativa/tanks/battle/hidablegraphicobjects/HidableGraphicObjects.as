package alternativa.tanks.battle.hidablegraphicobjects {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.Renderer;

  public class HidableGraphicObjects implements Renderer {
    private static const _objectPosition:Vector3 = new Vector3();

    private var hideRadiusSquared:Number;

    private const center:Vector3 = new Vector3();
    private const objects:Vector.<HidableGraphicObject> = new Vector.<HidableGraphicObject>();

    private var numObjects:int;

    public function HidableGraphicObjects() {
      super();
    }

    public function add(param1:HidableGraphicObject) : void {
      if(this.objects.indexOf(param1) < 0) {
        var local2:* = this.numObjects++;
        this.objects[local2] = param1;
      }
    }

    public function remove(param1:HidableGraphicObject) : void {
      var local2:int = int(this.objects.indexOf(param1));
      if(local2 >= 0) {
        param1.setAlphaMultiplier(1);
        --this.numObjects;
        this.objects[local2] = this.objects[this.numObjects];
        this.objects[this.numObjects] = null;
      }
    }

    public function setCenterAndRadius(param1:Vector3, param2:Number) : void {
      this.center.copy(param1);
      this.hideRadiusSquared = param2 * param2;
    }

    public function restore() : void {
      var local2:HidableGraphicObject = null;
      var local1:int = 0;
      while(local1 < this.numObjects) {
        local2 = this.objects[local1];
        local2.setAlphaMultiplier(1);
        local1++;
      }
    }

    public function render(param1:int, param2:int) : void {
      var local4:HidableGraphicObject = null;
      var local3:int = 0;
      while(local3 < this.numObjects) {
        local4 = this.objects[local3];
        local4.readPosition(_objectPosition);
        local4.setAlphaMultiplier(this.getAlphaMultiplier(_objectPosition));
        local3++;
      }
    }

    private function getAlphaMultiplier(param1:Vector3) : Number {
      var local2:Number = param1.x - this.center.x;
      var local3:Number = param1.y - this.center.y;
      var local4:Number = param1.z - this.center.z;
      var local5:Number = local2 * local2 + local3 * local3 + local4 * local4;
      if(local5 < this.hideRadiusSquared) {
        return Math.sqrt(local5 / this.hideRadiusSquared);
      }
      return 1;
    }

    public function clear() : void {
      this.objects.length = 0;
      this.numObjects = 0;
    }
  }
}
