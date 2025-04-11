package projects.tanks.client.commons.types {
  public class ItemViewCategoryEnum {
    public static const WEAPON:ItemViewCategoryEnum = new ItemViewCategoryEnum(0,"WEAPON");
    public static const ARMOR:ItemViewCategoryEnum = new ItemViewCategoryEnum(1,"ARMOR");
    public static const PAINT:ItemViewCategoryEnum = new ItemViewCategoryEnum(2,"PAINT");
    public static const INVENTORY:ItemViewCategoryEnum = new ItemViewCategoryEnum(3,"INVENTORY");
    public static const KIT:ItemViewCategoryEnum = new ItemViewCategoryEnum(4,"KIT");
    public static const SPECIAL:ItemViewCategoryEnum = new ItemViewCategoryEnum(5,"SPECIAL");
    public static const GIVEN_PRESENTS:ItemViewCategoryEnum = new ItemViewCategoryEnum(6,"GIVEN_PRESENTS");
    public static const RESISTANCE:ItemViewCategoryEnum = new ItemViewCategoryEnum(7,"RESISTANCE");
    public static const DRONE:ItemViewCategoryEnum = new ItemViewCategoryEnum(8,"DRONE");
    public static const INVISIBLE:ItemViewCategoryEnum = new ItemViewCategoryEnum(9,"INVISIBLE");

    private var _value:int;
    private var _name:String;

    public function ItemViewCategoryEnum(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ItemViewCategoryEnum> {
      var local1:Vector.<ItemViewCategoryEnum> = new Vector.<ItemViewCategoryEnum>();
      local1.push(WEAPON);
      local1.push(ARMOR);
      local1.push(PAINT);
      local1.push(INVENTORY);
      local1.push(KIT);
      local1.push(SPECIAL);
      local1.push(GIVEN_PRESENTS);
      local1.push(RESISTANCE);
      local1.push(DRONE);
      local1.push(INVISIBLE);
      return local1;
    }

    public function toString() : String {
      return "ItemViewCategoryEnum [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
