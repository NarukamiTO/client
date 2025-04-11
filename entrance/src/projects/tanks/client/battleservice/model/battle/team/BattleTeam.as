package projects.tanks.client.battleservice.model.battle.team {
  public class BattleTeam {
    public static const RED:BattleTeam = new BattleTeam(0,"RED");
    public static const BLUE:BattleTeam = new BattleTeam(1,"BLUE");
    public static const NONE:BattleTeam = new BattleTeam(2,"NONE");

    private var _value:int;
    private var _name:String;

    public function BattleTeam(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<BattleTeam> {
      var local1:Vector.<BattleTeam> = new Vector.<BattleTeam>();
      local1.push(RED);
      local1.push(BLUE);
      local1.push(NONE);
      return local1;
    }

    public function toString() : String {
      return "BattleTeam [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
