package alternativa.tanks.models.weapon.thunder {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import flash.display.BlendMode;

  internal class Trail extends Mesh {
    public function Trail(param1:Number, param2:Material) {
      super();
      var local3:Number = 4;
      var local4:Number = 240 * param1;
      var local5:Vertex = this.createVertex(-local3,0,0,0,0);
      var local6:Vertex = this.createVertex(local3,0,0,0,1);
      var local7:Vertex = this.createVertex(0,local4,0,1,0.5);
      this.createFace(local5,local6,local7).material = param2;
      this.createFace(local7,local6,local5).material = param2;
      calculateFacesNormals(true);
      calculateBounds();
      blendMode = BlendMode.SCREEN;
      alpha = 0.3;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex {
      var local6:Vertex = new Vertex();
      local6.next = vertexList;
      vertexList = local6;
      local6.x = param1;
      local6.y = param2;
      local6.z = param3;
      local6.u = param4;
      local6.v = param5;
      return local6;
    }

    private function createFace(param1:Vertex, param2:Vertex, param3:Vertex) : Face {
      var local4:Face = new Face();
      local4.next = faceList;
      faceList = local4;
      local4.wrapper = new Wrapper();
      local4.wrapper.vertex = param1;
      local4.wrapper.next = new Wrapper();
      local4.wrapper.next.vertex = param2;
      local4.wrapper.next.next = new Wrapper();
      local4.wrapper.next.next.vertex = param3;
      return local4;
    }
  }
}
