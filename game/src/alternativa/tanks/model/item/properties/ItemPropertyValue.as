package alternativa.tanks.model.item.properties {
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public interface ItemPropertyValue {
    function getValue(param1:int = 0) : String;
    function getProperty() : ItemGarageProperty;
  }
}
