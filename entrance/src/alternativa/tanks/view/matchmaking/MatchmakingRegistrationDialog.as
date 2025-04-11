package alternativa.tanks.view.matchmaking {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.battlelist.MatchmakingEvent;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import forms.ColorConstants;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import utils.TimeFormatter;

  public class MatchmakingRegistrationDialog extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    private static const WINDOW_WIDTH:int = 340;
    private static const WINDOW_HEIGHT:int = 290;
    private static const PADDING:int = 10;

    private static var headerImageClass:Class = MatchmakingRegistrationDialog_headerImageClass;
    private static var headerImageData:BitmapData = Bitmap(new headerImageClass()).bitmapData;

    private var headerImage:Bitmap = new Bitmap(headerImageData);
    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var cancelRegistrationButton:DefaultButtonBase = new DefaultButtonBase();
    private var modeNameLabel:LabelBase = new LabelBase();
    private var averageWaitingTimeLine:MatchmakingInfoLine;
    private var waitingTimeLine:MatchmakingInfoLine;
    private var registrationTime:int;
    private var waitingTimeTimer:Timer;

    public function MatchmakingRegistrationDialog() {
      super();
      this.createWindow();
      this.addInner();
      this.addHeaderImage();
      this.addModeNameLabel();
      this.addAverageWaitingTimeLine();
      this.addWaitingTimeLine();
      this.addCancelButton();
    }

    public function prepareForShowing(param1:String, param2:int) : void {
      this.modeNameLabel.text = param1;
      this.averageWaitingTimeLine.setText(TimeFormatter.format(param2));
      this.waitingTimeLine.setText(TimeFormatter.format(0));
      this.startWaitingTimer();
    }

    private function addModeNameLabel() : void {
      this.modeNameLabel.x = 2 * PADDING;
      this.modeNameLabel.y = this.headerImage.y + this.headerImage.height + 4;
      this.modeNameLabel.autoSize = TextFieldAutoSize.NONE;
      this.modeNameLabel.width = 300;
      this.modeNameLabel.height = 16;
      this.modeNameLabel.size = 14;
      this.modeNameLabel.bold = true;
      this.modeNameLabel.align = TextFormatAlign.CENTER;
      this.modeNameLabel.color = ColorConstants.GREEN_LABEL;
      this.window.addChild(this.modeNameLabel);
    }

    private function addAverageWaitingTimeLine() : void {
      this.averageWaitingTimeLine = new MatchmakingInfoLine(localeService.getText(TanksLocale.TEXT_ESTIMATED_WAITING_TIME_LABEL));
      this.averageWaitingTimeLine.x = 2 * PADDING;
      this.averageWaitingTimeLine.y = this.modeNameLabel.y + this.modeNameLabel.height + 6;
      this.window.addChild(this.averageWaitingTimeLine);
    }

    private function addWaitingTimeLine() : void {
      this.waitingTimeLine = new MatchmakingInfoLine(localeService.getText(TanksLocale.TEXT_CURRENT_WAITING_TIME_LABEL));
      this.waitingTimeLine.x = 2 * PADDING;
      this.waitingTimeLine.y = this.averageWaitingTimeLine.y + this.averageWaitingTimeLine.height + 2;
      this.window.addChild(this.waitingTimeLine);
    }

    private function createWindow() : void {
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_TOURNAMENT_PREPARE,WINDOW_WIDTH,WINDOW_HEIGHT);
      addChild(this.window);
    }

    private function addInner() : void {
      this.inner = new TankWindowInner(WINDOW_WIDTH - PADDING * 2,WINDOW_HEIGHT - PADDING * 3 - this.cancelRegistrationButton.height,TankWindowInner.GREEN);
      this.inner.x = PADDING;
      this.inner.y = PADDING;
      this.window.addChild(this.inner);
    }

    private function addHeaderImage() : void {
      this.headerImage.x = (WINDOW_WIDTH - this.headerImage.width) / 2;
      this.headerImage.y = PADDING;
      this.window.addChild(this.headerImage);
    }

    private function addCancelButton() : void {
      this.cancelRegistrationButton = new DefaultButtonBase();
      this.cancelRegistrationButton.label = localeService.getText(TanksLocale.TEXT_BATTLE_EXIT);
      this.cancelRegistrationButton.x = (WINDOW_WIDTH - this.cancelRegistrationButton.width) / 2;
      this.cancelRegistrationButton.y = WINDOW_HEIGHT - this.cancelRegistrationButton.height - 1.5 * PADDING;
      this.cancelRegistrationButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.window.addChild(this.cancelRegistrationButton);
    }

    private function startWaitingTimer() : void {
      this.registrationTime = getTimer();
      this.waitingTimeTimer = new Timer(1000);
      this.waitingTimeTimer.addEventListener(TimerEvent.TIMER,this.onWaitingTimeTimer);
      this.waitingTimeTimer.start();
    }

    private function onWaitingTimeTimer(param1:TimerEvent) : void {
      this.waitingTimeLine.setText(TimeFormatter.format((getTimer() - this.registrationTime) / 1000));
    }

    public function prepareForHiding() : void {
      this.stopTimer();
    }

    private function stopTimer() : void {
      this.waitingTimeTimer.stop();
      this.waitingTimeTimer.removeEventListener(TimerEvent.TIMER,this.onWaitingTimeTimer);
    }

    private function onCloseButtonClick(param1:MouseEvent) : void {
      this.exitFromQueue();
    }

    override protected function cancelKeyPressed() : void {
      this.exitFromQueue();
    }

    private function exitFromQueue() : void {
      this.stopTimer();
      dispatchEvent(new MatchmakingEvent(MatchmakingEvent.UNREGISTRATION));
    }
  }
}
