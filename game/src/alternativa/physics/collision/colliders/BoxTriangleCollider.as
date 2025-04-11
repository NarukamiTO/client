package alternativa.physics.collision.colliders {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.Collider;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.primitives.CollisionTriangle;

  public class BoxTriangleCollider implements Collider {
    public var epsilon:Number;

    private var minOverlap:Number;

    private const toBox:Vector3 = new Vector3();
    private const axis:Vector3 = new Vector3();
    private const axis10:Vector3 = new Vector3();
    private const axis11:Vector3 = new Vector3();
    private const axis12:Vector3 = new Vector3();
    private const axis20:Vector3 = new Vector3();
    private const axis21:Vector3 = new Vector3();
    private const axis22:Vector3 = new Vector3();
    private const minOverlapAxis:Vector3 = new Vector3();
    private const _basisMatrix:Matrix4 = new Matrix4();
    private const boxFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
    private const triFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex()]);

    public function BoxTriangleCollider(param1:Number) {
      super();
      this.epsilon = param1;
    }

    public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void {
      var local4:CollisionTriangle = null;
      var local5:CollisionBox = null;
      if(!this.haveCollision(param1,param2)) {
        return;
      }
      if(param1 is CollisionBox) {
        local5 = CollisionBox(param1);
        local4 = CollisionTriangle(param2);
      } else {
        local5 = CollisionBox(param2);
        local4 = CollisionTriangle(param1);
      }
      this.findContacts(local5,local4,this.minOverlapAxis,param3);
    }

    public function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean {
      var local3:CollisionTriangle = null;
      var local4:CollisionBox = null;
      var local5:Matrix4 = null;
      var local6:Matrix4 = null;
      var local7:Vector3 = null;
      if(param1 is CollisionBox) {
        local4 = CollisionBox(param1);
        local3 = CollisionTriangle(param2);
      } else {
        local4 = CollisionBox(param2);
        local3 = CollisionTriangle(param1);
      }
      local5 = local4.transform;
      local6 = local3.transform;
      this.toBox.x = local5.m03 - local6.m03;
      this.toBox.y = local5.m13 - local6.m13;
      this.toBox.z = local5.m23 - local6.m23;
      this.minOverlap = 10000000000;
      this.axis.x = local6.m02;
      this.axis.y = local6.m12;
      this.axis.z = local6.m22;
      if(!this.testOverlapOnMainAxis(local4,local3,this.axis,this.toBox)) {
        return false;
      }
      this.axis10.x = local5.m00;
      this.axis10.y = local5.m10;
      this.axis10.z = local5.m20;
      if(!this.testOverlapOnMainAxis(local4,local3,this.axis10,this.toBox)) {
        return false;
      }
      this.axis11.x = local5.m01;
      this.axis11.y = local5.m11;
      this.axis11.z = local5.m21;
      if(!this.testOverlapOnMainAxis(local4,local3,this.axis11,this.toBox)) {
        return false;
      }
      this.axis12.x = local5.m02;
      this.axis12.y = local5.m12;
      this.axis12.z = local5.m22;
      if(!this.testOverlapOnMainAxis(local4,local3,this.axis12,this.toBox)) {
        return false;
      }
      local7 = local3.e0;
      this.axis20.x = local6.m00 * local7.x + local6.m01 * local7.y + local6.m02 * local7.z;
      this.axis20.y = local6.m10 * local7.x + local6.m11 * local7.y + local6.m12 * local7.z;
      this.axis20.z = local6.m20 * local7.x + local6.m21 * local7.y + local6.m22 * local7.z;
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis10,this.axis20,this.toBox)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis11,this.axis20,this.toBox)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis12,this.axis20,this.toBox)) {
        return false;
      }
      local7 = local3.e1;
      this.axis21.x = local6.m00 * local7.x + local6.m01 * local7.y + local6.m02 * local7.z;
      this.axis21.y = local6.m10 * local7.x + local6.m11 * local7.y + local6.m12 * local7.z;
      this.axis21.z = local6.m20 * local7.x + local6.m21 * local7.y + local6.m22 * local7.z;
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis10,this.axis21,this.toBox)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis11,this.axis21,this.toBox)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis12,this.axis21,this.toBox)) {
        return false;
      }
      local7 = local3.e2;
      this.axis22.x = local6.m00 * local7.x + local6.m01 * local7.y + local6.m02 * local7.z;
      this.axis22.y = local6.m10 * local7.x + local6.m11 * local7.y + local6.m12 * local7.z;
      this.axis22.z = local6.m20 * local7.x + local6.m21 * local7.y + local6.m22 * local7.z;
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis10,this.axis22,this.toBox)) {
        return false;
      }
      if(!this.testOverlapOnDerivedAxis(local4,local3,this.axis11,this.axis22,this.toBox)) {
        return false;
      }
      return this.testOverlapOnDerivedAxis(local4,local3,this.axis12,this.axis22,this.toBox);
    }

    private function testOverlapOnMainAxis(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector3) : Boolean {
      var local5:Number = this.getOverlapOnAxis(param1,param2,param3,param4);
      return this.registerOverlap(local5,param3);
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

    private function testOverlapOnDerivedAxis(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector3, param5:Vector3) : Boolean {
      var local7:Number = NaN;
      this.axis.x = param3.y * param4.z - param3.z * param4.y;
      this.axis.y = param3.z * param4.x - param3.x * param4.z;
      this.axis.z = param3.x * param4.y - param3.y * param4.x;
      var local6:Number = this.axis.x * this.axis.x + this.axis.y * this.axis.y + this.axis.z * this.axis.z;
      if(local6 < 1e-10) {
        return true;
      }
      local7 = 1 / Math.sqrt(local6);
      this.axis.x *= local7;
      this.axis.y *= local7;
      this.axis.z *= local7;
      var local8:Number = this.getOverlapOnAxis(param1,param2,this.axis,param5);
      return this.registerOverlap(local8,this.axis);
    }

    private function getOverlapOnAxis(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector3) : Number {
      var local8:Number = NaN;
      var local5:Matrix4 = param1.transform;
      var local6:Vector3 = param1.hs;
      var local7:Number = 0;
      local8 = (local5.m00 * param3.x + local5.m10 * param3.y + local5.m20 * param3.z) * local6.x;
      if(local8 < 0) {
        local7 -= local8;
      } else {
        local7 += local8;
      }
      local8 = (local5.m01 * param3.x + local5.m11 * param3.y + local5.m21 * param3.z) * local6.y;
      if(local8 < 0) {
        local7 -= local8;
      } else {
        local7 += local8;
      }
      local8 = (local5.m02 * param3.x + local5.m12 * param3.y + local5.m22 * param3.z) * local6.z;
      if(local8 < 0) {
        local7 -= local8;
      } else {
        local7 += local8;
      }
      var local9:Number = param4.x * param3.x + param4.y * param3.y + param4.z * param3.z;
      var local10:Matrix4 = param2.transform;
      var local11:Number = local10.m00 * param3.x + local10.m10 * param3.y + local10.m20 * param3.z;
      var local12:Number = local10.m01 * param3.x + local10.m11 * param3.y + local10.m21 * param3.z;
      var local13:Number = local10.m02 * param3.x + local10.m12 * param3.y + local10.m22 * param3.z;
      var local14:Number = 0;
      var local15:Vector3 = param2.v0;
      var local16:Vector3 = param2.v1;
      var local17:Vector3 = param2.v2;
      if(local9 < 0) {
        local9 = -local9;
        local8 = local15.x * local11 + local15.y * local12 + local15.z * local13;
        if(local8 < local14) {
          local14 = local8;
        }
        local8 = local16.x * local11 + local16.y * local12 + local16.z * local13;
        if(local8 < local14) {
          local14 = local8;
        }
        local8 = local17.x * local11 + local17.y * local12 + local17.z * local13;
        if(local8 < local14) {
          local14 = local8;
        }
        local14 = -local14;
      } else {
        local8 = local15.x * local11 + local15.y * local12 + local15.z * local13;
        if(local8 > local14) {
          local14 = local8;
        }
        local8 = local16.x * local11 + local16.y * local12 + local16.z * local13;
        if(local8 > local14) {
          local14 = local8;
        }
        local8 = local17.x * local11 + local17.y * local12 + local17.z * local13;
        if(local8 > local14) {
          local14 = local8;
        }
      }
      return local7 + local14 - local9;
    }

    private function findContacts(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector.<ShapeContact>) : void {
      var local6:Matrix4 = null;
      var local7:Vector3 = null;
      var local12:ShapeContact = null;
      var local13:Vector3 = null;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local5:Matrix4 = param1.transform;
      local6 = param2.transform;
      local7 = this.toBox;
      local7.x = local5.m03 - local6.m03;
      local7.y = local5.m13 - local6.m13;
      local7.z = local5.m23 - local6.m23;
      if(param3.x * local7.x + param3.y * local7.y + param3.z * local7.z < 0) {
        param3.x = -param3.x;
        param3.y = -param3.y;
        param3.z = -param3.z;
      }
      var local8:Matrix4 = this._basisMatrix;
      ColliderUtils.buildContactBasis(param3,local5,local6,local8);
      ColliderUtils.getBoxFaceVerticesInCCWOrder(param1,param3,FaceSide.BACK,this.boxFaceVertices);
      ColliderUtils.getTriangleFaceInCCWOrder(param2,param3,this.triFaceVertices);
      ColliderUtils.transformFaceToReferenceSpace(local8,local5,this.boxFaceVertices,4);
      ColliderUtils.transformFaceToReferenceSpace(local8,local6,this.triFaceVertices,3);
      var local9:int = int(param4.length);
      PolygonsIntersectionUtils.findContacts(param1,this.boxFaceVertices,4,param2,this.triFaceVertices,3,local8,param4);
      var local10:int = int(param4.length);
      var local11:int = local9;
      while(local11 < local10) {
        local12 = param4[local11];
        local13 = local12.normal;
        local14 = local6.m02;
        local15 = local6.m12;
        local16 = local6.m22;
        if(local13.x * local14 + local13.y * local15 + local13.z * local16 < 0) {
          local12.dispose();
          local10--;
          param4[local11] = param4[local10];
          param4[local10] = null;
          local11--;
        }
        local11++;
      }
      if(local10 < param4.length) {
        param4.length = local10;
      }
    }
  }
}
