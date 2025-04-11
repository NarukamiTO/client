package alternativa.tanks.models.weapon.healing.targeting {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.HealingGunTargetEvaluator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.TargetPriorityCalculator;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;

  public class IsisTargetPriorityCalculator implements TargetPriorityCalculator {
    [Inject]
    public static var battleService:BattleService;

    private const COMMON_PRIORITY_WEIGHT:Number = 0.0001;
    private const LOCK_RANGE_DELTA:Number = 50;
    private const CURRENT_TARGET_BONUS:Number = 100;

    private var commonTargetEvaluator:CommonTargetEvaluator;
    private var targetEvaluator:HealingGunTargetEvaluator;
    private var maxAngle:Number;
    private var fullDamageDistance:Number;
    private var target:Tank;

    public function IsisTargetPriorityCalculator(param1:IsisCC) {
      super();
      this.commonTargetEvaluator = battleService.getCommonTargetEvaluator();
      this.targetEvaluator = battleService.getHealingGunTargetEvaluator();
      this.fullDamageDistance = param1.radius - this.LOCK_RANGE_DELTA;
      this.maxAngle = param1.coneAngle;
    }

    public function setTarget(param1:Tank) : void {
      this.target = param1;
    }

    public function resetTarget() : void {
      this.target = null;
    }

    public function getTargetPriority(param1:Tank, param2:Number, param3:Number) : Number {
      if(param1.health == 0) {
        return 0;
      }
      var local4:Body = param1.getBody();
      var local5:Number = Number(this.commonTargetEvaluator.getTargetPriority(local4,param2,param3,this.fullDamageDistance,this.maxAngle));
      return this.targetEvaluator.getTargetPriority(local4) + local5 * this.COMMON_PRIORITY_WEIGHT + this.calculateBonusForLastTarget(param1);
    }

    private function calculateBonusForLastTarget(param1:Tank) : Number {
      return param1 != this.target ? 0 : this.CURRENT_TARGET_BONUS;
    }
  }
}
