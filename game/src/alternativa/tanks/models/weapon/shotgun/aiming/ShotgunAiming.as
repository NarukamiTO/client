package alternativa.tanks.models.weapon.shotgun.aiming {
  import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
  import alternativa.tanks.models.weapon.shotgun.ShotgunRicochetTargetingSystem;

  [ModelInterface]
  public interface ShotgunAiming {
    function createTargetingSystem() : ShotgunRicochetTargetingSystem;
    function getPelletDirectionCalculator() : PelletDirectionCalculator;
  }
}
