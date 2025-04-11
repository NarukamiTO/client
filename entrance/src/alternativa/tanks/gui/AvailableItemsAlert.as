package alternativa.tanks.gui {
  import alternativa.tanks.gui.alerts.ItemsAlert;
  import alternativa.tanks.model.garage.resistance.ModuleResistances;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;

  public class AvailableItemsAlert extends ItemsAlert {
    [Inject]
    public static var premiumService:PremiumService;

    public function AvailableItemsAlert(param1:Vector.<GarageItemInfo>, param2:String, param3:String) {
      super(param2,param3,this.addItems,param1);
    }

    private function addItems(param1:Vector.<GarageItemInfo>) : void {
      var local4:GarageItemInfo = null;
      var local5:int = 0;
      var local6:Boolean = false;
      var local7:IGameObject = null;
      var local8:Vector.<ItemGarageProperty> = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        local5 = 0;
        local6 = local4.premiumItem && !premiumService.hasPremium();
        local7 = local4.item;
        local8 = null;
        if(local7.hasModel(ModuleResistances)) {
          local8 = ModuleResistances(local7.adapt(ModuleResistances)).getResistances();
        }
        partsList.addItem(local4.item,local4.name,local4.category,local4.position,0,local5,local6,true,0,local4.preview,0,null,local4.modificationIndex,null,local8);
        local3++;
      }
    }
  }
}
