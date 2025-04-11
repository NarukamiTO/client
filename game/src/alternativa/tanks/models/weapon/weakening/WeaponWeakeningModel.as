package alternativa.tanks.models.weapon.weakening {
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponReconfiguredListener;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.IWeaponWeakeningModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningModelBase;

  [ModelInfo]
  public class WeaponWeakeningModel extends WeaponWeakeningModelBase implements IWeaponWeakeningModelBase, IWeaponWeakeningModel, ObjectLoadListener {
    public function WeaponWeakeningModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:WeaponWeakeningCC = getInitParam();
      var local2:WeaponWeakeningData = new WeaponWeakeningData();
      local2.maximumDamageRadius = isNaN(local1.maximumDamageRadius) ? 0 : BattleUtils.toClientScale(local1.maximumDamageRadius);
      local2.minimumDamageRadius = isNaN(local1.minimumDamageRadius) ? 1 : BattleUtils.toClientScale(local1.minimumDamageRadius);
      local2.minimumDamagePercent = isNaN(local1.minimumDamagePercent) ? 0 : local1.minimumDamagePercent;
      if(local2.minimumDamagePercent > 100) {
        local2.minimumDamagePercent = 100;
      }
      putData(WeaponWeakeningData,local2);
    }

    public function getDistanceWeakening() : DistanceWeakening {
      var local1:WeaponWeakeningData = WeaponWeakeningData(getData(WeaponWeakeningData));
      return new DistanceWeakening(local1.maximumDamageRadius,local1.minimumDamageRadius,local1.minimumDamagePercent);
    }

    public function reconfigureWeapon(param1:Number, param2:Number) : void {
      var local3:WeaponWeakeningData = WeaponWeakeningData(getData(WeaponWeakeningData));
      local3.maximumDamageRadius = isNaN(param1) ? 0 : BattleUtils.toClientScale(param1);
      local3.minimumDamageRadius = isNaN(param2) ? 1 : BattleUtils.toClientScale(param2);
      var local4:IGameObject = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank().user;
      StreamWeaponReconfiguredListener(object.event(StreamWeaponReconfiguredListener)).streamWeaponDistanceChanged(local4,local3.minimumDamageRadius);
    }
  }
}
