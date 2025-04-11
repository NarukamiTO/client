package services.alertservice {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.ColorButton;
  import controls.TankWindow;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.buttons.ButtonBase;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.events.AlertEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class Alert extends Sprite {
    public static const ALERT_QUIT:int = 0;
    public static const ALERT_CONFIRM_EMAIL:int = 1;
    public static const ERROR_CALLSIGN_FIRST_SYMBOL:int = 2;
    public static const ERROR_CALLSIGN_DEVIDE:int = 3;
    public static const ERROR_CALLSIGN_LAST_SYMBOL:int = 4;
    public static const ERROR_CALLSIGN_LENGTH:int = 5;
    public static const ERROR_CALLSIGN_UNIQUE:int = 6;
    public static const ERROR_PASSWORD_LENGTH:int = 7;
    public static const ERROR_PASSWORD_INCORRECT:int = 8;
    public static const ERROR_PASSWORD_CHANGE:int = 9;
    public static const ERROR_EMAIL_UNIQUE:int = 10;
    public static const ERROR_EMAIL_INVALID:int = 11;
    public static const ERROR_EMAIL_NOTFOUND:int = 12;
    public static const ERROR_EMAIL_NOTSENDED:int = 13;
    public static const ERROR_FATAL:int = 14;
    public static const ERROR_FATAL_DEBUG:int = 15;
    public static const GARAGE_AVAILABLE:int = 16;
    public static const ALERT_RECOVERY_LINK_SENDED:int = 17;
    public static const ALERT_CHAT_PROCEED:int = 18;
    public static const CAPTCHA_INCORRECT:int = 19;
    public static const ERROR_CONFIRM_EMAIL:int = 20;
    public static const CONFIRM_UNKINK_VK:int = 21;
    public static const ERROR_PARTNER_LINK_ALREADY_EXISTS:int = 22;

    protected var bgWindow:TankWindow = new TankWindow();

    private var output:LabelBase;
    private var message:String;
    private var labels:Vector.<String>;

    protected var alertWindow:Sprite = new Sprite();

    public var closeButton:MainPanelCloseButton = new MainPanelCloseButton();

    private var closable:Boolean = false;

    private const alerts:Array = [];

    private var id:int;
    private var localeService:ILocaleService;
    private var customButtons:Vector.<Sprite>;

    public function Alert(param1:int = -1, param2:Boolean = false) {
      super();
      this.closable = param2;
      this.id = param1;
      this.init();
    }

    public static function fillButtonLabels(param1:ILocaleService) : void {
      AlertAnswer.YES = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_YES);
      AlertAnswer.NO = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_NO);
      AlertAnswer.OK = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      AlertAnswer.CANCEL = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_CANCEL);
      AlertAnswer.SEND = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_SEND_BUG_REPORT);
      AlertAnswer.RETURN = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_RETURN_TO_BATTLE);
      AlertAnswer.GARAGE = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_GO_TO_GARAGE);
      AlertAnswer.PROCEED = param1.getText(TanksLocale.TEXT_ALERT_ANSWER_PROCEED);
      AlertAnswer.ENTER = param1.getText(TanksLocale.TEXT_BATTLEINFO_PANEL_PAID_BATTLES_ALERT_ANSWER_ENTER);
      AlertAnswer.DO_NOT_ENTER = param1.getText(TanksLocale.TEXT_BATTLEINFO_PANEL_PAID_BATTLES_ALERT_ANSWER_DONT_ENTER);
    }

    private function init() : void {
      this.localeService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      this.bgWindow.headerLang = this.localeService.getText(TanksLocale.TEXT_GUI_LANG);
      if(AlertAnswer.YES == null) {
        fillButtonLabels(this.localeService);
      }
      this.initStandardAlerts(this.localeService);
      if(this.id > -1) {
        this.showAlert(this.alerts[this.id][0],this.alerts[this.id][1]);
      }
      this.createOutput();
    }

    private function initStandardAlerts(param1:ILocaleService) : void {
      this.alerts[ALERT_QUIT] = [param1.getText(TanksLocale.TEXT_ALERT_QUIT_TEXT),Vector.<String>([AlertAnswer.YES,AlertAnswer.NO])];
      this.alerts[ALERT_CONFIRM_EMAIL] = [param1.getText(TanksLocale.TEXT_ALERT_EMAIL_CONFIRMED),Vector.<String>([AlertAnswer.YES])];
      this.alerts[ERROR_FATAL] = [param1.getText(TanksLocale.TEXT_ERROR_FATAL),Vector.<String>([AlertAnswer.RETURN])];
      this.alerts[ERROR_FATAL_DEBUG] = [param1.getText(TanksLocale.TEXT_ERROR_FATAL_DEBUG),Vector.<String>([AlertAnswer.SEND])];
      this.alerts[ERROR_CALLSIGN_FIRST_SYMBOL] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_WRONG_FIRST_SYMBOL),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_CALLSIGN_DEVIDE] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_NOT_SINGLE_DEVIDERS),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_CALLSIGN_LAST_SYMBOL] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_WRONG_LAST_SYMBOL),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_CALLSIGN_LENGTH] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_LENGTH),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_CALLSIGN_UNIQUE] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_NOT_UNIQUE),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_EMAIL_UNIQUE] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_UNIQUE),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_EMAIL_INVALID] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_INVALID),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_EMAIL_NOTFOUND] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_FOUND),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_EMAIL_NOTSENDED] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_SENDED),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_PASSWORD_INCORRECT] = [param1.getText(TanksLocale.TEXT_ERROR_PASSWORD_INCORRECT),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_PASSWORD_LENGTH] = [param1.getText(TanksLocale.TEXT_ERROR_PASSWORD_LENGTH),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_PASSWORD_CHANGE] = [param1.getText(TanksLocale.TEXT_ERROR_PASSWORD_CHANGE),Vector.<String>([AlertAnswer.OK])];
      this.alerts[GARAGE_AVAILABLE] = [param1.getText(TanksLocale.TEXT_ALERT_GARAGE_AVAILABLE),Vector.<String>([AlertAnswer.GARAGE,AlertAnswer.CANCEL])];
      this.alerts[ALERT_RECOVERY_LINK_SENDED] = [param1.getText(TanksLocale.TEXT_SETTINGS_CHANGE_PASSWORD_CONFIRMATION_SENT_TEXT),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ALERT_CHAT_PROCEED] = [param1.getText(TanksLocale.TEXT_ALERT_CHAT_PROCEED_EXTERNAL_LINK),Vector.<String>([AlertAnswer.CANCEL])];
      this.alerts[CAPTCHA_INCORRECT] = [param1.getText(TanksLocale.TEXT_CAPTCHA_INCORRECT),Vector.<String>([AlertAnswer.OK])];
      this.alerts[ERROR_CONFIRM_EMAIL] = [param1.getText(TanksLocale.TEXT_ALERT_EMAIL_CONFIRMED_WRONG_LINK),Vector.<String>([AlertAnswer.OK])];
      this.alerts[CONFIRM_UNKINK_VK] = ["Внимание!\nПрежде чем вы сможете закрыть доступ для сервиса ВКонтакте, вам\nнеобходимо установить пароль для аккаунта \"Танков Онлайн\" в настройках.",[AlertAnswer.OK]];
      this.alerts[ERROR_PARTNER_LINK_ALREADY_EXISTS] = [param1.getText(TanksLocale.TEXT_PARTNER_USERNAME_ALREDY_USED_ERROR),Vector.<String>([AlertAnswer.OK])];
    }

    private function createOutput() : void {
      this.output = new LabelBase();
      this.output.autoSize = TextFieldAutoSize.CENTER;
      this.output.align = TextFormatAlign.CENTER;
      this.output.size = 14;
      this.output.width = 10;
      this.output.height = 10;
      this.output.x = -5;
      this.output.y = 30;
      this.output.multiline = true;
    }

    public function showAlert(param1:String, param2:Vector.<String>) : void {
      this.message = param1;
      this.customButtons = null;
      this.labels = param2;
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    public function showAlertWithCustomButtons(param1:String, param2:Vector.<String>, param3:Vector.<Sprite>) : void {
      this.message = param1;
      this.labels = param2;
      this.customButtons = param3;
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      this.doLayout(param1);
    }

    private function hasButtons() : Boolean {
      return this.labels.length != 0;
    }

    private function isCustomLabels() : Boolean {
      return this.customButtons != null;
    }

    protected function doLayout(param1:Event) : void {
      var local4:Sprite = null;
      var local5:int = 0;
      var local6:DefaultButtonBase = null;
      var local2:int = this.calculateButtonsWidth();
      var local3:int = local2 * this.labels.length / 2;
      addChild(this.alertWindow);
      this.alertWindow.addChild(this.bgWindow);
      this.alertWindow.addChild(this.output);
      this.output.htmlText = this.message;
      if(this.hasButtons()) {
        local5 = 0;
        while(local5 < this.labels.length) {
          if(this.isCustomLabels()) {
            local4 = this.customButtons[local5];
          } else {
            local6 = new DefaultButtonBase();
            local4 = local6;
            local6.label = this.labels[local5];
          }
          local4.x = local2 * local5 - local3;
          local4.y = this.output.y + this.output.height + 15;
          local4.width = local2 - 6;
          local4.addEventListener(MouseEvent.CLICK,this.close);
          this.alertWindow.addChild(local4);
          local5++;
        }
        this.bgWindow.height = local4.y + 60;
      } else {
        this.bgWindow.height = this.output.y + this.output.height + 30;
      }
      this.bgWindow.width = Math.max(int(this.output.width + 50),local3 * 2 + 50);
      this.bgWindow.x = -int(this.bgWindow.width / 2) - 3;
      stage.addEventListener(Event.RESIZE,this.onStageResize);
      stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.ALERT);
      stage.focus = this;
      if(this.closable) {
        this.alertWindow.addChild(this.closeButton);
        this.closeButton.x = this.bgWindow.x + this.bgWindow.width - this.closeButton.width - 10;
        this.closeButton.y = 10;
        this.closeButton.addEventListener(MouseEvent.CLICK,this.close);
      }
      this.onStageResize(null);
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      var local2:String = null;
      switch(this.labels.length) {
        case 1:
          if(AlertUtils.isConfirmationKey(param1.keyCode) || AlertUtils.isCancelKey(param1.keyCode)) {
            local2 = this.labels[0];
          }
          break;
        case 2:
          if(AlertUtils.isConfirmationKey(param1.keyCode)) {
            local2 = this.getFirstExistingLabel(this.getConfirmationButtonNames());
          } else if(AlertUtils.isCancelKey(param1.keyCode)) {
            local2 = this.getFirstExistingLabel(this.getCancelButtonNames());
          }
          break;
        case 3:
          if(AlertUtils.isConfirmationKey(param1.keyCode)) {
            local2 = this.getFirstExistingLabel(this.getConfirmationButtonNames());
          } else if(AlertUtils.isCancelKey(param1.keyCode)) {
            local2 = this.getFirstExistingLabel(Vector.<String>([AlertAnswer.CANCEL]));
          }
      }
      if(local2 != null) {
        param1.stopImmediatePropagation();
        this.dispatchClickEventForButtonWithLabel(local2);
      }
    }

    private function getCancelButtonNames() : Vector.<String> {
      return Vector.<String>([AlertAnswer.NO,AlertAnswer.CANCEL,AlertAnswer.RETURN,AlertAnswer.DO_NOT_ENTER]);
    }

    private function getConfirmationButtonNames() : Vector.<String> {
      return Vector.<String>([AlertAnswer.OK,AlertAnswer.YES,AlertAnswer.GARAGE,AlertAnswer.PROCEED,AlertAnswer.SEND,AlertAnswer.ENTER,this.localeService.getText(TanksLocale.TEXT_BATTLE_ENTER_WARNING_PARKOUR_BUTTON_ENTER)]);
    }

    private function getFirstExistingLabel(param1:Vector.<String>) : String {
      var local3:int = 0;
      var local2:int = 0;
      while(local2 < this.labels.length) {
        local3 = int(param1.indexOf(this.labels[local2]));
        if(local3 > -1) {
          return param1[local3];
        }
        local2++;
      }
      return "";
    }

    private function childHasLabel(param1:Object) : Boolean {
      return param1 is ButtonBase || param1 is ColorButton;
    }

    private function getChildLabel(param1:Object) : String {
      if(param1 is ButtonBase) {
        return ButtonBase(param1).label;
      }
      if(param1 is ColorButton) {
        return ColorButton(param1).label;
      }
      return null;
    }

    private function dispatchClickEventForButtonWithLabel(param1:String) : void {
      var local3:DisplayObject = null;
      var local2:int = 0;
      while(local2 < this.alertWindow.numChildren) {
        local3 = this.alertWindow.getChildAt(local2);
        if(this.childHasLabel(local3) && this.getChildLabel(local3) == param1) {
          local3.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
          return;
        }
        local2++;
      }
    }

    private function calculateButtonsWidth() : int {
      var local1:int = 80;
      var local2:LabelBase = new LabelBase();
      var local3:int = 0;
      while(local3 < this.labels.length) {
        local2.text = this.labels[local3];
        if(local2.width > local1) {
          local1 = local2.width;
        }
        local3++;
      }
      return local1 + 18;
    }

    private function onStageResize(param1:Event) : void {
      this.alertWindow.x = int(stage.stageWidth / 2);
      this.alertWindow.y = int(stage.stageHeight / 2 - this.alertWindow.height / 2);
    }

    private function close(param1:MouseEvent) : void {
      stage.removeEventListener(Event.RESIZE,this.onStageResize);
      stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      this.removeMouseListenerFromButtons();
      while(this.alertWindow.numChildren > 0) {
        this.alertWindow.removeChildAt(0);
      }
      if(this.childHasLabel(param1.currentTarget)) {
        dispatchEvent(new AlertEvent(this.getChildLabel(param1.currentTarget)));
      }
      removeDisplayObject(this);
    }

    private function removeMouseListenerFromButtons() : void {
      var local2:DisplayObject = null;
      var local1:int = 0;
      while(local1 < this.alertWindow.numChildren) {
        local2 = this.alertWindow.getChildAt(local1);
        if(local2 == this.closeButton) {
          local2.removeEventListener(MouseEvent.CLICK,this.close);
        }
        local1++;
      }
    }

    public function simulatePressedCancel() : void {
      var local1:String = null;
      if(this.labels.length == 2) {
        local1 = this.getFirstExistingLabel(this.getCancelButtonNames());
      } else if(this.labels.length == 1) {
        local1 = this.labels[0];
      }
      if(local1 != null) {
        this.dispatchClickEventForButtonWithLabel(local1);
      }
    }
  }
}
