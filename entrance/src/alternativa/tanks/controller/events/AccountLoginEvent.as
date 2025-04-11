package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class AccountLoginEvent extends Event {
    public static const EVENT_TYPE:String = "AccountLoginEvent.EVENT_TYPE";

    private var _hash:String;

    public function AccountLoginEvent(param1:String) {
      this._hash = param1;
      super(EVENT_TYPE);
    }

    public function get hash() : String {
      return this._hash;
    }
  }
}
