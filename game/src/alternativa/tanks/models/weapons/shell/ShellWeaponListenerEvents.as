package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShellWeaponListenerEvents implements ShellWeaponListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShellWeaponListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int, param2:int, param3:Vector3) : void {
      var i:int = 0;
      var m:ShellWeaponListener = null;
      var barrelIndex:int = param1;
      var shotId:int = param2;
      var direction:Vector3 = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShellWeaponListener(this.impl[i]);
          m.onShot(barrelIndex,shotId,direction);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onDummyShot(param1:int) : void {
      var i:int = 0;
      var m:ShellWeaponListener = null;
      var barrelIndex:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShellWeaponListener(this.impl[i]);
          m.onDummyShot(barrelIndex);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
