package alternativa.tanks.models.weapon.ricochet {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  [ModelInterface]
  public interface RicochetWeaponCallback {
    function onShot(param1:int, param2:int, param3:Vector3) : void;
    function onDummyShot(param1:int) : void;
    function onTargetHit(param1:int, param2:Body, param3:Vector.<Vector3>) : void;
    function onStaticHit(param1:int, param2:Vector.<Vector3>) : void;
  }
}
