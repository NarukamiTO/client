package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class InviteCodeEnteredEvent extends Event {
    public static const INVITE_ENTERED:String = "INVITE_ENTERED";

    private var _inviteCode:String;

    public function InviteCodeEnteredEvent(param1:String) {
      this._inviteCode = param1;
      super(INVITE_ENTERED);
    }

    public function get inviteCode() : String {
      return this._inviteCode;
    }
  }
}
