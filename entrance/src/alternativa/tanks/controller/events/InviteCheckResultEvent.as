package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class InviteCheckResultEvent extends Event {
    public static const INVITE_CODE_IS_UNBOUND:String = "INVITE_CODE_IS_UNBOUND";
    public static const INVITE_CODE_DOES_NOT_EXIST:String = "INVITE_CODE_DOES_NOT_EXIST";

    private var _uid:String;

    public function InviteCheckResultEvent(param1:String, param2:String = null) {
      this._uid = param2;
      super(param1);
    }

    public function get uid() : String {
      return this._uid;
    }
  }
}
