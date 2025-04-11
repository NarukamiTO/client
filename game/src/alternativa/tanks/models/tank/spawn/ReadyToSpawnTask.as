package alternativa.tanks.models.tank.spawn {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.utils.MathUtils;
  import platform.client.fp10.core.type.IGameObject;

  public class ReadyToSpawnTask implements LogicUnit {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    private var readyTime:int;
    private var tank:Tank;
    private var battleEventSupport:BattleEventSupport;

    public function ReadyToSpawnTask(param1:int, param2:Tank) {
      super();
      this.readyTime = param1;
      this.tank = param2;
      this.initBattleEventListeners(battleEventDispatcher);
    }

    private function initBattleEventListeners(param1:BattleEventDispatcher) : void {
      this.battleEventSupport = new BattleEventSupport(param1);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinished);
      this.battleEventSupport.activateHandlers();
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:IGameObject = null;
      var local4:ITankSpawner = null;
      this.tank.getSkin().setAlpha(MathUtils.clamp((this.readyTime - param1) / 500,0,1));
      if(param1 > this.readyTime) {
        this.stop();
        local3 = this.tank.getUser();
        local4 = ITankSpawner(local3.adapt(ITankSpawner));
        local4.readyToSpawn();
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      if(param1.tank == this.tank) {
        this.stop();
      }
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      if(param1.tank == this.tank) {
        this.stop();
      }
    }

    private function onBattleFinished(param1:BattleFinishEvent) : void {
      this.stop();
    }

    private function stop() : void {
      battleService.getBattleRunner().removeLogicUnit(this);
      this.battleEventSupport.deactivateHandlers();
    }
  }
}
