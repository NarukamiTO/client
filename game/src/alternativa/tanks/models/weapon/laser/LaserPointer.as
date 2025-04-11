package alternativa.tanks.models.weapon.laser {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface LaserPointer {
    function updateDirection(param1:Vector3) : void;
    function aimAtTank(param1:Tank, param2:Vector3) : void;
    function hideLaser() : void;
    function getLaserPointerBlueColor() : uint;
    function getLaserPointerRedColor() : uint;
  }
}
