package alternativa.tanks.models.weapon.artillery {
  [ModelInterface]
  public interface IArtilleryModel {
    function getDefaultElevation() : Number;
    function getWeapon() : ArtilleryWeapon;
  }
}
