package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface WeaponBuffListener {
    function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void;
  }
}
