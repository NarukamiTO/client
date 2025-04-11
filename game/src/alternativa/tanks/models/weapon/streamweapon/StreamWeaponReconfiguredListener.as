package alternativa.tanks.models.weapon.streamweapon {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface StreamWeaponReconfiguredListener {
    function streamWeaponReconfigured(param1:IGameObject, param2:Number) : void;
    function streamWeaponDistanceChanged(param1:IGameObject, param2:Number) : void;
  }
}
