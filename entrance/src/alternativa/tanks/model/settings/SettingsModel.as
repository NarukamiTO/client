package alternativa.tanks.model.settings {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.gui.settings.SettingsWindowEvent;
  import alternativa.tanks.gui.settings.tabs.account.AccountSettingsEvent;
  import alternativa.tanks.gui.settings.tabs.account.AccountSettingsTab;
  import alternativa.tanks.gui.settings.tabs.game.ReceivePersonalMessagesSettingEvent;
  import alternativa.tanks.model.antiaddiction.IAntiAddictionAlert;
  import alternativa.tanks.model.useremailandpassword.IUserEmailAndPassword;
  import alternativa.tanks.model.useremailandpassword.PasswordService;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.settings.ISettingsService;
  import flash.display.Bitmap;
  import flash.events.Event;
  import forms.events.MainButtonBarEvents;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.chat.models.chat.users.personalmessagereceiver.PersonalMessageReceiveMode;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.client.panel.model.profile.usersettings.ClientStoredSettings;
  import projects.tanks.client.panel.model.profile.usersettings.ISettingsModelBase;
  import projects.tanks.client.panel.model.profile.usersettings.SettingsModelBase;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaClientFacade;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaParser;
  import projects.tanks.clients.flash.commons.models.captcha.IServerCaptcha;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import services.alertservice.Alert;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class SettingsModel extends SettingsModelBase implements ISettingsModelBase, ObjectLoadPostListener, ObjectUnloadListener, CaptchaClientFacade {
    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var panelView:IPanelView;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleInviteService:IBattleInviteService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var fullscreenService:FullscreenService;

    [Inject]
    public static var passwordService:PasswordService;

    private var settingsWindow:SettingsWindow;
    private var emailConfirmed:Boolean;
    private var receivePersonalMessageOnlyFromFriends:Boolean;

    public function SettingsModel() {
      super();
    }

    public function openAntiAddictionSettings(param1:PersonalMessageReceiveMode, param2:String, param3:String) : void {
      this.openSettingsWindow(param1,true,param2,param3);
    }

    public function openSettings(param1:PersonalMessageReceiveMode) : void {
      this.openSettingsWindow(param1,false,"","");
    }

    private function openSettingsWindow(param1:PersonalMessageReceiveMode, param2:Boolean, param3:String, param4:String) : void {
      this.emailConfirmed = settingsService.isEmailConfirmed();
      if(this.settingsWindow != null) {
        return;
      }
      this.receivePersonalMessageOnlyFromFriends = param1 == PersonalMessageReceiveMode.FRIENDS_ONLY;
      this.settingsWindow = new SettingsWindow(settingsService.getEmail(),this.emailConfirmed,this.receivePersonalMessageOnlyFromFriends,param2,param3,param4);
      if(!this.emailConfirmed) {
        this.settingsWindow.addEventListener(AccountSettingsEvent.SET_EMAIL,getFunctionWrapper(this.onSetEmail));
        this.settingsWindow.addEventListener(AccountSettingsEvent.CHANGE_PASSWORD,getFunctionWrapper(this.callbackCheckPassword));
      }
      this.settingsWindow.addEventListener(SettingsWindowEvent.CLOSE_SETTINGS,getFunctionWrapper(this.onSettingsClose));
      this.settingsWindow.addEventListener(AccountSettingsEvent.CHANGE_PASSWORD_BY_EMAIL,getFunctionWrapper(this.onChangePasswordOnEmail));
      this.settingsWindow.addEventListener(AccountSettingsEvent.CHECK_PASSWORD,getFunctionWrapper(this.onCheckPassword));
      this.settingsWindow.addEventListener(AccountSettingsEvent.SET_ANTI_ADDICTION,getFunctionWrapper(this.onSetAntiAddictionInfo));
      this.settingsWindow.addEventListener(ReceivePersonalMessagesSettingEvent.RECEIVE_PERSONAL_MESSAGES_CHANGE,getFunctionWrapper(this.onChangeReceivePersonalMessageOnlyFromFriends));
      panelView.unlock();
      if(!settingsService.isPasswordSet) {
        passwordService.checkIsPasswordSet(this.callbackIsPasswordSet);
      } else {
        this.settingsWindow.show();
      }
      IServerCaptcha(object.adapt(IServerCaptcha)).bindFacade(this);
      var local5:AccountSettingsTab = this.settingsWindow.getAccountSettings();
      if(Boolean(local5)) {
        local5.addEventListener(RefreshCaptchaClickedEvent.CLICKED,getFunctionWrapper(this.onRefreshCaptcha));
        this.getNewCaptcha();
      }
    }

    private function onCheckPassword(param1:AccountSettingsEvent) : void {
      passwordService.checkPassword(this.settingsWindow.getAccountSettings().getOldPassword(),this.callbackCheckPassword);
    }

    private function onSetAntiAddictionInfo(param1:AccountSettingsEvent) : void {
      var local2:AccountSettingsTab = this.settingsWindow.getAccountSettings();
      if(local2.initialRealName != local2.realName || local2.idNumber != local2.initialIDNumber) {
        IAntiAddictionAlert(object.adapt(IAntiAddictionAlert)).setIdNumberAndRealName(local2.realName,local2.idNumber);
      }
    }

    private function destroySettingsWindow() : void {
      IServerCaptcha(object.adapt(IServerCaptcha)).unbindFacade();
      if(!this.emailConfirmed) {
        this.settingsWindow.removeEventListener(AccountSettingsEvent.SET_EMAIL,getFunctionWrapper(this.onSetEmail));
        this.settingsWindow.removeEventListener(AccountSettingsEvent.CHANGE_PASSWORD,getFunctionWrapper(this.callbackCheckPassword));
      }
      this.settingsWindow.removeEventListener(SettingsWindowEvent.CLOSE_SETTINGS,getFunctionWrapper(this.onSettingsClose));
      this.settingsWindow.removeEventListener(AccountSettingsEvent.CHANGE_PASSWORD_BY_EMAIL,getFunctionWrapper(this.onChangePasswordOnEmail));
      this.settingsWindow.removeEventListener(AccountSettingsEvent.CHECK_PASSWORD,getFunctionWrapper(this.onCheckPassword));
      this.settingsWindow.removeEventListener(ReceivePersonalMessagesSettingEvent.RECEIVE_PERSONAL_MESSAGES_CHANGE,getFunctionWrapper(this.onChangeReceivePersonalMessageOnlyFromFriends));
      this.settingsWindow.removeEventListener(AccountSettingsEvent.SET_ANTI_ADDICTION,getFunctionWrapper(this.onSetAntiAddictionInfo));
      panelView.getPanel().buttonBar.settingsButton.enable = true;
      this.uploadSettingsToServer();
      this.settingsWindow.destroy();
      this.settingsWindow = null;
    }

    private function onChangePasswordOnEmail(param1:AccountSettingsEvent) : void {
      var local2:AccountSettingsTab = null;
      if(this.emailConfirmed) {
        local2 = this.settingsWindow.getAccountSettings();
        IServerCaptcha(object.adapt(IServerCaptcha)).checkCaptcha(local2.getCaptchaAnswer(),CaptchaLocation.ACCOUNT_SETTINGS_FORM);
      }
    }

    private function onSettingsClose(param1:Event = null) : void {
      this.destroySettingsWindow();
    }

    private function onSetEmail(param1:Event = null) : void {
      var local2:AccountSettingsTab = null;
      if(!this.emailConfirmed) {
        local2 = this.settingsWindow.getAccountSettings();
        if(Boolean(local2.email)) {
          IServerCaptcha(object.adapt(IServerCaptcha)).checkCaptcha(local2.getCaptchaAnswer(),CaptchaLocation.ACCOUNT_SETTINGS_FORM);
        }
      }
    }

    private function callbackCheckPassword(param1:Boolean) : void {
      var local2:AccountSettingsTab = null;
      if(param1) {
        local2 = this.settingsWindow.getAccountSettings();
        if(!this.emailConfirmed && local2.password != "") {
          this.setOrUpdatePassword();
        }
      } else {
        this.settingsWindow.getAccountSettings().highlightIncorrectOldPassword();
      }
    }

    private function setOrUpdatePassword() : void {
      var local1:AccountSettingsTab = this.settingsWindow.getAccountSettings();
      if(local1.getOldPassword() == "") {
        passwordService.setPassword(local1.password);
      } else {
        passwordService.updatePassword(local1.getOldPassword(),local1.password);
      }
    }

    private function onChangeReceivePersonalMessageOnlyFromFriends(param1:ReceivePersonalMessagesSettingEvent) : void {
      if(this.receivePersonalMessageOnlyFromFriends != param1.getValue()) {
        server.setReceivePersonalMessages(param1.getValue() ? PersonalMessageReceiveMode.FRIENDS_ONLY : PersonalMessageReceiveMode.ALL);
      }
    }

    public function objectLoadedPost() : void {
      panelView.getPanel().buttonBar.soundOn = !settingsService.muteSound;
      settingsService.initSoundValue();
      panelView.getPanel().buttonBar.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
      var local1:String = IUserEmailAndPassword(object.adapt(IUserEmailAndPassword)).getEmail();
      this.uploadSettingsToServer();
    }

    private function uploadSettingsToServer() : void {
      var local1:ClientStoredSettings = new ClientStoredSettings();
      local1.showDamageEnabled = settingsService.showDamage;
      server.uploadClientSettings(local1);
    }

    private function onButtonBarButtonClick(param1:MainButtonBarEvents) : void {
      switch(param1.typeButton) {
        case MainButtonBarEvents.SOUND:
          this.toggleSoundMute();
          break;
        case MainButtonBarEvents.SETTINGS:
          server.showSettings();
      }
    }

    public function objectUnloaded() : void {
      if(panelView.getPanel() != null) {
        panelView.getPanel().buttonBar.removeEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
      }
    }

    private function toggleSoundMute() : void {
      settingsService.muteSound = !settingsService.muteSound;
      panelView.unlock();
    }

    public function callbackIsPasswordSet(param1:Boolean) : void {
      if(param1) {
        settingsService.isPasswordSet = true;
      } else {
        this.settingsWindow.getAccountSettings().hideOldPasswordField();
      }
      this.settingsWindow.show();
    }

    public function captchaUpdated(param1:CaptchaLocation, param2:Vector.<int>) : void {
      CaptchaParser.parse(param2,this.onCaptchaParsed,param1);
    }

    private function onCaptchaParsed(param1:Bitmap, param2:CaptchaLocation) : void {
      var local3:AccountSettingsTab = null;
      if(param2 == CaptchaLocation.ACCOUNT_SETTINGS_FORM) {
        local3 = this.settingsWindow.getAccountSettings();
        local3.setCaptchaImage(param1);
      }
    }

    public function setCaptchaLocations(param1:Vector.<CaptchaLocation>) : void {
    }

    public function captchaAnswerCorrect(param1:CaptchaLocation) : void {
      this.getNewCaptcha();
      var local2:AccountSettingsTab = this.settingsWindow.getAccountSettings();
      if(this.emailConfirmed) {
        local2.disableChangePasswordPanel();
        alertService.showAlert(localeService.getText(TanksLocale.TEXT_SETTINGS_CHANGE_PASSWORD_CONFIRMATION_SENT_TEXT),Vector.<String>([AlertAnswer.OK]));
        IUserEmailAndPassword(object.adapt(IUserEmailAndPassword)).sendChangeInstruction();
      } else {
        IUserEmailAndPassword(object.adapt(IUserEmailAndPassword)).changeEmail(local2.email);
      }
    }

    public function captchaAnswerIncorrect(param1:CaptchaLocation, param2:Vector.<int>) : void {
      alertService.showAlertById(Alert.CAPTCHA_INCORRECT);
      this.captchaUpdated(param1,param2);
    }

    private function onRefreshCaptcha(param1:RefreshCaptchaClickedEvent) : void {
      this.getNewCaptcha();
    }

    private function getNewCaptcha() : void {
      IServerCaptcha(object.adapt(IServerCaptcha)).getNewCaptcha(CaptchaLocation.ACCOUNT_SETTINGS_FORM);
    }
  }
}
