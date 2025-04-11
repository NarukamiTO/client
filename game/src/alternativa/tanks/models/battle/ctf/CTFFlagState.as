package alternativa.tanks.models.battle.ctf {
  public class CTFFlagState {
    public static const AT_BASE:CTFFlagState = new CTFFlagState(0,"AT_BASE");
    public static const DROPPED:CTFFlagState = new CTFFlagState(1,"DROPPED");
    public static const CARRIED:CTFFlagState = new CTFFlagState(2,"CARRIED");
    public static const EXILED:CTFFlagState = new CTFFlagState(3,"EXILED");

    private var _value:int;
    private var _stringValue:String;

    public function CTFFlagState(param1:int, param2:String) {
      super();
      this._value = param1;
      this._stringValue = param2;
    }

    public function get value() : int {
      return this._value;
    }

    public function toString() : String {
      return "CTFFlagState [" + this._stringValue + "]";
    }
  }
}
