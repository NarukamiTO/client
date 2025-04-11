package alternativa.tanks.gui.alerts {
  import alternativa.tanks.service.upgradingitems.ItemInfo;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public class UpgradedItemsAlert extends ItemsAlert {
    public function UpgradedItemsAlert(param1:Vector.<ItemInfo>, param2:String, param3:String) {
      super(param2,param3,this.addItems,param1);
    }

    private function addItems(param1:Vector.<ItemInfo>) : void {
      var local4:ItemInfo = null;
      var local5:Vector.<ItemGarageProperty> = null;
      var local6:GarageItemInfo = null;
      var local7:int = 0;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        local5 = local4.resistances;
        local6 = local4.info;
        local7 = 0;
        partsList.addItem(local6.item,local6.name,local6.category,local6.position,0,local7,false,true,0,local6.preview,0,null,local6.modificationIndex,null,local5,true);
        local3++;
      }
    }
  }
}
