package alternativa.tanks.models.weapons.targeting.direction {
  import alternativa.tanks.models.weapon.AllGlobalGunParams;

  public interface TargetingDirectionCalculator {
    function getDirections(param1:AllGlobalGunParams) : Vector.<TargetingDirection>;
  }
}
