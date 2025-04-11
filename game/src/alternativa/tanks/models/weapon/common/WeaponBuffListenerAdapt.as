package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponBuffListenerAdapt implements WeaponBuffListener {
    private var object:IGameObject;
    private var impl:WeaponBuffListener;

    public function WeaponBuffListenerAdapt(param1:IGameObject, param2:WeaponBuffListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var user:IGameObject = param1;
      var buffed:Boolean = param2;
      var recoilForce:Number = param3;
      try {
        Model.object = this.object;
        this.impl.weaponBuffStateChanged(user,buffed,recoilForce);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
