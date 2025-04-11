package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RocketLauncherSfxEvents implements RocketLauncherSfx {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function RocketLauncherSfxEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : RocketLauncherSfxData {
      var result:RocketLauncherSfxData = null;
      var i:int = 0;
      var m:RocketLauncherSfx = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RocketLauncherSfx(this.impl[i]);
          result = m.getSfxData();
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
