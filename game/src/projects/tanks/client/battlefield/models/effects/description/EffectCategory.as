package projects.tanks.client.battlefield.models.effects.description {
  public class EffectCategory {
    public static const INVENTORY:EffectCategory = new EffectCategory(0,"INVENTORY");
    public static const BONUS:EffectCategory = new EffectCategory(1,"BONUS");
    public static const OVERDRIVE:EffectCategory = new EffectCategory(2,"OVERDRIVE");
    public static const OTHER:EffectCategory = new EffectCategory(3,"OTHER");

    private var _value:int;
    private var _name:String;

    public function EffectCategory(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<EffectCategory> {
      var local1:Vector.<EffectCategory> = new Vector.<EffectCategory>();
      local1.push(INVENTORY);
      local1.push(BONUS);
      local1.push(OVERDRIVE);
      local1.push(OTHER);
      return local1;
    }

    public function toString() : String {
      return "EffectCategory [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
