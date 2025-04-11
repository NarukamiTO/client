package projects.tanks.client.panel.model.payment.modes.paygarden {
  public class PayGardenProductType {
    public static const CRYSTALS:PayGardenProductType = new PayGardenProductType(0,"CRYSTALS");
    public static const PREMIUM:PayGardenProductType = new PayGardenProductType(1,"PREMIUM");
    public static const ITEM:PayGardenProductType = new PayGardenProductType(2,"ITEM");

    private var _value:int;
    private var _name:String;

    public function PayGardenProductType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<PayGardenProductType> {
      var local1:Vector.<PayGardenProductType> = new Vector.<PayGardenProductType>();
      local1.push(CRYSTALS);
      local1.push(PREMIUM);
      local1.push(ITEM);
      return local1;
    }

    public function toString() : String {
      return "PayGardenProductType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
