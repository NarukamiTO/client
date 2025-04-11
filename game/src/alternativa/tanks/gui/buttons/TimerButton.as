package alternativa.tanks.gui.buttons {
  import controls.buttons.h50px.GreyBigButton;
  import controls.labels.CountDownTimerLabel;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteAfter;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class TimerButton extends GreyBigButton implements CountDownTimerOnCompleteAfter {
    private var timerLabel:CountDownTimerLabel;
    private var timer:CountDownTimer;

    public function TimerButton() {
      super();
      this.init();
    }

    private function init() : void {
      this.timerLabel = new CountDownTimerLabel();
      this.timerLabel.align = TextFormatAlign.CENTER;
      this.timerLabel.autoSize = TextFieldAutoSize.NONE;
      this.timerLabel.autoSize = TextFieldAutoSize.NONE;
      this.timerLabel.selectable = false;
      this.timerLabel.x = 2;
      this.timerLabel.y = 25;
      this.timerLabel.height = 24;
      this.timerLabel.size = 14;
      this.timerLabel.mouseEnabled = false;
      this.timerLabel.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      addChild(this.timerLabel);
      this.timerLabel.visible = false;
    }

    public function startTimer(param1:CountDownTimer) : void {
      enabled = false;
      this.timer = param1;
      if(param1.getRemainingSeconds() > 0) {
        this.showTime();
        param1.addListener(CountDownTimerOnCompleteAfter,this);
      }
    }

    private function showTime() : void {
      this.timerLabel.width = int(width) - 4;
      this.timerLabel.visible = true;
      this.timerLabel.start(this.timer);
      this.resize();
    }

    private function resize() : void {
      if(this.timerLabel.visible) {
        _label.y = 8;
      } else {
        _label.y = 15;
      }
    }

    public function hideTime() : void {
      if(this.timer != null) {
        this.timer.removeListener(CountDownTimerOnCompleteAfter,this);
        this.timer = null;
      }
      this.timerLabel.visible = false;
      this.timerLabel.stop();
      this.resize();
    }

    public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void {
      this.hideTime();
      dispatchEvent(new TimerButtonEvent(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON));
    }
  }
}
