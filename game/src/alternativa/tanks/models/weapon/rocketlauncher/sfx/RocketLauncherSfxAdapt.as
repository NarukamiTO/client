package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RocketLauncherSfxAdapt implements RocketLauncherSfx {
    private var object:IGameObject;
    private var impl:RocketLauncherSfx;

    public function RocketLauncherSfxAdapt(param1:IGameObject, param2:RocketLauncherSfx) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : RocketLauncherSfxData {
      var result:RocketLauncherSfxData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSfxData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
