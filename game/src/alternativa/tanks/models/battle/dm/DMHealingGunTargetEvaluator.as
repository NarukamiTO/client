package alternativa.tanks.models.battle.dm {
  import alternativa.physics.Body;
  import alternativa.tanks.models.weapon.shared.HealingGunTargetEvaluator;

  public class DMHealingGunTargetEvaluator implements HealingGunTargetEvaluator {
    public function DMHealingGunTargetEvaluator() {
      super();
    }

    public function getTargetPriority(param1:Body) : Number {
      return 1;
    }
  }
}
