package projects.tanks.client.commons.models.layout {
  public class LayoutState {
    public static const MATCHMAKING:LayoutState = new LayoutState(0,"MATCHMAKING");
    public static const BATTLE_SELECT:LayoutState = new LayoutState(1,"BATTLE_SELECT");
    public static const GARAGE:LayoutState = new LayoutState(2,"GARAGE");
    public static const BATTLE:LayoutState = new LayoutState(3,"BATTLE");
    public static const RELOAD_SPACE:LayoutState = new LayoutState(4,"RELOAD_SPACE");
    public static const CLAN:LayoutState = new LayoutState(5,"CLAN");

    private var _value:int;
    private var _name:String;

    public function LayoutState(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<LayoutState> {
      var local1:Vector.<LayoutState> = new Vector.<LayoutState>();
      local1.push(MATCHMAKING);
      local1.push(BATTLE_SELECT);
      local1.push(GARAGE);
      local1.push(BATTLE);
      local1.push(RELOAD_SPACE);
      local1.push(CLAN);
      return local1;
    }

    public function toString() : String {
      return "LayoutState [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
