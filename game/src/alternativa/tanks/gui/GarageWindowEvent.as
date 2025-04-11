package alternativa.tanks.gui {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class GarageWindowEvent extends Event {
    public static const WAREHOUSE_ITEM_SELECTED:String = "GarageWindowEventWirehouseItemSelected";
    public static const STORE_ITEM_SELECTED:String = "GarageWindowEventStoreItemSelected";
    public static const BUY_ITEM:String = "GarageWindowEventBuyItem";
    public static const SETUP_ITEM:String = "GarageWindowEventSetupItem";
    public static const UNMOUNT_ITEM:String = "GarageWindowEventRemoveItem";
    public static const UPGRADE_ITEM:String = "GarageWindowEventUpgradeItem";
    public static const ADD_CRYSTALS:String = "GarageWindowEventAddCrystals";
    public static const DELETE_PRESENT:String = "GarageWindowEventDeletePresent";

    public var item:IGameObject;
    public var crystalsToBuy:int = 0;

    public function GarageWindowEvent(param1:String, param2:IGameObject, param3:int = 0) {
      super(param1,true,false);
      this.item = param2;
      this.crystalsToBuy = param3;
    }
  }
}
