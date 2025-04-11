package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShellWeaponListenerAdapt implements ShellWeaponListener {
    private var object:IGameObject;
    private var impl:ShellWeaponListener;

    public function ShellWeaponListenerAdapt(param1:IGameObject, param2:ShellWeaponListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int, param2:int, param3:Vector3) : void {
      var barrelIndex:int = param1;
      var shotId:int = param2;
      var direction:Vector3 = param3;
      try {
        Model.object = this.object;
        this.impl.onShot(barrelIndex,shotId,direction);
      }
      finally {
        Model.popObject();
      }
    }

    public function onDummyShot(param1:int) : void {
      var barrelIndex:int = param1;
      try {
        Model.object = this.object;
        this.impl.onDummyShot(barrelIndex);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
