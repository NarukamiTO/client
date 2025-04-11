package alternativa.tanks.models.battle.dm {
  import alternativa.physics.Body;
  import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;

  public class DMRailgunTargetEvaluator implements RailgunTargetEvaluator {
    public function DMRailgunTargetEvaluator() {
      super();
    }

    public function getHitEfficiency(param1:Body) : Number {
      return param1.tank.health > 0 ? 1 : 0;
    }

    public function isFriendly(param1:Body) : Boolean {
      return false;
    }
  }
}
