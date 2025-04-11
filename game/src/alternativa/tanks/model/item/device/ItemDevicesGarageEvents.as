package alternativa.tanks.model.item.device {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.device.ItemDevicesCC;

  public class ItemDevicesGarageEvents implements ItemDevicesGarage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ItemDevicesGarageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function buyDevice(param1:IGameObject, param2:int) : void {
      var i:int = 0;
      var m:ItemDevicesGarage = null;
      var device:IGameObject = param1;
      var expectedPrice:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemDevicesGarage(this.impl[i]);
          m.buyDevice(device,expectedPrice);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function insertDevice(param1:IGameObject) : void {
      var i:int = 0;
      var m:ItemDevicesGarage = null;
      var device:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemDevicesGarage(this.impl[i]);
          m.insertDevice(device);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function removeDevice() : void {
      var i:int = 0;
      var m:ItemDevicesGarage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemDevicesGarage(this.impl[i]);
          m.removeDevice();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getParams() : ItemDevicesCC {
      var result:ItemDevicesCC = null;
      var i:int = 0;
      var m:ItemDevicesGarage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemDevicesGarage(this.impl[i]);
          result = m.getParams();
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
