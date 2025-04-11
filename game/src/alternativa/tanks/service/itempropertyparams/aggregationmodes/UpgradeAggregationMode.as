package alternativa.tanks.service.itempropertyparams.aggregationmodes {
  import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;

  public interface UpgradeAggregationMode {
    function createValueCalculator(param1:int, param2:GaragePropertyParams) : PropertyCalculator;
  }
}
