package alternativa.tanks.models.weapons.charging {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponChargingCommunicationEvents implements WeaponChargingCommunication {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponChargingCommunicationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startCharging(param1:int) : void {
      var i:int = 0;
      var m:WeaponChargingCommunication = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponChargingCommunication(this.impl[i]);
          m.startCharging(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function finishCharging(param1:int) : void {
      var i:int = 0;
      var m:WeaponChargingCommunication = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponChargingCommunication(this.impl[i]);
          m.finishCharging(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
