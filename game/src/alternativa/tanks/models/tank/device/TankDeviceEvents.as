package alternativa.tanks.models.tank.device {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TankDeviceEvents implements TankDevice {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TankDeviceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDevice() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:TankDevice = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankDevice(this.impl[i]);
          result = m.getDevice();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
