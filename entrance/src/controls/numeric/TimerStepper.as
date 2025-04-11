package controls.numeric {
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;

  public class TimerStepper {
    private static const CHANGE_COUNTER_VALUE:int = 7;
    private static const DEFAULT_INTERVAL_DURATION:int = 75;
    private static const STEPS:Vector.<int> = new <int>[1,5,10,20,50,100,200,500];

    private var stepUnit:Number;
    private var timer:Timer;
    private var intervalId:int;
    private var intervalCounter:int;
    private var stepper:INumericStepper;
    private var stepIndex:int;

    public function TimerStepper(param1:INumericStepper, param2:Number = 1) {
      super();
      this.stepper = param1;
      this.stepUnit = param2;
      this.timer = new Timer(500,1);
      this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
    }

    public function start() : void {
      this.timer.reset();
      this.timer.start();
    }

    public function stop() : void {
      this.timer.stop();
      clearInterval(this.intervalId);
    }

    private function onTimerComplete(param1:TimerEvent) : void {
      this.intervalCounter = 0;
      this.stepIndex = 0;
      this.intervalId = setInterval(this.changeCounterByTime,DEFAULT_INTERVAL_DURATION);
    }

    private function changeCounterByTime() : void {
      var local1:Number = this.stepper.getValue() + this.stepper.getButtonStatus() * this.getStep();
      ++this.intervalCounter;
      if(this.intervalCounter >= CHANGE_COUNTER_VALUE && this.stepIndex + 1 < STEPS.length && local1 % this.getStepByIndex(this.stepIndex + 1) < this.stepUnit) {
        this.intervalCounter = 0;
        ++this.stepIndex;
      }
      this.stepper.setValue(local1,true);
    }

    private function getStep() : Number {
      return this.getStepByIndex(this.stepIndex);
    }

    public function setStep(param1:Number) : void {
      this.stepUnit = param1;
    }

    private function getStepByIndex(param1:int) : Number {
      return STEPS[param1] * this.stepUnit;
    }
  }
}
