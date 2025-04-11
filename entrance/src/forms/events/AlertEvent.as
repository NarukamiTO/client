package forms.events {
  import flash.events.Event;

  public class AlertEvent extends Event {
    public static const ALERT_BUTTON_PRESSED:String = "CloseAlert";

    private var _typeButton:String;

    public function AlertEvent(param1:String) {
      super(ALERT_BUTTON_PRESSED,true,false);
      this._typeButton = param1;
    }

    public function get typeButton() : String {
      return this._typeButton;
    }
  }
}
