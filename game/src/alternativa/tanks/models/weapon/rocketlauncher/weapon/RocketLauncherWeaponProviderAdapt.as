package alternativa.tanks.models.weapon.rocketlauncher.weapon {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RocketLauncherWeaponProviderAdapt implements RocketLauncherWeaponProvider {
    private var object:IGameObject;
    private var impl:RocketLauncherWeaponProvider;

    public function RocketLauncherWeaponProviderAdapt(param1:IGameObject, param2:RocketLauncherWeaponProvider) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function remoteWeapon() : RemoteRocketLauncherWeapon {
      var result:RemoteRocketLauncherWeapon = null;
      try {
        Model.object = this.object;
        result = this.impl.remoteWeapon();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
