package alternativa.tanks.models.weapon.smoky {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  [ModelInterface]
  public interface SmokyCallback {
    function onShot(param1:int) : void;
    function onShotStatic(param1:int, param2:Vector3) : void;
    function onShotTarget(param1:int, param2:Vector3, param3:Body) : void;
  }
}
