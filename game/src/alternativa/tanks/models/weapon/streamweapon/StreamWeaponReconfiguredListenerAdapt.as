package alternativa.tanks.models.weapon.streamweapon {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class StreamWeaponReconfiguredListenerAdapt implements StreamWeaponReconfiguredListener {
    private var object:IGameObject;
    private var impl:StreamWeaponReconfiguredListener;

    public function StreamWeaponReconfiguredListenerAdapt(param1:IGameObject, param2:StreamWeaponReconfiguredListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function streamWeaponReconfigured(param1:IGameObject, param2:Number) : void {
      var user:IGameObject = param1;
      var dischargeRate:Number = param2;
      try {
        Model.object = this.object;
        this.impl.streamWeaponReconfigured(user,dischargeRate);
      }
      finally {
        Model.popObject();
      }
    }

    public function streamWeaponDistanceChanged(param1:IGameObject, param2:Number) : void {
      var user:IGameObject = param1;
      var newDistance:Number = param2;
      try {
        Model.object = this.object;
        this.impl.streamWeaponDistanceChanged(user,newDistance);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
