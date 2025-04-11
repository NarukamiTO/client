package alternativa.physics.collision {
  import alternativa.physics.Body;

  public interface IRayCollisionFilter {
    function considerBody(param1:Body) : Boolean;
  }
}
