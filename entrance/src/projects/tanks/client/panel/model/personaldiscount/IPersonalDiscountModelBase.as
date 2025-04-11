package projects.tanks.client.panel.model.personaldiscount {
  import projects.tanks.client.panel.model.garage.GarageItemInfo;

  public interface IPersonalDiscountModelBase {
    function showPersonalDiscount(param1:GarageItemInfo, param2:int, param3:int, param4:int) : void;
  }
}
