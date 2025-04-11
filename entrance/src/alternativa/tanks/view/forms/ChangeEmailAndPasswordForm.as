package alternativa.tanks.view.forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controller.events.ChangeEmailCaptchaEvent;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.service.IPasswordParamsService;
  import alternativa.tanks.view.bubbles.Bubble;
  import alternativa.tanks.view.bubbles.EntranceBubbleFactory;
  import alternativa.tanks.view.forms.commons.RegistrationCommonElementsSection;
  import alternativa.tanks.view.forms.primivites.Alert;
  import alternativa.tanks.view.forms.primivites.ValidationIcon;
  import controls.base.DefaultButtonBase;
  import controls.base.TankInputBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import forms.TankWindowWithHeader;
  import forms.events.AlertEvent;
  import forms.events.LoginFormEvent;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaSection;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import services.alertservice.AlertAnswer;

  public class ChangeEmailAndPasswordForm extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var passwordParamsService:IPasswordParamsService;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    private var windowSize:Point;
    private var window:TankWindowWithHeader;
    private var pass1:TankInputBase;
    private var pass2:TankInputBase;
    private var emailInput:TankInputBase;
    private var pass1CheckIcon:ValidationIcon;
    private var pass2CheckIcon:ValidationIcon;
    private var emailCheckIcon:ValidationIcon;
    private var okButton:DefaultButtonBase;
    private var cancelButton:DefaultButtonBase;

    public var captchaSection:CaptchaSection;

    private const windowMargin:int = 12;
    private const margin:int = 20;
    private const buttonSize:Point = new Point(104,33);

    private var _inputsLeftMargin:int = 110;
    private var passwordIsTooEasyBubble:Bubble;
    private var passwordsDoNotMatchBubble:Bubble;
    private var emailInvalodBubble:Bubble;
    private var passChangeAlert:Alert;
    private var passChangeFailureAlert:Alert;
    private var windowShown:Boolean;

    public function ChangeEmailAndPasswordForm() {
      super();
      this.init();
    }

    private static function isPasswordValid(param1:String) : Boolean {
      return param1 == "" || param1.length >= passwordParamsService.minPasswordLength && passwordParamsService.forbiddenPasswords.indexOf(param1.toLowerCase()) == -1;
    }

    public function init() : void {
      this.initGUI();
      if(Boolean(stage)) {
        this.initEvents();
        this.alignYourself(null);
      } else {
        addEventListener(Event.ADDED_TO_STAGE,function(param1:Event):void {
          initEvents();
          alignYourself(null);
          dispatchEvent(new RefreshCaptchaClickedEvent());
          loaderWindowService.hide();
        });
      }
      this.windowShown = true;
    }

    private function initGUI() : void {
      var local2:int = 0;
      var local3:int = 0;
      var local1:int = 120;
      this.emailInput = new TankInputBase();
      this.emailInput.label = localeService.getText(TanksLocale.TEXT_SETTINGS_EMAIL_LABEL_TEXT);
      this.emailInput.maxChars = RegistrationCommonElementsSection.MAX_CHARS_EMAIL;
      this.pass1 = new TankInputBase();
      this.pass1.label = localeService.getText(TanksLocale.TEXT_SETTINGS_NEW_PASSWORD_LABEL_TEXT);
      this._inputsLeftMargin = this.margin + 3 + (int(Math.abs(this.emailInput._label.x)) > int(Math.abs(this.pass1._label.x)) ? int(Math.abs(this.emailInput._label.x)) : int(Math.abs(this.pass1._label.x)));
      this.pass1.hidden = true;
      this.pass1.width = local1;
      this.pass1.x = this._inputsLeftMargin;
      this.pass1.y = this.margin + 6;
      this.pass1.maxChars = passwordParamsService.maxPasswordLength;
      this.pass1.tabIndex = 1;
      this.pass2 = new TankInputBase();
      this.pass2.width = local1;
      this.pass2.hidden = true;
      this.pass2.label = localeService.getText(TanksLocale.TEXT_SETTINGS_REENTER_PASSWORD_LABEL_TEXT);
      this.pass2.x = int(this.margin + 4 + this.pass1.width + 20 + this.pass2._label.width);
      this.pass2.y = this.pass1.y;
      this.pass2.maxChars = passwordParamsService.maxPasswordLength;
      this.pass2.tabIndex = 2;
      local3 = this.pass2.x + local1 + this.margin + 5;
      this.emailInput.x = this._inputsLeftMargin;
      this.emailInput.y = this.pass2.y + this.pass2.height + this.windowMargin;
      local2 = int(local3 - this.margin - this.emailInput.x - 5);
      this.emailInput.width = local2;
      this.emailInput.tabIndex = 3;
      this.captchaSection = new CaptchaSection();
      this.captchaSection.manualInitialize();
      this.captchaSection.y = int(this.emailInput.y + this.emailInput.height + this.margin);
      this.captchaSection.x = this._inputsLeftMargin;
      this.captchaSection.width = local2;
      this.captchaSection.visible = true;
      this.captchaSection.tabIndex = 4;
      this.pass1CheckIcon = new ValidationIcon();
      this.pass2CheckIcon = new ValidationIcon();
      this.emailCheckIcon = new ValidationIcon();
      this.pass1CheckIcon.x = local1 - this.pass1CheckIcon.width - 10;
      this.pass1CheckIcon.y = 7;
      this.pass2CheckIcon.x = local1 - this.pass2CheckIcon.width - 10;
      this.pass2CheckIcon.y = 7;
      this.emailCheckIcon.x = local2 - this.emailCheckIcon.width - 10;
      this.emailCheckIcon.y = 7;
      this.okButton = new DefaultButtonBase();
      this.okButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_SAVE_TEXT);
      this.okButton.x = int(local3 - this.buttonSize.x - this.margin + 3);
      this.okButton.y = this.captchaSection.y + this.captchaSection.height + this.windowMargin;
      this.okButton.enable = false;
      this.cancelButton = new DefaultButtonBase();
      this.cancelButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_CANCEL_TEXT);
      this.cancelButton.x = int(local3 - this.buttonSize.x * 2 - 5 - this.margin);
      this.cancelButton.y = this.okButton.y;
      var local4:int = int(this.okButton.y + this.okButton.height + this.windowMargin);
      this.windowSize = new Point(local3,local4);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CHANGE_PASSWORD_EMAIL,this.windowSize.x,this.windowSize.y);
      addChild(this.window);
      addChild(this.okButton);
      addChild(this.cancelButton);
      addChild(this.emailInput);
      addChild(this.captchaSection);
      addChild(this.pass1);
      addChild(this.pass2);
      this.pass1.addChild(this.pass1CheckIcon);
      this.pass2.addChild(this.pass2CheckIcon);
      this.emailInput.addChild(this.emailCheckIcon);
      this.window.height = this.windowSize.y;
      this.window.width = this.windowSize.x;
      this.createBubbles();
    }

    private function initEvents() : void {
      stage.addEventListener(Event.RESIZE,this.alignYourself);
      this.pass1.addEventListener(LoginFormEvent.TEXT_CHANGED,this.updatePasswordBlock);
      this.pass1.addEventListener(FocusEvent.FOCUS_OUT,this.updatePasswordBlock);
      this.pass2.addEventListener(LoginFormEvent.TEXT_CHANGED,this.updatePasswordBlock);
      this.pass2.addEventListener(FocusEvent.FOCUS_OUT,this.updatePasswordBlock);
      this.emailInput.addEventListener(FocusEvent.FOCUS_OUT,this.updatePasswordBlock);
      this.emailInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.checkEmailConfirmation);
      this.okButton.addEventListener(MouseEvent.CLICK,this.onOkClick);
      this.cancelButton.addEventListener(MouseEvent.CLICK,this.onCancelClick);
      this.captchaSection.refreshButton.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void {
        dispatchEvent(new RefreshCaptchaClickedEvent());
      });
    }

    public function get password() : String {
      if(this.pass2.validValue && this.pass1.value == this.pass2.value) {
        return this.pass1.value;
      }
      return null;
    }

    public function get email() : String {
      if(this.emailInput.validValue) {
        return this.emailInput.value;
      }
      return null;
    }

    public function set email(param1:String) : void {
      this.emailInput.value = param1;
      this.updatePasswordBlock(null);
    }

    private function alignYourself(param1:Event) : void {
      if(Boolean(stage)) {
        this.x = int((stage.stageWidth - this.windowSize.x) / 2);
        this.y = int((stage.stageHeight - this.windowSize.y) / 2);
      }
    }

    private function updatePasswordBlock(param1:Event) : void {
      this.pass1.validValue = isPasswordValid(this.pass1.value);
      this.pass1CheckIcon.markAsInvalid();
      var local2:Boolean = true;
      this.pass2.validValue = this.pass2.value == "" || this.pass1.value == this.pass2.value;
      this.pass2CheckIcon.markAsInvalid();
      if(this.pass1.value == "") {
        this.pass1CheckIcon.turnOff();
        local2 = false;
      } else if(this.pass1.validValue) {
        this.pass1CheckIcon.markAsValid();
        local2 = false;
      }
      if(this.pass2.value == "") {
        this.pass2CheckIcon.turnOff();
      } else if(this.pass2.validValue) {
        this.pass2CheckIcon.markAsValid();
      }
      if(local2) {
        this.pass1CheckIcon.addChild(this.passwordIsTooEasyBubble);
      } else {
        this.passwordIsTooEasyBubble.hide();
      }
      var local3:Boolean = !(local2 || this.pass2.validValue);
      if(local3) {
        this.pass2CheckIcon.addChild(this.passwordsDoNotMatchBubble);
      } else {
        this.passwordsDoNotMatchBubble.hide();
      }
      var local4:Boolean = Boolean(validateService.isEmailValid(this.emailInput.value));
      if(local4) {
        this.emailInput.validValue = true;
        if(this.emailInput.value == "") {
          this.emailCheckIcon.turnOff();
        } else {
          this.emailCheckIcon.markAsValid();
        }
      } else {
        this.emailInput.validValue = false;
        this.emailCheckIcon.markAsInvalid();
      }
      var local5:Boolean = !(local2 || local3) && !local4;
      if(local5) {
        this.emailCheckIcon.addChild(this.emailInvalodBubble);
      } else {
        this.emailInvalodBubble.hide();
      }
      this.okButton.enable = this.pass1.value != "" && this.pass1.validValue && this.pass2.value != "" && this.pass2.validValue && this.emailInput.value != "" && this.emailInput.validValue;
    }

    private function removeEvents() : void {
      stage.removeEventListener(Event.RESIZE,this.alignYourself);
      this.pass1.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.updatePasswordBlock);
      this.pass1.removeEventListener(FocusEvent.FOCUS_OUT,this.updatePasswordBlock);
      this.pass2.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.updatePasswordBlock);
      this.pass2.removeEventListener(FocusEvent.FOCUS_OUT,this.updatePasswordBlock);
      this.emailInput.removeEventListener(FocusEvent.FOCUS_OUT,this.updatePasswordBlock);
      this.emailInput.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.updatePasswordBlock);
      this.okButton.removeEventListener(MouseEvent.CLICK,this.onOkClick);
      this.cancelButton.removeEventListener(MouseEvent.CLICK,this.onCancelClick);
    }

    private function createBubbles() : void {
      this.passwordIsTooEasyBubble = EntranceBubbleFactory.passwordIsTooEasyBubble();
      this.passwordsDoNotMatchBubble = EntranceBubbleFactory.passwordsDoNotMatchBubble();
      this.emailInvalodBubble = EntranceBubbleFactory.emailInvalidBubble();
    }

    private function onOkClick(param1:MouseEvent) : void {
      dispatchEvent(new ChangeEmailCaptchaEvent(this.getCaptchaAnswer(),this.password,this.email));
    }

    private function onCancelClick(param1:MouseEvent) : void {
      this.gotToLoginForm();
    }

    private function gotToLoginForm() : void {
      dispatchEvent(new NavigationEvent(NavigationEvent.GO_TO_LOGIN_FORM));
    }

    private function checkEmailConfirmation(param1:Event) : void {
      this.updatePasswordBlock(null);
    }

    public function hideYourself() : void {
      if(this.windowShown) {
        this.removeEvents();
        this.windowShown = false;
      }
    }

    public function setPasswordChangeResult(param1:Boolean, param2:String) : void {
      if(param1) {
        this.passChangeAlert = new Alert();
        this.passChangeAlert.showAlert(param2,Vector.<String>([AlertAnswer.OK]));
        if(Boolean(parent)) {
          parent.addChild(this.passChangeAlert);
        }
        this.passChangeAlert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.onChangePasswordAndEmailAlertPressed);
      } else {
        this.passChangeFailureAlert = new Alert();
        this.passChangeFailureAlert.showAlert(param2,Vector.<String>([AlertAnswer.OK]));
        if(Boolean(parent)) {
          parent.addChild(this.passChangeFailureAlert);
        }
        this.passChangeFailureAlert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.onChangePassChangeFailureAlertPressed);
      }
    }

    private function onChangePassChangeFailureAlertPressed(param1:AlertEvent) : void {
      this.passChangeFailureAlert.parent.removeChild(this.passChangeFailureAlert);
      this.gotToLoginForm();
    }

    private function onChangePasswordAndEmailAlertPressed(param1:AlertEvent) : void {
      this.passChangeAlert.parent.removeChild(this.passChangeAlert);
      this.gotToLoginForm();
    }

    private function getCaptchaAnswer() : String {
      return this.captchaSection.captchaAnswer.value;
    }

    public function setCaptchaImage(param1:Bitmap) : void {
      this.captchaSection.captcha = param1;
    }

    public function captchaFailed() : void {
      dispatchEvent(new RefreshCaptchaClickedEvent());
    }
  }
}
