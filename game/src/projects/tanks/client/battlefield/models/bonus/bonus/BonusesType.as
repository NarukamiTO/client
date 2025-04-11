package projects.tanks.client.battlefield.models.bonus.bonus {
  public class BonusesType {
    public static const CRYSTAL:BonusesType = new BonusesType(0,"CRYSTAL");
    public static const NITRO:BonusesType = new BonusesType(1,"NITRO");
    public static const ARMOR_UP:BonusesType = new BonusesType(2,"ARMOR_UP");
    public static const FIRST_AID:BonusesType = new BonusesType(3,"FIRST_AID");
    public static const DAMAGE_UP:BonusesType = new BonusesType(4,"DAMAGE_UP");
    public static const RECHARGE:BonusesType = new BonusesType(5,"RECHARGE");
    public static const GOLD:BonusesType = new BonusesType(6,"GOLD");

    private var _value:int;
    private var _name:String;

    public function BonusesType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<BonusesType> {
      var local1:Vector.<BonusesType> = new Vector.<BonusesType>();
      local1.push(CRYSTAL);
      local1.push(NITRO);
      local1.push(ARMOR_UP);
      local1.push(FIRST_AID);
      local1.push(DAMAGE_UP);
      local1.push(RECHARGE);
      local1.push(GOLD);
      return local1;
    }

    public function toString() : String {
      return "BonusesType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
