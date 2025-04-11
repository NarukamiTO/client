package alternativa.tanks.gui.settings.tabs.account {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.icons.SocialNetworkIcon;
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.gui.settings.tabs.*;
  import alternativa.tanks.gui.shop.components.window.ShopWindowCountrySelector;
  import alternativa.tanks.service.socialnetwork.ISocialNetworkPanelService;
  import alternativa.tanks.service.socialnetwork.SocialNetworkServiceEvent;
  import assets.icons.InputCheckIcon;
  import controls.DefaultIconButton;
  import controls.FBButton;
  import controls.GoogleButton;
  import controls.TankWindowInner;
  import controls.VKButton;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInput;
  import controls.containers.HorizontalStackPanel;
  import controls.containers.VerticalStackPanel;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.system.Capabilities;
  import flash.text.AntiAliasType;
  import forms.events.LoginFormEvent;
  import forms.registration.CallsignIconStates;
  import forms.registration.bubbles.EmailInvalidBubble;
  import forms.registration.bubbles.PasswordIsTooEasyBubble;
  import forms.registration.bubbles.PasswordsDoNotMatchBubble;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaSection;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;

  public class AccountSettingsTab extends SettingsTabView {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var partnersService:IPartnerService;

    [Inject]
    public static var socialNetworkService:ISocialNetworkPanelService;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var helperService:IHelpService;

    private static const HELPER_GROUP_KEY:String = "ChangeHelpers";
    private static const PASSWORD_IS_TOO_EASY:int = 3;
    private static const PASSWORDS_DO_NOT_MATCH:int = 4;
    private static const ERROR_EMAIL_INVALID:int = 5;
    private static const CHECK_ICON_OFFSET:int = 7;
    private static const INPUT_HEIGHT:int = 30;

    private static const forbiddenPasswords:Array = ["1234567890","123456789","12345678","1234567","123456","12345","1234","0123","01234","012345","0123456","01234567","012345678","0123456789","9876","98765","987654","9876543","98765432","987654321","9876543210","8765","87654","876543","8765432","87654321","876543210","7654","76543","765432","7654321","76543210","6543","65432","654321","6543210","5432","54321","543210","4321","43210","3210","1111","2222","3333","4444","5555","6666","7777","8888","9999","0000","11111","22222","33333","44444","55555","66666","77777","88888","99999","00000","111111","222222","333333","444444","555555","666666","777777","888888","999999","000000","1111111","2222222","3333333","4444444","5555555","6666666","7777777","8888888","9999999","0000000","11111111","22222222","33333333","44444444","55555555","66666666","77777777","88888888","99999999","00000000","111111111","222222222","333333333","444444444","555555555","666666666","777777777","888888888","999999999","000000000"
    ,"abcd","Jack","1234","snoopy","suzy","spike","1012","1234","pepper ","shelby","12345 ","54321 ","pass ","wolf","john","qqqq","aaaa","ZZZz","asdf","zxcv","asdf","zxcv","asdfgh","zxcvbn","1111","!!!!","4321","$#@!","1234","!@#$","12345","!@#$%","123456","!@#$%^","abcd","ABCD","qwerty1","QWERTY!","1q2w3e4r","1q2w3e","q1w2e3","q1w2e3r4","qweasd","QWEASD","asdzxc","ASDZXC","qweqwe","QWEQWE","asdasd","ASDASD","zxczxc","qwaszx","elite","ELITE","1qwerty","!QWERTY","black","blue","green","grey","yellow","orange","brown","support","Support","Topgun","topgun","help","Lame","hack","hunter","ranger","lamer","Lamer","hacker","Hacker","hack","summer","spring","autumn","winter","sunday","monday","tuesday","wednesda","thursday","friday","saturday","january","february","march","april","june","july","august","september","october","november","december","cool","lucky","korn ","fuck","Honda","mustang","pentium","mouse","stan","soccer","password","diablo","zoom","joker","nofear","unix","home","apache","holly"
    ,"q3rulez","pass123","magnum","mother","father","lisa","janet","helen","chocolate","Matrix","Gold","dollar","pussy","eminem","personal","zippo","jennifer","pepsi","clock","time","good","super","friend","angel","qwer","qwert","qwerty","homer","angle","johan","love","test","1q2w3e4r5t6y","31337","loll","gggg"];
    private static const VKONTAKTE:String = "vkontakte";
    private static const FACEBOOK:String = "facebook";
    private static const GOOGLE:String = "google";

    private var pass1:TankInput;
    private var pass2:TankInput;
    private var emailInput:TankInput;
    private var realNameInput:TankInput;
    private var idNumberInput:TankInput;
    private var setEmailButton:DefaultButtonBase;
    private var pass1CheckIcon:InputCheckIcon;
    private var pass2CheckIcon:InputCheckIcon;
    private var emailCheckIcon:InputCheckIcon;
    private var passwordIsTooEasyBubble:PasswordIsTooEasyBubble;
    private var passwordsDoNotMatchBubble:PasswordsDoNotMatchBubble;
    private var errorEmailInvalodBubble:EmailInvalidBubble;
    private var changePasswordOnEmailButton:DefaultButtonBase;
    private var multiSNMode:Boolean;
    private var snButton:DefaultIconButton;
    private var snHasLinkLabel:LabelBase;
    private var vkButton:DefaultButtonBase;
    private var fbButton:DefaultButtonBase;
    private var googleButton:DefaultButtonBase;
    private var fbIcon:Bitmap;
    private var vkIcon:Bitmap;
    private var googleIcon:Bitmap;

    public var emailConfirmed:Boolean = false;
    public var initialRealName:String;
    public var initialIDNumber:String;

    private var saveAntiAddictionInfoButton:DefaultButtonBase;
    private var currentSN:String;
    private var oldPassword:TankInput;
    private var oldPasswordLabel:LabelBase;
    private var oldPasswordCheckIcon:InputCheckIcon;
    private var changePasswordButton:DefaultButtonBase;
    private var captchaSection:CaptchaSection;

    public function AccountSettingsTab(param1:String, param2:Boolean, param3:Boolean, param4:String, param5:String) {
      super();
      this.initialRealName = param4;
      this.initialIDNumber = param5;
      this.emailConfirmed = param2;
      var local6:VerticalStackPanel = new VerticalStackPanel();
      local6.setMargin(MARGIN);
      addChild(this.createCountrySelector());
      local6.y = 3 * MARGIN + INPUT_HEIGHT;
      if(!partnersService.isRunningInsidePartnerEnvironment()) {
        if(param2) {
          local6.addItem(this.createPanelChangePasswordOnEmail());
        } else {
          local6.addItem(this.createPasswordAndEmailPanel(param1));
          this.initEvents();
          this.createBubbles();
        }
      }
      if(Boolean(socialNetworkService.snEnabledInCurrentLocale(FACEBOOK)) || Boolean(socialNetworkService.snEnabledInCurrentLocale(VKONTAKTE)) || Boolean(socialNetworkService.snEnabledInCurrentLocale(GOOGLE))) {
        local6.addItem(this.createSNPanel());
      }
      if(param3) {
        local6.addItem(this.createAntiAddictionPanel(param1,param5,param4));
      }
      addChildAt(local6,0);
    }

    private static function restoreInput(param1:Event) : void {
      var local2:TankInput = param1.currentTarget as TankInput;
      local2.validValue = true;
    }

    private static function isPasswordValid(param1:String) : Boolean {
      return param1 == "" || param1.length >= 4 && forbiddenPasswords.indexOf(param1.toLowerCase()) == -1;
    }

    private static function trimString(param1:String) : String {
      if(Boolean(param1)) {
        return param1.replace(/^\s+|\s+$/g,"");
      }
      return param1;
    }

    private function createAntiAddictionPanel(param1:String, param2:String, param3:String) : DisplayObject {
      var local7:LabelBase = null;
      var local4:VerticalStackPanel = new VerticalStackPanel();
      local4.setMargin(MARGIN_AFTER_PARTITION_LABEL);
      var local5:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,0,TankWindowInner.TRANSPARENT);
      var local6:LabelBase = new LabelBase();
      local6.antiAliasType = AntiAliasType.ADVANCED;
      local6.sharpness = -100;
      local6.thickness = 100;
      local6.text = "防沉迷验证登记";
      local5.addChild(local6);
      local4.addItem(local6);
      local7 = new LabelBase();
      local5.addChild(local7);
      local7.text = "您的真实姓名:";
      local7.x = MARGIN;
      this.realNameInput = new TankInput();
      local5.addChild(this.realNameInput);
      this.realNameInput.width = local5.width - MARGIN * 3 - local7.textWidth - 4;
      this.realNameInput.x = local7.x + local7.width + MARGIN;
      this.realNameInput.y = local5.y + MARGIN;
      local7.y = this.realNameInput.y + Math.round((this.realNameInput.height - local7.textHeight) * 0.5) - 2;
      var local8:LabelBase = new LabelBase();
      local5.addChild(local8);
      local8.text = "身份证号码:";
      local8.x = MARGIN;
      local8.y = this.realNameInput.y + this.realNameInput.height + MARGIN + 6;
      this.idNumberInput = new TankInput();
      local5.addChild(this.idNumberInput);
      this.idNumberInput.textField.text = param1;
      this.idNumberInput.x = this.realNameInput.x;
      this.idNumberInput.y = this.realNameInput.y + this.realNameInput.height + MARGIN;
      this.idNumberInput.width = this.realNameInput.width;
      this.idNumberInput.textField.text = param2 != null && param2 != "null" ? param2 : "";
      this.realNameInput.textField.text = param3 != null && param3 != "null" ? param3 : "";
      this.idNumberInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.validateAddictionID);
      this.realNameInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.validateRealName);
      this.saveAntiAddictionInfoButton = new DefaultButtonBase();
      this.saveAntiAddictionInfoButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_SAVE_TEXT);
      this.saveAntiAddictionInfoButton.addEventListener(MouseEvent.CLICK,this.onClickSaveAntiAddictionInfo);
      local5.height = MARGIN * 4 + 2 * this.realNameInput.height + this.saveAntiAddictionInfoButton.height;
      this.saveAntiAddictionInfoButton.x = SettingsWindow.TAB_VIEW_MAX_WIDTH - MARGIN - this.saveAntiAddictionInfoButton.width;
      this.saveAntiAddictionInfoButton.y = 3 * MARGIN + 2 * this.realNameInput.height;
      local5.addChild(this.saveAntiAddictionInfoButton);
      local4.addItem(local5);
      return local4;
    }

    private function createPanelChangePasswordOnEmail() : TankWindowInner {
      var local1:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,2 * MARGIN + INPUT_HEIGHT,TankWindowInner.TRANSPARENT);
      this.changePasswordOnEmailButton = new DefaultButtonBase();
      this.changePasswordOnEmailButton.width = 210;
      this.changePasswordOnEmailButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_CHANGE_PASSWORD_TEXT);
      this.changePasswordOnEmailButton.x = (SettingsWindow.TAB_VIEW_MAX_WIDTH - this.changePasswordOnEmailButton.width) / 2;
      this.changePasswordOnEmailButton.y = MARGIN;
      this.changePasswordOnEmailButton.addEventListener(MouseEvent.CLICK,this.onClickChangePasswordOnEmail);
      local1.addChild(this.changePasswordOnEmailButton);
      this.createCaptcha(local1);
      return local1;
    }

    private function createPasswordAndEmailPanel(param1:String) : TankWindowInner {
      var local2:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,INPUT_HEIGHT * 3 + 4 * MARGIN,TankWindowInner.TRANSPARENT);
      this.oldPasswordLabel = this.createLabel(localeService.getText(TanksLocale.TEXT_CURRENT_PASSWORD));
      var local3:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_SETTINGS_NEW_PASSWORD_LABEL_TEXT));
      var local4:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_SETTINGS_REENTER_PASSWORD_LABEL_TEXT));
      var local5:int = (SettingsWindow.TAB_VIEW_MAX_WIDTH - this.oldPasswordLabel.width - local3.width - local4.width - 7 * MARGIN) / 3 + 1;
      this.oldPassword = new TankInput();
      this.oldPassword.hidden = true;
      this.oldPassword.width = local5;
      this.oldPassword.maxChars = 20;
      this.oldPassword.validValue = true;
      this.pass1 = new TankInput();
      this.pass1.hidden = true;
      this.pass1.width = local5;
      this.pass1.maxChars = 20;
      this.pass1.validValue = true;
      this.oldPassword.height = this.pass1.height;
      this.pass2 = new TankInput();
      this.pass2.hidden = true;
      this.pass2.width = local5;
      this.pass2.maxChars = 20;
      this.pass2.validValue = true;
      this.oldPasswordLabel.x = MARGIN;
      this.oldPasswordLabel.y = MARGIN + (INPUT_HEIGHT - this.oldPasswordLabel.height) / 2;
      this.oldPassword.x = this.oldPasswordLabel.x + this.oldPasswordLabel.width + MARGIN;
      this.oldPassword.y = MARGIN;
      local3.x = this.oldPassword.x + this.oldPassword.width + MARGIN;
      local3.y = this.oldPasswordLabel.y;
      this.pass1.x = local3.x + local3.width + MARGIN;
      this.pass1.y = MARGIN;
      local4.x = this.pass1.x + this.pass1.width + MARGIN;
      local4.y = this.oldPasswordLabel.y;
      this.pass2.x = local4.x + local4.width + MARGIN;
      this.pass2.y = MARGIN;
      local2.addChild(this.oldPasswordLabel);
      local2.addChild(this.oldPassword);
      local2.addChild(local3);
      local2.addChild(this.pass1);
      local2.addChild(local4);
      local2.addChild(this.pass2);
      this.changePasswordButton = new DefaultButtonBase();
      this.changePasswordButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_CHANGE_PASSWORD_BUTTON);
      this.changePasswordButton.addEventListener(MouseEvent.CLICK,this.onClickChangePassword);
      this.changePasswordButton.x = SettingsWindow.TAB_VIEW_MAX_WIDTH - MARGIN - this.changePasswordButton.width;
      this.changePasswordButton.y = 2 * MARGIN + INPUT_HEIGHT;
      local2.addChild(this.changePasswordButton);
      this.oldPasswordCheckIcon = new InputCheckIcon();
      this.oldPasswordCheckIcon.x = this.oldPassword.x + local5 - this.oldPasswordCheckIcon.width / 2 - CHECK_ICON_OFFSET * 2;
      this.oldPasswordCheckIcon.y = this.oldPassword.y + CHECK_ICON_OFFSET;
      this.oldPasswordCheckIcon.visible = false;
      this.oldPasswordCheckIcon.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_INVALID);
      this.pass1CheckIcon = new InputCheckIcon();
      this.pass2CheckIcon = new InputCheckIcon();
      this.pass1CheckIcon.x = this.pass1.x + local5 - this.pass1CheckIcon.width / 2 - CHECK_ICON_OFFSET * 2;
      this.pass1CheckIcon.y = this.pass1.y + MARGIN;
      this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
      this.pass2CheckIcon.x = this.pass2.x + local5 - this.pass2CheckIcon.width / 2 - CHECK_ICON_OFFSET * 2;
      this.pass2CheckIcon.y = this.pass2.y + MARGIN;
      this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
      local2.addChild(this.oldPasswordCheckIcon);
      local2.addChild(this.pass1CheckIcon);
      local2.addChild(this.pass2CheckIcon);
      var local6:DisplayObject = this.createSetEmailPanel(param1);
      local6.height = INPUT_HEIGHT;
      local6.x = MARGIN;
      local6.y = INPUT_HEIGHT + this.changePasswordButton.height + 3 * MARGIN;
      local2.addChild(local6);
      this.emailCheckIcon = new InputCheckIcon();
      this.emailCheckIcon.x = this.emailInput.x + this.emailInput.width - this.emailCheckIcon.width / 2 - CHECK_ICON_OFFSET;
      this.emailCheckIcon.y = local6.y + CHECK_ICON_OFFSET;
      this.emailState = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
      local2.addChild(this.emailCheckIcon);
      this.createCaptcha(local2);
      return local2;
    }

    private function createCaptcha(param1:TankWindowInner) : void {
      var container:TankWindowInner = param1;
      this.captchaSection = new CaptchaSection();
      this.captchaSection.manualInitialize();
      this.captchaSection.refreshButton.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void {
        dispatchEvent(new RefreshCaptchaClickedEvent());
      });
      this.captchaSection.x = (container.width - this.captchaSection.width) / 2;
      this.captchaSection.y = MARGIN + container.height;
      this.captchaSection.visible = true;
      container.height += this.captchaSection.height + 2 * MARGIN;
      container.addChild(this.captchaSection);
      dispatchEvent(new RefreshCaptchaClickedEvent());
    }

    public function setCaptchaImage(param1:Bitmap) : void {
      if(Boolean(this.captchaSection)) {
        this.captchaSection.captcha = param1;
      }
    }

    public function getCaptchaAnswer() : String {
      if(Boolean(this.captchaSection)) {
        return this.captchaSection.captchaAnswer.value;
      }
      return "";
    }

    private function createCountrySelector() : TankWindowInner {
      var local1:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,INPUT_HEIGHT + 2 * MARGIN,TankWindowInner.TRANSPARENT);
      var local2:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_CHECK_YOU_LOCATION_TEXT));
      var local3:ShopWindowCountrySelector = new ShopWindowCountrySelector(false);
      var local4:int = local2.width + MARGIN + local3.width;
      local2.x = int(SettingsWindow.TAB_VIEW_MAX_WIDTH / 2 - local4 / 2);
      local2.y += MARGIN;
      local3.y = MARGIN;
      local3.x = local2.x + local2.width + MARGIN;
      local1.addChild(local2);
      local1.addChild(local3);
      local1.height = INPUT_HEIGHT + 2 * MARGIN;
      return local1;
    }

    private function needAdditionalCorrection() : Boolean {
      var local1:String = Capabilities.os;
      return local1.indexOf("Windows") >= 0 || local1.indexOf("Mac") >= 0;
    }

    private function createSetEmailPanel(param1:String) : DisplayObject {
      var local2:HorizontalStackPanel = new HorizontalStackPanel();
      local2.setMargin(MARGIN);
      var local3:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_SETTINGS_EMAIL_LABEL_TEXT));
      this.setEmailButton = new DefaultButtonBase();
      this.setEmailButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_LINK_EMAIL_BUTTON);
      this.setEmailButton.addEventListener(MouseEvent.CLICK,this.onClickSetEmailButton);
      this.emailInput = new TankInput();
      this.emailInput.value = param1;
      this.emailInput.validValue = true;
      this.emailInput.width = SettingsWindow.TAB_VIEW_MAX_WIDTH - 4 * MARGIN - local3.width - this.setEmailButton.width;
      if(localeService.language == LocaleServiceLangValues.CN) {
        this.emailInput.width += 3;
        if(this.needAdditionalCorrection()) {
          this.emailInput.width -= 4;
        }
      }
      local2.addItem(local3);
      local2.addItem(this.emailInput);
      local2.addItem(this.setEmailButton);
      return local2;
    }

    private function createLabel(param1:String) : LabelBase {
      var local2:LabelBase = new LabelBase();
      local2.text = param1;
      local2.y = Math.round((INPUT_HEIGHT - local2.textHeight) * 0.5) - 2;
      return local2;
    }

    private function onClickSaveAntiAddictionInfo(param1:MouseEvent) : void {
      if(this.realName != "" && this.idNumber != "") {
        dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.SET_ANTI_ADDICTION));
      }
    }

    private function onClickSetEmailButton(param1:MouseEvent) : void {
      if(!this.emailConfirmed && this.email != null) {
        dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.SET_EMAIL));
      }
    }

    private function onClickChangePassword(param1:MouseEvent = null) : void {
      if(this.emailConfirmed || !this.oldPassword.visible || this.getOldPassword() == "" && this.password == "") {
        dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.CHANGE_PASSWORD));
      } else {
        dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.CHECK_PASSWORD));
      }
    }

    override public function show() : void {
      display.stage.addEventListener(Event.RESIZE,this.onResizeStage);
      this.onResizeStage();
      this.showHelpers();
    }

    override public function hide() : void {
      this.hideHelpers();
      display.stage.removeEventListener(Event.RESIZE,this.onResizeStage);
    }

    private function hideHelpers() : void {
      helperService.hideHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY);
      helperService.hideHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH);
      helperService.hideHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID);
    }

    private function showHelpers() : void {
      if(this.emailInput != null) {
        this.updateEmailInput();
      }
      if(!this.emailConfirmed && this.pass1 != null) {
        this.updatePasswordBlock();
      }
    }

    private function updateEmailInput(param1:Event = null) : void {
      if(Boolean(partnersService.isRunningInsidePartnerEnvironment()) || this.emailConfirmed) {
        return;
      }
      var local2:Boolean = true;
      if(this.emailInput.value.length > 0) {
        local2 = Boolean(validateService.isEmailValid(this.emailInput.value));
      }
      if(!local2) {
        helperService.showHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID,true);
      } else {
        helperService.hideHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID);
      }
      if(local2) {
        this.emailInput.validValue = true;
        this.emailState = this.emailInput.value == "" ? CallsignIconStates.CALLSIGN_ICON_STATE_OFF : CallsignIconStates.CALLSIGN_ICON_STATE_VALID;
      } else {
        this.emailInput.validValue = false;
        this.emailState = CallsignIconStates.CALLSIGN_ICON_STATE_INVALID;
      }
      this.setEmailButton.enable = local2;
    }

    private function updatePasswordBlock(param1:Event = null) : void {
      if(Boolean(partnersService.isRunningInsidePartnerEnvironment()) || this.emailConfirmed) {
        return;
      }
      this.pass1.validValue = isPasswordValid(this.pass1.value);
      this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_INVALID;
      var local2:Boolean = true;
      this.pass2.validValue = this.pass2.value == "" || this.pass1.value == this.pass2.value;
      this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_INVALID;
      if(this.pass1.value == "") {
        this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
        local2 = false;
      } else if(this.pass1.validValue) {
        this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_VALID;
        local2 = false;
      }
      if(this.pass2.value == "") {
        this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
      } else if(this.pass2.validValue) {
        this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_VALID;
      }
      var local3:Boolean = !(local2 || this.pass2.validValue);
      if(local2) {
        helperService.showHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY,true);
      } else {
        helperService.hideHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY);
      }
      if(local3) {
        helperService.showHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH,true);
      } else {
        helperService.hideHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH);
      }
      this.changePasswordButton.enable = this.pass1.value == this.pass2.value && this.pass1.validValue && this.pass2.validValue;
    }

    private function createSNPanel() : TankWindowInner {
      var local3:LabelBase = null;
      var local4:Boolean = false;
      var local1:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,0,TankWindowInner.TRANSPARENT);
      this.multiSNMode = this.getEnabledSocialNetworks().length > 1;
      var local2:Sprite = new Sprite();
      if(this.multiSNMode) {
        local3 = new LabelBase();
        local3.text = localeService.getText(TanksLocale.TEXT_SETTINGS_ACCOUNT_ACCESS);
        local3.y = 5;
        local2.addChild(local3);
        this.vkIcon = SocialNetworkIcon.createVk();
        this.fbIcon = SocialNetworkIcon.createFb();
        this.googleIcon = SocialNetworkIcon.createGoogle();
        this.vkButton = new DefaultButtonBase();
        this.fbButton = new DefaultButtonBase();
        this.googleButton = new DefaultButtonBase();
        this.vkIcon.y = local3.y + local3.height + MARGIN;
        local2.addChild(this.vkIcon);
        this.vkButton.label = this.getLinkUnlinkText(VKONTAKTE);
        this.vkButton.width = 120;
        this.vkButton.y = local3.y + local3.height + MARGIN;
        this.vkButton.x = this.vkIcon.x + this.vkIcon.width + MARGIN;
        local2.addChild(this.vkButton);
        this.fbIcon.x = this.vkButton.x + this.vkButton.width + 5 * MARGIN;
        this.fbIcon.y = local3.y + local3.height + MARGIN;
        local2.addChild(this.fbIcon);
        this.fbButton.label = this.getLinkUnlinkText(FACEBOOK);
        this.fbButton.width = 120;
        this.fbButton.y = local3.y + local3.height + MARGIN;
        this.fbButton.x = this.fbIcon.x + this.fbIcon.width + MARGIN;
        local2.addChild(this.fbButton);
        if(socialNetworkService.snLinkExists(GOOGLE)) {
          this.googleIcon.x = this.fbButton.x + this.fbButton.width + 5 * MARGIN;
          this.googleIcon.y = local3.y + local3.height + MARGIN;
          local2.addChild(this.googleIcon);
          this.googleButton.label = this.getLinkUnlinkText(GOOGLE);
          this.googleButton.width = 120;
          this.googleButton.y = local3.y + local3.height + MARGIN;
          this.googleButton.x = this.googleIcon.x + this.googleIcon.width + MARGIN;
          local2.addChild(this.googleButton);
        }
        local3.x = (local2.width - local3.width) / 2;
        this.vkButton.addEventListener(MouseEvent.CLICK,this.onVkChangeStateClick);
        this.fbButton.addEventListener(MouseEvent.CLICK,this.onFbChangeStateClick);
        this.googleButton.addEventListener(MouseEvent.CLICK,this.onGoogleChangeStateClick);
      } else {
        this.currentSN = this.getEnabledSocialNetworks()[0];
        local4 = Boolean(socialNetworkService.snLinkExists(this.currentSN));
        this.snHasLinkLabel = new LabelBase();
        this.snHasLinkLabel.text = local4 ? localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK_ACCOUNT) : localeService.getText(TanksLocale.TEXT_SETTINGS_LINK_ACCOUNT);
        local2.addChild(this.snHasLinkLabel);
        this.snButton = this.getSocialNetworkButton(this.currentSN);
        this.snButton.width = 102;
        this.snButton.x = this.snHasLinkLabel.x + this.snHasLinkLabel.width + 5;
        this.snHasLinkLabel.y = this.snButton.y + 7;
        local2.addChild(this.snButton);
        local2.y = MARGIN;
        this.snButton.addEventListener(MouseEvent.CLICK,this.onChangeLinkStateClick);
      }
      local2.x = (SettingsWindow.TAB_VIEW_MAX_WIDTH - local2.width) / 2;
      local1.height = local2.height + 2 * MARGIN;
      local1.addChild(local2);
      socialNetworkService.addEventListener(SocialNetworkServiceEvent.UNLINK_SUCCESS,this.onUnlinkSuccess);
      socialNetworkService.addEventListener(SocialNetworkServiceEvent.LINK_SUCCESS,this.onLinkSuccess);
      return local1;
    }

    private function getLinkUnlinkText(param1:String) : String {
      return !!socialNetworkService.snLinkExists(param1) ? localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK) : localeService.getText(TanksLocale.TEXT_SETTINGS_LINK);
    }

    private function getEnabledSocialNetworks() : Array {
      var local1:Array = [];
      if(socialNetworkService.snEnabledInCurrentLocale(VKONTAKTE)) {
        local1.push(VKONTAKTE);
      }
      if(socialNetworkService.snEnabledInCurrentLocale(FACEBOOK)) {
        local1.push(FACEBOOK);
      }
      if(socialNetworkService.snEnabledInCurrentLocale(GOOGLE)) {
        local1.push(GOOGLE);
      }
      return local1;
    }

    private function getSocialNetworkButton(param1:String) : DefaultIconButton {
      if(param1 == VKONTAKTE) {
        return new VKButton();
      }
      if(param1 == FACEBOOK) {
        return new FBButton();
      }
      if(param1 == GOOGLE) {
        return new GoogleButton();
      }
      return null;
    }

    private function onLinkSuccess(param1:SocialNetworkServiceEvent) : void {
      if(this.multiSNMode) {
        this.changeButtonText(param1.socialNetworkId,true);
      } else {
        this.snHasLinkLabel.text = localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK_ACCOUNT);
        this.snButton.x = this.snHasLinkLabel.x + this.snHasLinkLabel.width + 5;
      }
    }

    private function onUnlinkSuccess(param1:SocialNetworkServiceEvent) : void {
      if(this.multiSNMode) {
        this.changeButtonText(param1.socialNetworkId,false);
      } else if(param1.socialNetworkId == GOOGLE) {
        this.snButton.visible = false;
        this.snHasLinkLabel.visible = false;
      } else {
        this.snHasLinkLabel.text = localeService.getText(TanksLocale.TEXT_SETTINGS_LINK_ACCOUNT);
        this.snButton.x = this.snHasLinkLabel.x + this.snHasLinkLabel.width + 5;
      }
    }

    private function changeButtonText(param1:String, param2:Boolean) : void {
      if(param1 == GOOGLE) {
        this.googleIcon.visible = false;
        this.googleButton.visible = false;
      } else if(param1 == VKONTAKTE) {
        this.vkButton.label = localeService.getText(param2 ? TanksLocale.TEXT_SETTINGS_UNLINK : TanksLocale.TEXT_SETTINGS_LINK);
      } else {
        this.fbButton.label = localeService.getText(param2 ? TanksLocale.TEXT_SETTINGS_UNLINK : TanksLocale.TEXT_SETTINGS_LINK);
      }
    }

    private function onChangeLinkStateClick(param1:MouseEvent) : void {
      this.changeSocialNetworkState(this.currentSN);
    }

    private function onVkChangeStateClick(param1:MouseEvent) : void {
      this.changeSocialNetworkState(VKONTAKTE);
    }

    private function onFbChangeStateClick(param1:MouseEvent) : void {
      this.changeSocialNetworkState(FACEBOOK);
    }

    private function onGoogleChangeStateClick(param1:MouseEvent) : void {
      this.changeSocialNetworkState(GOOGLE);
    }

    private function changeSocialNetworkState(param1:String) : void {
      if(socialNetworkService.snLinkExists(param1)) {
        socialNetworkService.unlink(param1);
      } else {
        socialNetworkService.createLink(param1);
      }
    }

    private function initEvents() : void {
      this.pass1.addEventListener(FocusEvent.FOCUS_IN,restoreInput);
      this.pass2.addEventListener(FocusEvent.FOCUS_IN,restoreInput);
      this.emailInput.addEventListener(FocusEvent.FOCUS_IN,restoreInput);
      this.pass1.addEventListener(Event.CHANGE,this.updatePasswordBlock);
      this.pass1.addEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
      this.pass2.addEventListener(Event.CHANGE,this.updatePasswordBlock);
      this.pass2.addEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
      this.emailInput.addEventListener(FocusEvent.FOCUS_IN,this.updateEmailInput);
      this.emailInput.addEventListener(Event.CHANGE,this.updateEmailInput);
      this.oldPassword.addEventListener(FocusEvent.FOCUS_IN,this.restoreOldPasswordInput);
      this.oldPassword.addEventListener(Event.CHANGE,this.restoreOldPasswordInput);
    }

    private function validateRealName(param1:LoginFormEvent) : void {
      var local2:String = null;
      if(this.realNameInput != null) {
        local2 = trimString(this.realNameInput.textField.text);
        this.realNameInput.validValue = Boolean(validateService.isChinaNameValid(local2)) || local2.length == 0;
      }
    }

    private function validateAddictionID(param1:LoginFormEvent) : void {
      var local2:String = null;
      if(this.idNumberInput != null) {
        local2 = this.idNumberInput.textField.text;
        this.idNumberInput.validValue = Boolean(validateService.isChinaCardIdValid(local2)) || local2.length == 0;
      }
    }

    private function onClickChangePasswordOnEmail(param1:MouseEvent) : void {
      dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.CHANGE_PASSWORD_BY_EMAIL));
    }

    public function disableChangePasswordPanel() : void {
      this.changePasswordOnEmailButton.enable = false;
      if(Boolean(this.captchaSection)) {
        this.captchaSection.setEnabled(false);
      }
    }

    private function restoreOldPasswordInput(param1:Event) : void {
      this.oldPasswordCheckIcon.visible = false;
      this.oldPassword.validValue = true;
    }

    public function highlightIncorrectOldPassword() : void {
      this.oldPassword.validValue = false;
      this.oldPasswordCheckIcon.visible = true;
    }

    public function hideOldPasswordField() : void {
      this.oldPassword.visible = false;
      this.oldPasswordLabel.visible = false;
    }

    public function set pass1State(param1:int) : void {
      if(param1 == CallsignIconStates.CALLSIGN_ICON_STATE_OFF) {
        this.pass1CheckIcon.visible = false;
      } else {
        this.pass1CheckIcon.visible = true;
        this.pass1CheckIcon.gotoAndStop(param1);
      }
    }

    public function set pass2State(param1:int) : void {
      if(param1 == CallsignIconStates.CALLSIGN_ICON_STATE_OFF) {
        this.pass2CheckIcon.visible = false;
      } else {
        this.pass2CheckIcon.visible = true;
        this.pass2CheckIcon.gotoAndStop(param1);
      }
    }

    public function set emailState(param1:int) : void {
      if(param1 == CallsignIconStates.CALLSIGN_ICON_STATE_OFF) {
        this.emailCheckIcon.visible = false;
      } else {
        this.emailCheckIcon.visible = true;
        this.emailCheckIcon.gotoAndStop(param1);
      }
    }

    private function createBubbles() : void {
      this.passwordIsTooEasyBubble = new PasswordIsTooEasyBubble();
      this.passwordsDoNotMatchBubble = new PasswordsDoNotMatchBubble();
      this.errorEmailInvalodBubble = new EmailInvalidBubble();
      helperService.registerHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY,this.passwordIsTooEasyBubble,false);
      helperService.registerHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH,this.passwordsDoNotMatchBubble,false);
      helperService.registerHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID,this.errorEmailInvalodBubble,false);
    }

    private function onResizeStage(param1:Event = null) : void {
      var local2:int = 0;
      if(parent != null) {
        local2 = INPUT_HEIGHT + 3 * MARGIN;
        if(this.passwordIsTooEasyBubble != null) {
          this.passwordIsTooEasyBubble.targetPoint = new Point(this.pass1CheckIcon.x + this.pass1CheckIcon.width / 2 + this.x + parent.x,local2 + this.pass1CheckIcon.y + this.pass1CheckIcon.height / 2 + this.y + parent.y);
        }
        if(this.passwordsDoNotMatchBubble != null) {
          this.passwordsDoNotMatchBubble.targetPoint = new Point(this.pass2CheckIcon.x + this.pass2CheckIcon.width / 2 + this.x + parent.x,local2 + this.pass2CheckIcon.y + this.pass2CheckIcon.height / 2 + this.y + parent.y);
        }
        if(this.errorEmailInvalodBubble != null) {
          this.errorEmailInvalodBubble.targetPoint = new Point(this.emailCheckIcon.x + this.emailCheckIcon.width / 2 + this.x + parent.x,local2 + this.emailCheckIcon.y + this.emailCheckIcon.height / 2 + this.y + parent.y);
        }
      }
    }

    public function get password() : String {
      var local1:String = "";
      if(!this.emailConfirmed) {
        if(Boolean(this.pass1.textField.text)) {
          if(this.pass1.textField.text == this.pass2.textField.text) {
            local1 = this.pass1.textField.text;
          }
        }
      }
      return local1;
    }

    public function get email() : String {
      if(this.emailConfirmed) {
        return "";
      }
      if(this.emailInput.textField.text.indexOf("*") != -1) {
        return null;
      }
      return this.emailInput.textField.text;
    }

    public function get realName() : String {
      if(this.realNameInput != null && this.realNameInput.textField.text != null && trimString(this.realNameInput.textField.text).length > 0) {
        return this.realNameInput.textField.text;
      }
      return "";
    }

    public function get idNumber() : String {
      if(this.idNumberInput != null && this.idNumberInput.textField.text != null && trimString(this.idNumberInput.textField.text).length > 0) {
        return this.idNumberInput.textField.text;
      }
      return "";
    }

    public function getOldPassword() : String {
      return this.oldPassword != null ? this.oldPassword.value : "";
    }

    override public function destroy() : void {
      if(!this.emailConfirmed) {
        this.changePasswordButton.removeEventListener(MouseEvent.CLICK,this.onClickChangePassword);
        this.setEmailButton.removeEventListener(MouseEvent.CLICK,this.onClickSetEmailButton);
        this.pass1.removeEventListener(FocusEvent.FOCUS_IN,restoreInput);
        this.pass2.removeEventListener(FocusEvent.FOCUS_IN,restoreInput);
        this.emailInput.removeEventListener(FocusEvent.FOCUS_IN,restoreInput);
        this.pass1.removeEventListener(Event.CHANGE,this.updatePasswordBlock);
        this.pass1.removeEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
        this.pass2.removeEventListener(Event.CHANGE,this.updatePasswordBlock);
        this.pass2.removeEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
        this.emailInput.removeEventListener(FocusEvent.FOCUS_IN,this.updateEmailInput);
        this.emailInput.removeEventListener(Event.CHANGE,this.updateEmailInput);
        this.oldPassword.removeEventListener(FocusEvent.FOCUS_IN,this.restoreOldPasswordInput);
        this.oldPassword.removeEventListener(Event.CHANGE,this.restoreOldPasswordInput);
      }
      if(Boolean(this.saveAntiAddictionInfoButton)) {
        this.saveAntiAddictionInfoButton.removeEventListener(MouseEvent.CLICK,this.onClickSaveAntiAddictionInfo);
      }
      helperService.unregisterHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY);
      helperService.unregisterHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH);
      helperService.unregisterHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID);
      if(!this.emailConfirmed) {
        this.oldPassword.removeEventListener(FocusEvent.FOCUS_IN,this.restoreOldPasswordInput);
        this.oldPassword.removeEventListener(Event.CHANGE,this.restoreOldPasswordInput);
      }
      super.destroy();
    }
  }
}
