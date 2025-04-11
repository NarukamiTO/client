package alternativa.tanks.models.weapons.shell {
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponObject;
  import platform.client.fp10.core.type.IGameObject;

  public class ShellWeaponObject extends DiscreteWeaponObject {
    public function ShellWeaponObject(param1:IGameObject) {
      super(param1);
    }

    public function shellCommunication() : ShellWeaponCommunication {
      if(remote) {
        return DummyShellWeaponCommunication.INSTANCE;
      }
      return ShellWeaponCommunication(object.adapt(ShellWeaponCommunication));
    }
  }
}
