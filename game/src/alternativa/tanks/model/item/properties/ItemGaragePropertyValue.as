package alternativa.tanks.model.item.properties {
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.properties.ItemGaragePropertyData;

  public class ItemGaragePropertyValue implements ItemPropertyValue {
    private var garageProperty:ItemGaragePropertyData;

    public function ItemGaragePropertyValue(param1:ItemGaragePropertyData) {
      super();
      this.garageProperty = param1;
    }

    public function getValue(param1:int = 0) : String {
      return this.garageProperty.value;
    }

    public function getProperty() : ItemGarageProperty {
      return this.garageProperty.property;
    }

    public function isUpgradable() : Boolean {
      return false;
    }

    public function getUpgradableValue() : UpgradableItemPropertyValue {
      return null;
    }
  }
}
