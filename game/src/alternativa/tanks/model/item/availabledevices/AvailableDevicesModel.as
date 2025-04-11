package alternativa.tanks.model.item.availabledevices {
  import alternativa.tanks.gui.device.DevicesLoadedEvent;
  import alternativa.tanks.service.device.DeviceService;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.availabledevices.AvailableDevicesModelBase;
  import projects.tanks.client.garage.models.item.availabledevices.IAvailableDevicesModelBase;

  [ModelInfo]
  public class AvailableDevicesModel extends AvailableDevicesModelBase implements IAvailableDevicesModelBase, AvailableDevices {
    [Inject]
    public static var deviceService:DeviceService;

    public function AvailableDevicesModel() {
      super();
    }

    public function loadDevices() : void {
      server.loadAvailableDevices();
    }

    public function devicesLoaded(param1:Vector.<IGameObject>, param2:IGameObject) : void {
      deviceService.setAvailableDevices(object,param1);
      deviceService.insertDevice(object,param2);
      deviceService.dispatchEvent(new DevicesLoadedEvent());
    }
  }
}
