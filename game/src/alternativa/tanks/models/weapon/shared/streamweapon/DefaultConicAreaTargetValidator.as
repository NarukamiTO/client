package alternativa.tanks.models.weapon.shared.streamweapon {
  import alternativa.physics.Body;
  import alternativa.tanks.models.weapon.shared.ConicAreaTargetValidator;

  public class DefaultConicAreaTargetValidator implements ConicAreaTargetValidator {
    public function DefaultConicAreaTargetValidator() {
      super();
    }

    public function isValidTarget(param1:Body) : Boolean {
      return param1.tank.health > 0;
    }
  }
}
