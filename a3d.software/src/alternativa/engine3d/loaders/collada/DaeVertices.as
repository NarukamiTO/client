package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.objects.Mesh;

  use namespace alternativa3d;
  use namespace collada;

  public class DaeVertices extends DaeElement {
    private var positions:DaeSource;

    public function DaeVertices(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    override protected function parseImplementation() : Boolean {
      var inputXML:XML = null;
      inputXML = data.input.(@semantic == "POSITION")[0];
      if(inputXML != null) {
        this.positions = new DaeInput(inputXML,document).prepareSource(3);
        if(this.positions != null) {
          return true;
        }
      }
      return false;
    }

    public function fillInMesh(param1:Mesh) : Vector.<Vertex> {
      var local6:int = 0;
      var local7:int = 0;
      var local8:Vertex = null;
      var local2:int = this.positions.stride;
      var local3:Vector.<Number> = this.positions.numbers;
      var local4:int = this.positions.numbers.length / local2;
      var local5:Vector.<Vertex> = new Vector.<Vertex>(local4);
      local6 = 0;
      while(local6 < local4) {
        local7 = local2 * local6;
        local8 = new Vertex();
        local8.alternativa3d::next = param1.alternativa3d::vertexList;
        param1.alternativa3d::vertexList = local8;
        local8.x = local3[local7];
        local8.y = local3[int(local7 + 1)];
        local8.z = local3[int(local7 + 2)];
        local8.alternativa3d::index = -1;
        local5[local6] = local8;
        local6++;
      }
      return local5;
    }
  }
}
