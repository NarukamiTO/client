package alternativa.tanks.sfx.levelup {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;

  public class LightBeam extends Mesh {
    public function LightBeam(param1:Number) {
      super();
      var local2:Number = param1 / 2;
      var local3:Number = 0;
      var local4:Vertex = addVertex(-local2,0,param1 + local3,0,0);
      var local5:Vertex = addVertex(-local2,0,0 + local3,0,1);
      var local6:Vertex = addVertex(local2,0,0 + local3,1,1);
      var local7:Vertex = addVertex(local2,0,param1 + local3,1,0);
      addQuadFace(local4,local5,local6,local7);
      sorting = Sorting.DYNAMIC_BSP;
      calculateBounds();
      calculateFacesNormals();
    }

    public function init(param1:TextureMaterial) : void {
      setMaterialToAllFaces(param1);
    }

    public function clear() : void {
      setMaterialToAllFaces(null);
    }
  }
}
