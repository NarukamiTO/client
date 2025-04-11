package alternativa.tanks.models.weapon.shared.shot {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponReloadTimeChangedListenerAdapt implements WeaponReloadTimeChangedListener {
    private var object:IGameObject;
    private var impl:WeaponReloadTimeChangedListener;

    public function WeaponReloadTimeChangedListenerAdapt(param1:IGameObject, param2:WeaponReloadTimeChangedListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var previousReloadTime:int = param1;
      var actualReloadTime:int = param2;
      try {
        Model.object = this.object;
        this.impl.weaponReloadTimeChanged(previousReloadTime,actualReloadTime);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
