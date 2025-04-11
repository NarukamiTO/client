package alternativa.tanks.controller.events.showform {
  import flash.events.Event;

  public class ShowFormEvent extends Event {
    public static const SHOW_RESTORE_PASSWORD_FORM:String = "ShowFormEvent.SHOW_RESTORE_PASSWORD_FORM";
    public static const SHOW_RECOVERY_HASH_IS_WRONG_ALERT:String = "ShowFormEvent.SHOW_RECOVERY_HASH_IS_WRONG_ALERT";
    public static const SHOW_STAND_ALONE_CAPTCHA:String = "ShowFormEvent.SHOW_STAND_ALONE_CAPTCHA";
    public static const SHOW_INVITE_FORM:String = "ShowFormEvent.SHOW_INVITE_FORM";
    public static const SHOW_CHANGE_UID_AND_PASSWORD_FORM:String = "ShowFormEvent.SHOW_CHANGE_UID_AND_PASSWORD_FORM";
    public static const SHOW_CHANGE_UID_FORM:String = "ShowFormEvent.SHOW_CHANGE_UID_FORM";

    public function ShowFormEvent(param1:String) {
      super(param1);
    }
  }
}
