package alternativa.physics.collision.colliders {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.Collider;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.primitives.CollisionSphere;

  public class BoxSphereCollider implements Collider {
    private var center:Vector3 = new Vector3();
    private var closestPoint:Vector3 = new Vector3();
    private var boxPosition:Vector3 = new Vector3();
    private var spherePosition:Vector3 = new Vector3();

    public function BoxSphereCollider() {
      super();
    }

    public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void {
      var local5:CollisionBox = null;
      var local7:Matrix4 = null;
      var local4:CollisionSphere = param1 as CollisionSphere;
      if(local4 == null) {
        local4 = param2 as CollisionSphere;
        local5 = param1 as CollisionBox;
      } else {
        local5 = param2 as CollisionBox;
      }
      var local6:Matrix4 = local4.transform;
      local6.getAxis(3,this.spherePosition);
      local7 = local5.transform;
      local7.getAxis(3,this.boxPosition);
      local7.transformVectorInverse(this.spherePosition,this.center);
      var local8:Vector3 = local5.hs;
      var local9:Number = local8.x + local4.r;
      var local10:Number = local8.y + local4.r;
      var local11:Number = local8.z + local4.r;
      if(this.center.x > local9 || this.center.x < -local9 || this.center.y > local10 || this.center.y < -local10 || this.center.z > local11 || this.center.z < -local11) {
        return;
      }
      if(this.center.x > local8.x) {
        this.closestPoint.x = local8.x;
      } else if(this.center.x < -local8.x) {
        this.closestPoint.x = -local8.x;
      } else {
        this.closestPoint.x = this.center.x;
      }
      if(this.center.y > local8.y) {
        this.closestPoint.y = local8.y;
      } else if(this.center.y < -local8.y) {
        this.closestPoint.y = -local8.y;
      } else {
        this.closestPoint.y = this.center.y;
      }
      if(this.center.z > local8.z) {
        this.closestPoint.z = local8.z;
      } else if(this.center.z < -local8.z) {
        this.closestPoint.z = -local8.z;
      } else {
        this.closestPoint.z = this.center.z;
      }
      var local12:Number = this.center.subtract(this.closestPoint).lengthSqr();
      if(local12 > local4.r * local4.r) {
        return;
      }
      var local13:ShapeContact = ShapeContact.create();
      local13.shape1 = local4;
      local13.shape2 = local5;
      local13.normal.copy(this.closestPoint).transform4(local7).subtract(this.spherePosition).normalize().reverse();
      local13.penetration = local4.r - Math.sqrt(local12);
      local13.position.copy(local13.normal).scale(-local4.r).add(this.spherePosition);
      param3[param3.length] = local13;
    }

    public function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean {
      var local4:CollisionBox = null;
      var local3:CollisionSphere = param1 as CollisionSphere;
      if(local3 == null) {
        local3 = param2 as CollisionSphere;
        local4 = param1 as CollisionBox;
      } else {
        local4 = param2 as CollisionBox;
      }
      var local5:Matrix4 = local3.transform;
      local5.getAxis(3,this.spherePosition);
      var local6:Matrix4 = local4.transform;
      local6.getAxis(3,this.boxPosition);
      local6.transformVectorInverse(this.spherePosition,this.center);
      var local7:Vector3 = local4.hs;
      var local8:Number = local7.x + local3.r;
      var local9:Number = local7.y + local3.r;
      var local10:Number = local7.z + local3.r;
      if(this.center.x > local8 || this.center.x < -local8 || this.center.y > local9 || this.center.y < -local9 || this.center.z > local10 || this.center.z < -local10) {
        return false;
      }
      if(this.center.x > local7.x) {
        this.closestPoint.x = local7.x;
      } else if(this.center.x < -local7.x) {
        this.closestPoint.x = -local7.x;
      } else {
        this.closestPoint.x = this.center.x;
      }
      if(this.center.y > local7.y) {
        this.closestPoint.y = local7.y;
      } else if(this.center.y < -local7.y) {
        this.closestPoint.y = -local7.y;
      } else {
        this.closestPoint.y = this.center.y;
      }
      if(this.center.z > local7.z) {
        this.closestPoint.z = local7.z;
      } else if(this.center.z < -local7.z) {
        this.closestPoint.z = -local7.z;
      } else {
        this.closestPoint.z = this.center.z;
      }
      var local11:Number = this.center.subtract(this.closestPoint).lengthSqr();
      return local11 <= local3.r * local3.r;
    }
  }
}
