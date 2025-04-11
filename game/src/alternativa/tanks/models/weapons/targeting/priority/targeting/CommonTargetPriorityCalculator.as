package alternativa.tanks.models.weapons.targeting.priority.targeting {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;

  public class CommonTargetPriorityCalculator implements TargetPriorityCalculator {
    [Inject]
    public static var battleService:BattleService;

    private var commonTargetEvaluator:CommonTargetEvaluator;
    private var maxAngle:Number;
    private var fullDamageDistance:Number;

    public function CommonTargetPriorityCalculator(param1:WeaponObject) {
      super();
      this.commonTargetEvaluator = battleService.getCommonTargetEvaluator();
      this.fullDamageDistance = this.getFullDamageDistance(param1);
      var local2:VerticalAutoAiming = param1.verticalAutoAiming();
      this.maxAngle = local2.getMaxAngle();
    }

    public function getTargetPriority(param1:Tank, param2:Number, param3:Number) : Number {
      return this.commonTargetEvaluator.getTargetPriority(param1.getBody(),param2,param3,this.fullDamageDistance,this.maxAngle);
    }

    protected function getFullDamageDistance(param1:WeaponObject) : Number {
      return param1.distanceWeakening().getFullDamageDistance();
    }
  }
}
