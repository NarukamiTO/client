package alternativa.tanks.model.item.upgradable.calculators {
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class PropertyNotFoundError extends Error {
    public function PropertyNotFoundError(param1:ItemProperty) {
      super(param1.name);
    }
  }
}
