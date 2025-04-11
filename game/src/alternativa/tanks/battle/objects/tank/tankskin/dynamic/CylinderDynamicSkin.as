package alternativa.tanks.battle.objects.tank.tankskin.dynamic {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;

  public class CylinderDynamicSkin extends CommonDynamicSkin {
    private var real2UVratio:Number;
    private var radius:Number;
    private var uvPeriod:Number;

    public function CylinderDynamicSkin(param1:Number) {
      super();
      this.uvPeriod = param1;
    }

    private static function get2UVRatio(param1:Face) : Number {
      var local2:Vector.<Vertex> = param1.vertices;
      return get2UVRatioForVertices(local2[0],local2[1]);
    }

    private static function get2UVRatioForVertices(param1:Vertex, param2:Vertex) : Number {
      var local3:Number = param1.x - param2.x;
      var local4:Number = param1.y - param2.y;
      var local5:Number = param1.z - param2.z;
      var local6:Number = Math.sqrt(local3 * local3 + local4 * local4 + local5 * local5);
      var local7:Number = param1.u - param2.u;
      var local8:Number = param1.v - param2.v;
      var local9:Number = Math.sqrt(local7 * local7 + local8 * local8);
      return local9 / local6;
    }

    override public function init() : void {
      var local1:Face = null;
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Vertex = null;
      var local7:Vertex = null;
      super.init();
      this.real2UVratio = 0;
      for each(local1 in faces) {
        this.real2UVratio += get2UVRatio(local1);
      }
      this.real2UVratio /= faces.length;
      local2 = Number.POSITIVE_INFINITY;
      local3 = Number.POSITIVE_INFINITY;
      local4 = Number.NEGATIVE_INFINITY;
      local5 = Number.NEGATIVE_INFINITY;
      for each(local6 in vertices) {
        local7 = local6;
        if(local7.x < local2) {
          local2 = Number(local7.x);
        }
        if(local7.z < local3) {
          local3 = Number(local7.z);
        }
        if(local7.x > local4) {
          local4 = Number(local7.x);
        }
        if(local7.z > local5) {
          local5 = Number(local7.z);
        }
      }
      this.radius = (local4 - local2 + local5 - local3) / 4;
      rotation = 0;
      this.rotate(0);
    }

    override public function rotate(param1:Number) : void {
      super.rotate(param1);
    }
  }
}
