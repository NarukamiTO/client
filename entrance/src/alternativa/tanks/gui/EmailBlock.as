package alternativa.tanks.gui {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.textinputs.PlaceholderInputText;
  import base.DiscreteSprite;
  import controls.ValidationIcon;
  import controls.base.LabelBase;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.text.TextFormatAlign;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.registration.bubbles.EmailInvalidBubble;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class EmailBlock extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var displayService:IDisplay;

    private static const EMAIL_PLACEHOLDER_TEXT:String = "yourname@example.com";
    private static const EMAIL_CHECK_DELAY:int = 500;

    private var emailInput:PlaceholderInputText;
    private var errorEmailInvalidBubble:EmailInvalidBubble;
    private var emailCheckIcon:ValidationIcon;
    private var timeoutId:int = -1;

    public function EmailBlock(param1:int, param2:int) {
      super();
      var local3:LabelBase = new LabelBase();
      local3.htmlText = localeService.getText(TanksLocale.TEXT_SETTINGS_EMAIL_LABEL_TEXT);
      local3.x = param2;
      local3.y = 7;
      addChild(local3);
      this.emailInput = new PlaceholderInputText(EMAIL_PLACEHOLDER_TEXT);
      this.emailInput.x = int(param2 + local3.width + 5);
      this.emailInput.y = 0;
      this.emailInput.width = param1 - 2 * param2 - local3.width - 5;
      this.emailInput.validValue = true;
      this.emailInput.align = TextFormatAlign.LEFT;
      this.emailInput.addEventListener(Event.CHANGE,this.validateEmail);
      addChild(this.emailInput);
      this.emailCheckIcon = new ValidationIcon();
      this.emailCheckIcon.x = param1 - param2 - this.emailCheckIcon.width - 10;
      this.emailCheckIcon.y = local3.y;
      addChild(this.emailCheckIcon);
      this.errorEmailInvalidBubble = new EmailInvalidBubble();
      this.errorEmailInvalidBubble.visible = false;
      displayService.stage.addChild(this.errorEmailInvalidBubble);
      displayService.stage.addEventListener(Event.RESIZE,this.alignBubble,false,-1);
    }

    public function alignBubble(param1:Event = null) : void {
      var local2:int = 0;
      var local3:int = 0;
      if(this.errorEmailInvalidBubble != null && parent != null) {
        local2 = this.x + this.emailCheckIcon.x + this.emailCheckIcon.width / 2;
        local3 = this.y + this.emailCheckIcon.y + this.emailCheckIcon.height / 2;
        this.errorEmailInvalidBubble.targetPoint = parent.localToGlobal(new Point(local2,local3));
        this.errorEmailInvalidBubble.align(displayService.stage.stageWidth,displayService.stage.stageHeight);
      }
    }

    public function destroy() : void {
      displayService.stage.removeChild(this.errorEmailInvalidBubble);
      this.errorEmailInvalidBubble = null;
      displayService.stage.removeEventListener(Event.RESIZE,this.alignBubble);
      this.resetTimeout();
    }

    private function validateEmail(param1:Event) : void {
      this.resetTimeout();
      this.dispatchInvalidEmailEvent();
      if(this.emailInput.value == "") {
        this.errorEmailInvalidBubble.visible = false;
        this.emailInput.validValue = true;
        this.emailCheckIcon.turnOff();
      } else if(!validateService.isEmailValid(this.emailInput.value)) {
        this.errorEmailInvalidBubble.visible = true;
        this.errorEmailInvalidBubble.setEmailInvalidText();
        this.errorEmailInvalidBubble.redraw();
        this.emailCheckIcon.markAsInvalid();
        this.emailInput.validValue = false;
        this.alignBubble();
      } else {
        this.errorEmailInvalidBubble.visible = false;
        this.emailInput.validValue = true;
        this.emailCheckIcon.startProgress();
        this.timeoutId = setTimeout(this.sendValidationRequest,EMAIL_CHECK_DELAY);
      }
    }

    private function sendValidationRequest() : void {
      this.resetTimeout();
      dispatchEvent(new EmailBlockRequestEvent(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,this.emailInput.value));
    }

    private function dispatchValidEmailEvent() : void {
      dispatchEvent(new EmailBlockValidationEvent(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.emailInput.value,true));
    }

    private function dispatchInvalidEmailEvent() : void {
      dispatchEvent(new EmailBlockValidationEvent(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.emailInput.value,false));
    }

    private function resetTimeout() : void {
      if(this.timeoutId != -1) {
        clearTimeout(this.timeoutId);
        this.timeoutId = -1;
      }
    }

    public function showEmailIsBusy(param1:String) : void {
      if(this.emailInput.value == param1) {
        this.emailInput.validValue = false;
        this.emailCheckIcon.markAsInvalid();
        this.errorEmailInvalidBubble.setEmailIsNotUniqueText();
        this.errorEmailInvalidBubble.visible = true;
        this.errorEmailInvalidBubble.redraw();
        this.dispatchInvalidEmailEvent();
        this.alignBubble();
      }
    }

    public function showEmailIsForbidden(param1:String) : void {
      if(this.emailInput.value == param1) {
        this.emailInput.validValue = false;
        this.emailCheckIcon.markAsInvalid();
        this.errorEmailInvalidBubble.setEmailForbiddenText();
        this.errorEmailInvalidBubble.visible = true;
        this.errorEmailInvalidBubble.redraw();
        this.dispatchInvalidEmailEvent();
        this.alignBubble();
      }
    }

    public function showEmailIsFree(param1:String) : void {
      if(this.emailInput.value == param1) {
        this.emailInput.validValue = true;
        this.emailCheckIcon.markAsValid();
        this.errorEmailInvalidBubble.visible = false;
        this.dispatchValidEmailEvent();
      }
    }

    public function get email() : String {
      return this.emailInput.value;
    }

    public function set email(param1:String) : void {
      this.emailInput.setValue(param1);
    }
  }
}
