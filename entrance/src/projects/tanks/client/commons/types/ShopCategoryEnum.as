package projects.tanks.client.commons.types {
  public class ShopCategoryEnum {
    public static const CRYSTALS:ShopCategoryEnum = new ShopCategoryEnum(0,"CRYSTALS");
    public static const COINS:ShopCategoryEnum = new ShopCategoryEnum(1,"COINS");
    public static const PREMIUM:ShopCategoryEnum = new ShopCategoryEnum(2,"PREMIUM");
    public static const GOLD_BOXES:ShopCategoryEnum = new ShopCategoryEnum(3,"GOLD_BOXES");
    public static const PAINTS:ShopCategoryEnum = new ShopCategoryEnum(4,"PAINTS");
    public static const KITS:ShopCategoryEnum = new ShopCategoryEnum(5,"KITS");
    public static const OTHERS:ShopCategoryEnum = new ShopCategoryEnum(6,"OTHERS");
    public static const LOOT_BOXES:ShopCategoryEnum = new ShopCategoryEnum(7,"LOOT_BOXES");
    public static const NO_CATEGORY:ShopCategoryEnum = new ShopCategoryEnum(8,"NO_CATEGORY");

    private var _value:int;
    private var _name:String;

    public function ShopCategoryEnum(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ShopCategoryEnum> {
      var local1:Vector.<ShopCategoryEnum> = new Vector.<ShopCategoryEnum>();
      local1.push(CRYSTALS);
      local1.push(COINS);
      local1.push(PREMIUM);
      local1.push(GOLD_BOXES);
      local1.push(PAINTS);
      local1.push(KITS);
      local1.push(OTHERS);
      local1.push(LOOT_BOXES);
      local1.push(NO_CATEGORY);
      return local1;
    }

    public function toString() : String {
      return "ShopCategoryEnum [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
