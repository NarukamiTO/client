package alternativa.tanks.models.weapons.targeting.priority.targeting {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;

  public class PenetratingTargetPriorityCalculator implements TargetPriorityCalculator {
    [Inject]
    public static var battleService:BattleService;

    private const COMMON_PRIORITY_WEIGHT:Number = 0.000001;
    private const FULL_DAMAGE_DISTANCE:Number = 10000;

    private var commonTargetEvaluator:CommonTargetEvaluator;
    private var targetEvaluator:RailgunTargetEvaluator;
    private var maxAngle:Number;

    public function PenetratingTargetPriorityCalculator(param1:WeaponObject) {
      super();
      this.commonTargetEvaluator = battleService.getCommonTargetEvaluator();
      this.targetEvaluator = battleService.getRailgunTargetEvaluator();
      this.maxAngle = param1.verticalAutoAiming().getMaxAngle();
    }

    public function getTargetPriority(param1:Tank, param2:Number, param3:Number) : Number {
      var local4:Body = param1.getBody();
      var local5:Number = Number(this.commonTargetEvaluator.getTargetPriority(local4,param2,param3,this.FULL_DAMAGE_DISTANCE,this.maxAngle));
      return this.targetEvaluator.getHitEfficiency(local4) + local5 * this.COMMON_PRIORITY_WEIGHT;
    }
  }
}
