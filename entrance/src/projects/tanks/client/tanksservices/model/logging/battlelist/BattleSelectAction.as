package projects.tanks.client.tanksservices.model.logging.battlelist {
  public class BattleSelectAction {
    public static const SELECT_BATTLE:BattleSelectAction = new BattleSelectAction(0,"SELECT_BATTLE");
    public static const CHOOSE_MODE:BattleSelectAction = new BattleSelectAction(1,"CHOOSE_MODE");
    public static const CREATE_BATTLE:BattleSelectAction = new BattleSelectAction(2,"CREATE_BATTLE");
    public static const ENTER_TO_BATTLE:BattleSelectAction = new BattleSelectAction(3,"ENTER_TO_BATTLE");
    public static const COPY_BATTLE_LINK:BattleSelectAction = new BattleSelectAction(4,"COPY_BATTLE_LINK");

    private var _value:int;
    private var _name:String;

    public function BattleSelectAction(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<BattleSelectAction> {
      var local1:Vector.<BattleSelectAction> = new Vector.<BattleSelectAction>();
      local1.push(SELECT_BATTLE);
      local1.push(CHOOSE_MODE);
      local1.push(CREATE_BATTLE);
      local1.push(ENTER_TO_BATTLE);
      local1.push(COPY_BATTLE_LINK);
      return local1;
    }

    public function toString() : String {
      return "BattleSelectAction [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
