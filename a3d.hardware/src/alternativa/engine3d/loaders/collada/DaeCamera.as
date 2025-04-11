package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.core.Camera3D;

  use namespace collada;

  public class DaeCamera extends DaeElement {
    public function DaeCamera(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    private function setXFov(param1:Camera3D, param2:Number) : void {
    }

    public function parseCamera() : Camera3D {
      var local3:Number = NaN;
      var local4:XML = null;
      var local5:XML = null;
      var local6:XML = null;
      var local7:XML = null;
      var local8:XML = null;
      var local9:Number = NaN;
      var local1:Camera3D = new Camera3D();
      var local2:XML = data.optics.technique_common.perspective[0];
      if(Boolean(local2)) {
        local3 = Math.PI / 180;
        local4 = local2.xfov[0];
        local5 = local2.yfov[0];
        local6 = local2.aspect_ratio[0];
        if(local6 == null) {
          if(local4 != null) {
            this.setXFov(local1,parseNumber(local4) * local3);
          } else if(local5 != null) {
            this.setXFov(local1,parseNumber(local5) * local3);
          }
        } else {
          local9 = parseNumber(local6);
          if(local4 != null) {
            this.setXFov(local1,parseNumber(local4) * local3);
          } else if(local5 != null) {
            this.setXFov(local1,local9 * parseNumber(local5) * local3);
          }
        }
        local7 = local2.znear[0];
        local8 = local2.zfar[0];
        if(local7 != null) {
          local1.nearClipping = parseNumber(local7);
        }
        if(local8 != null) {
          local1.farClipping = parseNumber(local8);
        }
      }
      return local1;
    }
  }
}
