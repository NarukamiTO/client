package alternativa.tanks.models.tank {
  import alternativa.math.Vector3;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class MoveCommandUtils {
    private static const nearDistance:Number = 30;
    private static const nearDistanceSqr:Number = nearDistance * nearDistance;
    private static const nearVelocity:Number = 50;
    private static const nearVelocitySqr:Number = nearVelocity * nearVelocity;
    private static const nearOrientationDegrees:Number = 4;
    private static const nearOrientationRad:Number = nearOrientationDegrees / 180 * Math.PI;
    private static const nearRotationDirDegrees:Number = 10;
    private static const nearRotationDirRad:Number = nearRotationDirDegrees / 180 * Math.PI;

    public function MoveCommandUtils() {
      super();
    }

    public static function copyMoveCommand(param1:MoveCommand, param2:MoveCommand) : void {
      copyVector3d(param1.angularVelocity,param2.angularVelocity);
      copyVector3d(param1.linearVelocity,param2.linearVelocity);
      copyVector3d(param1.orientation,param2.orientation);
      copyVector3d(param1.position,param2.position);
      param2.control = param1.control;
      param2.turnSpeedNumber = param1.turnSpeedNumber;
    }

    public static function copyVector3d(param1:Vector3d, param2:Vector3d) : void {
      param2.x = param1.x;
      param2.y = param1.y;
      param2.z = param1.z;
    }

    public static function calculateDistanceSqr(param1:Vector3, param2:Vector3d) : Number {
      var local3:Number = param1.x - param2.x;
      var local4:Number = param1.y - param2.y;
      var local5:Number = param1.z - param2.z;
      return local3 * local3 + local4 * local4 + local5 * local5;
    }

    public static function isMoveCommandsAlmostEquals(param1:MoveCommand, param2:MoveCommand) : Boolean {
      return checkDistance(param1,param2) && checkOrientation(param1,param2) && checkLinearVelocity(param1,param2) && checkAngularVelocity(param1,param2);
    }

    private static function checkDistance(param1:MoveCommand, param2:MoveCommand) : Boolean {
      return diffSqr(param1.position,param2.position) < nearDistanceSqr;
    }

    private static function checkLinearVelocity(param1:MoveCommand, param2:MoveCommand) : Boolean {
      return diffSqr(param1.linearVelocity,param2.linearVelocity) < nearVelocitySqr;
    }

    private static function checkOrientation(param1:MoveCommand, param2:MoveCommand) : Boolean {
      var local3:Vector3d = param2.orientation;
      var local4:Vector3d = param1.orientation;
      return Math.abs(local4.x - local3.x) < nearOrientationRad && Math.abs(local4.y - local3.y) < nearOrientationRad && Math.abs(local4.z - local3.z) < nearOrientationRad;
    }

    private static function checkAngularVelocity(param1:MoveCommand, param2:MoveCommand) : Boolean {
      var local3:Vector3d = param2.angularVelocity;
      var local4:Vector3d = param1.angularVelocity;
      return Math.abs(local4.x - local3.x) < nearRotationDirRad && Math.abs(local4.y - local3.y) < nearRotationDirRad && Math.abs(local4.z - local3.z) < nearRotationDirRad;
    }

    private static function diffSqr(param1:Vector3d, param2:Vector3d) : Number {
      var local3:Number = param1.x - param2.x;
      var local4:Number = param1.y - param2.y;
      var local5:Number = param1.z - param2.z;
      return local3 * local3 + local4 * local4 + local5 * local5;
    }

    private static function cosAngleBetween(param1:Vector3d, param2:Vector3d) : Number {
      var local3:Number = length(param1);
      var local4:Number = length(param2);
      return (param1.x * param2.x + param1.y * param2.y + param1.z * param2.z) / local3 / local4;
    }

    private static function length(param1:Vector3d) : Number {
      return Math.sqrt(param1.x * param1.x + param1.y * param1.y + param1.z * param1.z);
    }

    public static function getDiffs(param1:MoveCommand, param2:MoveCommand) : String {
      return dumpDistance(param1,param2) + " " + dumpOrientation(param1,param2) + " " + dumpLinearVelocity(param1,param2) + " " + dumpAngularVelocity(param1,param2) + " " + dumpBooleans(param1,param2);
    }

    private static function dumpBooleans(param1:MoveCommand, param2:MoveCommand) : String {
      return (checkDistance(param1,param2) ? "T" : "F") + (checkOrientation(param1,param2) ? "T" : "F") + (checkLinearVelocity(param1,param2) ? "T" : "F") + (checkAngularVelocity(param1,param2) ? "T" : "F");
    }

    private static function dumpDistance(param1:MoveCommand, param2:MoveCommand) : String {
      return "dist: [" + diffSqr(param1.position,param2.position) + "/" + nearDistanceSqr + "]";
    }

    private static function dumpOrientation(param1:MoveCommand, param2:MoveCommand) : String {
      var local3:Vector3d = param2.orientation;
      var local4:Vector3d = param1.orientation;
      return "ori: [X:" + Math.abs(local4.x - local3.x) + "/" + nearOrientationRad + "];[Y:" + Math.abs(local4.x - local3.x) + "/" + nearOrientationRad + "];[Z:" + Math.abs(local4.x - local3.x) + "/" + nearOrientationRad + "]";
    }

    private static function dumpLinearVelocity(param1:MoveCommand, param2:MoveCommand) : String {
      return "lV: [" + diffSqr(param1.linearVelocity,param2.linearVelocity) + "/" + nearVelocitySqr + "]";
    }

    private static function dumpAngularVelocity(param1:MoveCommand, param2:MoveCommand) : String {
      var local3:Vector3d = param2.angularVelocity;
      var local4:Vector3d = param1.angularVelocity;
      return "oV: [X:" + Math.abs(local4.x - local3.x) + "/" + nearRotationDirRad + "];[Y:" + Math.abs(local4.x - local3.x) + "/" + nearRotationDirRad + "];[Z:" + Math.abs(local4.x - local3.x) + "/" + nearRotationDirRad + "]";
    }
  }
}
