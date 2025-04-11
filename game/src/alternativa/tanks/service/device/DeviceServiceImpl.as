package alternativa.tanks.service.device {
  import alternativa.tanks.model.item.device.ItemDevicesGarage;
  import alternativa.tanks.model.item.temporary.ITemporaryItem;
  import alternativa.tanks.service.item.ItemService;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.IGameObject;

  public class DeviceServiceImpl extends EventDispatcher implements DeviceService {
    [Inject]
    public static var itemService:ItemService;

    private var availableDevices:Dictionary;
    private var mountedDevices:Dictionary;

    public function DeviceServiceImpl() {
      super();
    }

    public function init() : void {
      this.availableDevices = new Dictionary();
      this.mountedDevices = new Dictionary();
    }

    public function setAvailableDevices(param1:IGameObject, param2:Vector.<IGameObject>) : void {
      this.availableDevices[this.getBaseClass(param1)] = param2;
    }

    public function getAvailableDevices(param1:IGameObject) : Vector.<IGameObject> {
      return this.availableDevices[this.getBaseClass(param1)];
    }

    public function getDeviceOwnType(param1:IGameObject) : DeviceOwningType {
      if(param1 == null || Boolean(ITemporaryItem(param1.adapt(ITemporaryItem)).isInfinityLifeTimeItem())) {
        return DeviceOwningType.BOUGHT;
      }
      return ITemporaryItem(param1.adapt(ITemporaryItem)).getTimeRemainingInMSec() > 0 ? DeviceOwningType.RENT : DeviceOwningType.NOT_OWNED;
    }

    public function getInsertedDevicePreview(param1:IGameObject) : ImageResource {
      var local2:IGameObject = this.mountedDevices[this.getBaseClass(param1)];
      return local2 != null ? itemService.getPreviewResource(local2) : ItemDevicesGarage(param1.adapt(ItemDevicesGarage)).getParams().preview;
    }

    public function isDevicesAvailable(param1:IGameObject) : Boolean {
      if(!param1.hasModel(ItemDevicesGarage)) {
        return false;
      }
      return ItemDevicesGarage(param1.adapt(ItemDevicesGarage)).getParams().devicesAvailable;
    }

    public function insertDevice(param1:IGameObject, param2:IGameObject) : void {
      this.mountedDevices[this.getBaseClass(param1)] = param2;
      this.notifyDevicesStateUpdated();
    }

    public function removeDevice(param1:IGameObject) : void {
      delete this.mountedDevices[this.getBaseClass(param1)];
      this.notifyDevicesStateUpdated();
    }

    public function getInsertedDevice(param1:IGameObject) : IGameObject {
      return this.mountedDevices[this.getBaseClass(param1)];
    }

    private function notifyDevicesStateUpdated() : void {
      dispatchEvent(new UpdateDevicesEvent());
    }

    private function getBaseClass(param1:IGameObject) : IGameClass {
      return itemService.getModifications(param1)[0].gameClass;
    }

    public function isSale(param1:IGameObject) : Boolean {
      return ItemDevicesGarage(param1.adapt(ItemDevicesGarage)).getParams().sale;
    }
  }
}
