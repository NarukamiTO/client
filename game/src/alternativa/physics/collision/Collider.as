package alternativa.physics.collision {
  import alternativa.physics.ShapeContact;

  public interface Collider {
    function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void;
    function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean;
  }
}
