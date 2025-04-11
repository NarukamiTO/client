package alternativa.tanks.battle {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.SpeedHackEvent;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.getTimer;

  public class SpeedHackChecker {
    [Inject]
    public static var clientLog:IClientLog;

    private const checkInterval:EncryptedInt = new EncryptedIntImpl(15000);
    private const threshold:EncryptedInt = new EncryptedIntImpl(300);
    private const maxErrors:EncryptedInt = new EncryptedIntImpl(3);
    private const errorCounter:EncryptedInt = new EncryptedIntImpl(0);

    private var battleEventDispatcher:BattleEventDispatcher;
    private var timer:Timer;
    private var localTime:int;
    private var systemTime:Number;
    private var deltas:Array = [];

    public function SpeedHackChecker(param1:BattleEventDispatcher) {
      super();
      this.battleEventDispatcher = param1;
      this.localTime = getTimer();
      this.systemTime = new Date().time;
      this.timer = new Timer(this.checkInterval.getInt());
      this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      this.timer.start();
    }

    public function stop() : void {
      this.timer.stop();
    }

    private function onTimer(param1:TimerEvent) : void {
      var local2:int = getTimer();
      var local3:Number = new Date().time;
      var local4:Number = local2 - this.localTime - local3 + this.systemTime;
      if(Math.abs(local4) > this.threshold.getInt()) {
        this.deltas.push(local4);
        this.errorCounter.setInt(this.errorCounter.getInt() + 1);
        if(this.errorCounter.getInt() >= this.maxErrors.getInt()) {
          this.stop();
          this.battleEventDispatcher.dispatchEvent(new SpeedHackEvent(this.deltas));
        }
      } else {
        this.errorCounter.setInt(0);
        this.deltas.length = 0;
      }
      this.localTime = local2;
      this.systemTime = local3;
    }
  }
}
