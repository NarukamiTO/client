package alternativa.tanks.battle.objects.tank.tankchassis {
  import alternativa.physics.Body;
  import alternativa.physics.collision.IRayCollisionFilter;

  internal class RayCollisionFilter implements IRayCollisionFilter {
    private var body:Body;

    public function RayCollisionFilter(param1:Body) {
      super();
      this.body = param1;
    }

    public function considerBody(param1:Body) : Boolean {
      return this.body != param1;
    }
  }
}
