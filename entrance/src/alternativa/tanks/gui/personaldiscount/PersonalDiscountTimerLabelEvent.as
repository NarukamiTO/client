package alternativa.tanks.gui.personaldiscount {
  import flash.events.Event;

  public class PersonalDiscountTimerLabelEvent extends Event {
    public static const TIME_ON_COMPLETE_PERSONAL_DISCOUNT_TIMER:String = "PersonalDiscountTimerLabelOnCompleteTimer";

    public function PersonalDiscountTimerLabelEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
