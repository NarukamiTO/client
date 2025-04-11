package alternativa.tanks.models.weapon.angles.verticals {
  import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.autoaiming.IWeaponVerticalAnglesModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.autoaiming.WeaponVerticalAnglesModelBase;

  [ModelInfo]
  public class WeaponVerticalAnglesModel extends WeaponVerticalAnglesModelBase implements IWeaponVerticalAnglesModelBase, VerticalAngles {
    public function WeaponVerticalAnglesModel() {
      super();
    }

    public function getAngleUp() : Number {
      return getInitParam().angleUp;
    }

    public function getAngleDown() : Number {
      return getInitParam().angleDown;
    }
  }
}
