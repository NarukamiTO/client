package alternativa.tanks.service.itempropertyparams.aggregationmodes {
  import alternativa.tanks.model.item.upgradable.calculators.CriticalChanceCalculator;
  import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;

  public class CritUpgradeAggregationMode implements UpgradeAggregationMode {
    public function CritUpgradeAggregationMode() {
      super();
    }

    public function createValueCalculator(param1:int, param2:GaragePropertyParams) : PropertyCalculator {
      return new CriticalChanceCalculator(param1,param2);
    }
  }
}
