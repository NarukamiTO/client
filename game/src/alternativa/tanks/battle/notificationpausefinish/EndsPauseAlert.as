package alternativa.tanks.battle.notificationpausefinish {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.utils.removeDisplayObject;
  import controls.TankWindow;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import services.alertservice.AlertAnswer;

  public class EndsPauseAlert extends DialogWindow {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const TIME_REPLACE_PATTERN:String = "{time}";
    private static const GAP_AROUND:int = 25;
    private static const GAP_BETWEEN_BUTTON:int = 6;
    private static const GAP_BETWEEN_LABEL_AND_BUTTON:int = 15;

    private var _bgWindow:TankWindow;
    private var _buttonYes:DefaultButtonBase;
    private var _buttonNo:DefaultButtonBase;
    private var _labelOne:LabelBase;
    private var _labelTwo:LabelBase;
    private var _seconds:int;
    private var _pauseText:String;

    public function EndsPauseAlert() {
      super();
      this._pauseText = localeService.getText(TanksLocale.TEXT_REARM_PAUSE_ALERT);
      this._bgWindow = new TankWindow();
      addChild(this._bgWindow);
      this._labelOne = this.createLabel();
      this._labelTwo = this.createLabel();
      this._buttonYes = new DefaultButtonBase();
      this._buttonYes.label = AlertAnswer.YES;
      addChild(this._buttonYes);
      this._buttonNo = new DefaultButtonBase();
      this._buttonNo.label = AlertAnswer.NO;
      addChild(this._buttonNo);
      this.resize();
    }

    private function createLabel() : LabelBase {
      var local1:LabelBase = new LabelBase();
      local1.y = GAP_AROUND;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = 14;
      local1.width = 10;
      local1.height = 10;
      local1.multiline = true;
      addChild(local1);
      return local1;
    }

    public function set seconds(param1:int) : void {
      if(this._seconds == param1) {
        return;
      }
      this._seconds = param1;
      var local2:int = this._seconds / 60;
      this._seconds -= local2 * 60;
      var local3:String = this._seconds < 10 ? "0" + this._seconds : this._seconds.toString();
      var local4:Array = this._pauseText.replace(TIME_REPLACE_PATTERN,local2 + ":" + local3).split("\n");
      this._labelOne.text = local4[0];
      this._labelTwo.text = local4[1];
    }

    public function show() : void {
      blurService.blurAllContent();
      this.resize();
      display.stage.addChild(this);
      display.stage.focus = this;
      this.setEvents();
    }

    private function resize() : void {
      var local1:int = Math.max(this._labelOne.width + 2 * GAP_AROUND,this._labelTwo.width + 2 * GAP_AROUND);
      this._bgWindow.width = Math.max(local1,this._buttonNo.width + this._buttonYes.width + GAP_BETWEEN_BUTTON + 2 * GAP_AROUND);
      this._bgWindow.x = -int(this._bgWindow.width / 2);
      this._labelOne.x = -int(this._labelOne.width / 2);
      this._labelTwo.x = -int(this._labelTwo.width / 2);
      this._labelTwo.y = this._labelOne.y + this._labelOne.height;
      this._buttonYes.y = this._labelTwo.y + this._labelTwo.height + GAP_BETWEEN_LABEL_AND_BUTTON;
      this._buttonNo.y = this._labelTwo.y + this._labelTwo.height + GAP_BETWEEN_LABEL_AND_BUTTON;
      this._buttonYes.x = -this._buttonYes.width - GAP_BETWEEN_BUTTON / 2;
      this._buttonNo.x = GAP_BETWEEN_BUTTON / 2;
      this._bgWindow.height = this._buttonNo.y + this._buttonNo.height + GAP_AROUND;
      this.x = display.stage.stageWidth >> 1;
      this.y = display.stage.stageHeight - this.height >> 1;
    }

    private function setEvents() : void {
      this._buttonYes.addEventListener(MouseEvent.CLICK,this.onYesClick);
      this._buttonNo.addEventListener(MouseEvent.CLICK,this.onNoClick);
      display.stage.addEventListener(Event.RESIZE,this.onStageResize);
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpThis);
    }

    private function onNoClick(param1:MouseEvent = null) : void {
      dispatchEvent(new NotificationEndsPausedAlertEvent(NotificationEndsPausedAlertEvent.CLOSE_ALERT));
    }

    private function onYesClick(param1:MouseEvent = null) : void {
      dispatchEvent(new NotificationEndsPausedAlertEvent(NotificationEndsPausedAlertEvent.RETURN_TO_BATTLE));
    }

    private function onStageResize(param1:Event) : void {
      this.resize();
    }

    private function onKeyUpThis(param1:KeyboardEvent) : void {
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.onNoClick();
      }
      if(AlertUtils.isConfirmationKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.onYesClick();
      }
    }

    public function destroy() : void {
      this.removeEvents();
      blurService.unblurAllContent();
      removeDisplayObject(this);
      this._bgWindow = null;
      this._buttonYes = null;
      this._buttonNo = null;
      this._labelOne = null;
      this._labelTwo = null;
    }

    private function removeEvents() : void {
      this._buttonYes.removeEventListener(MouseEvent.CLICK,this.onYesClick);
      this._buttonNo.removeEventListener(MouseEvent.CLICK,this.onNoClick);
      display.stage.removeEventListener(Event.RESIZE,this.onStageResize);
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpThis);
    }
  }
}
