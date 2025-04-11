package alternativa.tanks.models.weapons.charging {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponChargingListenerEvents implements WeaponChargingListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponChargingListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function handleChargingStart() : void {
      var i:int = 0;
      var m:WeaponChargingListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponChargingListener(this.impl[i]);
          m.handleChargingStart();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function handleChargingFinish(param1:int) : void {
      var i:int = 0;
      var m:WeaponChargingListener = null;
      var durationMs:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponChargingListener(this.impl[i]);
          m.handleChargingFinish(durationMs);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
