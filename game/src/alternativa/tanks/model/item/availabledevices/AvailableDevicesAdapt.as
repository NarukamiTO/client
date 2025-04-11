package alternativa.tanks.model.item.availabledevices {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AvailableDevicesAdapt implements AvailableDevices {
    private var object:IGameObject;
    private var impl:AvailableDevices;

    public function AvailableDevicesAdapt(param1:IGameObject, param2:AvailableDevices) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loadDevices() : void {
      try {
        Model.object = this.object;
        this.impl.loadDevices();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
