package alternativa.proplib.objects {
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.Mesh;

  public class Polygon extends Mesh {
    public function Polygon(vertices:Vector.<Number>, uv:Vector.<Number>, twoSided:Boolean) {
      super();
      var numVertices:int = vertices.length / 3;
      var indices:Vector.<int> = new Vector.<int>(numVertices + 1);
      indices[0] = numVertices;
      for(var i:int = 0; i < numVertices; i++) {
        indices[i + 1] = i;
      }
      addVerticesAndFaces(vertices,uv,indices,true);
      if(twoSided) {
      }
      calculateFacesNormals();
      calculateBounds();
      sorting = Sorting.DYNAMIC_BSP;
      clipping = Clipping.FACE_CLIPPING;
    }
  }
}
