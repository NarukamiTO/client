package alternativa.tanks.models.battle.meteor {
  public class MeteorState {
    public static var INIT:MeteorState = new MeteorState(0);
    public static var FALLING:MeteorState = new MeteorState(1);
    public static var DISAPPEARING:MeteorState = new MeteorState(2);
    public static var EXPLOSION:MeteorState = new MeteorState(3);

    private var _stateId:int;

    public function MeteorState(param1:int) {
      super();
      this._stateId = param1;
    }

    public function get stateId() : int {
      return this._stateId;
    }
  }
}
