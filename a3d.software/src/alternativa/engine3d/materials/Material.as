package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import flash.utils.getQualifiedClassName;

  use namespace alternativa3d;

  public class Material {
    public var name:String;
    public var alphaTestThreshold:Number = 0;
    public var zOffset:Boolean = false;
    public var uploadEveryFrame:Boolean = false;

    alternativa3d var useVerticesNormals:Boolean = false;

    public function Material() {
      super();
    }

    alternativa3d function get transparent() : Boolean {
      return false;
    }

    alternativa3d function set transparent(param1:Boolean) : void {
    }

    public function clone() : Material {
      var local1:Material = new Material();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    protected function clonePropertiesFrom(param1:Material) : void {
      this.name = param1.name;
      this.alphaTestThreshold = param1.alphaTestThreshold;
      this.alternativa3d::useVerticesNormals = param1.alternativa3d::useVerticesNormals;
    }

    public function toString() : String {
      var local1:String = getQualifiedClassName(this);
      return "[" + local1.substr(local1.indexOf("::") + 2) + " " + this.name + "]";
    }

    alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Face, param4:Number) : void {
      this.alternativa3d::clearLinks(param3);
    }

    alternativa3d function drawOpaque(param1:Camera3D, param2:Object, param3:Object, param4:int, param5:int, param6:Object3D) : void {
    }

    alternativa3d function drawTransparent(param1:Camera3D, param2:Object, param3:Object, param4:int, param5:int, param6:Object3D, param7:Boolean = false) : void {
    }

    alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      this.alternativa3d::clearLinks(param3);
    }

    alternativa3d function clearLinks(param1:Face) : void {
      var local2:Face = null;
      while(param1 != null) {
        local2 = param1.alternativa3d::processNext;
        param1.alternativa3d::processNext = null;
        param1 = local2;
      }
    }

    public function dispose() : void {
    }
  }
}
