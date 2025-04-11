package projects.tanks.clients.fp10.libraries.tanksservices.model.friends {
  public class FriendState {
    public static const UNKNOWN:FriendState = new FriendState(0);
    public static const ACCEPTED:FriendState = new FriendState(1);
    public static const INCOMING:FriendState = new FriendState(2);

    private var _state:int;

    public function FriendState(param1:int) {
      super();
      this._state = param1;
    }

    public function get state() : int {
      return this._state;
    }

    public function toString() : String {
      return "FriendState{_state=" + String(this._state) + "}";
    }
  }
}
