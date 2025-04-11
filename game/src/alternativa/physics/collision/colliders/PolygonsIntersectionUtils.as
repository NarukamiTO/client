package alternativa.physics.collision.colliders {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.CollisionShape;
  import flash.geom.Point;

  public class PolygonsIntersectionUtils {
    private static const projectedPoints1:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
    private static const projectedPoints2:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
    private static const intersection:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);

    private static var points1:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
    private static var points2:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);

    private static const point:Point = new Point();
    private static const normal1:Vector3 = new Vector3();
    private static const normal2:Vector3 = new Vector3();

    public function PolygonsIntersectionUtils() {
      super();
    }

    public static function findContacts(param1:CollisionShape, param2:Vector.<Vertex>, param3:int, param4:CollisionShape, param5:Vector.<Vertex>, param6:int, param7:Matrix4, param8:Vector.<ShapeContact>) : void {
      var local11:Point = null;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:ShapeContact = null;
      var local15:Vector3 = null;
      calculateFaceNormal(param2,normal1);
      calculateFaceNormal(param5,normal2);
      fillProjectedPoints(param2,param3,projectedPoints1);
      fillProjectedPoints(param5,param6,projectedPoints2);
      var local9:int = findPolygonsIntersection(projectedPoints1,param3,projectedPoints2,param6,intersection);
      var local10:int = 0;
      while(local10 < local9) {
        local11 = intersection[local10];
        local12 = getFaceZ(local11,Vertex(param2[0]).transformed,normal1);
        local13 = getFaceZ(local11,Vertex(param5[0]).transformed,normal2);
        if(local13 > local12) {
          local14 = ShapeContact.create();
          local14.shape1 = param1;
          local14.shape2 = param4;
          local15 = local14.position;
          local15.x = local11.x;
          local15.y = local11.y;
          local15.z = 0.5 * (local12 + local13);
          local15.transform4(param7);
          local14.penetration = local13 - local12;
          local14.normal.x = param7.m02;
          local14.normal.y = param7.m12;
          local14.normal.z = param7.m22;
          param8[param8.length] = local14;
        }
        local10++;
      }
    }

    private static function calculateFaceNormal(param1:Vector.<Vertex>, param2:Vector3) : void {
      var local9:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local14:Number = NaN;
      var local3:Vertex = param1[0];
      var local4:Vertex = param1[1];
      var local5:Vertex = param1[2];
      var local6:Vector3 = local3.transformed;
      var local7:Vector3 = local4.transformed;
      var local8:Vector3 = local5.transformed;
      local9 = local7.x - local6.x;
      var local10:Number = local7.y - local6.y;
      local11 = local7.z - local6.z;
      local12 = local8.x - local6.x;
      var local13:Number = local8.y - local6.y;
      local14 = local8.z - local6.z;
      param2.x = local10 * local14 - local11 * local13;
      param2.y = local11 * local12 - local9 * local14;
      param2.z = local9 * local13 - local10 * local12;
      param2.normalize();
    }

    private static function fillProjectedPoints(param1:Vector.<Vertex>, param2:int, param3:Vector.<Point>) : void {
      var local5:Vertex = null;
      var local6:Point = null;
      var local4:int = 0;
      while(local4 < param2) {
        local5 = param1[local4];
        local6 = param3[local4];
        local6.x = local5.transformed.x;
        local6.y = local5.transformed.y;
        local4++;
      }
    }

    private static function findPolygonsIntersection(param1:Vector.<Point>, param2:int, param3:Vector.<Point>, param4:int, param5:Vector.<Point>) : int {
      var local9:Point = null;
      var local10:Vector.<Point> = null;
      copyPoints(param3,points1,param4);
      var local6:int = param4;
      var local7:Point = param1[param2 - 1];
      var local8:int = 0;
      while(local8 < param2) {
        local9 = param1[local8];
        local6 = clip(local7,local9,points1,points2,local6);
        if(local6 == 0) {
          break;
        }
        local7 = local9;
        local10 = points1;
        points1 = points2;
        points2 = local10;
        local8++;
      }
      copyPoints(points1,param5,local6);
      return local6;
    }

    private static function copyPoints(param1:Vector.<Point>, param2:Vector.<Point>, param3:int) : void {
      var local5:Point = null;
      var local6:Point = null;
      var local4:int = 0;
      while(local4 < param3) {
        local5 = param1[local4];
        local6 = param2[local4];
        local6.x = local5.x;
        local6.y = local5.y;
        local4++;
      }
    }

    private static function clip(param1:Point, param2:Point, param3:Vector.<Point>, param4:Vector.<Point>, param5:int) : int {
      var local10:Point = null;
      var local11:Boolean = false;
      var local6:Point = param3[param5 - 1];
      var local7:Boolean = arePointsCCW(param1,param2,local6);
      var local8:int = 0;
      var local9:int = 0;
      while(local9 < param5) {
        local10 = param3[local9];
        local11 = arePointsCCW(param1,param2,local10);
        if(local11) {
          if(!local7) {
            calculateIntersection(param1,param2,local6,local10,point);
            setPoint(point,param4,local8++);
          }
          setPoint(local10,param4,local8++);
        } else if(local7) {
          calculateIntersection(param1,param2,local6,local10,point);
          setPoint(point,param4,local8++);
        }
        local7 = local11;
        local6 = local10;
        local9++;
      }
      return local8;
    }

    private static function setPoint(param1:Point, param2:Vector.<Point>, param3:int) : void {
      var local4:Point = param2[param3];
      local4.x = param1.x;
      local4.y = param1.y;
    }

    private static function arePointsCCW(param1:Point, param2:Point, param3:Point) : Boolean {
      var local4:Number = param2.x - param1.x;
      var local5:Number = param2.y - param1.y;
      var local6:Number = param3.x - param1.x;
      var local7:Number = param3.y - param1.y;
      return local4 * local7 - local5 * local6 > 0;
    }

    private static function calculateIntersection(param1:Point, param2:Point, param3:Point, param4:Point, param5:Point) : void {
      var local6:Number = param2.x - param1.x;
      var local7:Number = param2.y - param1.y;
      var local8:Number = param4.x - param3.x;
      var local9:Number = param4.y - param3.y;
      var local10:Number = param3.x - param1.x;
      var local11:Number = param3.y - param1.y;
      var local12:Number = (local6 * local11 - local7 * local10) / (local7 * local8 - local6 * local9);
      param5.x = param3.x + local12 * local8;
      param5.y = param3.y + local12 * local9;
    }

    private static function getFaceZ(param1:Point, param2:Vector3, param3:Vector3) : Number {
      var local4:Number = param2.dot(param3);
      return (local4 - param1.x * param3.x - param1.y * param3.y) / param3.z;
    }
  }
}
