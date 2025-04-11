package forms.userlabel {
  import flash.events.Event;

  public class UserLabelClickWithCtrlEvent extends Event {
    public static const USER_LABEL_CLICK_WITH_CTRL_EVENT:String = "UserLabelClickWithCtrlEvent.USER_LABEL_CLICK_WITH_CTRL_EVENT";

    public var uid:String;
    public var shiftPressed:Boolean;

    public function UserLabelClickWithCtrlEvent(param1:String, param2:String, param3:Boolean) {
      this.uid = param2;
      this.shiftPressed = param3;
      super(param1,true);
    }
  }
}
