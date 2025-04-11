package alternativa.tanks.models.battle.gui.gui.statistics.field.timelimit {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkManager;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkingField;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.getTimer;

  public class TimeLimitField extends WinkingField {
    private var timer:Timer;
    private var targetTime:uint;
    private var onlySeconds:Boolean;

    public function TimeLimitField(param1:int, param2:DisplayObject, param3:WinkManager, param4:Boolean) {
      super(param1,param2,param3);
      this.onlySeconds = param4;
      this.timer = new Timer(1000);
      this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
    }

    private static function getMinutes(param1:int) : String {
      var local2:int = param1 / 60;
      return local2 > 9 ? local2.toString() : "0" + local2.toString();
    }

    private static function getSeconds(param1:int) : String {
      var local2:int = param1 % 60;
      return local2 > 9 ? local2.toString() : "0" + local2.toString();
    }

    public function startCountdown(param1:int) : void {
      this.targetTime = Math.round(getTimer() / 1000 + param1);
      value = param1;
      if(_value > 0) {
        this.timer.stop();
        this.timer.start();
      } else {
        stopWink();
      }
    }

    public function stopCountdown() : void {
      this.timer.stop();
    }

    override protected function updateLabel() : void {
      if(this.onlySeconds) {
        label.text = _value < 10 ? "0" + _value.toString() : _value.toString();
      } else {
        label.text = getMinutes(_value) + " : " + getSeconds(_value);
      }
    }

    override protected function onRemovedFromStage(param1:Event) : void {
      super.onRemovedFromStage(param1);
      this.timer.stop();
    }

    private function onTimer(param1:TimerEvent) : void {
      var local2:int = 0;
      if(_value > 0) {
        local2 = Math.round(this.targetTime - getTimer() / 1000);
        value = local2 < 0 ? 0 : local2;
      } else {
        this.timer.stop();
      }
    }
  }
}
