package alternativa.tanks.model.item.device {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.device.ItemDevicesCC;

  public class ItemDevicesGarageAdapt implements ItemDevicesGarage {
    private var object:IGameObject;
    private var impl:ItemDevicesGarage;

    public function ItemDevicesGarageAdapt(param1:IGameObject, param2:ItemDevicesGarage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function buyDevice(param1:IGameObject, param2:int) : void {
      var device:IGameObject = param1;
      var expectedPrice:int = param2;
      try {
        Model.object = this.object;
        this.impl.buyDevice(device,expectedPrice);
      }
      finally {
        Model.popObject();
      }
    }

    public function insertDevice(param1:IGameObject) : void {
      var device:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.insertDevice(device);
      }
      finally {
        Model.popObject();
      }
    }

    public function removeDevice() : void {
      try {
        Model.object = this.object;
        this.impl.removeDevice();
      }
      finally {
        Model.popObject();
      }
    }

    public function getParams() : ItemDevicesCC {
      var result:ItemDevicesCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getParams();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
