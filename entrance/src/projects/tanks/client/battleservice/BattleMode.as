package projects.tanks.client.battleservice {
  public class BattleMode {
    public static const DM:BattleMode = new BattleMode(0,"DM");
    public static const TDM:BattleMode = new BattleMode(1,"TDM");
    public static const CTF:BattleMode = new BattleMode(2,"CTF");
    public static const CP:BattleMode = new BattleMode(3,"CP");
    public static const AS:BattleMode = new BattleMode(4,"AS");
    public static const RUGBY:BattleMode = new BattleMode(5,"RUGBY");
    public static const SUR:BattleMode = new BattleMode(6,"SUR");
    public static const JGR:BattleMode = new BattleMode(7,"JGR");

    private var _value:int;
    private var _name:String;

    public function BattleMode(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<BattleMode> {
      var local1:Vector.<BattleMode> = new Vector.<BattleMode>();
      local1.push(DM);
      local1.push(TDM);
      local1.push(CTF);
      local1.push(CP);
      local1.push(AS);
      local1.push(RUGBY);
      local1.push(SUR);
      local1.push(JGR);
      return local1;
    }

    public function toString() : String {
      return "BattleMode [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
