package projects.tanks.client.panel.model.garage.availableitems {
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public interface IAvailableItemsModelBase {
    function showAvailableItems(param1:Vector.<GarageItemInfo>) : void;
  }
}
