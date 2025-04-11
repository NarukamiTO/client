package forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.LabelBase;
  import controls.statassets.BlackRoundRect;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ChangeTeamAlert extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    public static const RED:int = 0;
    public static const BLUE:int = 1;

    private const PADDING:int = 15;

    private var bg:BlackRoundRect = new BlackRoundRect();
    private var label:LabelBase = new LabelBase();
    private var countDown:int = 0;
    private var countDownTimer:Timer;

    public function ChangeTeamAlert(param1:int, param2:int = 0) {
      super();
      var local3:String = param2 == RED ? localeService.getText(TanksLocale.TEXT_BATTLE_TEAM_RED) : localeService.getText(TanksLocale.TEXT_BATTLE_TEAM_BLUE);
      this.label.align = TextFormatAlign.CENTER;
      this.label.size = 14;
      this.label.bold = true;
      this.label.htmlText = "<font color=" + (param2 == RED ? "\"#ff9999\">" : "\"#99ccff\">") + localeService.getText(TanksLocale.TEXT_BATTLE_TEAM_ALERT,local3) + "</font>";
      addChild(this.bg);
      addChild(this.label);
      this.label.x = this.PADDING;
      this.label.y = this.PADDING;
      this.bg.width = this.label.width + this.PADDING * 2;
      this.bg.height = this.label.height + this.PADDING * 2;
      this.countDown = param1;
      this.showCountDown();
      addEventListener(MouseEvent.CLICK,this.hide);
    }

    public function hide(param1:Event = null) : void {
      if(this.parent != null) {
        this.parent.removeChild(this);
        removeEventListener(MouseEvent.CLICK,this.hide);
      }
    }

    private function showCountDown() : void {
      this.countDownTimer = new Timer(1000);
      this.countDownTimer.addEventListener(TimerEvent.TIMER,this.showCountDownTick);
      this.countDownTimer.start();
      this.showCountDownTick();
    }

    private function showCountDownTick(param1:TimerEvent = null) : void {
      --this.countDown;
      if(this.countDown < 0) {
        this.countDownTimer.removeEventListener(TimerEvent.TIMER,this.showCountDownTick);
        this.countDownTimer.stop();
        this.hide();
      }
    }
  }
}
