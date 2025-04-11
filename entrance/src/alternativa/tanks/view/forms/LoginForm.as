package alternativa.tanks.view.forms {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controller.events.AccountLoginPressed;
  import alternativa.tanks.controller.events.LoginButtonPressed;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.google.GoogleLoginEvent;
  import alternativa.tanks.controller.events.socialnetwork.StartExternalEntranceEvent;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.service.IExternalEntranceService;
  import alternativa.tanks.service.IRegistrationUXService;
  import alternativa.tanks.view.bubbles.Bubble;
  import alternativa.tanks.view.bubbles.EntranceBubbleFactory;
  import alternativa.tanks.view.forms.commons.RegistrationCommonElementsSection;
  import alternativa.tanks.view.forms.primivites.Alert;
  import alternativa.tanks.view.forms.primivites.ValidationIcon;
  import alternativa.tanks.view.registration.ExternalEntranceForm;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.PasswordInput;
  import controls.base.TankInputBase;
  import controls.checkbox.CheckBoxBase;
  import controls.dropdownlist.AccountsList;
  import flash.display.Bitmap;
  import flash.display.InteractiveObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.net.SharedObject;
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
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class LoginForm extends Sprite {
    [Inject]
    public static var externalEntranceService:IExternalEntranceService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var registrationUXService:IRegistrationUXService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public var localeService:ILocaleService;

    [Inject]
    public var injector:IInjector;
    public var _callSignOrEmail:TankInputBase;
    public var restoreLink:LabelBase;

    private var _password:PasswordInput;

    public var checkRemember:CheckBoxBase;
    public var playButton:DefaultButtonBase;
    public var registerButton:LabelBase;

    private var checkRememberLabel:LabelBase;
    private var accountsList:AccountsList;
    private var window:TankWindowWithHeader;
    private var snPanel:ExternalEntranceForm;

    public var captchaSection:CaptchaSection;

    private var accountSelected:Boolean = false;
    private var _margin:int = 25;
    private var _windowWidth:int = 372;
    private var _windowHeight:int = 193;
    private var _inputsLeftMargin:int = 72;
    private var _symbolIsNotAllowedBubble:Bubble;
    private var _callSignCheckIcon:ValidationIcon;
    private var _notAllowedShowDelayTimerTimer:Timer;
    private var _isAddLoginButtonPressedEventListeners:Boolean;

    public function LoginForm() {
      super();
    }

    [PostConstruct]
    public function postConstruct() : void {
      var buttonWidth:int;
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_LOGIN,this._windowWidth,this._windowHeight);
      this.restoreLink = new LabelBase();
      this.restoreLink.htmlText = this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_RESTORE_LINK_TEXT);
      this.restoreLink.x = this._windowWidth - this.restoreLink.width - this._margin;
      this.restoreLink.y = this._margin;
      this.window.addChild(this.restoreLink);
      buttonWidth = 115;
      this._callSignOrEmail = new TankInputBase();
      this._callSignOrEmail.label = this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_CALLSIGN);
      this._callSignOrEmail.maxChars = RegistrationCommonElementsSection.MAX_CHARS_EMAIL;
      this._password = new PasswordInput();
      this._password.label = this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_PASSWORD);
      this._inputsLeftMargin = this._margin - 3 + (Math.abs(this._callSignOrEmail._label.x) > Math.abs(this._password._label.x) ? Math.abs(this._callSignOrEmail._label.x) : Math.abs(this._password._label.x));
      this.registerButton = new LabelBase();
      this.registerButton.htmlText = "<a href=\'event:\'><font color=\'#59ff32\'><u>" + this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_BUTTON_NEW_PLAYER_TEXT) + "</u></font></a>";
      this.registerButton.width = Math.max(this.registerButton.width,buttonWidth);
      this.registerButton.x = this._inputsLeftMargin;
      this.registerButton.y = this._margin;
      this.registerButton.visible = false;
      this.window.addChild(this.registerButton);
      this._callSignOrEmail.width = this._windowWidth - this._inputsLeftMargin - this._margin;
      this._callSignOrEmail.x = this._inputsLeftMargin;
      this._callSignOrEmail.y = this._margin + this.restoreLink.height + this._margin / 3;
      this._callSignOrEmail.restrict = "@А-Яа-я.0-9a-zA-z_\\-";
      this._callSignOrEmail.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onCallsignChanged);
      this.accountsList = new AccountsList(this._callSignOrEmail);
      this.accountsList.tabChildren = false;
      this.accountsList.x = this._callSignOrEmail.x;
      this.accountsList.y = this._callSignOrEmail.y + 3;
      this.accountsList.addEventListener(Event.CHANGE,this.onAccountChange);
      this.accountsList.width = this._windowWidth - this._inputsLeftMargin - this._margin;
      this.accountsList.initialize();
      this._password.width = this._windowWidth - this._inputsLeftMargin - this._margin;
      this._password.x = this._inputsLeftMargin;
      this._password.y = this._callSignOrEmail.y + this._callSignOrEmail.height + this._margin / 3;
      this._password.hidden = true;
      this._password.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onPasswordChanged);
      this.window.addChild(this._password);
      this._callSignCheckIcon = new ValidationIcon();
      this._callSignCheckIcon.x = this._windowWidth - this._margin - this._callSignCheckIcon.width - 10 - (this.accountsList.visible ? 31 : 0);
      this._callSignCheckIcon.y = this._callSignOrEmail.y + 7;
      this.window.addChild(this._callSignCheckIcon);
      this.checkRemember = new CheckBoxBase();
      this.checkRemember.x = this._inputsLeftMargin;
      this.checkRemember.y = this._windowHeight - this.checkRemember.height - this._margin - 2;
      this.window.addChild(this.checkRemember);
      this.checkRememberLabel = new LabelBase();
      this.checkRememberLabel.x = this.checkRemember.x + this.checkRemember.width;
      this.checkRememberLabel.y = this.checkRemember.y + 5;
      this.checkRememberLabel.text = this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_REMEMBER);
      this.window.addChild(this.checkRememberLabel);
      this.playButton = new DefaultButtonBase();
      this.playButton.label = this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORD_FORM_PLAY_BUTTON);
      this.playButton.width = this.registerButton.width = Math.max(this.playButton.width,this.registerButton.width);
      this.playButton.x = this._windowWidth - this._margin - this.playButton.width;
      this.playButton.y = this._windowHeight - this.playButton.height - this._margin;
      this.window.addChild(this.playButton);
      this.captchaSection = this.injector.instantiate(CaptchaSection);
      if(Boolean(externalEntranceService.vkontakteEnabled) || Boolean(externalEntranceService.facebookEnabled) || Boolean(externalEntranceService.googleEnabled)) {
        this.snPanel = new ExternalEntranceForm(this._windowWidth - 40,85,this.localeService.getText(TanksLocale.TEXT_CHECK_PASSWORK_FORM_LOGIN_VIA));
        addChild(this.snPanel);
        this.snPanel.y = this.window.y + this.window.height - 15;
        this.snPanel.x = this.window.x + (this._windowWidth - this.snPanel.width) / 2;
        if(externalEntranceService.vkontakteEnabled) {
          this.snPanel.vkButton.addEventListener(MouseEvent.CLICK,this.onVkButtonClick);
        }
        if(externalEntranceService.facebookEnabled) {
          this.snPanel.fbButton.addEventListener(MouseEvent.CLICK,this.onFbButtonClick);
        }
        if(externalEntranceService.googleEnabled) {
          this.snPanel.googleButton.addEventListener(MouseEvent.CLICK,this.onGoogleButtonClick);
        }
      }
      this.window.addChild(this._callSignOrEmail);
      this.window.addChild(this.accountsList);
      addChild(this.window);
      this.registerButton.visible = true;
      this.registerButton.addEventListener(MouseEvent.CLICK,this.onRegistrationClicked);
      this.restoreLink.addEventListener(MouseEvent.CLICK,this.showRestoreForm);
      this.captchaSection.refreshButton.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void {
        dispatchEvent(new RefreshCaptchaClickedEvent());
      });
      this._symbolIsNotAllowedBubble = EntranceBubbleFactory.symbolIsNotAllowedBubble();
      this._notAllowedShowDelayTimerTimer = new Timer(1000,1);
      this._notAllowedShowDelayTimerTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCallsignCheckTimerComplete);
      this.addLoginButtonPressedEventListeners();
      display.stage.addEventListener(Event.RESIZE,this.alignYourself);
      this.alignYourself();
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      registrationUXService.logNavigationFinish();
    }

    private function onAccountChange(param1:Event) : void {
      if(!this.accountsList.selectedItem) {
        this.accountSelected = false;
        if(this.accountsList.length == 0) {
          this.callsign = "";
          this.password = "";
          this._password.enable = true;
          this.accountsList.visible = false;
          this.accountsList.removeEventListener(Event.CHANGE,this.onAccountChange);
          this._callSignCheckIcon.x += 31;
        } else {
          this.accountsList.selectItemAt(0);
        }
        return;
      }
      this.callsign = this.accountsList.selectedItem.data.userName;
      this._password.enable = false;
      this.password = "12345678";
      this.accountSelected = true;
    }

    private function onRemoveFromStage(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.removeEventListener(Event.RESIZE,this.alignYourself);
      this.registerButton.removeEventListener(MouseEvent.CLICK,this.onRegistrationClicked);
      this.restoreLink.removeEventListener(MouseEvent.CLICK,this.showRestoreForm);
      this._callSignOrEmail.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onCallsignChanged);
      this.accountsList.removeEventListener(Event.CHANGE,this.onAccountChange);
      this.removeLoginButtonPressedEvenListeners();
      this._notAllowedShowDelayTimerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onCallsignCheckTimerComplete);
      this._notAllowedShowDelayTimerTimer.stop();
      if(externalEntranceService.vkontakteEnabled) {
        this.snPanel.vkButton.removeEventListener(MouseEvent.CLICK,this.onVkButtonClick);
      }
      if(externalEntranceService.facebookEnabled) {
        this.snPanel.fbButton.removeEventListener(MouseEvent.CLICK,this.onFbButtonClick);
      }
      loaderWindowService.showDelayed(100);
    }

    private function onVkButtonClick(param1:MouseEvent) : void {
      dispatchEvent(new StartExternalEntranceEvent(StartExternalEntranceEvent.START_LOGIN,"vkontakte",this.rememberMe));
    }

    private function onFbButtonClick(param1:MouseEvent) : void {
      dispatchEvent(new StartExternalEntranceEvent(StartExternalEntranceEvent.START_LOGIN,"facebook",this.rememberMe));
    }

    private function onGoogleButtonClick(param1:MouseEvent) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("onGoogleButtonClicked");
        ExternalInterface.addCallback("onGoogleTokenReceived",this.onGoogleTokenReceived);
      }
    }

    private function onGoogleTokenReceived(param1:String) : void {
      dispatchEvent(new GoogleLoginEvent(param1,this.rememberMe));
    }

    private function onCallsignCheckTimerComplete(param1:TimerEvent) : void {
      this.hideBubbles();
    }

    private function onCallsignChanged(param1:LoginFormEvent) : void {
      if(this.accountSelected) {
        this._password.enable = true;
        this.password = "";
        this.accountSelected = false;
      }
      this.hideBubbles();
      this._notAllowedShowDelayTimerTimer.reset();
      this._notAllowedShowDelayTimerTimer.start();
      if(!validateService.isValidIdentificationStringForLogin(this._callSignOrEmail.value)) {
        this._callSignOrEmail.value = this._callSignOrEmail.value.replace(ValidateService.NOT_ALLOWED_PATTERN_FOR_LOGIN,"");
        this._callSignOrEmail.validValue = false;
        this._callSignCheckIcon.markAsInvalid();
        this._callSignCheckIcon.addChild(this._symbolIsNotAllowedBubble);
      }
    }

    private function onPasswordChanged(param1:LoginFormEvent) : void {
      this.accountSelected = false;
    }

    private function hideBubbles() : void {
      this._callSignOrEmail.validValue = true;
      this._symbolIsNotAllowedBubble.hide();
      this._callSignCheckIcon.turnOff();
    }

    private function addLoginButtonPressedEventListeners() : void {
      if(!this._isAddLoginButtonPressedEventListeners) {
        this._isAddLoginButtonPressedEventListeners = true;
        this.playButton.enable = true;
        this.playButton.addEventListener(MouseEvent.CLICK,this.onPlayClicked);
        this._password.addEventListener(KeyboardEvent.KEY_DOWN,this.onPlayClickedKey);
        this.captchaSection.captchaAnswer.addEventListener(KeyboardEvent.KEY_DOWN,this.onPlayClickedKey);
      }
    }

    private function removeLoginButtonPressedEvenListeners() : void {
      if(this._isAddLoginButtonPressedEventListeners) {
        this._isAddLoginButtonPressedEventListeners = false;
        this.playButton.enable = false;
        this.playButton.removeEventListener(MouseEvent.CLICK,this.onPlayClicked);
        this._password.removeEventListener(KeyboardEvent.KEY_DOWN,this.onPlayClickedKey);
        this.captchaSection.captchaAnswer.removeEventListener(KeyboardEvent.KEY_DOWN,this.onPlayClickedKey);
      }
    }

    private function onPlayClicked(param1:MouseEvent) : void {
      this.removeLoginButtonPressedEvenListeners();
      if(this.accountSelected) {
        this.saveAccount();
        dispatchEvent(new AccountLoginPressed());
      } else {
        dispatchEvent(new LoginButtonPressed());
      }
    }

    private function saveAccount() : void {
      var local1:SharedObject = storageService.getStorage();
      var local2:Object = this.accountsList.selectedItem.data;
      local1.data.userName = local2.userName;
      local1.data.userHash = local2.userHash;
      if(!this.rememberMe) {
        local1.data.userHash = null;
      }
      local1.flush();
    }

    private function onPlayClickedKey(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER && this.playButton.enable) {
        this.removeLoginButtonPressedEvenListeners();
        if(this.accountSelected) {
          this.removeLoginButtonPressedEvenListeners();
          this.saveAccount();
          dispatchEvent(new AccountLoginPressed());
        } else {
          dispatchEvent(new LoginButtonPressed());
        }
      }
    }

    private function onRegistrationClicked(param1:MouseEvent) : void {
      dispatchEvent(new NavigationEvent(NavigationEvent.GO_TO_REGISTRATION_FORM));
    }

    public function get captchaAnswer() : String {
      if(Boolean(this.captchaSection)) {
        return this.captchaSection.captchaAnswer.value;
      }
      return "";
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

    public function get hash() : String {
      return this.accountsList.selectedItem.data.userHash;
    }

    public function set enableRegistration(param1:Boolean) : void {
      this.registerButton.visible = param1;
      if(param1) {
        this.registerButton.addEventListener(MouseEvent.CLICK,this.onRegistrationClicked);
      } else {
        this.registerButton.removeEventListener(MouseEvent.CLICK,this.onRegistrationClicked);
      }
    }

    private function showRestoreForm(param1:MouseEvent) : void {
      dispatchEvent(new NavigationEvent(NavigationEvent.GO_TO_RESTORE_PASSWORD_FORM));
    }

    public function alertAboutWrongPassword() : void {
      this.showErrorWindow(Alert.ERROR_PASSWORD_INCORRECT);
      this._password.clear();
      this._password.enable = true;
      this.accountSelected = false;
      this.addLoginButtonPressedEventListeners();
      if(this.window.contains(this.captchaSection)) {
        this.captchaSection.captchaAnswer.clear();
        dispatchEvent(new RefreshCaptchaClickedEvent());
      }
    }

    private function showErrorWindow(param1:int) : void {
      var local2:Alert = new Alert(param1);
      this.injector.injectInto(local2);
      parent.addChild(local2);
    }

    private function alignYourself(param1:Event = null) : void {
      this.x = int((display.stage.stageWidth - this.windowWidth) / 2);
      this.y = int((display.stage.stageHeight - this.windowHeight) / 2);
    }

    public function get rememberMe() : Boolean {
      return this.checkRemember.checked;
    }

    public function set remember(param1:Boolean) : void {
      this.checkRemember.checked = param1;
    }

    public function get windowWidth() : int {
      return this._windowWidth;
    }

    public function get windowHeight() : int {
      return this._windowHeight;
    }

    public function set captchaImage(param1:Bitmap) : void {
      if(Boolean(this.captchaSection)) {
        this.captchaSection.captcha = param1;
      }
    }

    public function captchaFailed() : void {
      this.addLoginButtonPressedEventListeners();
    }

    public function showCaptchaSection() : void {
      if(!this.window.contains(this.captchaSection)) {
        this.window.addChild(this.captchaSection);
        this.addLoginButtonPressedEventListeners();
        this.captchaSection.y = this._password.y + this._password.height + this._margin - 5;
        this.captchaSection.x = this._inputsLeftMargin;
        this.captchaSection.width = this._windowWidth - this._inputsLeftMargin - this._margin;
        this.captchaSection.visible = true;
        this.playButton.y = this.captchaSection.y + this.captchaSection.height + this._margin - 5;
        this.checkRemember.y = this.playButton.y + 2;
        this.checkRememberLabel.y = this.checkRemember.y + 5;
        this._windowHeight = this._windowHeight + this.captchaSection.height + this._margin - 5;
        this.window.height = this._windowHeight;
        if(this.snPanel != null) {
          this.snPanel.y = this.window.y + this.window.height - 15;
        }
        this.alignYourself();
        dispatchEvent(new RefreshCaptchaClickedEvent());
      }
    }
  }
}
