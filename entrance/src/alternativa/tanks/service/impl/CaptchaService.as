package alternativa.tanks.service.impl {
  import alternativa.tanks.controller.events.CaptchaUpdatedEvent;
  import alternativa.tanks.service.ICaptchaService;
  import alternativa.tanks.service.IEntranceServerFacade;
  import flash.display.Bitmap;
  import flash.utils.Dictionary;
  import org.robotlegs.mvcs.Actor;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaParser;

  public class CaptchaService extends Actor implements ICaptchaService {
    [Inject]
    public var serverFacade:IEntranceServerFacade;

    private var _correctAnswerCallbacks:Dictionary = new Dictionary();
    private var _enabledByCaptchaLocation:Dictionary = new Dictionary();

    public function CaptchaService() {
      super();
    }

    public function checkAnswer(param1:CaptchaLocation, param2:String, param3:Function) : void {
      this._correctAnswerCallbacks[param1] = param3;
      this.serverFacade.checkCaptcha(param2,param1);
    }

    public function answerCorrect(param1:CaptchaLocation) : void {
      this._correctAnswerCallbacks[param1].apply();
    }

    public function setNewCaptchaBytes(param1:Vector.<int>, param2:CaptchaLocation) : void {
      this._enabledByCaptchaLocation[param2] = true;
      CaptchaParser.parse(param1,this.onCaptchaParsed,param2);
    }

    private function onCaptchaParsed(param1:Bitmap, param2:CaptchaLocation) : void {
      switch(param2) {
        case CaptchaLocation.CLIENT_STARTUP:
          dispatch(new CaptchaUpdatedEvent(CaptchaUpdatedEvent.STAND_ALONE_CAPTCHA_UPDATED,param1));
          break;
        case CaptchaLocation.LOGIN_FORM:
          dispatch(new CaptchaUpdatedEvent(CaptchaUpdatedEvent.LOGIN_FORM_CAPTCHA_UPDATED,param1));
          break;
        case CaptchaLocation.REGISTER_FORM:
          dispatch(new CaptchaUpdatedEvent(CaptchaUpdatedEvent.REGISTRATION_FORM_CAPTCHA_UPDATED,param1));
          break;
        case CaptchaLocation.RESTORE_PASSWORD_FORM:
          dispatch(new CaptchaUpdatedEvent(CaptchaUpdatedEvent.RESTORE_PASSWORD_FORM_CAPTCHA_UPDATED,param1));
          break;
        case CaptchaLocation.EMAIL_CHANGE_HASH:
          dispatch(new CaptchaUpdatedEvent(CaptchaUpdatedEvent.EMAIL_CHANGE_HASH_CAPTCHA_UPDATED,param1));
      }
    }

    public function get loginCaptchaEnabled() : Boolean {
      return Boolean(this._enabledByCaptchaLocation[CaptchaLocation.LOGIN_FORM]);
    }
  }
}
