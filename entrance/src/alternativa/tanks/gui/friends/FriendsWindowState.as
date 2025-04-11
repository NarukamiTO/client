package alternativa.tanks.gui.friends {
  public class FriendsWindowState {
    public static const ACCEPTED:FriendsWindowState = new FriendsWindowState(0);
    public static const INCOMING:FriendsWindowState = new FriendsWindowState(1);
    public static const CLAN_MEMBERS:FriendsWindowState = new FriendsWindowState(2);
    public static const REFERRALS:FriendsWindowState = new FriendsWindowState(3);

    private var _value:int;

    public function FriendsWindowState(param1:int) {
      super();
      this._value = param1;
    }

    public function get value() : int {
      return this._value;
    }
  }
}
