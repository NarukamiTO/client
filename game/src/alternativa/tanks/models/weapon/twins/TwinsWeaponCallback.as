package alternativa.tanks.models.weapon.twins {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  [ModelInterface]
  public interface TwinsWeaponCallback {
    function onShot(param1:int, param2:int, param3:int, param4:Vector3) : void;
    function onDummyShot(param1:int, param2:int) : void;
    function onTargetHit(param1:int, param2:Body, param3:Vector3) : void;
    function onStaticHit(param1:int, param2:Vector3) : void;
  }
}
