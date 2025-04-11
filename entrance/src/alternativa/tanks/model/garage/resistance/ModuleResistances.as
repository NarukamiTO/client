package alternativa.tanks.model.garage.resistance {
  import projects.tanks.client.commons.types.ItemGarageProperty;

  [ModelInterface]
  public interface ModuleResistances {
    function getResistances() : Vector.<ItemGarageProperty>;
  }
}
