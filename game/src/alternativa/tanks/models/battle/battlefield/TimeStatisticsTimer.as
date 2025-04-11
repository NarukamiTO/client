package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import flash.utils.getTimer;

  public class TimeStatisticsTimer extends BattleRunnerProvider implements LogicUnit, BattleEventListener {
    private static const DELAY:int = 60000;

    private var battleEventsDispatcher:BattleEventDispatcher;
    private var startTime:int;

    public function TimeStatisticsTimer(param1:BattleEventDispatcher) {
      super();
      this.battleEventsDispatcher = param1;
    }

    public function start() : void {
      this.battleEventsDispatcher.addBattleEventListener(BattleFinishEvent,this);
      this.battleEventsDispatcher.addBattleEventListener(BattleUnloadEvent,this);
      this.startTime = getTimer();
      getBattleRunner().addLogicUnit(this);
    }

    public function handleBattleEvent(param1:Object) : void {
      this.destroy();
    }

    public function runLogic(param1:int, param2:int) : void {
      if(param1 - this.startTime > DELAY) {
        this.battleEventsDispatcher.dispatchEvent(new TimeStatisticsTimerEvent());
        this.destroy();
      }
    }

    private function destroy() : void {
      getBattleRunner().removeLogicUnit(this);
      this.battleEventsDispatcher.removeBattleEventListener(BattleFinishEvent,this);
      this.battleEventsDispatcher.removeBattleEventListener(BattleUnloadEvent,this);
    }
  }
}
