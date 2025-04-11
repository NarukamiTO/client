package alternativa.tanks.models.controlpoints.sfx {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;

  public class AnimatedBeam extends Mesh {
    public var animationSpeed:Number;

    private var a:Vertex;
    private var b:Vertex;
    private var c:Vertex;
    private var d:Vertex;
    private var e:Vertex;
    private var f:Vertex;
    private var g:Vertex;
    private var h:Vertex;
    private var i:Vertex;
    private var j:Vertex;
    private var k:Vertex;
    private var l:Vertex;
    private var unitLength:Number;
    private var vOffset:Number = 0;

    public function AnimatedBeam(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.unitLength = param3;
      this.animationSpeed = param4;
      useShadowMap = false;
      useLight = false;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      var local5:Number = param1 / 2;
      var local6:Vector.<Number> = Vector.<Number>([-local5,0,0,local5,0,0,local5,param2,0,-local5,param2,0,-local5,param2,0,local5,param2,0,local5,param2 + 1,0,-local5,param2 + 1,0,-local5,param2 + 1,0,local5,param2 + 1,0,local5,2 * param2 + 1,0,-local5,2 * param2 + 1,0]);
      var local7:Vector.<Number> = Vector.<Number>([0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,1,0,1,1,0,1]);
      var local8:Vector.<int> = Vector.<int>([4,0,1,2,3,4,4,5,6,7,4,8,9,10,11]);
      addVerticesAndFaces(local6,local7,local8,true);
      sorting = Sorting.DYNAMIC_BSP;
      this.writeVertices();
      calculateFacesNormals();
      this.updateV();
      boundMinX = -local5;
      boundMaxX = local5;
      boundMinY = 0;
      boundMaxY = length;
      boundMinZ = 0;
      boundMaxZ = 0;
    }

    public function setMaterials(param1:TextureMaterial, param2:TextureMaterial) : void {
      var local3:Face = faceList;
      local3.material = param1;
      local3.next.material = param2;
      local3.next.next.material = param1;
    }

    private function writeVertices() : void {
      var local1:Vector.<Vertex> = this.vertices;
      this.a = local1[0];
      this.b = local1[1];
      this.c = local1[2];
      this.d = local1[3];
      this.e = local1[4];
      this.f = local1[5];
      this.g = local1[6];
      this.h = local1[7];
      this.i = local1[8];
      this.j = local1[9];
      this.k = local1[10];
      this.l = local1[11];
    }

    private function updateV() : void {
      this.e.v = this.vOffset;
      this.f.v = this.vOffset;
      var local1:Number = (this.g.y - this.f.y) / this.unitLength + this.vOffset;
      this.g.v = local1;
      this.h.v = local1;
    }

    public function clear() : void {
      setMaterialToAllFaces(null);
    }

    public function setTipLength(param1:Number) : void {
      var local2:Number = Number(this.c.y);
      this.c.y = param1;
      this.d.y = param1;
      this.e.y = param1;
      this.f.y = param1;
      this.setLength(this.k.y + param1 - local2);
    }

    public function resize(param1:Number, param2:Number) : void {
      this.setWidth(param1);
      this.setLength(param2);
    }

    public function setWidth(param1:Number) : void {
      var local2:Number = param1 / 2;
      boundMinX = -local2;
      boundMaxX = local2;
      this.a.x = -local2;
      this.d.x = -local2;
      this.e.x = -local2;
      this.h.x = -local2;
      this.i.x = -local2;
      this.l.x = -local2;
      this.b.x = local2;
      this.c.x = local2;
      this.f.x = local2;
      this.g.x = local2;
      this.j.x = local2;
      this.k.x = local2;
    }

    public function setLength(param1:Number) : void {
      if(param1 < 1 + 2 * this.c.y) {
        visible = false;
      } else {
        visible = true;
        boundMaxY = param1;
        this.g.y = param1 - this.c.y;
        this.h.y = this.g.y;
        this.i.y = this.g.y;
        this.j.y = this.g.y;
        this.k.y = param1;
        this.l.y = param1;
        this.updateV();
      }
    }

    public function setURange(param1:Number) : void {
      this.a.u = 0.5 * (1 - param1);
      this.d.u = this.a.u;
      this.e.u = this.a.u;
      this.h.u = this.a.u;
      this.i.u = this.a.u;
      this.l.u = this.a.u;
      this.b.u = 0.5 * (1 + param1);
      this.c.u = this.b.u;
      this.f.u = this.b.u;
      this.g.u = this.b.u;
      this.j.u = this.b.u;
      this.k.u = this.b.u;
    }

    public function update(param1:Number) : void {
      this.vOffset += this.animationSpeed * param1;
      if(this.vOffset < 0) {
        this.vOffset += 1;
      } else if(this.vOffset > 1) {
        this.vOffset -= 1;
      }
      this.updateV();
    }

    public function setUnitLength(param1:Number) : void {
      this.unitLength = param1;
      this.updateV();
    }
  }
}
