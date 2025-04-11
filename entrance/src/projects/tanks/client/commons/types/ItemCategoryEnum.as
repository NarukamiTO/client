package projects.tanks.client.commons.types {
  public class ItemCategoryEnum {
    public static const WEAPON:ItemCategoryEnum = new ItemCategoryEnum(0,"WEAPON");
    public static const ARMOR:ItemCategoryEnum = new ItemCategoryEnum(1,"ARMOR");
    public static const PAINT:ItemCategoryEnum = new ItemCategoryEnum(2,"PAINT");
    public static const INVENTORY:ItemCategoryEnum = new ItemCategoryEnum(3,"INVENTORY");
    public static const PLUGIN:ItemCategoryEnum = new ItemCategoryEnum(4,"PLUGIN");
    public static const KIT:ItemCategoryEnum = new ItemCategoryEnum(5,"KIT");
    public static const EMBLEM:ItemCategoryEnum = new ItemCategoryEnum(6,"EMBLEM");
    public static const CRYSTAL:ItemCategoryEnum = new ItemCategoryEnum(7,"CRYSTAL");
    public static const PRESENT:ItemCategoryEnum = new ItemCategoryEnum(8,"PRESENT");
    public static const GIVEN_PRESENT:ItemCategoryEnum = new ItemCategoryEnum(9,"GIVEN_PRESENT");
    public static const RESISTANCE_MODULE:ItemCategoryEnum = new ItemCategoryEnum(10,"RESISTANCE_MODULE");
    public static const DEVICE:ItemCategoryEnum = new ItemCategoryEnum(11,"DEVICE");
    public static const LICENSE:ItemCategoryEnum = new ItemCategoryEnum(12,"LICENSE");
    public static const CONTAINER:ItemCategoryEnum = new ItemCategoryEnum(13,"CONTAINER");
    public static const DRONE:ItemCategoryEnum = new ItemCategoryEnum(14,"DRONE");
    public static const SKIN:ItemCategoryEnum = new ItemCategoryEnum(15,"SKIN");
    public static const MOBILE_LOOT_BOX:ItemCategoryEnum = new ItemCategoryEnum(16,"MOBILE_LOOT_BOX");

    private var _value:int;
    private var _name:String;

    public function ItemCategoryEnum(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ItemCategoryEnum> {
      var local1:Vector.<ItemCategoryEnum> = new Vector.<ItemCategoryEnum>();
      local1.push(WEAPON);
      local1.push(ARMOR);
      local1.push(PAINT);
      local1.push(INVENTORY);
      local1.push(PLUGIN);
      local1.push(KIT);
      local1.push(EMBLEM);
      local1.push(CRYSTAL);
      local1.push(PRESENT);
      local1.push(GIVEN_PRESENT);
      local1.push(RESISTANCE_MODULE);
      local1.push(DEVICE);
      local1.push(LICENSE);
      local1.push(CONTAINER);
      local1.push(DRONE);
      local1.push(SKIN);
      local1.push(MOBILE_LOOT_BOX);
      return local1;
    }

    public function toString() : String {
      return "ItemCategoryEnum [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
