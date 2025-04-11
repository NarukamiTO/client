package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import flash.display.Sprite;

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

    override alternativa3d function drawDebug(param1:Camera3D) : void {
      var local3:Sprite = null;
      var local2:int = int(param1.alternativa3d::checkInDebug(this));
      if(local2 > 0) {
        local3 = param1.view.alternativa3d::canvas;
        if(Boolean(local2 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
        }
        if(Boolean(local2 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
        }
      }
    }
  }
}
