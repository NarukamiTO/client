package alternativa.tanks.models.weapons.discrete {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface DiscreteWeapon {
    function tryToShoot(param1:int, param2:Vector3, param3:Vector.<Tank>) : void;
    function tryToDummyShoot(param1:int, param2:Vector3) : void;
  }
}
