package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapons.charging.DummyWeaponChargingCommunication;
  import alternativa.tanks.models.weapons.charging.WeaponChargingCommunication;
  import alternativa.tanks.models.weapons.shell.ShellWeaponObject;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtilleryObject extends ShellWeaponObject {
    public function ArtilleryObject(param1:IGameObject) {
      super(param1);
    }

    public function splash() : Splash {
      return Splash(object.adapt(Splash));
    }

    public function charging() : WeaponChargingCommunication {
      if(remote) {
        return DummyWeaponChargingCommunication.INSTANCE;
      }
      return WeaponChargingCommunication(object.adapt(WeaponChargingCommunication));
    }
  }
}
