package alternativa.tanks.models.weapon.ricochet {
  import alternativa.physics.Body;

  public class DMRicochetTargetEvaluator extends BaseRicochetTargeEvaluator implements RicochetTargetEvaluator {
    public function DMRicochetTargetEvaluator() {
      super();
    }

    public function getTargetPriority(param1:Body, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Number {
      return getBasePriority(param1.tank,param2,param3,param4,param5,param6);
    }
  }
}
