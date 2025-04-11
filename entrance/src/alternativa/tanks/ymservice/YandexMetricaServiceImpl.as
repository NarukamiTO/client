package alternativa.tanks.ymservice {
  import alternativa.tanks.newbieservice.NewbieUserService;
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.utils.Timer;

  public class YandexMetricaServiceImpl implements YandexMetricaService {
    [Inject]
    public static var newbieUserService:NewbieUserService;

    private static const YM_REACH_GOAL:String = "YMReachGoal";
    private static const YM_LOADED:String = "checkYMLoaded";
    private static const COOKIE_EXISTS_FUNC:String = "Cookie.exists";
    private static const WAS_IN_TUTORIAL:String = "FROM_TUTORIAL";

    private var delayedExecutionTimer:Timer = new Timer(100);
    private var reachedGoalsQueue:Vector.<String> = new Vector.<String>();

    public function YandexMetricaServiceImpl() {
      super();
      this.delayedExecutionTimer.addEventListener(TimerEvent.TIMER,this.executeOnTimer);
    }

    private static function isYMAvailable() : Boolean {
      return ExternalInterface.available && ExternalInterface.call(YM_LOADED);
    }

    private function executeOnTimer(param1:TimerEvent) : void {
      if(this.reachedGoalsQueue.length > 0) {
        this.executeTopQueueCommand();
      } else {
        this.delayedExecutionTimer.stop();
      }
    }

    private function executeTopQueueCommand() : void {
      var local1:String = null;
      if(isYMAvailable()) {
        local1 = this.reachedGoalsQueue.shift();
        ExternalInterface.call(YM_REACH_GOAL,local1);
      }
    }

    public function reachGoal(param1:String) : void {
      this.reachedGoalsQueue.push(param1);
      if(!this.delayedExecutionTimer.running) {
        this.delayedExecutionTimer.start();
      }
    }

    public function reachGoalIfPlayerWasInTutorial(param1:String) : void {
      var local2:Boolean = ExternalInterface.available && ExternalInterface.call(COOKIE_EXISTS_FUNC,WAS_IN_TUTORIAL) > 0;
      if(local2) {
        this.reachGoal(param1);
      }
    }

    public function reachGoalIfPlayerIsNewbie(param1:String) : void {
      if(newbieUserService.isNewbieUser) {
        this.reachGoalIfPlayerWasInTutorial(param1);
      }
    }
  }
}
