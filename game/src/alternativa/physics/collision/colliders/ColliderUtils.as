package alternativa.physics.collision.colliders {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.primitives.CollisionRect;
  import alternativa.physics.collision.primitives.CollisionTriangle;

  public class ColliderUtils {
    private static const _basisAxisX:Vector3 = new Vector3();
    private static const _basisAxisY:Vector3 = new Vector3();

    public function ColliderUtils() {
      super();
    }

    public static function buildContactBasis(param1:Vector3, param2:Matrix4, param3:Matrix4, param4:Matrix4) : void {
      var local5:Vector3 = _basisAxisX;
      var local6:Vector3 = _basisAxisY;
      if(Math.abs(param1.x) < Math.abs(param1.y)) {
        local5.x = 0;
        local5.y = param1.z;
        local5.z = -param1.y;
      } else {
        local5.x = -param1.z;
        local5.y = 0;
        local5.z = param1.x;
      }
      local5.normalize();
      local6.x = param1.y * local5.z - param1.z * local5.y;
      local6.y = param1.z * local5.x - param1.x * local5.z;
      local6.z = param1.x * local5.y - param1.y * local5.x;
      param4.m00 = local5.x;
      param4.m10 = local5.y;
      param4.m20 = local5.z;
      param4.m01 = local6.x;
      param4.m11 = local6.y;
      param4.m21 = local6.z;
      param4.m02 = param1.x;
      param4.m12 = param1.y;
      param4.m22 = param1.z;
    }

    public static function transformFaceToReferenceSpace(param1:Matrix4, param2:Matrix4, param3:Vector.<Vertex>, param4:int) : void {
      var local6:Vertex = null;
      var local5:int = 0;
      while(local5 < param4) {
        local6 = param3[local5];
        param2.transformVector(local6.local,local6.global);
        param1.transformVectorInverse(local6.global,local6.transformed);
        local5++;
      }
    }

    public static function getBoxFaceVerticesInCCWOrder(param1:CollisionBox, param2:Vector3, param3:FaceSide, param4:Vector.<Vertex>) : void {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Vector3 = null;
      var local16:Vector3 = null;
      var local17:Vertex = null;
      var local5:Matrix4 = param1.transform;
      var local6:int = 0;
      local11 = local5.m00;
      local12 = local5.m10;
      local13 = local5.m20;
      local7 = local11 * param2.x + local12 * param2.y + local13 * param2.z;
      local8 = Math.abs(local7);
      local11 = local5.m01;
      local12 = local5.m11;
      local13 = local5.m21;
      local10 = local11 * param2.x + local12 * param2.y + local13 * param2.z;
      local9 = Math.abs(local10);
      if(local9 > local8) {
        local8 = local9;
        local7 = local10;
        local6 = 1;
      }
      local11 = local5.m02;
      local12 = local5.m12;
      local13 = local5.m22;
      local10 = local11 * param2.x + local12 * param2.y + local13 * param2.z;
      local9 = Math.abs(local10);
      if(local9 > local8) {
        local7 = local10;
        local6 = 2;
      }
      local14 = local7 > 0 ? 1 : -1;
      if(param3 == FaceSide.BACK) {
        local14 = -local14;
      }
      local16 = param1.hs;
      switch(local6) {
        case 0:
          local15 = Vertex(param4[0]).local;
          local15.x = local14 * local16.x;
          local15.y = local16.y;
          local15.z = local16.z;
          local15 = Vertex(param4[1]).local;
          local15.x = local14 * local16.x;
          local15.y = -local16.y;
          local15.z = local16.z;
          local15 = Vertex(param4[2]).local;
          local15.x = local14 * local16.x;
          local15.y = -local16.y;
          local15.z = -local16.z;
          local15 = Vertex(param4[3]).local;
          local15.x = local14 * local16.x;
          local15.y = local16.y;
          local15.z = -local16.z;
          break;
        case 1:
          local15 = Vertex(param4[0]).local;
          local15.x = local16.x;
          local15.y = local14 * local16.y;
          local15.z = local16.z;
          local15 = Vertex(param4[1]).local;
          local15.x = local16.x;
          local15.y = local14 * local16.y;
          local15.z = -local16.z;
          local15 = Vertex(param4[2]).local;
          local15.x = -local16.x;
          local15.y = local14 * local16.y;
          local15.z = -local16.z;
          local15 = Vertex(param4[3]).local;
          local15.x = -local16.x;
          local15.y = local14 * local16.y;
          local15.z = local16.z;
          break;
        case 2:
          local15 = Vertex(param4[0]).local;
          local15.x = local16.x;
          local15.y = local16.y;
          local15.z = local14 * local16.z;
          local15 = Vertex(param4[1]).local;
          local15.x = -local16.x;
          local15.y = local16.y;
          local15.z = local14 * local16.z;
          local15 = Vertex(param4[2]).local;
          local15.x = -local16.x;
          local15.y = -local16.y;
          local15.z = local14 * local16.z;
          local15 = Vertex(param4[3]).local;
          local15.x = local16.x;
          local15.y = -local16.y;
          local15.z = local14 * local16.z;
          break;
        default:
          throw new Error();
      }
      if(local7 < 0) {
        local17 = param4[0];
        param4[0] = param4[3];
        param4[3] = local17;
        local17 = param4[1];
        param4[1] = param4[2];
        param4[2] = local17;
      }
    }

    public static function getRectFaceInCCWOrder(param1:CollisionRect, param2:Vector3, param3:Vector.<Vertex>) : void {
      var local5:Vertex = null;
      var local4:Vector3 = param1.hs;
      local5 = param3[0];
      local5.local.x = local4.x;
      local5.local.y = local4.y;
      local5.local.z = 0;
      local5 = param3[1];
      local5.local.x = -local4.x;
      local5.local.y = local4.y;
      local5.local.z = 0;
      local5 = param3[2];
      local5.local.x = -local4.x;
      local5.local.y = -local4.y;
      local5.local.z = 0;
      local5 = param3[3];
      local5.local.x = local4.x;
      local5.local.y = -local4.y;
      local5.local.z = 0;
      var local6:Matrix4 = param1.transform;
      var local7:Number = param2.x * local6.m02 + param2.y * local6.m12 + param2.z * local6.m22;
      if(local7 < 0) {
        local5 = param3[0];
        param3[0] = param3[3];
        param3[3] = local5;
        local5 = param3[1];
        param3[1] = param3[2];
        param3[2] = local5;
      }
    }

    public static function getTriangleFaceInCCWOrder(param1:CollisionTriangle, param2:Vector3, param3:Vector.<Vertex>) : void {
      var local4:Vertex = null;
      local4 = param3[0];
      local4.local.x = param1.v0.x;
      local4.local.y = param1.v0.y;
      local4.local.z = 0;
      local4 = param3[1];
      local4.local.x = param1.v1.x;
      local4.local.y = param1.v1.y;
      local4.local.z = 0;
      local4 = param3[2];
      local4.local.x = param1.v2.x;
      local4.local.y = param1.v2.y;
      local4.local.z = 0;
      var local5:Matrix4 = param1.transform;
      var local6:Number = param2.x * local5.m02 + param2.y * local5.m12 + param2.z * local5.m22;
      if(local6 < 0) {
        local4 = param3[0];
        param3[0] = param3[2];
        param3[2] = local4;
      }
    }
  }
}
