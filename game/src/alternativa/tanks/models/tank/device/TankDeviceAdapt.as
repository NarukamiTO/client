package alternativa.tanks.models.tank.device {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TankDeviceAdapt implements TankDevice {
    private var object:IGameObject;
    private var impl:TankDevice;

    public function TankDeviceAdapt(param1:IGameObject, param2:TankDevice) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDevice() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getDevice();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
