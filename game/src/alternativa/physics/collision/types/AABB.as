package alternativa.physics.collision.types {
  import flash.utils.getQualifiedClassName;

  public class AABB {
    public var minX:Number = 1e+308;
    public var minY:Number = 1e+308;
    public var minZ:Number = 1e+308;
    public var maxX:Number = -1e+308;
    public var maxY:Number = -1e+308;
    public var maxZ:Number = -1e+308;

    public function AABB() {
      super();
    }

    public function setSize(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
      this.minX = param1;
      this.minY = param2;
      this.minZ = param3;
      this.maxX = param4;
      this.maxY = param5;
      this.maxZ = param6;
    }

    public function addBoundBox(param1:AABB) : void {
      this.minX = param1.minX < this.minX ? param1.minX : this.minX;
      this.minY = param1.minY < this.minY ? param1.minY : this.minY;
      this.minZ = param1.minZ < this.minZ ? param1.minZ : this.minZ;
      this.maxX = param1.maxX > this.maxX ? param1.maxX : this.maxX;
      this.maxY = param1.maxY > this.maxY ? param1.maxY : this.maxY;
      this.maxZ = param1.maxZ > this.maxZ ? param1.maxZ : this.maxZ;
    }

    public function addPoint(param1:Number, param2:Number, param3:Number) : void {
      if(param1 < this.minX) {
        this.minX = param1;
      }
      if(param1 > this.maxX) {
        this.maxX = param1;
      }
      if(param2 < this.minY) {
        this.minY = param2;
      }
      if(param2 > this.maxY) {
        this.maxY = param2;
      }
      if(param3 < this.minZ) {
        this.minZ = param3;
      }
      if(param3 > this.maxZ) {
        this.maxZ = param3;
      }
    }

    public function infinity() : void {
      this.minX = 1e+308;
      this.minY = 1e+308;
      this.minZ = 1e+308;
      this.maxX = -1e+308;
      this.maxY = -1e+308;
      this.maxZ = -1e+308;
    }

    public function intersects(param1:AABB, param2:Number) : Boolean {
      return !(this.minX > param1.maxX + param2 || this.maxX < param1.minX - param2 || this.minY > param1.maxY + param2 || this.maxY < param1.minY - param2 || this.minZ > param1.maxZ + param2 || this.maxZ < param1.minZ - param2);
    }

    public function copyFrom(param1:AABB) : void {
      this.minX = param1.minX;
      this.minY = param1.minY;
      this.minZ = param1.minZ;
      this.maxX = param1.maxX;
      this.maxY = param1.maxY;
      this.maxZ = param1.maxZ;
    }

    public function clone() : AABB {
      var local1:AABB = new AABB();
      local1.copyFrom(this);
      return local1;
    }

    public function getSizeX() : Number {
      return this.maxX - this.minX;
    }

    public function getSizeY() : Number {
      return this.maxY - this.minY;
    }

    public function getSizeZ() : Number {
      return this.maxZ - this.minZ;
    }

    public function toString() : String {
      return getQualifiedClassName(this) + "(" + this.minX.toFixed(3) + ", " + this.minY.toFixed(3) + ", " + this.minZ.toFixed(3) + ": " + this.maxX.toFixed(3) + ", " + this.maxY.toFixed(3) + ", " + this.maxZ.toFixed(3) + ")";
    }
  }
}
