package alternativa.tanks.model.item.availabledevices {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AvailableDevicesEvents implements AvailableDevices {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function AvailableDevicesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loadDevices() : void {
      var i:int = 0;
      var m:AvailableDevices = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = AvailableDevices(this.impl[i]);
          m.loadDevices();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
