package alternativa.tanks.models.tank.device {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.user.device.ITankDeviceModelBase;
  import projects.tanks.client.battlefield.models.user.device.TankDeviceModelBase;

  [ModelInfo]
  public class TankDeviceModel extends TankDeviceModelBase implements ITankDeviceModelBase, TankDevice {
    public function TankDeviceModel() {
      super();
    }

    public function getDevice() : Long {
      return getInitParam().deviceId;
    }
  }
}
