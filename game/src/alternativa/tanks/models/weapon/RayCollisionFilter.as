package alternativa.tanks.models.weapon {
  import alternativa.physics.Body;
  import alternativa.physics.collision.IRayCollisionFilter;

  public class RayCollisionFilter implements IRayCollisionFilter {
    public var exclusion:Body;

    public function RayCollisionFilter() {
      super();
    }

    public function considerBody(param1:Body) : Boolean {
      return this.exclusion != param1;
    }
  }
}
