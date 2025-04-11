package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.primitives.CollisionRect;
  import alternativa.physics.collision.primitives.CollisionTriangle;

  public class CollisionGeometryParser {
    private static const MATERIAL:PhysicsMaterial = new PhysicsMaterial(0,1);
    private static const STATIC_COLLISION_GROUP:int = 255;
    private static const halfSize:Vector3 = new Vector3();
    private static const position:Vector3 = new Vector3();
    private static const rotation:Vector3 = new Vector3();
    private static const rotationMatrix:Matrix3 = new Matrix3();

    public function CollisionGeometryParser() {
      super();
    }

    public static function parse(param1:XML) : Vector.<CollisionShape> {
      var local2:Vector.<CollisionShape> = new Vector.<CollisionShape>();
      putAll(parseCollisionPlanes(param1),local2);
      putAll(parseCollisionBoxes(param1),local2);
      putAll(parseCollisionTrinagles(param1),local2);
      return local2;
    }

    private static function putAll(param1:Vector.<CollisionShape>, param2:Vector.<CollisionShape>) : void {
      var local3:CollisionShape = null;
      for each(local3 in param1) {
        param2.push(local3);
      }
    }

    private static function parseCollisionPlanes(param1:XML) : Vector.<CollisionShape> {
      var local4:XML = null;
      var local5:CollisionShape = null;
      var local2:Vector.<CollisionShape> = new Vector.<CollisionShape>();
      var local3:XMLList = param1.elements("collision-geometry")[0].elements("collision-plane");
      for each(local4 in local3) {
        halfSize.x = 0.5 * Number(local4.width);
        halfSize.y = 0.5 * Number(local4.length);
        halfSize.z = 0;
        local5 = new CollisionRect(halfSize,STATIC_COLLISION_GROUP,MATERIAL);
        setCollisionPrimitiveOrientation(local5,local4);
        local2.push(local5);
      }
      return local2;
    }

    private static function parseCollisionBoxes(param1:XML) : Vector.<CollisionShape> {
      var local4:XML = null;
      var local5:CollisionShape = null;
      var local2:Vector.<CollisionShape> = new Vector.<CollisionShape>();
      var local3:XMLList = param1.elements("collision-geometry")[0].elements("collision-box");
      for each(local4 in local3) {
        readVector3(local4.size,halfSize);
        halfSize.scale(0.5);
        local5 = new CollisionBox(halfSize,STATIC_COLLISION_GROUP,MATERIAL);
        setCollisionPrimitiveOrientation(local5,local4);
        local2.push(local5);
      }
      return local2;
    }

    private static function parseCollisionTrinagles(param1:XML) : Vector.<CollisionShape> {
      var local7:XML = null;
      var local8:CollisionShape = null;
      var local2:Vector.<CollisionShape> = new Vector.<CollisionShape>();
      var local3:Vector3 = new Vector3();
      var local4:Vector3 = new Vector3();
      var local5:Vector3 = new Vector3();
      var local6:XMLList = param1.elements("collision-geometry")[0].elements("collision-triangle");
      for each(local7 in local6) {
        readVector3(local7.v0,local3);
        readVector3(local7.v1,local4);
        readVector3(local7.v2,local5);
        local8 = new CollisionTriangle(local3,local4,local5,STATIC_COLLISION_GROUP,MATERIAL);
        setCollisionPrimitiveOrientation(local8,local7);
        local2.push(local8);
      }
      return local2;
    }

    private static function setCollisionPrimitiveOrientation(param1:CollisionShape, param2:XML) : void {
      readVector3(param2.position,position);
      readVector3(param2.rotation,rotation);
      rotationMatrix.setRotationMatrix(rotation.x,rotation.y,rotation.z);
      param1.transform.setFromMatrix3(rotationMatrix,position);
    }

    private static function readVector3(param1:XMLList, param2:Vector3) : void {
      var local3:XML = null;
      if(param1.length() > 0) {
        local3 = param1[0];
        param2.x = parseFloat(local3.x);
        param2.y = parseFloat(local3.y);
        param2.z = parseFloat(local3.z);
      } else {
        param2.reset(0,0,0);
      }
    }
  }
}
