package alternativa.tanks.models.battle.dm {
  import alternativa.physics.Body;
  import alternativa.tanks.models.battle.battlefield.CommonTargetEvaluatorConst;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;

  public class DMCommonTargetEvaluator implements CommonTargetEvaluator {
    public function DMCommonTargetEvaluator() {
      super();
    }

    public function getTargetPriority(param1:Body, param2:Number, param3:Number, param4:Number, param5:Number) : Number {
      if(param1.tank.health > 0) {
        return CommonTargetEvaluatorConst.MAX_PRIORITY - (CommonTargetEvaluatorConst.DISTANCE_WEIGHT * param2 / param4 + (1 - CommonTargetEvaluatorConst.DISTANCE_WEIGHT) * Math.abs(param3) / param5);
      }
      return 0;
    }
  }
}
