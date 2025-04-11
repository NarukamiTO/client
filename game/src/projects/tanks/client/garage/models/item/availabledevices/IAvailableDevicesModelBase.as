package projects.tanks.client.garage.models.item.availabledevices {
  import platform.client.fp10.core.type.IGameObject;

  public interface IAvailableDevicesModelBase {
    function devicesLoaded(param1:Vector.<IGameObject>, param2:IGameObject) : void;
  }
}
