package alternativa.tanks.models.weapon.freeze {
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;

  [ModelInterface]
  public interface IFreezeSFXModel {
    function getFreezeEffects(param1:Number, param2:Number) : StreamWeaponEffects;
  }
}
