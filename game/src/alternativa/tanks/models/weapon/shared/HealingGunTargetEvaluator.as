package alternativa.tanks.models.weapon.shared {
  import alternativa.physics.Body;

  public interface HealingGunTargetEvaluator {
    function getTargetPriority(param1:Body) : Number;
  }
}
