package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx.IRocketLauncherSfxModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx.RocketLauncherSfxModelBase;

  [ModelInfo]
  public class RocketLauncherSfxModel extends RocketLauncherSfxModelBase implements IRocketLauncherSfxModelBase, RocketLauncherSfx, ObjectLoadListener {
    public function RocketLauncherSfxModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:RocketLauncherSfxData = new RocketLauncherSfxData(getInitParam(),new LightingSfx(getInitParam().lightingSFXEntity));
      putData(RocketLauncherSfxData,local1);
    }

    public function getSfxData() : RocketLauncherSfxData {
      return RocketLauncherSfxData(getData(RocketLauncherSfxData));
    }
  }
}
