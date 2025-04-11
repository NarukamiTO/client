package alternativa.tanks.gui.personaldiscount {
  import alternativa.tanks.model.personaldiscount.PersonalDiscountModel;
  import controls.base.LabelBase;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteAfter;
  import controls.timer.CountDownTimerOnTick;
  import utils.TimeFormatter;

  public class PersonalDiscountLabel extends LabelBase implements CountDownTimerOnCompleteAfter, CountDownTimerOnTick {
    private var timer:CountDownTimer;
    private var originText:String;

    public function PersonalDiscountLabel() {
      super();
    }

    public function startTimer(param1:CountDownTimer) : void {
      this.timer = param1;
      if(param1.getRemainingSeconds() > 0) {
        this.addTimeToLabel(param1);
        param1.addListener(CountDownTimerOnCompleteAfter,this);
        param1.addListener(CountDownTimerOnTick,this);
      }
    }

    public function onTick(param1:CountDownTimer) : void {
      this.addTimeToLabel(param1);
    }

    private function addTimeToLabel(param1:CountDownTimer) : void {
      super.text = this.originText.replace(PersonalDiscountModel.DISCOUNT_TIMER_PATTERN,TimeFormatter.format(param1.getRemainingSeconds()));
    }

    public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void {
      this.hideTime();
      dispatchEvent(new PersonalDiscountTimerLabelEvent(PersonalDiscountTimerLabelEvent.TIME_ON_COMPLETE_PERSONAL_DISCOUNT_TIMER));
    }

    public function hideTime() : void {
      if(this.timer != null) {
        super.text = this.originText;
        this.timer.removeListener(CountDownTimerOnCompleteAfter,this);
        this.timer.destroy();
        this.timer = null;
      }
    }

    override public function set text(param1:String) : void {
      this.originText = param1;
      super.text = param1;
    }
  }
}
