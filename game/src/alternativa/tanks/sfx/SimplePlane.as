package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.objects.Mesh;

  public class SimplePlane extends Mesh {
    protected var a:Vertex;
    protected var b:Vertex;
    protected var c:Vertex;
    protected var d:Vertex;

    private var originX:Number;
    private var originY:Number;

    public function SimplePlane(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.originX = param3;
      this.originY = param4;
      boundMinX = -param3 * param1;
      boundMaxX = boundMinX + param1;
      boundMinY = -param4 * param2;
      boundMaxY = boundMinY + param2;
      boundMinZ = 0;
      boundMaxZ = 0;
      var local5:Vector.<Number> = Vector.<Number>([boundMinX,boundMinY,0,boundMaxX,boundMinY,0,boundMaxX,boundMaxY,0,boundMinX,boundMaxY,0]);
      var local6:Vector.<Number> = Vector.<Number>([0,1,1,1,1,0,0,0]);
      var local7:Vector.<int> = Vector.<int>([4,0,1,2,3]);
      addVerticesAndFaces(local5,local6,local7,true);
      calculateFacesNormals();
      this.writeVertices();
    }

    private function writeVertices() : void {
      var local1:Vector.<Vertex> = this.vertices;
      this.a = local1[0];
      this.b = local1[1];
      this.c = local1[2];
      this.d = local1[3];
    }

    public function setUVs(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void {
      this.a.u = param1;
      this.a.v = param2;
      this.b.u = param3;
      this.b.v = param4;
      this.c.u = param5;
      this.c.v = param6;
      this.d.u = param7;
      this.d.v = param8;
    }

    public function set width(param1:Number) : void {
      boundMinX = this.a.x = this.d.x = -this.originX * param1;
      boundMaxX = this.b.x = this.c.x = boundMinX + param1;
    }

    public function get length() : Number {
      return boundMaxY - boundMinY;
    }

    public function set length(param1:Number) : void {
      boundMinY = this.a.y = this.b.y = -this.originY * param1;
      boundMaxY = this.d.y = this.c.y = boundMinY + param1;
    }

    public function resize(param1:Number, param2:Number) : void {
      this.width = param1;
      this.length = param2;
    }
  }
}
