package alternativa.tanks.models.weapons.charging {
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.charging.IWeaponChargingCommunicationModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.charging.WeaponChargingCommunicationModelBase;

  [ModelInfo]
  public class WeaponChargingCommunicationModel extends WeaponChargingCommunicationModelBase implements IWeaponChargingCommunicationModelBase, WeaponChargingCommunication {
    public function WeaponChargingCommunicationModel() {
      super();
    }

    public function startCharging(param1:int) : void {
      server.startCharging(param1);
    }

    public function finishCharging(param1:int) : void {
      server.finishCharging(param1);
    }

    [Obfuscation(rename="false")]
    public function handleChargingStart() : void {
      this.listeners().handleChargingStart();
    }

    [Obfuscation(rename="false")]
    public function handleChargingFinish(param1:int) : void {
      this.listeners().handleChargingFinish(param1);
    }

    private function listeners() : WeaponChargingListener {
      return WeaponChargingListener(object.event(WeaponChargingListener));
    }
  }
}
