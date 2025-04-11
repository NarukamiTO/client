package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  public class GaussTrail extends Mesh {
    private var a:Vertex;
    private var b:Vertex;
    private var c:Vertex;
    private var d:Vertex;
    private var face:Face;

    public function GaussTrail(param1:Number = 1) {
      super();
      this.a = addVertex(-param1 / 2,param1,0,0,0);
      this.b = addVertex(-param1 / 2,0,0,0,1);
      this.c = addVertex(param1 / 2,0,0,1,1);
      this.d = addVertex(param1 / 2,param1,0,1,0);
      this.face = addQuadFace(this.a,this.b,this.c,this.d);
      calculateFacesNormals();
    }

    public function get material() : Material {
      return this.face.material;
    }

    public function set material(param1:Material) : void {
      setMaterialToAllFaces(param1);
    }

    public function get size() : Number {
      return this.a.y;
    }

    public function set size(param1:Number) : void {
      this.a.x = -param1 / 2;
      this.b.x = -param1 / 2;
      this.c.x = param1 / 2;
      this.d.x = param1 / 2;
      this.a.y = param1;
      this.d.y = param1;
      calculateFacesNormals();
    }
  }
}
