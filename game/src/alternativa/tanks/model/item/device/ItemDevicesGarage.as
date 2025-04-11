package alternativa.tanks.model.item.device {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.device.ItemDevicesCC;

  [ModelInterface]
  public interface ItemDevicesGarage {
    function buyDevice(param1:IGameObject, param2:int) : void;
    function insertDevice(param1:IGameObject) : void;
    function removeDevice() : void;
    function getParams() : ItemDevicesCC;
  }
}
