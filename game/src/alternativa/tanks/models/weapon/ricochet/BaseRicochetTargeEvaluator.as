package alternativa.tanks.models.weapon.ricochet {
  import alternativa.tanks.battle.objects.tank.Tank;

  public class BaseRicochetTargeEvaluator {
    private static const DISTANCE_WEIGHT:Number = 0.65;

    public function BaseRicochetTargeEvaluator() {
      super();
    }

    protected static function getBasePriority(param1:Tank, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Number {
      var local7:Number = NaN;
      var local8:Number = NaN;
      if(param1.health > 0) {
        local7 = DISTANCE_WEIGHT * param3 / param5 + (1 - DISTANCE_WEIGHT) * param4 / param6;
        local8 = param2 == 0 ? 2 : 0;
        return 1 - local7 + local8;
      }
      return 0;
    }
  }
}
