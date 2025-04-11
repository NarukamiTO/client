package alternativa.tanks.model.item.upgradable.calculators {
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
  import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;

  public class CriticalChanceCalculator extends BasePropertyCalculator implements PropertyCalculator, PropertyValueCalculator {
    [Inject]
    public static var propertyParamsService:ItemPropertyParamsService;

    private var afterCrit:LinearPropertyValueCalculator;
    private var deltaCrit:LinearPropertyValueCalculator;
    private var maxCrit:LinearPropertyValueCalculator;
    private var data:GaragePropertyParams;
    private var multiplier:Number;

    public function CriticalChanceCalculator(param1:int, param2:GaragePropertyParams) {
      this.data = param2;
      var local3:ItemPropertyParams = propertyParamsService.getParams(param2.property);
      this.multiplier = local3.getMultiplier();
      this.afterCrit = this.createPropertyCalculator(ItemProperty.AFTER_CRIT_CRITICAL_HIT_CHANCE,param1);
      this.deltaCrit = this.createPropertyCalculator(ItemProperty.CRITICAL_CHANCE_DELTA,param1);
      this.maxCrit = this.createPropertyCalculator(ItemProperty.MAX_CRITICAL_HIT_CHANCE,param1);
      super(param2.precision,this);
    }

    override public function getNumberValue(param1:int) : Number {
      return this.calculate(param1);
    }

    private function calculate(param1:int) : Number {
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local2:Number = this.afterCrit.getNumberValue(param1);
      var local3:Number = this.deltaCrit.getNumberValue(param1);
      var local4:Number = this.maxCrit.getNumberValue(param1);
      var local5:Number = 0;
      var local6:Number = 1;
      var local7:int = 1;
      while(true) {
        if(local2 > local4) {
          local5 += local6 * (local7 - 1 + 1 / local4);
          break;
        }
        local9 = Math.max(local2,0);
        local5 += local6 * local9 * local7;
        local6 *= 1 - local9;
        local2 += local3;
        local7++;
      }
      local8 = 1 / local5;
      return local8 * this.multiplier;
    }

    private function createPropertyCalculator(param1:ItemProperty, param2:int) : LinearPropertyValueCalculator {
      var local3:PropertyData = this.getPropertyData(param1);
      return new LinearPropertyValueCalculator(local3.initialValue,local3.finalValue,param2);
    }

    private function getPropertyData(param1:ItemProperty) : PropertyData {
      var local2:PropertyData = null;
      for each(local2 in this.data.properties) {
        if(local2.property == param1) {
          return local2;
        }
      }
      throw new PropertyNotFoundError(param1);
    }
  }
}
