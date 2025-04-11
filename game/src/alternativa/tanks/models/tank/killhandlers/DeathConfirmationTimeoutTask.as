package alternativa.tanks.models.tank.killhandlers {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;

  public class DeathConfirmationTimeoutTask implements LogicUnit, BattleEventListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    private static const DEATH_CONFIRMATION_TIMEOUT_MS:int = 2000;
    private static const EVENTS:Array = [TankUnloadedEvent,TankDeadEvent,TankRemovedFromBattleEvent];

    private var object:IGameObject;
    private var triggerTime:int;
    private var callback:Function;

    public function DeathConfirmationTimeoutTask() {
      super();
    }

    public function start(param1:IGameObject, param2:Function) : void {
      var local3:Class = null;
      if(this.object != null) {
        throw new Error();
      }
      this.object = param1;
      this.callback = param2;
      this.triggerTime = getTimer() + DEATH_CONFIRMATION_TIMEOUT_MS;
      battleService.getBattleRunner().addLogicUnit(this);
      for each(local3 in EVENTS) {
        battleEventDispatcher.addBattleEventListener(local3,this);
      }
    }

    public function runLogic(param1:int, param2:int) : void {
      if(param1 > this.triggerTime) {
        this.stop();
        this.callback(this.object);
        this.callback = null;
      }
    }

    private function stop() : void {
      var local1:Class = null;
      battleService.getBattleRunner().removeLogicUnit(this);
      for each(local1 in EVENTS) {
        battleEventDispatcher.removeBattleEventListener(local1,this);
      }
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is TankUnloadedEvent) {
        this.handleTankUnloadedEvent(TankUnloadedEvent(param1));
      } else if(param1 is TankRemovedFromBattleEvent) {
        this.handleTankRemovedFromBattleEvent(TankRemovedFromBattleEvent(param1));
      } else if(param1 is TankDeadEvent) {
        this.handleTankDeadEvent(TankDeadEvent(param1));
      }
    }

    private function handleTankUnloadedEvent(param1:TankUnloadedEvent) : void {
      this.stopIfOurUser(param1.tank.getUser());
    }

    private function handleTankRemovedFromBattleEvent(param1:TankRemovedFromBattleEvent) : void {
      this.stopIfOurUser(param1.tank.getUser());
    }

    private function handleTankDeadEvent(param1:TankDeadEvent) : void {
      this.stopIfOurUser(param1.victim);
    }

    private function stopIfOurUser(param1:IGameObject) : void {
      if(param1 == this.object) {
        this.stop();
      }
    }
  }
}
