package controls.labels {
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteBefore;
  import controls.timer.CountDownTimerOnTick;
  import flash.events.Event;
  import utils.TimeFormatter;

  public class CountDownTimerLabel extends MouseDisabledLabel implements CountDownTimerOnTick, CountDownTimerOnCompleteBefore {
    private var timer:CountDownTimer = null;

    public function CountDownTimerLabel() {
      super();
      addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
    }

    private static function formatTime(param1:int) : String {
      if(param1 <= 0) {
        return "";
      }
      return TimeFormatter.format(param1);
    }

    public function start(param1:CountDownTimer) : void {
      this.stop();
      this.timer = param1;
      if(stage != null) {
        this.addListeners();
      }
      this.onTick(param1);
    }

    public function stop() : void {
      if(this.timer != null) {
        if(stage != null) {
          this.removeListeners();
        }
        this.timer = null;
        text = "";
      }
    }

    public function onTick(param1:CountDownTimer) : void {
      text = formatTime(param1.getRemainingSeconds());
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void {
      if(param1 == this.timer) {
        this.timer = null;
        text = "";
      }
    }

    public function getCountDownTimer() : CountDownTimer {
      return this.timer;
    }

    private function addListeners() : void {
      this.timer.addListener(CountDownTimerOnTick,this);
      this.timer.addListener(CountDownTimerOnCompleteBefore,this);
    }

    private function removeListeners() : void {
      this.timer.removeListener(CountDownTimerOnTick,this);
      this.timer.removeListener(CountDownTimerOnCompleteBefore,this);
    }

    private function onRemoved(param1:Event) : void {
      if(this.timer != null) {
        this.removeListeners();
      }
    }

    private function onAdded(param1:Event) : void {
      if(this.timer != null) {
        this.addListeners();
        this.onTick(this.timer);
      }
    }
  }
}
