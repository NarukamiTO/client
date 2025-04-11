package alternativa.tanks.models.weapons.discrete {
  import alternativa.tanks.models.weapon.WeaponObject;
  import platform.client.fp10.core.type.IGameObject;

  public class DiscreteWeaponObject extends WeaponObject {
    public function DiscreteWeaponObject(param1:IGameObject) {
      super(param1);
    }

    public function discrete() : DiscreteWeapon {
      return DiscreteWeapon(super.object.adapt(DiscreteWeapon));
    }
  }
}
