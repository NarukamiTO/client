package alternativa.tanks.service.device {
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public interface DeviceService extends IEventDispatcher {
    function setAvailableDevices(param1:IGameObject, param2:Vector.<IGameObject>) : void;
    function getAvailableDevices(param1:IGameObject) : Vector.<IGameObject>;
    function getDeviceOwnType(param1:IGameObject) : DeviceOwningType;
    function insertDevice(param1:IGameObject, param2:IGameObject) : void;
    function removeDevice(param1:IGameObject) : void;
    function isDevicesAvailable(param1:IGameObject) : Boolean;
    function getInsertedDevice(param1:IGameObject) : IGameObject;
    function getInsertedDevicePreview(param1:IGameObject) : ImageResource;
    function isSale(param1:IGameObject) : Boolean;
    function init() : void;
  }
}
