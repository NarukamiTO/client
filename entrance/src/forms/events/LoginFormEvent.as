package forms.events {
  import flash.events.Event;

  public class LoginFormEvent extends Event {
    public static const TEXT_CHANGED:String = "LoginChanged";
    public static const PLAY_PRESSED:String = "PlayButtonPressed";
    public static const RESTORE_PRESSED:String = "RestoreButtonPressed";
    public static const SHOW_RULES:String = "ShowRules";
    public static const SHOW_TERMS:String = "ShowTerms";
    public static const CHANGE_STATE:String = "LoginFormStateChanged";

    public function LoginFormEvent(param1:String) {
      super(param1,true,false);
    }
  }
}
