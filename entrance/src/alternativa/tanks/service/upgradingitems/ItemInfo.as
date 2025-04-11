package alternativa.tanks.service.upgradingitems {
  import alternativa.tanks.model.garage.resistance.ModuleResistances;
  import alternativa.types.Long;
  import controls.timer.CountDownTimer;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.clients.flash.commons.models.runtime.DataOwner;

  public class ItemInfo {
    public var info:GarageItemInfo;
    public var timer:CountDownTimer;
    public var ownerId:Long;
    public var resistances:Vector.<ItemGarageProperty>;

    public function ItemInfo(param1:GarageItemInfo, param2:CountDownTimer) {
      super();
      this.info = param1;
      this.timer = param2;
      this.ownerId = DataOwner(param1.item.adapt(DataOwner)).getDataOwnerId();
      if(param1.item.hasModel(ModuleResistances)) {
        this.resistances = ModuleResistances(param1.item.adapt(ModuleResistances)).getResistances();
      }
    }
  }
}
