package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;

  use namespace alternativa3d;

  public class Decal extends Mesh {
    public var attenuation:Number = 1000000;

    public function Decal() {
      super();
      shadowMapAlphaThreshold = 100;
    }

    public function createGeometry(param1:Mesh, param2:Boolean = false) : void {
      if(!param2) {
        param1 = param1.clone() as Mesh;
      }
      alternativa3d::faceList = param1.alternativa3d::faceList;
      alternativa3d::vertexList = param1.alternativa3d::vertexList;
      param1.alternativa3d::faceList = null;
      param1.alternativa3d::vertexList = null;
      var local3:Vertex = alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::transformId = 0;
        local3.id = null;
        local3 = local3.alternativa3d::next;
      }
      var local4:Face = alternativa3d::faceList;
      while(local4 != null) {
        local4.id = null;
        local4 = local4.alternativa3d::next;
      }
      calculateBounds();
    }

    override public function clone() : Object3D {
      var local1:Decal = new Decal();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:Decal = param1 as Decal;
      this.attenuation = local2.attenuation;
    }
  }
}
