package alternativa.tanks.models.weapon.shaft.sfx {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  internal class Trail1 extends Mesh {
    private var a:Vertex;
    private var b:Vertex;
    private var c:Vertex;
    private var d:Vertex;
    private var face:Face;

    public function Trail1() {
      super();
      this.a = this.createVertex(-1,-1,0,0,1);
      this.b = this.createVertex(1,-1,0,1,1);
      this.c = this.createVertex(1,0,0,1,0);
      this.d = this.createVertex(-1,0,0,0,0);
      this.face = this.createQuad(this.a,this.b,this.c,this.d);
      calculateFacesNormals();
      sorting = Sorting.DYNAMIC_BSP;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }

    public function init(param1:Number, param2:Number, param3:Number, param4:Material) : void {
      alpha = 1;
      var local5:Number = param1 / 2;
      boundMinX = this.a.x = this.d.x = -local5;
      boundMaxX = this.b.x = this.c.x = local5;
      boundMinY = this.a.y = this.b.y = -param2;
      boundMaxY = 0;
      boundMinZ = boundMaxZ = 0;
      this.a.v = this.b.v = param3;
      this.face.material = param4;
    }

    public function set width(param1:Number) : void {
      var local2:Number = param1 / 2;
      boundMinX = this.a.x = this.d.x = -local2;
      boundMaxX = this.b.x = this.c.x = local2;
    }

    public function get length() : Number {
      return -this.a.y;
    }

    public function set length(param1:Number) : void {
      if(param1 < 10) {
        param1 = 10;
      }
      boundMinY = this.a.y = this.b.y = -param1;
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

    private function createQuad(param1:Vertex, param2:Vertex, param3:Vertex, param4:Vertex) : Face {
      var local5:Face = new Face();
      local5.next = faceList;
      faceList = local5;
      local5.wrapper = new Wrapper();
      local5.wrapper.vertex = param1;
      local5.wrapper.next = new Wrapper();
      local5.wrapper.next.vertex = param2;
      local5.wrapper.next.next = new Wrapper();
      local5.wrapper.next.next.vertex = param3;
      local5.wrapper.next.next.next = new Wrapper();
      local5.wrapper.next.next.next.vertex = param4;
      return local5;
    }
  }
}
