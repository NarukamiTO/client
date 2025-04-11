package alternativa.tanks.view.forms {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controller.events.CheckCallsignEvent;
  import alternativa.tanks.controller.events.PartnersEvent;
  import alternativa.tanks.controller.events.partners.FinishPartnerRegisterEvent;
  import alternativa.tanks.service.IRegistrationUXService;
  import alternativa.tanks.type.RulesType;
  import alternativa.tanks.view.bubbles.Bubble;
  import alternativa.tanks.view.bubbles.EntranceBubbleFactory;
  import alternativa.tanks.view.forms.commons.RegistrationCommonElementsSection;
  import alternativa.tanks.view.forms.freeuids.FreeUidsForm;
  import alternativa.tanks.view.forms.freeuids.FreeUidsFormEvent;
  import alternativa.tanks.view.forms.primivites.ValidationIcon;
  import alternativa.tanks.view.layers.EntranceView;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import controls.checkbox.CheckBoxBase;
  import controls.checkbox.CheckBoxEvent;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.TextEvent;
  import flash.events.TimerEvent;
  import flash.ui.Keyboard;
  import flash.utils.Timer;
  import forms.TankWindowWithHeader;
  import forms.events.LoginFormEvent;
  import org.robotlegs.core.IInjector;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXFormAction;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;

  public class PartnersRegistrationForm extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var helperService:IHelpService;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var registrationUXService:IRegistrationUXService;

    [Inject]
    public var entranceView:EntranceView;

    [Inject]
    public var injector:IInjector;

    private var _allowExternalLogin:Boolean = false;
    private var _callsignInput:TankInputBase;
    private var _continueButton:DefaultButtonBase;
    private var _rulesButton:LabelBase;
    private var _haveAccountLabel:LabelBase;
    private var infoLabel:LabelBase;
    private var _backgroundContainer:Sprite;
    private var _backgroundImage:Bitmap;
    private var _window:TankWindowWithHeader;
    private var _freeUidsForm:FreeUidsForm;
    private var _isFreeUidsFormAlreadyShowed:Boolean;
    private var _margin:int = 20;
    private var _border:int = 25;
    private var _windowWidth:int = 400;
    private var _windowHeight:int = 193;
    private var _inputsLeftMargin:int = 80;
    private var _callsignValidated:Boolean = false;
    private var _callSignCheckIcon:ValidationIcon;
    private var _checkCallsignTimer:Timer;

    private const checkCallsignDelay:int = 500;

    private var _checkSymbolAllowedTimer:Timer;

    private const checkSymbolAllowedDelay:int = 5000;

    private var _nameIsNotUniqueBubble:Bubble;
    private var _nameIsIncorrectBubble:Bubble;
    private var _symbolIsNotAllowedBubble:Bubble;
    private var _acceptRulesCheckBox:CheckBoxBase;

    public function PartnersRegistrationForm(param1:Bitmap, param2:Boolean) {
      super();
      this._backgroundImage = param1;
      this._allowExternalLogin = param2;
    }

    [PostConstruct]
    public function postConstruct() : void {
      var local1:int = this._border;
      this._window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_REGISTRATION,this._windowWidth,local1);
      this._callsignInput = new TankInputBase();
      this._callSignCheckIcon = new ValidationIcon();
      this._continueButton = new DefaultButtonBase();
      this._haveAccountLabel = new LabelBase();
      this.infoLabel = new LabelBase();
      this._acceptRulesCheckBox = new CheckBoxBase();
      this._window.addChild(this._callsignInput);
      this._window.addChild(this.infoLabel);
      this.infoLabel.text = localeService.getText(TanksLocale.TEXT_PARTNER_REGISTARTION_FORM_CHOOSE_NAME_TEXT);
      this.infoLabel.y = this._margin;
      this.infoLabel.x = this._border;
      this._inputsLeftMargin = this._border + 5 + this._callsignInput._label.width;
      this._callsignInput.x = this._border;
      this._callsignInput.y = this.infoLabel.y + this.infoLabel.height + this._margin - 5;
      this._callsignInput.width = this._windowWidth - 2 * this._border;
      this._callsignInput.maxChars = RegistrationCommonElementsSection.MAX_CHARS_CALLSIGN;
      this._callsignInput.tabIndex = 0;
      this._callsignInput.validValue = true;
      this._callSignCheckIcon.x = this._windowWidth - this._margin - this._callSignCheckIcon.width - 10;
      this._callSignCheckIcon.y = this._callsignInput.y + 7;
      this._acceptRulesCheckBox.x = this._border;
      this._acceptRulesCheckBox.y = this._callsignInput.y + this._callsignInput.height + this._margin - 6;
      this._window.addChild(this._acceptRulesCheckBox);
      this._rulesButton = new LabelBase();
      this._rulesButton.x = this._border + this._acceptRulesCheckBox.width;
      this._rulesButton.y = this._acceptRulesCheckBox.y;
      this._rulesButton.multiline = true;
      this._rulesButton.wordWrap = true;
      this._rulesButton.htmlText = localeService.getText(TanksLocale.TEXT_REGISTER_FORM_AGREEMENT_NOTE_TEXT);
      this._rulesButton.width = this._windowWidth - this._rulesButton.x - this._border;
      this._window.addChild(this._rulesButton);
      this._continueButton.label = localeService.getText(TanksLocale.TEXT_PARTNER_REGISTARTION_FORM_CONTINUE);
      this._continueButton.enable = false;
      this._continueButton.x = this._windowWidth - this._border - this._continueButton.width;
      this._continueButton.y = this._rulesButton.y + this._rulesButton.height + this._margin - 8;
      this._window.addChild(this._continueButton);
      this._haveAccountLabel.x = this._border;
      this._haveAccountLabel.multiline = true;
      this._haveAccountLabel.wordWrap = true;
      this._haveAccountLabel.width = this._windowWidth - this._haveAccountLabel.x - this._margin - this._continueButton.width;
      this._haveAccountLabel.htmlText = localeService.getText(TanksLocale.TEXT_PARTNER_REGISTARTION_FORM_LOGIN_LINK_TEXT);
      this._haveAccountLabel.y = this._continueButton.y + this._continueButton.height / 2 - this._haveAccountLabel.height / 2;
      this._haveAccountLabel.visible = this._allowExternalLogin;
      this._window.addChild(this._haveAccountLabel);
      this._checkCallsignTimer = new Timer(this.checkCallsignDelay,1);
      this._checkSymbolAllowedTimer = new Timer(this.checkSymbolAllowedDelay,1);
      this._backgroundContainer = new Sprite();
      addChild(this._backgroundContainer);
      this._window.addChild(this._callSignCheckIcon);
      addChild(this._window);
      this._freeUidsForm = new FreeUidsForm();
      this._freeUidsForm.x = this._callsignInput.x;
      this._freeUidsForm.y = this._callsignInput.y + this._callsignInput.height;
      this._freeUidsForm.width = this._windowWidth - 2 * this._border;
      addChild(this._freeUidsForm);
      this.createBubbles();
      this._window.height = Math.max(this._windowHeight,this._continueButton.y + this._continueButton.height + this._margin);
      this.setEvent();
      display.stage.focus = this._callsignInput.textField;
      this.alignYourself(null);
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
    }

    private function onRemovedFromStage(param1:Event) : void {
      this._freeUidsForm.destroy();
      stage.removeEventListener(Event.RESIZE,this.alignYourself);
    }

    public function setBackground(param1:Bitmap) : void {
      if(this._backgroundContainer.numChildren == 0) {
        this._backgroundImage = param1;
        this._backgroundContainer.addChild(param1);
        this.alignYourself(null);
      }
    }

    private function createBubbles() : void {
      var local1:ILocaleService = this.injector.getInstance(ILocaleService);
      this._nameIsNotUniqueBubble = EntranceBubbleFactory.nameIsNotUniqueinPartnerBubble();
      this._nameIsIncorrectBubble = EntranceBubbleFactory.nameIsIncorrectinPartnerBubble();
      this._symbolIsNotAllowedBubble = EntranceBubbleFactory.symbolIsNotAllowedinPartnerBubble();
    }

    private function setEvent() : void {
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.addEventListener(Event.RESIZE,this.alignYourself);
      this._callsignInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onCallsignChanged);
      this._callsignInput.addEventListener(KeyboardEvent.KEY_DOWN,this.onPlayClickedKey);
      this._continueButton.addEventListener(MouseEvent.CLICK,this.onRegisterButtonClick);
      this._haveAccountLabel.addEventListener(TextEvent.LINK,this.onHaveAccountClick);
      this._rulesButton.addEventListener(TextEvent.LINK,this.onRules);
      this._checkCallsignTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCallsignCheckTimerComplete);
      this._checkSymbolAllowedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSymbolAllowedChanged);
      this._freeUidsForm.addEventListener(FreeUidsFormEvent.CLICK_ITEM,this.onFreeUidsFormSelectedItem);
      this._freeUidsForm.addEventListener(FreeUidsFormEvent.FOCUS_OUT,this.onFreeUidsFormFocusOut);
      this._callsignInput.textField.addEventListener(FocusEvent.FOCUS_IN,this.onCallsignFocusIn);
      this._acceptRulesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onCheckRulesChanged);
    }

    private function onHaveAccountClick(param1:TextEvent) : void {
      if(param1.text == "haveAcc") {
        dispatchEvent(new PartnersEvent(PartnersEvent.START_LOGIN));
      }
    }

    private function removeEvent() : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.removeEventListener(Event.RESIZE,this.alignYourself);
      this._callsignInput.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onCallsignChanged);
      this._callsignInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.onPlayClickedKey);
      this._continueButton.removeEventListener(MouseEvent.CLICK,this.onRegisterButtonClick);
      this._haveAccountLabel.removeEventListener(TextEvent.LINK,this.onHaveAccountClick);
      this._rulesButton.removeEventListener(TextEvent.LINK,this.onRules);
      this._checkCallsignTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onCallsignCheckTimerComplete);
      this._checkSymbolAllowedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSymbolAllowedChanged);
      this._freeUidsForm.removeEventListener(FreeUidsFormEvent.CLICK_ITEM,this.onFreeUidsFormSelectedItem);
      this._freeUidsForm.removeEventListener(FreeUidsFormEvent.FOCUS_OUT,this.onFreeUidsFormFocusOut);
      this._callsignInput.textField.removeEventListener(FocusEvent.FOCUS_IN,this.onCallsignFocusIn);
      this._acceptRulesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onCheckRulesChanged);
    }

    private function onRemoveFromStage(param1:Event) : void {
      this._checkCallsignTimer.stop();
      this._checkSymbolAllowedTimer.stop();
      this.removeEvent();
    }

    private function onCallsignChanged(param1:LoginFormEvent = null) : void {
      this._callsignValidated = false;
      this._callsignInput.validValue = true;
      this._nameIsIncorrectBubble.hide();
      this._nameIsNotUniqueBubble.hide();
      this._symbolIsNotAllowedBubble.hide();
      this._callSignCheckIcon.turnOff();
      this._isFreeUidsFormAlreadyShowed = false;
      this.hideFreeUidsForm();
      this._checkCallsignTimer.reset();
      this._checkCallsignTimer.start();
      var local2:String = this._callsignInput.value;
      if(!validateService.isValidIdentificationStringForRegistration(local2)) {
        this._checkSymbolAllowedTimer.reset();
        this._checkSymbolAllowedTimer.start();
        registrationUXService.logCountableFormAction(RegistrationUXFormAction.FORBIDDEN_CHARACTERS_TYPED,validateService.getForbiddenCharactersCountForRegistration(local2));
        registrationUXService.logCountableFormAction(RegistrationUXFormAction.FORBIDDEN_LETTERS_TYPED,validateService.getForbiddenLettersCountForRegistration(local2));
        this._callsignInput.value = local2.replace(ValidateService.NOT_ALLOWED_PATTERN_FOR_REGISTRATION,"");
        this.alertAboutSymbolIsNotAllowed();
      }
      this.togglePlayButton();
    }

    private function onCheckRulesChanged(param1:CheckBoxEvent) : void {
      if(this._acceptRulesCheckBox.checked) {
        registrationUXService.logFormAction(RegistrationUXFormAction.USER_AGREEMENT_ACCEPTED);
      }
      this.togglePlayButton();
    }

    private function togglePlayButton() : void {
      this._continueButton.enable = this._callsignValidated && this._acceptRulesCheckBox.checked;
    }

    private function alertAboutSymbolIsNotAllowed() : void {
      this._callsignInput.validValue = false;
      this._callSignCheckIcon.markAsInvalid();
      this._window.addChild(this._symbolIsNotAllowedBubble);
      registrationUXService.logFormAction(RegistrationUXFormAction.FORBIDDEN_USERNAME_TYPED);
    }

    public function alertAboutFreeUid() : void {
      registrationUXService.logFormAction(RegistrationUXFormAction.CORRECT_USERNAME_TYPED);
      this._callsignInput.validValue = true;
      this._callsignValidated = true;
      this._callSignCheckIcon.markAsValid();
      this.togglePlayButton();
    }

    public function alertAboutBusyUid(param1:Vector.<String>) : void {
      registrationUXService.logFormAction(RegistrationUXFormAction.BUSY_USERNAME_TYPED);
      this._symbolIsNotAllowedBubble.hide();
      this._callsignInput.validValue = false;
      this._callSignCheckIcon.markAsInvalid();
      this._callSignCheckIcon.addChild(this._nameIsNotUniqueBubble);
      this._nameIsNotUniqueBubble.visible = true;
      if(param1.length != 0) {
        this._isFreeUidsFormAlreadyShowed = true;
        this._nameIsNotUniqueBubble.visible = false;
        this._freeUidsForm.create(param1);
      }
      this.togglePlayButton();
    }

    public function alertAboutIncorrectUid() : void {
      registrationUXService.logFormAction(RegistrationUXFormAction.FORBIDDEN_USERNAME_TYPED);
      this._symbolIsNotAllowedBubble.hide();
      this._callsignInput.validValue = false;
      this._callSignCheckIcon.markAsInvalid();
      this._callSignCheckIcon.addChild(this._nameIsIncorrectBubble);
      this.togglePlayButton();
    }

    private function onPlayClickedKey(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER && this._continueButton.enable) {
        this.onRegisterButtonClick();
      }
    }

    private function onCallsignCheckTimerComplete(param1:TimerEvent) : void {
      if(validateService.isUidValid(this._callsignInput.value)) {
        this._callSignCheckIcon.startProgress();
        dispatchEvent(new CheckCallsignEvent(this.callsign));
      } else {
        this._callsignInput.validValue = true;
        this._callSignCheckIcon.turnOff();
        if(this._callsignInput.value.length != 0) {
          this.alertAboutIncorrectUid();
        }
      }
    }

    private function onSymbolAllowedChanged(param1:TimerEvent) : void {
      this._symbolIsNotAllowedBubble.hide();
    }

    private function onFreeUidsFormSelectedItem(param1:FreeUidsFormEvent) : void {
      registrationUXService.logFormAction(RegistrationUXFormAction.USERNAME_OFFER_ACCEPTED);
      this.callsign = param1.uid;
      this.hideFreeUidsForm();
    }

    private function onFreeUidsFormFocusOut(param1:FreeUidsFormEvent) : void {
      this.hideFreeUidsForm();
    }

    private function hideFreeUidsForm() : void {
      this._freeUidsForm.hide();
      this._nameIsNotUniqueBubble.visible = true;
    }

    private function onCallsignFocusIn(param1:FocusEvent) : void {
      if(this._isFreeUidsFormAlreadyShowed) {
        this._nameIsNotUniqueBubble.visible = false;
        this._freeUidsForm.show();
      }
    }

    private function onRegisterButtonClick(param1:MouseEvent = null) : void {
      this._continueButton.enable = false;
      dispatchEvent(new FinishPartnerRegisterEvent(this.callsign));
    }

    private function onRules(param1:TextEvent) : void {
      var local2:ViewText = new ViewText();
      this.entranceView.addChild(local2);
      switch(param1.text) {
        case RulesType.RULES:
          local2.text = localeService.getText(TanksLocale.TEXT_GAME_RULES);
          break;
        case RulesType.EULA:
          local2.text = localeService.getText(TanksLocale.TEXT_GAME_TERMS);
          break;
        case RulesType.PRIVACY_POLICY:
          local2.text = localeService.getText(TanksLocale.TEXT_GAME_PRIVACY_POLICY);
          break;
        case RulesType.PARTNER_EULA:
          local2.text = localeService.getText(TanksLocale.TEXT_PARTNER_GAME_TERMS);
      }
    }

    private function alignYourself(param1:Event) : void {
      this.x = int((display.stage.stageWidth - this._windowWidth) / 2);
      this.y = int((display.stage.stageHeight - this._window.height) / 2);
      if(Boolean(this._backgroundImage)) {
        graphics.clear();
        graphics.beginFill(0);
        graphics.drawRect(-this.x,-this.y,display.stage.width,display.stage.height);
        graphics.endFill();
        this._backgroundImage.x = int(this._windowWidth - this._backgroundImage.width >> 1);
        this._backgroundImage.y = -int(display.stage.stageHeight - this._window.height >> 1);
      }
    }

    public function get callsign() : String {
      return this._callsignInput.textField.text;
    }

    public function set callsign(param1:String) : void {
      this._callsignInput.value = param1;
      display.stage.focus = this._callsignInput.textField;
      if(param1.length != 0) {
        this.onCallsignChanged();
        this._callsignInput.textField.setSelection(param1.length,param1.length);
      }
    }
  }
}
