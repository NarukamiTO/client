package projects.tanks.client.garage.models.item.rarity {
  public class Rarity {
    public static const CUSTOMISE:Rarity = new Rarity(0,"CUSTOMISE");
    public static const LEGENDARY:Rarity = new Rarity(1,"LEGENDARY");
    public static const EPIC:Rarity = new Rarity(2,"EPIC");
    public static const RARE:Rarity = new Rarity(3,"RARE");
    public static const CASUAL:Rarity = new Rarity(4,"CASUAL");

    private var _value:int;
    private var _name:String;

    public function Rarity(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<Rarity> {
      var local1:Vector.<Rarity> = new Vector.<Rarity>();
      local1.push(CUSTOMISE);
      local1.push(LEGENDARY);
      local1.push(EPIC);
      local1.push(RARE);
      local1.push(CASUAL);
      return local1;
    }

    public function toString() : String {
      return "Rarity [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
