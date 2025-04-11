package alternativa.tanks.models.weapon.streamweapon {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class StreamWeaponReconfiguredListenerEvents implements StreamWeaponReconfiguredListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function StreamWeaponReconfiguredListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function streamWeaponReconfigured(param1:IGameObject, param2:Number) : void {
      var i:int = 0;
      var m:StreamWeaponReconfiguredListener = null;
      var user:IGameObject = param1;
      var dischargeRate:Number = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponReconfiguredListener(this.impl[i]);
          m.streamWeaponReconfigured(user,dischargeRate);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function streamWeaponDistanceChanged(param1:IGameObject, param2:Number) : void {
      var i:int = 0;
      var m:StreamWeaponReconfiguredListener = null;
      var user:IGameObject = param1;
      var newDistance:Number = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponReconfiguredListener(this.impl[i]);
          m.streamWeaponDistanceChanged(user,newDistance);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
