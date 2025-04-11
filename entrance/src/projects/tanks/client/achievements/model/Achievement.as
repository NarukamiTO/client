package projects.tanks.client.achievements.model {
  public class Achievement {
    public static const FIRST_PURCHASE:Achievement = new Achievement(0,"FIRST_PURCHASE");
    public static const FIGHT_FIRST_BATTLE:Achievement = new Achievement(1,"FIGHT_FIRST_BATTLE");
    public static const FIRST_REFERRAL:Achievement = new Achievement(2,"FIRST_REFERRAL");

    private var _value:int;
    private var _name:String;

    public function Achievement(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<Achievement> {
      var local1:Vector.<Achievement> = new Vector.<Achievement>();
      local1.push(FIRST_PURCHASE);
      local1.push(FIGHT_FIRST_BATTLE);
      local1.push(FIRST_REFERRAL);
      return local1;
    }

    public function toString() : String {
      return "Achievement [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
