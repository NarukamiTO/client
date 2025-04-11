package projects.tanks.client.tanksservices.model.logging.garage {
  public class GarageAction {
    public static const SELECT_ITEM:GarageAction = new GarageAction(0,"SELECT_ITEM");
    public static const EQUIP_ITEM:GarageAction = new GarageAction(1,"EQUIP_ITEM");
    public static const UNMOUNT_ITEM:GarageAction = new GarageAction(2,"UNMOUNT_ITEM");
    public static const BUY_ITEM:GarageAction = new GarageAction(3,"BUY_ITEM");
    public static const BUY_MODIFICATION:GarageAction = new GarageAction(4,"BUY_MODIFICATION");
    public static const UPGRADE_ITEM:GarageAction = new GarageAction(5,"UPGRADE_ITEM");
    public static const CHOOSE_COUNT:GarageAction = new GarageAction(6,"CHOOSE_COUNT");
    public static const SHOW_BUY_CRYSTALS_WINDOW:GarageAction = new GarageAction(7,"SHOW_BUY_CRYSTALS_WINDOW");
    public static const PURCHASE_ACCEPTED:GarageAction = new GarageAction(8,"PURCHASE_ACCEPTED");
    public static const PURCHASE_DECLINED:GarageAction = new GarageAction(9,"PURCHASE_DECLINED");

    private var _value:int;
    private var _name:String;

    public function GarageAction(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<GarageAction> {
      var local1:Vector.<GarageAction> = new Vector.<GarageAction>();
      local1.push(SELECT_ITEM);
      local1.push(EQUIP_ITEM);
      local1.push(UNMOUNT_ITEM);
      local1.push(BUY_ITEM);
      local1.push(BUY_MODIFICATION);
      local1.push(UPGRADE_ITEM);
      local1.push(CHOOSE_COUNT);
      local1.push(SHOW_BUY_CRYSTALS_WINDOW);
      local1.push(PURCHASE_ACCEPTED);
      local1.push(PURCHASE_DECLINED);
      return local1;
    }

    public function toString() : String {
      return "GarageAction [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
