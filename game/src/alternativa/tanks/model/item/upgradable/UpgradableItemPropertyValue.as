package alternativa.tanks.model.item.upgradable {
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.model.item.upgradable.calculators.PropertyCalculator;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;

  public class UpgradableItemPropertyValue implements ItemPropertyValue {
    [Inject]
    public static var propertyParamsService:ItemPropertyParamsService;

    private var valueCalculator:PropertyCalculator;
    private var params:GaragePropertyParams;
    private var isUpgradableProperty:Boolean;

    public function UpgradableItemPropertyValue(param1:int, param2:GaragePropertyParams) {
      super();
      this.params = param2;
      var local3:ItemPropertyParams = propertyParamsService.getParams(param2.property);
      this.valueCalculator = local3.getAggregationMode().createValueCalculator(param1,param2);
      this.isUpgradableProperty = this.getValue(0) != this.getValue(param1);
    }

    public function isUpgradable() : Boolean {
      return this.isUpgradableProperty;
    }

    public function getValue(param1:int = 0) : String {
      return this.valueCalculator.getValue(param1);
    }

    public function getProperty() : ItemGarageProperty {
      return this.params.property;
    }

    public function isVisibleInInfo() : Boolean {
      return this.params.visibleInInfo;
    }

    public function getDelta(param1:int) : String {
      return this.valueCalculator.getDelta(param1);
    }
  }
}
