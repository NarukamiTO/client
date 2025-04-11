package projects.tanks.client.commons.types {
  public class ShopAbonementBonusTypeEnum {
    public static const BONUS:ShopAbonementBonusTypeEnum = new ShopAbonementBonusTypeEnum(0,"BONUS");
    public static const DISCOUNT:ShopAbonementBonusTypeEnum = new ShopAbonementBonusTypeEnum(1,"DISCOUNT");

    private var _value:int;
    private var _name:String;

    public function ShopAbonementBonusTypeEnum(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ShopAbonementBonusTypeEnum> {
      var local1:Vector.<ShopAbonementBonusTypeEnum> = new Vector.<ShopAbonementBonusTypeEnum>();
      local1.push(BONUS);
      local1.push(DISCOUNT);
      return local1;
    }

    public function toString() : String {
      return "ShopAbonementBonusTypeEnum [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
