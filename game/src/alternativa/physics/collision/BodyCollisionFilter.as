package alternativa.physics.collision {
  import alternativa.physics.Body;

  public interface BodyCollisionFilter {
    function considerBodies(param1:Body, param2:Body) : Boolean;
  }
}
