package alternativa.tanks.controller.events {
  import flash.events.Event;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class CheckCaptchaAnswerEvent extends Event {
    public static const EVENT_TYPE:String = "CheckCaptchaAnswerEvent.CHECK";

    private var _captchaAnswer:String;
    private var _location:CaptchaLocation;
    private var _onSuccessEvent:Event;

    public function CheckCaptchaAnswerEvent(param1:String, param2:CaptchaLocation, param3:Event) {
      super(EVENT_TYPE);
      this._captchaAnswer = param1;
      this._location = param2;
      this._onSuccessEvent = param3;
    }

    public function get captchaAnswer() : String {
      return this._captchaAnswer;
    }

    public function get location() : CaptchaLocation {
      return this._location;
    }

    public function get onSuccessEvent() : Event {
      return this._onSuccessEvent;
    }
  }
}
