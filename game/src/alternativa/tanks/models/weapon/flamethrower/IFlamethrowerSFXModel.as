package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;

  [ModelInterface]
  public interface IFlamethrowerSFXModel {
    function getFlamethrowerEffects(param1:Number, param2:Number) : StreamWeaponEffects;
  }
}
