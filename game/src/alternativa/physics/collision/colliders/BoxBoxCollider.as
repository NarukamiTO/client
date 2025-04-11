package alternativa.physics.collision.colliders {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.Collider;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;

  public class BoxBoxCollider implements Collider {
    private static const _axis:Vector3 = new Vector3();
    private static const _axis10:Vector3 = new Vector3();
    private static const _axis11:Vector3 = new Vector3();
    private static const _axis12:Vector3 = new Vector3();
    private static const _axis20:Vector3 = new Vector3();
    private static const _axis21:Vector3 = new Vector3();
    private static const _axis22:Vector3 = new Vector3();
    private static const _vectorToBox:Vector3 = new Vector3();
    private static const faceVertices1:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
    private static const faceVertices2:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
    private static const _basisMatrix:Matrix4 = new Matrix4();

    private var epsilon:Number;

    private const minOverlapAxis:Vector3 = new Vector3();

    private var minOverlap:Number;

    public function BoxBoxCollider(param1:Number) {
      super();
      this.epsilon = param1;
    }

    public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void {
      var local4:CollisionBox = null;
      var local5:CollisionBox = null;
      if(this.haveCollision(param1,param2)) {
        local4 = CollisionBox(param1);
        local5 = CollisionBox(param2);
        this.findContacts(local4,local5,this.minOverlapAxis,param3);
      }
    }

    public function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean {
      var local3:CollisionBox = null;
      var local5:Matrix4 = null;
      var local7:Vector3 = null;
      this.minOverlap = 10000000000;
      local3 = CollisionBox(param1);
      var local4:CollisionBox = CollisionBox(param2);
      local5 = local3.transform;
      var local6:Matrix4 = local4.transform;
      local7 = _vectorToBox;
      local7.x = local5.m03 - local6.m03;
      local7.y = local5.m13 - local6.m13;
      local7.z = local5.m23 - local6.m23;
      _axis10.x = local5.m00;
      _axis10.y = local5.m10;
      _axis10.z = local5.m20;
      if(!this.testOverlapOnMainAxis(local3,local4,_axis10,local7)) {
        return false;
      }
      _axis11.x = local5.m01;
      _axis11.y = local5.m11;
      _axis11.z = local5.m21;
      if(!this.testOverlapOnMainAxis(local3,local4,_axis11,local7)) {
        return false;
      }
      _axis12.x = local5.m02;
      _axis12.y = local5.m12;
      _axis12.z = local5.m22;
      if(!this.testOverlapOnMainAxis(local3,local4,_axis12,local7)) {
        return false;
      }
      _axis20.x = local6.m00;
      _axis20.y = local6.m10;
      _axis20.z = local6.m20;
      if(!this.testOverlapOnMainAxis(local3,local4,_axis20,local7)) {
        return false;
      }
      _axis21.x = local6.m01;
      _axis21.y = local6.m11;
      _axis21.z = local6.m21;
      if(!this.testOverlapOnMainAxis(local3,local4,_axis21,local7)) {
        return false;
      }
      _axis22.x = local6.m02;
      _axis22.y = local6.m12;
      _axis22.z = local6.m22;
      if(!this.testOverlapOnMainAxis(local3,local4,_axis22,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis10,_axis20,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis10,_axis21,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis10,_axis22,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis11,_axis20,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis11,_axis21,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis11,_axis22,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis12,_axis20,local7)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local3,local4,_axis12,_axis21,local7)) {
        return false;
      }
      return this.testOverlapOnDerivedAxis(local3,local4,_axis12,_axis22,local7);
    }

    private function testOverlapOnMainAxis(param1:CollisionBox, param2:CollisionBox, param3:Vector3, param4:Vector3) : Boolean {
      var local5:Number = this.getOverlapOnAxis(param1,param2,param3,param4);
      return this.registerOverlap(local5,param3);
    }

    private function testOverlapOnDerivedAxis(param1:CollisionBox, param2:CollisionBox, param3:Vector3, param4:Vector3, param5:Vector3) : Boolean {
      var local6:Vector3 = null;
      var local8:Number = NaN;
      local6 = _axis;
      local6.x = param3.y * param4.z - param3.z * param4.y;
      local6.y = param3.z * param4.x - param3.x * param4.z;
      local6.z = param3.x * param4.y - param3.y * param4.x;
      var local7:Number = local6.x * local6.x + local6.y * local6.y + local6.z * local6.z;
      if(local7 < 1e-10) {
        return true;
      }
      local8 = 1 / Math.sqrt(local7);
      local6.x *= local8;
      local6.y *= local8;
      local6.z *= local8;
      var local9:Number = this.getOverlapOnAxis(param1,param2,local6,param5);
      return this.registerOverlap(local9,local6);
    }

    private function registerOverlap(param1:Number, param2:Vector3) : Boolean {
      if(param1 < this.epsilon) {
        return false;
      }
      if(param1 + this.epsilon < this.minOverlap) {
        this.minOverlap = param1;
        this.minOverlapAxis.x = param2.x;
        this.minOverlapAxis.y = param2.y;
        this.minOverlapAxis.z = param2.z;
      }
      return true;
    }

    public function getOverlapOnAxis(param1:CollisionBox, param2:CollisionBox, param3:Vector3, param4:Vector3) : Number {
      var local5:Matrix4 = param1.transform;
      var local6:Number = (local5.m00 * param3.x + local5.m10 * param3.y + local5.m20 * param3.z) * param1.hs.x;
      if(local6 < 0) {
        local6 = -local6;
      }
      var local7:Number = local6;
      local6 = (local5.m01 * param3.x + local5.m11 * param3.y + local5.m21 * param3.z) * param1.hs.y;
      if(local6 < 0) {
        local6 = -local6;
      }
      local7 += local6;
      local6 = (local5.m02 * param3.x + local5.m12 * param3.y + local5.m22 * param3.z) * param1.hs.z;
      if(local6 < 0) {
        local6 = -local6;
      }
      local7 += local6;
      local5 = param2.transform;
      local6 = (local5.m00 * param3.x + local5.m10 * param3.y + local5.m20 * param3.z) * param2.hs.x;
      if(local6 < 0) {
        local6 = -local6;
      }
      local7 += local6;
      local6 = (local5.m01 * param3.x + local5.m11 * param3.y + local5.m21 * param3.z) * param2.hs.y;
      if(local6 < 0) {
        local6 = -local6;
      }
      local7 += local6;
      local6 = (local5.m02 * param3.x + local5.m12 * param3.y + local5.m22 * param3.z) * param2.hs.z;
      if(local6 < 0) {
        local6 = -local6;
      }
      local7 += local6;
      local6 = param4.x * param3.x + param4.y * param3.y + param4.z * param3.z;
      if(local6 < 0) {
        local6 = -local6;
      }
      return local7 - local6;
    }

    private function findContacts(param1:CollisionBox, param2:CollisionBox, param3:Vector3, param4:Vector.<ShapeContact>) : void {
      var local5:Matrix4 = param1.transform;
      var local6:Matrix4 = param2.transform;
      var local7:Vector3 = _vectorToBox;
      local7.x = local5.m03 - local6.m03;
      local7.y = local5.m13 - local6.m13;
      local7.z = local5.m23 - local6.m23;
      if(param3.x * local7.x + param3.y * local7.y + param3.z * local7.z < 0) {
        param3.x = -param3.x;
        param3.y = -param3.y;
        param3.z = -param3.z;
      }
      var local8:Matrix4 = _basisMatrix;
      ColliderUtils.buildContactBasis(param3,local5,local6,local8);
      ColliderUtils.getBoxFaceVerticesInCCWOrder(param1,param3,FaceSide.BACK,faceVertices1);
      ColliderUtils.getBoxFaceVerticesInCCWOrder(param2,param3,FaceSide.FRONT,faceVertices2);
      ColliderUtils.transformFaceToReferenceSpace(local8,param1.transform,faceVertices1,4);
      ColliderUtils.transformFaceToReferenceSpace(local8,param2.transform,faceVertices2,4);
      PolygonsIntersectionUtils.findContacts(param1,faceVertices1,4,param2,faceVertices2,4,local8,param4);
    }
  }
}
