package forms {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.LabelBase;
  import controls.statassets.BlackRoundRect;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ServerStopAlert extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var display:IDisplay;

    protected const PADDING:int = 15;

    protected var bg:BlackRoundRect = new BlackRoundRect();
    protected var timeLimitLabel:LabelBase = new LabelBase();
    protected var countDown:int = 0;
    protected var countDownTimer:Timer;
    protected var str:String;

    public function ServerStopAlert(param1:int) {
      super();
      this.countDown = param1;
      this.init();
    }

    protected function init() : void {
      this.timeLimitLabel.align = TextFormatAlign.CENTER;
      this.str = localeService.getText(TanksLocale.TEXT_SERVER_STOP_ALERT_TEXT);
      this.timeLimitLabel.text = this.getText(this.str,"88");
      addChild(this.bg);
      addChild(this.timeLimitLabel);
      this.timeLimitLabel.x = this.PADDING;
      this.timeLimitLabel.y = this.PADDING;
      this.bg.width = this.timeLimitLabel.width + this.PADDING * 2;
      this.bg.height = this.timeLimitLabel.height + this.PADDING * 2;
      display.dialogsLayer.addChild(this);
      display.stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize();
      this.showCountDown();
    }

    private function onResize(param1:Event = null) : void {
      this.x = Math.round((display.stage.stageWidth - this.width) * 0.5);
      this.y = Math.round((display.stage.stageHeight - this.height) * 0.5);
    }

    protected function showCountDown() : void {
      this.countDownTimer = new Timer(1000);
      this.countDownTimer.addEventListener(TimerEvent.TIMER,this.showCountDownTick);
      this.countDownTimer.start();
      this.showCountDownTick();
    }

    protected function showCountDownTick(param1:TimerEvent = null) : void {
      var local2:String = this.countDown > 9 ? String(this.countDown) : "0" + String(this.countDown);
      this.timeLimitLabel.text = this.timeLimitLabel.text = this.getText(this.str,local2);
      --this.countDown;
      if(this.countDown < 0) {
        this.countDownTimer.removeEventListener(TimerEvent.TIMER,this.showCountDownTick);
        this.countDownTimer.stop();
      }
    }

    protected function getText(param1:String, ... rest) : String {
      var local3:String = param1;
      var local4:int = 0;
      while(local4 < rest.length) {
        local3 = local3.replace("%" + (local4 + 1),rest[local4]);
        local4++;
      }
      return local3;
    }
  }
}
