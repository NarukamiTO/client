package alternativa.tanks.battle.objects.tank {
  import alternativa.math.Matrix3;
  import alternativa.physics.Body;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;

  public interface WeaponMount {
    function reset() : void;
    function updatePhysics(param1:Body) : void;
    function interpolate(param1:Number, param2:int) : void;
    function rotate(param1:Number, param2:Matrix3) : void;
    function isRotating() : Boolean;
    function getTurretInterpolatedDirection() : Number;
    function getTurretPhysicsDirection() : Number;
    function setTurretPhysicsDirection(param1:Number) : void;
    function getTurretRealControlType() : TurretControlType;
    function getTurretRealControlInput() : Number;
    function getTurretTurnSpeedNumber() : int;
    function setTurretControlState(param1:TurretControlType, param2:Number, param3:int) : void;
    function getBarrelInterpolatedElevation() : Number;
    function setBarrelElevation(param1:Number) : void;
    function setMaxTurnSpeed(param1:Number, param2:Boolean) : void;
    function getTurnAcceleration() : Number;
    function setTurnAcceleration(param1:Number) : void;
    function setGyroscopePower(param1:Number) : void;
    function lock(param1:int) : void;
    function unlock(param1:int) : void;
  }
}
