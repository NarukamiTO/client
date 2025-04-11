package alternativa.physics.collision.colliders {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.Collider;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.primitives.CollisionRect;

  public class BoxRectCollider implements Collider {
    private static const boxFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
    private static const rectFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
    private static const _basisMatrix:Matrix4 = new Matrix4();

    private const _vectorToBox:Vector3 = new Vector3();
    private const _axis:Vector3 = new Vector3();
    private const axis10:Vector3 = new Vector3();
    private const axis11:Vector3 = new Vector3();
    private const axis12:Vector3 = new Vector3();
    private const axis20:Vector3 = new Vector3();
    private const axis21:Vector3 = new Vector3();
    private const axis22:Vector3 = new Vector3();
    private const minOverlapAxis:Vector3 = new Vector3();

    private var minOverlap:Number;
    private var epsilon:Number;

    public function BoxRectCollider(param1:Number) {
      super();
      this.epsilon = param1;
    }

    public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void {
      var local4:CollisionRect = null;
      var local5:CollisionBox = null;
      if(this.haveCollision(param1,param2)) {
        if(param1 is CollisionRect) {
          local4 = CollisionRect(param1);
          local5 = CollisionBox(param2);
        } else {
          local4 = CollisionRect(param2);
          local5 = CollisionBox(param1);
        }
        this.findContacts(local5,local4,this.minOverlapAxis,param3);
      }
    }

    public function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean {
      var local3:CollisionBox = null;
      var local4:CollisionRect = null;
      this.minOverlap = 10000000000;
      if(param1 is CollisionBox) {
        local3 = CollisionBox(param1);
        local4 = CollisionRect(param2);
      } else {
        local3 = CollisionBox(param2);
        local4 = CollisionRect(param1);
      }
      var local5:Matrix4 = local3.transform;
      var local6:Matrix4 = local4.transform;
      this._vectorToBox.x = local5.m03 - local6.m03;
      this._vectorToBox.y = local5.m13 - local6.m13;
      this._vectorToBox.z = local5.m23 - local6.m23;
      this.axis22.x = local6.m02;
      this.axis22.y = local6.m12;
      this.axis22.z = local6.m22;
      if(!this.testMainAxis(local3,local4,this.axis22,this._vectorToBox)) {
        return false;
      }
      this.axis10.x = local5.m00;
      this.axis10.y = local5.m10;
      this.axis10.z = local5.m20;
      if(!this.testMainAxis(local3,local4,this.axis10,this._vectorToBox)) {
        return false;
      }
      this.axis11.x = local5.m01;
      this.axis11.y = local5.m11;
      this.axis11.z = local5.m21;
      if(!this.testMainAxis(local3,local4,this.axis11,this._vectorToBox)) {
        return false;
      }
      this.axis12.x = local5.m02;
      this.axis12.y = local5.m12;
      this.axis12.z = local5.m22;
      if(!this.testMainAxis(local3,local4,this.axis12,this._vectorToBox)) {
        return false;
      }
      this.axis20.x = local6.m00;
      this.axis20.y = local6.m10;
      this.axis20.z = local6.m20;
      this.axis21.x = local6.m01;
      this.axis21.y = local6.m11;
      this.axis21.z = local6.m21;
      if(!this.testDerivedAxis(local3,local4,this.axis10,this.axis20,this._vectorToBox)) {
        return false;
      }
      if(!this.testDerivedAxis(local3,local4,this.axis10,this.axis21,this._vectorToBox)) {
        return false;
      }
      if(!this.testDerivedAxis(local3,local4,this.axis11,this.axis20,this._vectorToBox)) {
        return false;
      }
      if(!this.testDerivedAxis(local3,local4,this.axis11,this.axis21,this._vectorToBox)) {
        return false;
      }
      if(!this.testDerivedAxis(local3,local4,this.axis12,this.axis20,this._vectorToBox)) {
        return false;
      }
      if(!this.testDerivedAxis(local3,local4,this.axis12,this.axis21,this._vectorToBox)) {
        return false;
      }
      return true;
    }

    private function testMainAxis(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector3) : Boolean {
      var local5:Number = this.getOverlapOnAxis(param1,param2,param3,param4);
      return this.registerOverlap(local5,param3);
    }

    private function testDerivedAxis(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector3, param5:Vector3) : Boolean {
      var local7:Number = NaN;
      this._axis.x = param3.y * param4.z - param3.z * param4.y;
      this._axis.y = param3.z * param4.x - param3.x * param4.z;
      this._axis.z = param3.x * param4.y - param3.y * param4.x;
      var local6:Number = this._axis.x * this._axis.x + this._axis.y * this._axis.y + this._axis.z * this._axis.z;
      if(local6 < 1e-10) {
        return true;
      }
      local7 = 1 / Math.sqrt(local6);
      this._axis.x *= local7;
      this._axis.y *= local7;
      this._axis.z *= local7;
      var local8:Number = this.getOverlapOnAxis(param1,param2,this._axis,param5);
      return this.registerOverlap(local8,this._axis);
    }

    private function getOverlapOnAxis(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector3) : Number {
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
      local6 = param4.x * param3.x + param4.y * param3.y + param4.z * param3.z;
      if(local6 < 0) {
        local6 = -local6;
      }
      return local7 - local6;
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

    private function findContacts(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector.<ShapeContact>) : void {
      var local5:Matrix4 = null;
      var local12:ShapeContact = null;
      var local13:Vector3 = null;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      local5 = param1.transform;
      var local6:Matrix4 = param2.transform;
      var local7:Vector3 = this._vectorToBox;
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
      ColliderUtils.getBoxFaceVerticesInCCWOrder(param1,param3,FaceSide.BACK,boxFaceVertices);
      ColliderUtils.getRectFaceInCCWOrder(param2,param3,rectFaceVertices);
      ColliderUtils.transformFaceToReferenceSpace(local8,local5,boxFaceVertices,4);
      ColliderUtils.transformFaceToReferenceSpace(local8,local6,rectFaceVertices,4);
      var local9:int = int(param4.length);
      PolygonsIntersectionUtils.findContacts(param1,boxFaceVertices,4,param2,rectFaceVertices,4,local8,param4);
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
        } else if(Math.abs(local6.m22) > 0.999) {
          local13.x = local14;
          local13.y = local15;
          local13.z = local16;
        }
        local11++;
      }
      if(local10 < param4.length) {
        param4.length = local10;
      }
    }
  }
}
