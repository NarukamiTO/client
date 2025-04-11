package alternativa.tanks.controller.events.showform {
  import flash.events.Event;

  public class ShowExternalEntranceFormEvent extends Event {
    public static const REGISTRATION_FORM:String = "ShowExternalEntranceFormEvent.REGISTRATION_FORM";
    public static const LOGIN_FORM:String = "ShowExternalEntranceFormEvent.LOGIN_FORM";

    public var loginCaptchaEnabled:Boolean;
    public var presetCallsign:String;
    public var socialNetworkId:String;

    public function ShowExternalEntranceFormEvent(param1:String, param2:String, param3:String, param4:Boolean) {
      this.socialNetworkId = param2;
      this.presetCallsign = param3;
      this.loginCaptchaEnabled = param4;
      super(param1);
    }

    override public function clone() : Event {
      return new ShowExternalEntranceFormEvent(type,this.socialNetworkId,this.presetCallsign,this.loginCaptchaEnabled);
    }
  }
}
