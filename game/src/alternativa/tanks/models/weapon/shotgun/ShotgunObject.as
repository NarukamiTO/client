package alternativa.tanks.models.weapon.shotgun {
  import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAiming;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponObject;
  import platform.client.fp10.core.type.IGameObject;

  public class ShotgunObject extends DiscreteWeaponObject {
    public function ShotgunObject(param1:IGameObject) {
      super(param1);
    }

    public function pelletDirectionCalculator() : PelletDirectionCalculator {
      var local1:ShotgunAiming = ShotgunAiming(object.adapt(ShotgunAiming));
      return local1.getPelletDirectionCalculator();
    }
  }
}
