package controls.timer {
  import alternativa.osgi.service.logging.LogService;
  import flash.utils.clearInterval;
  import flash.utils.getTimer;
  import flash.utils.setInterval;
  import platform.client.fp10.core.type.AutoClosable;

  public class CountDownTimer implements AutoClosable {
    [Inject]
    public static var logService:LogService;

    private static var intervalId:int;
    private static var allTimers:Vector.<CountDownTimer> = new Vector.<CountDownTimer>();
    private static var EMPTY_VECTOR:Vector.<Object> = new Vector.<Object>(0,true);

    private var endTime:Number;
    private var remainingTimeInSeconds:int;
    private var allListeners:Object = {};

    public function CountDownTimer() {
      super();
    }

    public static function resetAllTimers() : void {
      if(allTimers.length != 0) {
        clearInterval(intervalId);
        allTimers.length = 0;
      }
    }

    private static function onAllTimersTick() : void {
      var local3:CountDownTimer = null;
      var local1:int = getTimer();
      var local2:int = allTimers.length - 1;
      while(local2 >= 0) {
        local3 = allTimers[local2];
        local3.onTick(local1);
        local2--;
      }
    }

    public function addListener(param1:Class, param2:Object) : void {
      var local3:Vector.<Object> = this.allListeners[param1];
      if(local3 == null) {
        this.allListeners[param1] = local3 = new Vector.<Object>();
      }
      local3.push(param2);
    }

    public function removeListener(param1:Class, param2:Object) : void {
      var local3:Vector.<Object> = this.allListeners[param1];
      if(local3 != null) {
        local3.splice(local3.indexOf(param2),1);
      }
    }

    public function start(param1:Number) : void {
      this.endTime = param1;
      this.addTimer();
      this.remainingTimeInSeconds = Math.ceil((param1 - getTimer()) / 1000);
    }

    public function destroy() : void {
      this.removeTimer();
      this.allListeners = {};
    }

    public function stop() : void {
      this._stop(true);
    }

    private function _stop(param1:Boolean) : void {
      var local2:CountDownTimerOnCompleteBefore = null;
      var local3:CountDownTimerOnCompleteAfter = null;
      this.removeTimer();
      this.remainingTimeInSeconds = 0;
      for each(local2 in this.getListeners(CountDownTimerOnCompleteBefore).concat()) {
        local2.onCompleteBefore(this,param1);
      }
      for each(local3 in this.getListeners(CountDownTimerOnCompleteAfter).concat()) {
        local3.onCompleteAfter(this,param1);
      }
      this.allListeners = {};
    }

    public function getRemainingSeconds() : int {
      return this.remainingTimeInSeconds;
    }

    public function getEndTime() : uint {
      return this.endTime;
    }

    private function onTick(param1:int) : void {
      var local2:CountDownTimerOnTick = null;
      this.remainingTimeInSeconds = Math.ceil((this.endTime - param1) / 1000);
      if(this.remainingTimeInSeconds <= 0) {
        this._stop(false);
      } else {
        for each(local2 in this.getListeners(CountDownTimerOnTick)) {
          local2.onTick(this);
        }
      }
    }

    private function getListeners(param1:Class) : Vector.<Object> {
      var local2:Vector.<Object> = this.allListeners[param1];
      if(local2 != null) {
        return local2;
      }
      return EMPTY_VECTOR;
    }

    private function addTimer() : void {
      if(allTimers.length == 0) {
        intervalId = setInterval(onAllTimersTick,1000);
      }
      allTimers.push(this);
    }

    private function removeTimer() : void {
      var local1:Number = Number(allTimers.indexOf(this));
      if(local1 == -1) {
        return;
      }
      allTimers.splice(local1,1);
      if(allTimers.length == 0) {
        clearInterval(intervalId);
      }
    }

    public function close() : void {
      this.destroy();
    }
  }
}
