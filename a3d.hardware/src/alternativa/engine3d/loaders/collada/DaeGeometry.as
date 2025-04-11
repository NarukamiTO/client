package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.objects.Mesh;

  use namespace collada;
  use namespace alternativa3d;
  use namespace daeAlternativa3DMesh;

  public class DaeGeometry extends DaeElement {
    private var primitives:Vector.<DaePrimitive>;
    private var vertices:DaeVertices;

    public function DaeGeometry(param1:XML, param2:DaeDocument) {
      super(param1,param2);
      this.constructVertices();
    }

    private function constructVertices() : void {
      var local1:XML = data.mesh.vertices[0];
      if(local1 != null) {
        this.vertices = new DaeVertices(local1,document);
        document.vertices[this.vertices.id] = this.vertices;
      }
    }

    override protected function parseImplementation() : Boolean {
      if(this.vertices != null) {
        return this.parsePrimitives();
      }
      return false;
    }

    private function parsePrimitives() : Boolean {
      var local4:XML = null;
      this.primitives = new Vector.<DaePrimitive>();
      var local1:XMLList = data.mesh.children();
      var local2:int = 0;
      var local3:int = int(local1.length());
      while(local2 < local3) {
        local4 = local1[local2];
        switch(local4.localName()) {
          case "polygons":
          case "polylist":
          case "triangles":
          case "trifans":
          case "tristrips":
            this.primitives.push(new DaePrimitive(local4,document));
            break;
        }
        local2++;
      }
      return true;
    }

    public function parseMesh(param1:Object) : Mesh {
      var local2:Mesh = null;
      if(data.mesh.length() > 0) {
        local2 = new Mesh();
        this.fillInMesh(local2,param1);
        this.cleanVertices(local2);
        local2.calculateFacesNormals(true);
        local2.calculateBounds();
        return local2;
      }
      return null;
    }

    public function fillInMesh(param1:Mesh, param2:Object) : Vector.<Vertex> {
      var local6:DaePrimitive = null;
      this.vertices.parse();
      var local3:Vector.<Vertex> = this.vertices.fillInMesh(param1);
      var local4:int = 0;
      var local5:int = int(this.primitives.length);
      while(local4 < local5) {
        local6 = this.primitives[local4];
        local6.parse();
        if(local6.verticesEquals(this.vertices)) {
          local6.fillInMesh(param1,local3,param2[local6.materialSymbol]);
        }
        local4++;
      }
      return local3;
    }

    public function cleanVertices(param1:Mesh) : void {
      var local2:Vertex = param1.alternativa3d::vertexList;
      while(local2 != null) {
        local2.alternativa3d::index = 0;
        local2.alternativa3d::value = null;
        local2 = local2.alternativa3d::next;
      }
    }
  }
}
