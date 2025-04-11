package alternativa.tanks.models.weapon.rocketlauncher.weapon {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RocketLauncherWeaponProviderEvents implements RocketLauncherWeaponProvider {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function RocketLauncherWeaponProviderEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function remoteWeapon() : RemoteRocketLauncherWeapon {
      var result:RemoteRocketLauncherWeapon = null;
      var i:int = 0;
      var m:RocketLauncherWeaponProvider = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RocketLauncherWeaponProvider(this.impl[i]);
          result = m.remoteWeapon();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
