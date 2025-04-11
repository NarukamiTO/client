package alternativa.tanks.service.itempropertyparams.aggregationmodes {
  import alternativa.tanks.model.item.upgradable.calculators.BasePropertyCalculator;
  import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
  import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;

  public class InvertUpgradeAggregationMode implements UpgradeAggregationMode {
    [Inject]
    public static var propertyParamsService:ItemPropertyParamsService;

    public function InvertUpgradeAggregationMode() {
      super();
    }

    public function createValueCalculator(param1:int, param2:GaragePropertyParams) : PropertyCalculator {
      var local7:PropertyData = null;
      var local8:Number = NaN;
      var local3:ItemPropertyParams = propertyParamsService.getParams(param2.property);
      var local4:Vector.<ItemProperty> = local3.getProperties();
      var local5:Number = 0;
      var local6:Number = 0;
      for each(local7 in param2.properties) {
        if(local4.indexOf(local7.property) != -1) {
          local5 += local7.initialValue;
          local6 += local7.finalValue;
        }
      }
      local8 = local3.getMultiplier();
      local5 /= local8;
      local6 /= local8;
      return new BasePropertyCalculator(param2.precision,new InvertPropertyCalculator(local5,local6,param1));
    }
  }
}
