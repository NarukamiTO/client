package alternativa.tanks.model.item.properties {
  [ModelInterface]
  public interface ItemProperties {
    function getProperties() : Vector.<ItemPropertyValue>;
    function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue>;
  }
}
