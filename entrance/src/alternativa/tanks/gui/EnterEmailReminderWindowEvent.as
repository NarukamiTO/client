package alternativa.tanks.gui {
  import flash.events.Event;

  public class EnterEmailReminderWindowEvent extends Event {
    public static const EMAIL_SAVING_AND_CONFIRMATION:String = "SAVE_EMAIL";
    public static const EMAIL_CONFIRMATION:String = "EMAIL_CONFIRMATION";
    public static const WINDOW_CLOSING:String = "WINDOW_CLOSING";

    private var _email:String;

    public function EnterEmailReminderWindowEvent(param1:String, param2:String = null) {
      this._email = param2;
      super(param1,true);
    }

    public function get email() : String {
      return this._email;
    }
  }
}
