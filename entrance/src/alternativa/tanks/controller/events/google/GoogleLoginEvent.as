package alternativa.tanks.controller.events.google {
  import flash.events.Event;

  public class GoogleLoginEvent extends Event {
    public static const EVENT_TYPE:String = "GoogleLoginEvent.EVENT_TYPE";

    private var _token:String;
    private var _rememberMe:Boolean;

    public function GoogleLoginEvent(param1:String, param2:Boolean) {
      super(EVENT_TYPE);
      this._token = param1;
      this._rememberMe = param2;
    }

    public function get token() : String {
      return this._token;
    }

    public function get rememberMe() : Boolean {
      return this._rememberMe;
    }

    override public function clone() : Event {
      return new GoogleLoginEvent(this._token,this._rememberMe);
    }
  }
}
