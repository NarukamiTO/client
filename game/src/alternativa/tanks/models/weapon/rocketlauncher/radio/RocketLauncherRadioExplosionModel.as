package alternativa.tanks.models.weapon.rocketlauncher.radio {
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponProvider;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.radio.IRocketLauncherRadioExplosionModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.radio.RocketLauncherRadioExplosionModelBase;

  [ModelInfo]
  public class RocketLauncherRadioExplosionModel extends RocketLauncherRadioExplosionModelBase implements IRocketLauncherRadioExplosionModelBase, RocketExplosion {
    public function RocketLauncherRadioExplosionModel() {
      super();
    }

    public function shellDestroyed(param1:int) : void {
      RocketLauncherWeaponProvider(object.adapt(RocketLauncherWeaponProvider)).remoteWeapon().explodeRocket(param1);
    }
  }
}
