package alternativa.tanks.models.tank.support {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import alternativa.tanks.battle.events.reload.ReloadActivateEvent;
  import alternativa.tanks.battle.events.reload.ReloadDeactivateEvent;
  import alternativa.tanks.battle.events.reload.ReloadScheduledEvent;
  import alternativa.tanks.models.battle.gui.indicators.ReloaderIndicator;
  import flash.events.Event;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;

  public class TankReloaderSupport implements AutoClosable, BattleEventListener, LogicUnit {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    private static const ADDITIONAL_DELAY_TIME_MS:int = 900;

    private var _user:IGameObject;
    private var _idleTimeoutEndTime:int;
    private var _reloaderIndicator:ReloaderIndicator;

    public function TankReloaderSupport(param1:IGameObject) {
      super();
      this._user = param1;
      this.init();
    }

    private function init() : void {
      this._reloaderIndicator = new ReloaderIndicator();
      display.stage.addEventListener(Event.ACTIVATE,this.onActivate);
      display.stage.addEventListener(Event.DEACTIVATE,this.onDeactivate);
      battleEventDispatcher.addBattleEventListener(ReloadScheduledEvent,this);
      battleEventDispatcher.addBattleEventListener(BattleFinishEvent,this);
      battleEventDispatcher.addBattleEventListener(TankUnloadedEvent,this);
      battleEventDispatcher.addBattleEventListener(TankDeadEvent,this);
    }

    private function onActivate(param1:Event) : void {
      this._reloaderIndicator.visible = true;
    }

    private function onDeactivate(param1:Event) : void {
      this._reloaderIndicator.visible = false;
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is ReloadScheduledEvent) {
        this.showIndicator(ReloadScheduledEvent(param1).suicideDelayMS + ADDITIONAL_DELAY_TIME_MS);
      } else if(param1 is BattleFinishEvent) {
        this.hideIndicator();
      } else if(param1 is TankUnloadedEvent) {
        this.onTankUnload(TankUnloadedEvent(param1));
      } else if(param1 is TankDeadEvent) {
        this.onTankDead(TankDeadEvent(param1));
      }
    }

    private function showIndicator(param1:int) : void {
      this._idleTimeoutEndTime = getTimer() + param1;
      this._reloaderIndicator.show(param1 / 1000);
      battleService.getBattleRunner().addLogicUnit(this);
      battleEventDispatcher.dispatchEvent(new ReloadActivateEvent());
    }

    private function hideIndicator() : void {
      battleService.getBattleRunner().removeLogicUnit(this);
      this._reloaderIndicator.hide();
      battleEventDispatcher.dispatchEvent(new ReloadDeactivateEvent());
    }

    public function runLogic(param1:int, param2:int) : void {
      this._reloaderIndicator.seconds = Math.max((this._idleTimeoutEndTime - param1) / 1000,0);
    }

    private function onTankUnload(param1:TankUnloadedEvent) : void {
      if(this._user == param1.tank.getUser()) {
        this.hideIndicator();
      }
    }

    private function onTankDead(param1:TankDeadEvent) : void {
      if(this._user == param1.victim) {
        this.hideIndicator();
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      display.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
      display.stage.removeEventListener(Event.DEACTIVATE,this.onDeactivate);
      battleEventDispatcher.removeBattleEventListener(ReloadScheduledEvent,this);
      battleEventDispatcher.removeBattleEventListener(BattleFinishEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankUnloadedEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankDeadEvent,this);
      this._reloaderIndicator.destroy();
      this._reloaderIndicator = null;
      this._user = null;
    }
  }
}
