package alternativa.tanks.models.weapon.shotgun.sfx {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;

  public class PelletTrail extends Mesh {
    private var a:Vertex;
    private var b:Vertex;
    private var c:Vertex;
    private var d:Vertex;

    public var distance:Number = 0;
    public var direction:Vector3 = new Vector3();
    public var position:Vector3 = new Vector3();
    public var isRicochet:Boolean = false;

    public function PelletTrail() {
      super();
      this.a = addVertex(-1,1,0,0,0);
      this.b = addVertex(-1,0,0,0,1);
      this.c = addVertex(1,0,0,1,1);
      this.d = addVertex(1,1,0,1,0);
      addQuadFace(this.a,this.b,this.c,this.d);
      calculateFacesNormals();
    }

    public function init(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:TextureMaterial) : void {
      var local7:Number = param1 / 2;
      this.initVertex(this.a,-local7,param4);
      this.initVertex(this.b,-local7,param3);
      this.initVertex(this.c,local7,param3);
      this.initVertex(this.d,local7,param4);
      this.alpha = param2;
      this.distance = param5;
      setMaterialToAllFaces(param6);
    }

    private function initVertex(param1:Vertex, param2:Number, param3:Number) : void {
      param1.x = param2;
      param1.y = param3;
    }

    public function clear() : void {
      setMaterialToAllFaces(null);
      this.isRicochet = false;
    }
  }
}
