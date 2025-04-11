package alternativa.tanks.battle.objects.tank.tankskin.dynamic {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import flash.geom.Point;

  public class CommonDynamicSkin implements DynamicSkin {
    protected var faces:Vector.<Face> = new Vector.<Face>();
    protected var rotation:Number;
    protected var vertices:Vector.<Vertex> = new Vector.<Vertex>();
    protected var originalUVs:Vector.<Point> = new Vector.<Point>();

    public function CommonDynamicSkin() {
      super();
      this.rotation = 0;
    }

    public function addFace(param1:Face) : void {
      this.faces.push(param1);
    }

    public function init() : void {
      var local1:Face = null;
      var local2:Vertex = null;
      for each(local1 in this.faces) {
        for each(local2 in local1.vertices) {
          this.vertices.push(local2);
          this.originalUVs.push(new Point(local2.u,local2.v));
        }
      }
    }

    public function setMaterial(param1:Material) : void {
      var local2:Face = null;
      for each(local2 in this.faces) {
        local2.material = param1;
      }
    }

    public function rotate(param1:Number) : void {
      this.rotation += param1;
    }

    public function reset() : void {
      this.rotation = 0;
    }
  }
}
