package alternativa.tanks.models.weapon.rotation {
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAngles;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.IWeaponRotationLimitModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.WeaponRotationLimitModelBase;

  [ModelInfo]
  public class WeaponRotationLimitModel extends WeaponRotationLimitModelBase implements IWeaponRotationLimitModelBase, WeaponRotationLimit {
    public function WeaponRotationLimitModel() {
      super();
    }

    public function getMaxAngle() : Number {
      return this.verticalAngles().getAngleDown();
    }

    public function getMinAngle() : Number {
      return -this.verticalAngles().getAngleUp();
    }

    private function verticalAngles() : VerticalAngles {
      return VerticalAngles(object.adapt(VerticalAngles));
    }
  }
}
