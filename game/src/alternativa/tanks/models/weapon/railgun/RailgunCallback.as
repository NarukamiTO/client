package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  [ModelInterface]
  public interface RailgunCallback {
    function onStartCharging(param1:int) : void;
    function onShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>) : void;
    function onShotDummy(param1:int) : void;
  }
}
