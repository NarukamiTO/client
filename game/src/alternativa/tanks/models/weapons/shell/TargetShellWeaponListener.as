package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface TargetShellWeaponListener {
    function onShotWithTarget(param1:int, param2:int, param3:Vector3, param4:Tank, param5:Vector3) : void;
  }
}
