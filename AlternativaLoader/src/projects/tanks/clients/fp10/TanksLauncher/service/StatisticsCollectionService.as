package projects.tanks.clients.fp10.TanksLauncher.service {
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  public class StatisticsCollectionService {
    private static const TIMER_DELAY:int = 500;
    private static const CATEGORY:String = "TanksLauncher";
    private static const ACTION_LABEL_START:String = "startDownload";
    private static const ACTION_LABEL_END:String = "endDownload";
    private static const ACTION_LABEL_FINISH:String = "finishDownload";
    private static const ACTION_LOADING_PROGRESS:String = "downloadProgress";
    private static const ACTION_LOADING_ERROR:String = "loadingError";
    private static const MAX_ERROR_MASSAGE_LENGTH:int = 50;

    private var _trackerService:TrackerService;
    private var _timer:Timer;
    private var _counter:int;

    public function StatisticsCollectionService() {
      super();
      this.init();
    }

    private function init() : void {
      this._timer = new Timer(TIMER_DELAY);
      this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      this._trackerService = new TrackerService();
    }

    private function onTimer(param1:TimerEvent) : void {
      ++this._counter;
      var local2:Number = this._counter * TIMER_DELAY / 1000;
      this._trackerService.trackEvent(CATEGORY,ACTION_LOADING_PROGRESS,"passed=" + local2 + " second");
    }

    public function start() : void {
      this._trackerService.trackEvent(CATEGORY,ACTION_LOADING_PROGRESS,ACTION_LABEL_START);
      this._timer.start();
    }

    public function finish() : void {
      var local1:Number = this._counter * TIMER_DELAY / 1000;
      this._trackerService.trackEvent(CATEGORY,ACTION_LOADING_PROGRESS,ACTION_LABEL_END);
      this._trackerService.trackEvent(CATEGORY,ACTION_LOADING_PROGRESS,ACTION_LABEL_FINISH + "=" + local1 + " second");
      this._timer.stop();
    }

    public function handleLoadingError(param1:String) : void {
      this._timer.stop();
      if(param1.length > MAX_ERROR_MASSAGE_LENGTH) {
        param1 = param1.substr(0,MAX_ERROR_MASSAGE_LENGTH);
      }
      this._trackerService.trackEvent(CATEGORY,ACTION_LOADING_ERROR,param1);
    }
  }
}
