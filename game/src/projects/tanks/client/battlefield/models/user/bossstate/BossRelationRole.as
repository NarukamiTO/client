package projects.tanks.client.battlefield.models.user.bossstate {
  public class BossRelationRole {
    public static const VICTIM:BossRelationRole = new BossRelationRole(0,"VICTIM");
    public static const INCARNATION:BossRelationRole = new BossRelationRole(1,"INCARNATION");
    public static const BOSS:BossRelationRole = new BossRelationRole(2,"BOSS");

    private var _value:int;
    private var _name:String;

    public function BossRelationRole(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<BossRelationRole> {
      var local1:Vector.<BossRelationRole> = new Vector.<BossRelationRole>();
      local1.push(VICTIM);
      local1.push(INCARNATION);
      local1.push(BOSS);
      return local1;
    }

    public function toString() : String {
      return "BossRelationRole [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
