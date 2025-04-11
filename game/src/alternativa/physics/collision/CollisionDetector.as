package alternativa.physics.collision {
  import alternativa.math.Vector3;
  import alternativa.physics.BodyContact;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.physics.TankBody;

  public interface CollisionDetector {
    function getBodyContacts(param1:Vector.<BodyContact>) : void;
    function raycast(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean;
    function raycastStatic(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean;
    function hasStaticHit(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter = null) : Boolean;
    function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void;
    function testCollision(param1:CollisionShape, param2:CollisionShape) : Boolean;
    function getTankBodies() : Vector.<TankBody>;
  }
}
