package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;

  use namespace alternativa3d;

  public class AmbientLight extends Light3D {
    public function AmbientLight(param1:uint) {
      super();
      this.color = param1;
      calculateBounds();
    }

    override public function clone() : Object3D {
      var local1:AmbientLight = new AmbientLight(color);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override alternativa3d function drawDebug(param1:Camera3D, param2:Canvas) : void {
      var local4:Canvas = null;
      var local3:int = int(param1.alternativa3d::checkInDebug(this));
      if(local3 > 0) {
        local4 = param2.alternativa3d::getChildCanvas(true,false);
        if(Boolean(local3 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
        }
        if(Boolean(local3 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,local4,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
        }
      }
    }
  }
}
