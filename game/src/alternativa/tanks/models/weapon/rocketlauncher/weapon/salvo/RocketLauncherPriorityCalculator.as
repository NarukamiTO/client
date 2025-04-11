package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.CommonTargetPriorityCalculator;

  public class RocketLauncherPriorityCalculator extends CommonTargetPriorityCalculator {
    private static const CURRENT_TARGET_BONUS:Number = 900;

    private var target:RocketTargetPoint;
    private var shotRange:Number;

    public function RocketLauncherPriorityCalculator(param1:WeaponObject, param2:RocketTargetPoint, param3:Number) {
      this.target = param2;
      this.shotRange = param3;
      super(param1);
    }

    override public function getTargetPriority(param1:Tank, param2:Number, param3:Number) : Number {
      return super.getTargetPriority(param1,param2,param3) + this.calculateBonusForLastTarget(param1);
    }

    override protected function getFullDamageDistance(param1:WeaponObject) : Number {
      return this.shotRange;
    }

    private function calculateBonusForLastTarget(param1:Tank) : Number {
      return this.target.isSameTank(param1) ? CURRENT_TARGET_BONUS : 0;
    }
  }
}
