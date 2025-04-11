package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.objects.Mesh;
  import flash.geom.Vector3D;

  use namespace alternativa3d;

  public class Shadow {
    public var mapSize:int;
    public var blur:int;
    public var attenuation:Number;
    public var nearDistance:Number;
    public var farDistance:Number;
    public var color:int;
    public var alpha:Number;
    public var direction:Vector3D = new Vector3D(0,0,-1);
    public var offset:Number = 0;
    public var backFadeRange:Number = 0;

    private var casters:Vector.<Mesh> = new Vector.<Mesh>();
    private var castersCount:int = 0;

    public function Shadow(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:int = 0, param7:Number = 1) {
      super();
      this.mapSize = param1;
      this.blur = param2;
      this.attenuation = param3;
      this.nearDistance = param4;
      this.farDistance = param5;
      this.color = param6;
      this.alpha = param7;
    }

    public function addCaster(param1:Mesh) : void {
      this.casters[this.castersCount] = param1;
      ++this.castersCount;
    }

    public function removeCaster(param1:Mesh) : void {
      var local2:int = 0;
      while(local2 < this.castersCount) {
        if(this.casters[local2] == param1) {
          --this.castersCount;
          while(local2 < this.castersCount) {
            this.casters[local2] = this.casters[int(local2 + 1)];
            local2++;
          }
          this.casters.length = this.castersCount;
          break;
        }
        local2++;
      }
    }

    public function removeAllCasters() : void {
      this.castersCount = 0;
      this.casters.length = 0;
    }
  }
}
