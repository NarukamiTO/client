package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;

  internal class ShotTrail extends Mesh {
    private var a:Vertex;
    private var b:Vertex;
    private var c:Vertex;
    private var d:Vertex;
    private var face:Face;
    private var bottomV:Number;
    private var distanceV:Number;

    public function ShotTrail() {
      super();
      this.a = addVertex(-1,1,0);
      this.b = addVertex(-1,0,0);
      this.c = addVertex(1,0,0);
      this.d = addVertex(1,1,0);
      this.face = addQuadFace(this.a,this.b,this.c,this.d);
      calculateFacesNormals();
      sorting = Sorting.DYNAMIC_BSP;
      softAttenuation = 80;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }

    public function init(param1:Number, param2:Number, param3:Material, param4:Number) : void {
      var local5:Number = param1 * 0.5;
      this.a.x = -local5;
      this.a.y = param2;
      this.a.u = 0;
      this.b.x = -local5;
      this.b.y = 0;
      this.b.u = 0;
      this.c.x = local5;
      this.c.y = 0;
      this.c.u = 1;
      this.d.x = local5;
      this.d.y = param2;
      this.d.u = 1;
      boundMinX = -local5;
      boundMinY = 0;
      boundMinZ = 0;
      boundMaxX = local5;
      boundMaxY = param2;
      boundMaxZ = 0;
      this.face.material = param3;
      var local6:TextureMaterial = param3 as TextureMaterial;
      if(local6 != null && local6.texture != null) {
        this.bottomV = param2 / (param1 * local6.texture.height / local6.texture.width);
        this.distanceV = param4 / param1;
      } else {
        this.bottomV = 1;
        this.distanceV = 0;
      }
    }

    public function clear() : void {
      this.face.material = null;
    }

    public function update(param1:Number) : void {
      var local2:Number = this.distanceV * param1;
      this.a.v = local2;
      this.b.v = this.bottomV + local2;
      this.c.v = this.bottomV + local2;
      this.d.v = local2;
    }
  }
}
