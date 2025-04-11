package controls.checkbox {
  import flash.events.Event;

  public class CheckBoxEvent extends Event {
    public static const STATE_CHANGED:String = "CheckBoxStateChangeEvent";

    public function CheckBoxEvent(param1:String) {
      super(param1);
    }
  }
}
