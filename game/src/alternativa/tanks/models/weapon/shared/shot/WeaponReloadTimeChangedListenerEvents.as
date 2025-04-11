package alternativa.tanks.models.weapon.shared.shot {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponReloadTimeChangedListenerEvents implements WeaponReloadTimeChangedListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponReloadTimeChangedListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var i:int = 0;
      var m:WeaponReloadTimeChangedListener = null;
      var previousReloadTime:int = param1;
      var actualReloadTime:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponReloadTimeChangedListener(this.impl[i]);
          m.weaponReloadTimeChanged(previousReloadTime,actualReloadTime);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
