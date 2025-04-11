package alternativa.tanks.battle.scene3d {
  public class RotationState {
    public static const WITHOUT_ROTATION:RotationState = new RotationState("without_rotation");
    public static const USE_RANDOM_ROTATION:RotationState = new RotationState("use_random_rotation");

    private var _state:String;

    public function RotationState(param1:String) {
      super();
      this._state = param1;
    }

    public function get state() : String {
      return this._state;
    }

    public function toString() : String {
      return "RotationState{_state=" + String(this._state) + "}";
    }
  }
}
