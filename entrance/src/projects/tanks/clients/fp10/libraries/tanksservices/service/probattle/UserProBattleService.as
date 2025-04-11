package projects.tanks.clients.fp10.libraries.tanksservices.service.probattle {
  import flash.events.EventDispatcher;
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  public class UserProBattleService extends EventDispatcher implements IUserProBattleService {
    private var timer:Timer;
    private var userHasAbonement:Boolean = false;

    public function UserProBattleService() {
      super();
    }

    public function hasAbonement() : Boolean {
      return this.userHasAbonement;
    }

    public function setAbonementRemainingTimeSec(param1:int) : void {
      if(param1 > 0) {
        this.userHasAbonement = true;
        this.setTimer(param1);
      } else {
        this.userHasAbonement = false;
      }
    }

    private function setTimer(param1:int) : void {
      this.timer = new Timer(this.getNormalizedDuration(param1),1);
      this.timer.addEventListener(TimerEvent.TIMER,this.onAbonementDurationOver);
      this.timer.start();
    }

    private function getNormalizedDuration(param1:int) : Number {
      var local2:Number = int.MAX_VALUE;
      if(int.MAX_VALUE / 1000 > param1) {
        local2 = param1 * 1000;
      }
      return local2;
    }

    private function onAbonementDurationOver(param1:TimerEvent) : void {
      this.timer.removeEventListener(TimerEvent.TIMER,this.onAbonementDurationOver);
      this.timer.stop();
      this.userHasAbonement = false;
      dispatchEvent(new ProBattleEvent(ProBattleEvent.OVER));
    }
  }
}
