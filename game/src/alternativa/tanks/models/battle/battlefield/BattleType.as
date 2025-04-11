package alternativa.tanks.models.battle.battlefield {
  public class BattleType {
    public static const DM:BattleType = new BattleType(0,false);
    public static const TDM:BattleType = new BattleType(1,true);
    public static const CTF:BattleType = new BattleType(2,true);
    public static const DOMINATION:BattleType = new BattleType(3,true);
    public static const AS:BattleType = new BattleType(4,true);
    public static const RUGBY:BattleType = new BattleType(5,true);
    public static const JGR:BattleType = new BattleType(6,false);

    private var _value:int;
    private var _team:Boolean;

    public function BattleType(param1:int, param2:Boolean) {
      super();
      this._value = param1;
      this._team = param2;
    }

    public function get value() : int {
      return this._value;
    }

    public function isTeam() : Boolean {
      return this._team;
    }
  }
}
