package alternativa.physics.collision {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.types.AABB;

  public class CollisionShape {
    public static const BOX:int = 1;
    public static const SPHERE:int = 2;
    public static const RECT:int = 4;
    public static const TRIANGLE:int = 8;

    public var type:int;
    public var collisionGroup:int;
    public var body:Body;
    public var localTransform:Matrix4;
    public var transform:Matrix4 = new Matrix4();
    public var aabb:AABB = new AABB();
    public var material:PhysicsMaterial;

    public function CollisionShape(param1:int, param2:int, param3:PhysicsMaterial) {
      super();
      this.type = param1;
      this.collisionGroup = param2;
      this.material = param3;
    }

    public function setBody(param1:Body, param2:Matrix4 = null) : void {
      if(this.body == param1) {
        return;
      }
      this.body = param1;
      if(param1 != null) {
        if(param2 != null) {
          if(this.localTransform == null) {
            this.localTransform = new Matrix4();
          }
          this.localTransform.copy(param2);
        } else {
          this.localTransform = null;
        }
      }
    }

    public function calculateAABB() : AABB {
      return this.aabb;
    }

    public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number {
      return -1;
    }

    public function clone() : CollisionShape {
      var local1:CollisionShape = this.createPrimitive();
      return local1.copyFrom(this);
    }

    public function copyFrom(param1:CollisionShape) : CollisionShape {
      if(param1 == null) {
        throw new ArgumentError("Parameter source cannot be null");
      }
      this.type = param1.type;
      this.transform.copy(param1.transform);
      this.collisionGroup = param1.collisionGroup;
      this.setBody(param1.body,param1.localTransform);
      this.aabb.copyFrom(param1.aabb);
      return this;
    }

    protected function createPrimitive() : CollisionShape {
      return new CollisionShape(this.type,this.collisionGroup,this.material);
    }
  }
}
