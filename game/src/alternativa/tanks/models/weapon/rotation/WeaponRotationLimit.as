package alternativa.tanks.models.weapon.rotation {
  [ModelInterface]
  public interface WeaponRotationLimit {
    function getMaxAngle() : Number;
    function getMinAngle() : Number;
  }
}
