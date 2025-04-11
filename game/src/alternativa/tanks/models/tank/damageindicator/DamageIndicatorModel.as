package alternativa.tanks.models.tank.damageindicator {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.sfx.damageindicator.DamageIndicatorEffect;
  import forms.ColorConstants;
  import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorModelBase;
  import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorType;
  import projects.tanks.client.battlefield.models.user.damageindicator.IDamageIndicatorModelBase;
  import projects.tanks.client.battlefield.models.user.damageindicator.TargetTankDamage;

  [ModelInfo]
  public class DamageIndicatorModel extends DamageIndicatorModelBase implements IDamageIndicatorModelBase {
    public function DamageIndicatorModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function showDamageForShooter(param1:Vector.<TargetTankDamage>) : void {
      var local2:TargetTankDamage = null;
      var local3:Tank = null;
      var local4:Vector3 = null;
      var local5:Object3D = null;
      for each(local2 in param1) {
        if(local2.target != null) {
          local3 = ITankModel(local2.target.adapt(ITankModel)).getTank();
          local4 = BattleUtils.tmpVector;
          if(local3.isLastHitPointSet) {
            local4.copy(local3.lastHitPoint);
            BattleUtils.localToGlobal(local3.getBody(),local4);
          } else {
            local5 = local3.getTurret3D();
            local4.reset(local5.x,local5.y,local5.z);
          }
          DamageIndicatorEffect.start(local4,this.getEffectColor(local2),local2.damageAmount);
        }
      }
    }

    private function getEffectColor(param1:TargetTankDamage) : uint {
      switch(param1.damageIndicatorType) {
        case DamageIndicatorType.FATAL:
          return ColorConstants.USER_TITLE_RED;
        case DamageIndicatorType.CRITICAL:
          return ColorConstants.USER_TITLE_YELLOW;
        case DamageIndicatorType.HEAL:
          return ColorConstants.GREEN_TEXT;
        default:
          return ColorConstants.WHITE;
      }
    }
  }
}
