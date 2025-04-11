package alternativa.tanks.models.weapons.charging {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponChargingCommunicationAdapt implements WeaponChargingCommunication {
    private var object:IGameObject;
    private var impl:WeaponChargingCommunication;

    public function WeaponChargingCommunicationAdapt(param1:IGameObject, param2:WeaponChargingCommunication) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startCharging(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.startCharging(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function finishCharging(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.finishCharging(time);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
