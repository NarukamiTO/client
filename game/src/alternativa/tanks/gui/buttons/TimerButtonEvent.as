package alternativa.tanks.gui.buttons {
  import flash.events.Event;

  public class TimerButtonEvent extends Event {
    public static const TIME_ON_COMPLETE_TIMER_BUTTON:String = "TimerButtonEventTimeOnCompleteTimerButton";

    public function TimerButtonEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
