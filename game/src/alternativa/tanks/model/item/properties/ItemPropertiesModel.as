package alternativa.tanks.model.item.properties {
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import projects.tanks.client.garage.models.item.properties.IItemPropertiesModelBase;
  import projects.tanks.client.garage.models.item.properties.ItemGaragePropertyData;
  import projects.tanks.client.garage.models.item.properties.ItemPropertiesModelBase;

  [ModelInfo]
  public class ItemPropertiesModel extends ItemPropertiesModelBase implements IItemPropertiesModelBase, ItemProperties {
    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    public function ItemPropertiesModel() {
      super();
    }

    private static function compare(param1:ItemPropertyValue, param2:ItemPropertyValue) : Number {
      var local3:ItemPropertyParams = propertyService.getParams(param1.getProperty());
      var local4:ItemPropertyParams = propertyService.getParams(param2.getProperty());
      var local5:int = local3 != null ? local3.sortIndex : 0;
      var local6:int = local4 != null ? local4.sortIndex : 0;
      if(local5 < local6) {
        return -1;
      }
      if(local5 > local6) {
        return 1;
      }
      return 0;
    }

    public function getProperties() : Vector.<ItemPropertyValue> {
      var local1:Vector.<ItemPropertyValue> = null;
      var local3:ItemGaragePropertyData = null;
      var local2:Object = getData(Vector);
      if(local2 == null) {
        local1 = new Vector.<ItemPropertyValue>();
        for each(local3 in getInitParam().properties) {
          local1.push(new ItemGaragePropertyValue(local3));
        }
        local1.sort(compare);
        putData(Vector,local1);
      } else {
        local1 = Vector.<ItemPropertyValue>(local2);
      }
      return local1;
    }

    public function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue> {
      return this.getProperties();
    }
  }
}
