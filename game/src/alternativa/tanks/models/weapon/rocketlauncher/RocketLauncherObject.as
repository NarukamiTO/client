package alternativa.tanks.models.weapon.rocketlauncher {
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfx;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfxData;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapons.charging.DummyWeaponChargingCommunication;
  import alternativa.tanks.models.weapons.charging.WeaponChargingCommunication;
  import alternativa.tanks.models.weapons.shell.ShellWeaponObject;
  import platform.client.fp10.core.type.IGameObject;

  public class RocketLauncherObject extends ShellWeaponObject {
    public function RocketLauncherObject(param1:IGameObject) {
      super(param1);
    }

    public function splash() : Splash {
      return Splash(object.adapt(Splash));
    }

    public function laser() : LaserPointer {
      return LaserPointer(object.adapt(LaserPointer));
    }

    public function charging() : WeaponChargingCommunication {
      if(remote) {
        return DummyWeaponChargingCommunication.INSTANCE;
      }
      return WeaponChargingCommunication(object.adapt(WeaponChargingCommunication));
    }

    public function getSfxData() : RocketLauncherSfxData {
      return RocketLauncherSfx(object.adapt(RocketLauncherSfx)).getSfxData();
    }
  }
}
