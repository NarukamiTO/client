package alternativa.tanks.models.weapon.streamweapon {
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.IStreamWeaponModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponModelBase;

  [ModelInfo]
  public class StreamWeaponModel extends StreamWeaponModelBase implements IStreamWeaponModelBase, IStreamWeaponModel, ObjectLoadListener {
    public function StreamWeaponModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:StreamWeaponCC = getInitParam();
      var local2:StreamWeaponData = new StreamWeaponData(local1.energyCapacity,local1.energyDischargeSpeed,local1.energyRechargeSpeed,local1.weaponTickIntervalMsec);
      putData(StreamWeaponData,local2);
    }

    public function getStreamWeaponData() : StreamWeaponData {
      return StreamWeaponData(getData(StreamWeaponData));
    }

    public function reconfigureWeapon(param1:Number) : void {
      StreamWeaponData(getData(StreamWeaponData)).setEnergyDischargeSpeed(param1);
      var local2:StreamWeaponReconfiguredListener = StreamWeaponReconfiguredListener(object.event(StreamWeaponReconfiguredListener));
      var local3:IGameObject = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank().user;
      local2.streamWeaponReconfigured(local3,param1);
    }
  }
}
