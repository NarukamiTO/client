package alternativa.tanks.view.events {
  import flash.events.Event;

  public class SendChangeUidEvent extends Event {
    public static const EVENT_TYPE:String = "SendChangeUidEvent.EVENT_TYPE";

    private var _uid:String;

    public function SendChangeUidEvent(param1:String) {
      super(EVENT_TYPE);
      this._uid = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    override public function clone() : Event {
      return new SendChangeUidEvent(this._uid);
    }
  }
}
