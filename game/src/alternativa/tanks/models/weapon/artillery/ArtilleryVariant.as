package alternativa.tanks.models.weapon.artillery {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface ArtilleryVariant {
    function initArtilleryVariant(param1:IGameObject, param2:ArtilleryWeapon, param3:Boolean) : void;
  }
}
