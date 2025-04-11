package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankInput;
  import controls.TankWindow;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.geom.Point;
  import flash.utils.Timer;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class AntiAddictionWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const Watches3Hours:Class = AntiAddictionWindow_Watches3Hours;
    private static const Watches5Hours:Class = AntiAddictionWindow_Watches5Hours;

    private var window:TankWindow;
    private var okButton:DefaultButtonBase;
    private var closeButton:DefaultButtonBase;
    private var descText:LabelBase;

    public var realNameInput:TankInputBase;
    public var idCardInput:TankInputBase;

    private var watches:Bitmap;

    public var windowSize:Point;

    private var timer:Timer;
    private var secondsToWait:int = 60;

    public function AntiAddictionWindow(param1:int, param2:Boolean) {
      super();
      this.windowSize = new Point(392,param2 ? 170 : 270);
      this.window = new TankWindow();
      this.window.width = this.windowSize.x;
      this.window.height = this.windowSize.y;
      this.window.headerLang = localeService.getText(TanksLocale.TEXT_GUI_LANG);
      this.watches = param1 >= 5 * 60 ? new Watches5Hours() : new Watches3Hours();
      this.watches.x = 12;
      this.watches.y = 34;
      this.window.addChild(this.watches);
      this.okButton = new DefaultButtonBase();
      this.okButton.width = 115;
      this.okButton.height = 30;
      this.okButton.x = 150;
      this.okButton.y = 220;
      this.okButton.label = "确认";
      if(!param2) {
        this.window.addChild(this.okButton);
      }
      this.closeButton = new DefaultButtonBase();
      this.closeButton.width = 96;
      this.closeButton.height = 30;
      this.closeButton.x = 280;
      this.closeButton.y = param2 ? 120 : 220;
      this.closeButton.label = "取消" + " (" + this.secondsToWait + ")";
      this.window.addChild(this.closeButton);
      this.realNameInput = new TankInputBase();
      this.realNameInput.label = "您的真实姓名:";
      this.realNameInput.x = 165;
      this.realNameInput.y = 30;
      this.idCardInput = new TankInputBase();
      this.idCardInput.label = "身份证号码:";
      this.idCardInput.x = 165;
      this.idCardInput.y = 70;
      if(!param2) {
        this.window.addChild(this.idCardInput);
        this.window.addChild(this.realNameInput);
      }
      this.idCardInput.addEventListener(FocusEvent.FOCUS_OUT,this.validateAddictionID);
      this.idCardInput.addEventListener(FocusEvent.FOCUS_IN,this.restoreInput);
      this.realNameInput.addEventListener(FocusEvent.FOCUS_OUT,this.validateRealName);
      this.realNameInput.addEventListener(FocusEvent.FOCUS_IN,this.restoreInput);
      this.descText = new LabelBase();
      this.descText.text = param1 >= 5 * 60 ? "您已进入不健康游戏时间，为了您的健康，请您立即下线休息。\n如不下线，您的身体将受到损害，您的收益已降为零，直到您的累计下线时间满5小时后，才能恢复正常。" : "您已经进入疲劳游戏时间，您的游戏收益将降为正常值的50%，为了您的健康，请尽快下线休息，做适当身体活动，合理安排学习生活。";
      this.descText.x = param2 ? 80 : 14;
      this.descText.y = param2 ? 40 : 120;
      this.descText.wordWrap = true;
      this.descText.height = 80;
      this.descText.width = param2 ? 300 : 370;
      this.window.addChild(this.descText);
      addChild(this.window);
      this.closeButton.enable = false;
      this.timer = new Timer(1000);
      this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      this.timer.start();
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCancelClicked);
      this.okButton.addEventListener(MouseEvent.CLICK,this.onOkClicked);
      dialogService.enqueueDialog(this);
    }

    private static function trimString(param1:String) : String {
      if(param1.charAt(0) == " ") {
        param1 = trimString(param1.substring(1));
      }
      if(param1.charAt(param1.length - 1) == " ") {
        param1 = trimString(param1.substring(0,param1.length - 1));
      }
      return param1;
    }

    private function onTimer(param1:TimerEvent) : void {
      if(--this.secondsToWait < 0) {
        this.closeButton.label = "取消";
        this.closeButton.enable = true;
        this.timer.stop();
      } else {
        this.closeButton.label = "取消" + " (" + this.secondsToWait + ")";
      }
    }

    private function restoreInput(param1:FocusEvent) : void {
      var local2:TankInput = param1.currentTarget as TankInput;
      local2.validValue = true;
    }

    private function validateRealName(param1:FocusEvent) : void {
      var local2:RegExp = null;
      if(this.realNameInput != null) {
        local2 = /^[一-龥]+$/;
        this.realNameInput.validValue = Boolean(this.realNameInput.value.match(local2)) || trimString(this.realNameInput.value).length == 0;
      }
    }

    private function validateAddictionID(param1:FocusEvent) : void {
      var local2:RegExp = null;
      if(this.idCardInput != null) {
        local2 = /^\d{17}[0-9xX]$/;
        this.idCardInput.validValue = Boolean(this.idCardInput.value.match(local2)) || trimString(this.idCardInput.value).length == 0;
      }
    }

    public function disableButtons() : void {
      this.okButton.enable = false;
      this.closeButton.enable = false;
    }

    public function enableButtons() : void {
      this.okButton.enable = true;
      if(this.secondsToWait < 0) {
        this.closeButton.enable = true;
      }
    }

    private function onCancelClicked(param1:Event = null) : void {
      this.removeDialog();
    }

    private function onOkClicked(param1:Event = null) : void {
      dispatchEvent(new Event(Event.COMPLETE));
    }

    public function removeDialog() : void {
      dialogService.removeDialog(this);
    }
  }
}
