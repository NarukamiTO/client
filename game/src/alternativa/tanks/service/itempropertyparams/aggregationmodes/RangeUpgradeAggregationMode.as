package alternativa.tanks.service.itempropertyparams.aggregationmodes {
  import alternativa.tanks.model.item.upgradable.calculators.BasePropertyCalculator;
  import alternativa.tanks.model.item.upgradable.calculators.LinearPropertyValueCalculator;
  import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
  import alternativa.tanks.model.item.upgradable.calculators.RangePropertyCalculator;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
  import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;

  public class RangeUpgradeAggregationMode implements UpgradeAggregationMode {
    [Inject]
    public static var propertyParamsService:ItemPropertyParamsService;

    public function RangeUpgradeAggregationMode() {
      super();
    }

    public function createValueCalculator(param1:int, param2:GaragePropertyParams) : PropertyCalculator {
      var local6:PropertyData = null;
      var local3:ItemPropertyParams = propertyParamsService.getParams(param2.property);
      var local4:Vector.<ItemProperty> = local3.getProperties();
      var local5:Vector.<BasePropertyCalculator> = new Vector.<BasePropertyCalculator>();
      for each(local6 in param2.properties) {
        if(local4.indexOf(local6.property) != -1) {
          local5.push(new BasePropertyCalculator(param2.precision,new LinearPropertyValueCalculator(local6.initialValue,local6.finalValue,param1)));
        }
      }
      if(local5.length != 2) {
        throw new Error("Unexpected number subproperties: property=" + param2.property + "; valueCalculators=" + local5);
      }
      return new RangePropertyCalculator(local5[0],local5[1]);
    }
  }
}
