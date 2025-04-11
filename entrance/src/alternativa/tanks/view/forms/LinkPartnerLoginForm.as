package alternativa.tanks.view.forms {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.controller.events.LoginButtonPressed;
  import alternativa.tanks.controller.events.PartnersEvent;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.service.IRegistrationUXService;
  import alternativa.tanks.view.bubbles.Bubble;
  import alternativa.tanks.view.bubbles.EntranceBubbleFactory;
  import alternativa.tanks.view.forms.commons.RegistrationCommonElementsSection;
  import alternativa.tanks.view.forms.primivites.ValidationIcon;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.display.Bitmap;
  import flash.display.InteractiveObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.ui.Keyboard;
  import flash.utils.Timer;
  import forms.TankWindowWithHeader;
  import forms.events.LoginFormEvent;
  import org.robotlegs.core.IInjector;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaSection;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import services.alertservice.Alert;

  public class LinkPartnerLoginForm extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var log:LogService;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var registrationUXService:IRegistrationUXService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public var injector:IInjector;

    private var _callSignOrEmail:TankInputBase;
    private var _password:TankInputBase;
    private var _playButton:DefaultButtonBase;
    private var _backButton:DefaultButtonBase;
    private var _informLabel:LabelBase;
    private var _window:TankWindowWithHeader;
    private var _captchaSection:CaptchaSection;
    private var _backgroundContainer:Sprite;
    private var _backgroundImage:Bitmap;
    private var _margin:int = 25;
    private var _windowWidth:int = 372;
    private var _windowHeight:int = 208;
    private var _inputsLeftMargin:int = 72;
    private var _symbolIsNotAllowedBubble:Bubble;
    private var _callSignCheckIcon:ValidationIcon;
    private var _notAllowedDelayTimerTimer:Timer;

    public function LinkPartnerLoginForm(param1:Bitmap) {
      super();
      this._backgroundImage = param1;
    }

    [PostConstruct]
    public function postConstruct() : void {
      this._backgroundContainer = new Sprite();
      addChild(this._backgroundContainer);
      this._window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_LINK,this._windowWidth,this._windowHeight);
      addChild(this._window);
      var local1:int = 115;
      this._callSignOrEmail = new TankInputBase();
      this._callSignOrEmail.label = localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_CALLSIGN);
      this._callSignOrEmail.maxChars = RegistrationCommonElementsSection.MAX_CHARS_EMAIL;
      this._password = new TankInputBase();
      this._password.label = localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_PASSWORD);
      this._inputsLeftMargin = this._margin - 3 + (Math.abs(this._callSignOrEmail._label.x) > Math.abs(this._password._label.x) ? Math.abs(this._callSignOrEmail._label.x) : Math.abs(this._password._label.x));
      this._callSignOrEmail.width = this._windowWidth - this._inputsLeftMargin - this._margin;
      this._callSignOrEmail.x = this._inputsLeftMargin;
      this._callSignOrEmail.y = this._margin;
      this._callSignOrEmail.tabIndex = 0;
      this._callSignOrEmail.restrict = "@А-Яа-я.0-9a-zA-z_\\-";
      this._window.addChild(this._callSignOrEmail);
      display.stage.focus = this._callSignOrEmail;
      this._password.width = this._windowWidth - this._inputsLeftMargin - this._margin;
      this._password.x = this._inputsLeftMargin;
      this._password.y = this._callSignOrEmail.y + this._callSignOrEmail.height + this._margin / 3;
      this._password.hidden = true;
      this._password.tabIndex = 1;
      this._window.addChild(this._password);
      this._callSignCheckIcon = new ValidationIcon();
      this._callSignCheckIcon.x = this._windowWidth - this._margin - this._callSignCheckIcon.width - 10;
      this._callSignCheckIcon.y = this._callSignOrEmail.y + 7;
      this._window.addChild(this._callSignCheckIcon);
      this._informLabel = new LabelBase();
      this._informLabel.text = localeService.getText(TanksLocale.TEXT_PARTNER_LOGIN_FORM_ENTER_USERNAME_TEXT);
      this._informLabel.x = this._margin;
      this._informLabel.y = this._password.y + this._password.height + this._margin - 10;
      this._informLabel.multiline = true;
      this._informLabel.wordWrap = true;
      this._informLabel.width = this._windowWidth - this._informLabel.x - this._margin;
      this._window.addChild(this._informLabel);
      this._backButton = new DefaultButtonBase();
      this._backButton.label = localeService.getText(TanksLocale.TEXT_BACK_BUTTON);
      this._playButton = new DefaultButtonBase();
      this._playButton.label = localeService.getText(TanksLocale.TEXT_COMPLETE_BUTTON);
      this._playButton.width = this._backButton.width = Math.max(this._playButton.width,this._backButton.width,local1);
      this._playButton.x = this._windowWidth - this._margin - this._playButton.width;
      this._playButton.y = this._windowHeight - this._playButton.height - this._margin;
      this._window.addChild(this._playButton);
      this._backButton.x = this._margin;
      this._backButton.y = this._playButton.y;
      this._window.addChild(this._backButton);
      this._notAllowedDelayTimerTimer = new Timer(1000,1);
      this._captchaSection = this.injector.instantiate(CaptchaSection);
      this._symbolIsNotAllowedBubble = EntranceBubbleFactory.symbolIsNotAllowedBubble();
      this.setEvents();
      this.alignYourself();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      registrationUXService.logNavigationFinish();
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      stage.addEventListener(Event.RESIZE,this.alignYourself);
      this.alignYourself(null);
      if(Boolean(this._backgroundImage)) {
        this.setBackground(this._backgroundImage);
      }
      loaderWindowService.hide();
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.alignYourself);
    }

    public function setBackground(param1:Bitmap) : void {
      if(this._backgroundContainer.numChildren == 0) {
        this._backgroundImage = param1;
        this._backgroundContainer.addChild(param1);
        this.alignYourself();
      }
    }

    private function onPlayClicked(param1:MouseEvent = null) : void {
      this._playButton.enable = false;
      dispatchEvent(new LoginButtonPressed());
    }

    private function onBackClicked(param1:MouseEvent) : void {
      dispatchEvent(new PartnersEvent(PartnersEvent.START_REGISTRATION));
    }

    private function onKeyDownPasswordInput(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER && this._playButton.enable) {
        this.onPlayClicked();
      }
    }

    public function get captchaAnswer() : String {
      return this._captchaSection.captchaAnswer.value;
    }

    public function get mainPassword() : String {
      return this._password.value;
    }

    public function set password(param1:String) : void {
      this._password.value = param1;
    }

    public function get callsign() : String {
      return this._callSignOrEmail.value;
    }

    public function set callsign(param1:String) : void {
      if(param1 != null) {
        this._callSignOrEmail.value = param1;
        display.stage.focus = this._callSignOrEmail.textField.length == 0 ? this._callSignOrEmail.textField : this._password.textField;
      }
    }

    public function get password() : String {
      return this._password.value;
    }

    private function setEvents() : void {
      display.stage.addEventListener(Event.RESIZE,this.alignYourself);
      this._playButton.addEventListener(MouseEvent.CLICK,this.onPlayClicked);
      this._backButton.addEventListener(MouseEvent.CLICK,this.onBackClicked);
      this._password.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownPasswordInput);
      this._callSignOrEmail.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onCallsignChanged);
      this._captchaSection.captchaAnswer.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownPasswordInput);
      this._captchaSection.refreshButton.addEventListener(MouseEvent.CLICK,this.onCaptchaRefresh);
      this._notAllowedDelayTimerTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCallsignCheckTimerComplete);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
    }

    private function onCaptchaRefresh(param1:MouseEvent = null) : void {
      this._captchaSection.captchaAnswer.clear();
      dispatchEvent(new RefreshCaptchaClickedEvent());
    }

    private function onRemoveFromStage(param1:Event) : void {
      this._notAllowedDelayTimerTimer.stop();
      this.removeEvents();
    }

    private function removeEvents() : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.removeEventListener(Event.RESIZE,this.alignYourself);
      this._playButton.removeEventListener(MouseEvent.CLICK,this.onPlayClicked);
      this._backButton.removeEventListener(MouseEvent.CLICK,this.onBackClicked);
      this._password.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownPasswordInput);
      this._callSignOrEmail.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onCallsignChanged);
      this._captchaSection.captchaAnswer.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownPasswordInput);
      this._captchaSection.refreshButton.removeEventListener(MouseEvent.CLICK,this.onCaptchaRefresh);
      this._notAllowedDelayTimerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onCallsignCheckTimerComplete);
    }

    private function onCallsignCheckTimerComplete(param1:TimerEvent) : void {
      this.hideBubbles();
    }

    private function onCallsignChanged(param1:LoginFormEvent) : void {
      this.hideBubbles();
      this._notAllowedDelayTimerTimer.reset();
      this._notAllowedDelayTimerTimer.start();
      if(!validateService.isValidIdentificationStringForLogin(this._callSignOrEmail.value)) {
        this._callSignOrEmail.value = this._callSignOrEmail.value.replace(ValidateService.NOT_ALLOWED_PATTERN_FOR_LOGIN,"");
        this._callSignOrEmail.validValue = false;
        this._callSignCheckIcon.markAsInvalid();
        this._callSignCheckIcon.addChild(this._symbolIsNotAllowedBubble);
      }
    }

    private function hideBubbles() : void {
      this._callSignOrEmail.validValue = true;
      this._symbolIsNotAllowedBubble.hide();
      this._callSignCheckIcon.turnOff();
    }

    public function showAlertAboutWrongPassword() : void {
      this._playButton.enable = true;
      this.showErrorWindow(Alert.ERROR_PASSWORD_INCORRECT);
      this._password.clear();
      if(this._window.contains(this._captchaSection)) {
        this.onCaptchaRefresh();
      }
    }

    private function showErrorWindow(param1:int) : void {
      var local2:Alert = new Alert(param1);
      display.contentUILayer.addChild(local2);
    }

    private function alignYourself(param1:Event = null) : void {
      this.x = int((display.stage.stageWidth - this._windowWidth) / 2);
      this.y = int((display.stage.stageHeight - this._windowHeight) / 2);
      if(Boolean(this._backgroundImage)) {
        graphics.clear();
        graphics.beginFill(0);
        graphics.drawRect(-this.x,-this.y,display.stage.width,display.stage.height);
        graphics.endFill();
        this._backgroundImage.x = int(this._windowWidth - this._backgroundImage.width >> 1);
        this._backgroundImage.y = -int(display.stage.stageHeight - this._window.height >> 1);
      }
    }

    public function set captchaImage(param1:Bitmap) : void {
      if(Boolean(this._captchaSection)) {
        this._captchaSection.captcha = param1;
      }
    }

    public function captchaFailed() : void {
      this._playButton.enable = true;
    }

    public function showCaptchaSection() : void {
      if(!this._window.contains(this._captchaSection)) {
        this._window.addChild(this._captchaSection);
        this._captchaSection.y = this._password.y + this._password.height + this._margin - 5;
        this._captchaSection.x = this._inputsLeftMargin;
        this._captchaSection.width = this._windowWidth - this._inputsLeftMargin - this._margin;
        this._captchaSection.visible = true;
        this._informLabel.y = this._captchaSection.y + this._captchaSection.height + this._margin - 10;
        this._playButton.y = this._informLabel.y + this._informLabel.height + this._margin - 5;
        this._backButton.y = this._playButton.y;
        this._windowHeight = this._windowHeight + this._captchaSection.height + this._margin - 5;
        this._window.height = this._windowHeight;
        this.alignYourself();
        this.onCaptchaRefresh();
        this._playButton.enable = true;
      }
    }

    public function linkAlreadyExists() : void {
      this._playButton.enable = true;
      this.showErrorWindow(Alert.ERROR_PARTNER_LINK_ALREADY_EXISTS);
    }
  }
}
