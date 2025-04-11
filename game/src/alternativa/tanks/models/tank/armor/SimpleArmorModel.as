package alternativa.tanks.models.tank.armor {
  import projects.tanks.client.battlefield.models.tankparts.armor.simple.ISimpleArmorModelBase;
  import projects.tanks.client.battlefield.models.tankparts.armor.simple.SimpleArmorModelBase;

  [ModelInfo]
  public class SimpleArmorModel extends SimpleArmorModelBase implements ISimpleArmorModelBase, Armor {
    public function SimpleArmorModel() {
      super();
    }

    public function getMaxHealth() : int {
      return getInitParam().maxHealth;
    }
  }
}
