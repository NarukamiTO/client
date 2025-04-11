package alternativa.tanks.models.weapon.shared {
  import alternativa.physics.Body;

  public interface ConicAreaTargetValidator {
    function isValidTarget(param1:Body) : Boolean;
  }
}
