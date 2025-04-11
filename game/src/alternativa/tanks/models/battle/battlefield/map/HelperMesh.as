package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.primitives.Plane;

  public class HelperMesh extends BSP {
    public function HelperMesh() {
      super();
      var local1:Plane = new Plane();
      createTree(local1);
      z = -20000;
      name = "static";
    }
  }
}
