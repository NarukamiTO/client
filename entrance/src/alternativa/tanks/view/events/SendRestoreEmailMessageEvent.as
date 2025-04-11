package alternativa.tanks.view.events {
  import flash.events.Event;

  public class SendRestoreEmailMessageEvent extends Event {
    public static const SEND:String = "RESTORE_EMAIL";

    private var _emailAddress:String;

    public function SendRestoreEmailMessageEvent(param1:String) {
      super(SEND);
      this._emailAddress = param1;
    }

    public function get emailAddress() : String {
      return this._emailAddress;
    }

    override public function clone() : Event {
      return new SendRestoreEmailMessageEvent(this._emailAddress);
    }
  }
}
