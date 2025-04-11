package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class LoginViaPartnerEvent extends Event {
    public static const EVENT_TYPE:String = "LoginViaPartnerEvent";

    private var _partnerId:String;

    public function LoginViaPartnerEvent(param1:String) {
      super(EVENT_TYPE);
      this._partnerId = param1;
    }

    public function get partnerId() : String {
      return this._partnerId;
    }

    override public function clone() : Event {
      return new LoginViaPartnerEvent(this.partnerId);
    }
  }
}
