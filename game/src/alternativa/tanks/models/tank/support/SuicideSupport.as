package alternativa.tanks.models.tank.support {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.PauseActivationEvent;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import alternativa.tanks.battle.events.reload.ReloadActivateEvent;
  import alternativa.tanks.battle.events.reload.ReloadDeactivateEvent;
  import alternativa.tanks.battle.events.suicide.SuicideActivationEvent;
  import alternativa.tanks.battle.events.suicide.SuicideDeactivationEvent;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.gui.indicators.SuicideIndicator;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.suicide.SuicideModelServer;

  public class SuicideSupport implements AutoClosable, BattleEventListener, LogicUnit {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInputLockService:BattleInputService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var keysBindingService:KeysBindingService;

    private static const SUICIDE_PING_DELAY:int = 1000;
    private static const PRIORITY_KEY_DOWN_LISTENER:int = 1;

    private var SUICIDE_DELAY:int;
    private var _user:IGameObject;
    private var _server:SuicideModelServer;
    private var _requested:Boolean;
    private var _tankInBattle:Boolean;
    private var _pauseEnable:Boolean;
    private var _rearmorEnable:Boolean;
    private var _suicideIndicator:SuicideIndicator;
    private var _idleTimeoutEndTime:int;

    public function SuicideSupport(param1:IGameObject, param2:SuicideModelServer, param3:int) {
      super();
      this.SUICIDE_DELAY = param3 + SUICIDE_PING_DELAY;
      this._user = param1;
      this._server = param2;
      this.init();
    }

    private function init() : void {
      this._suicideIndicator = new SuicideIndicator();
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,PRIORITY_KEY_DOWN_LISTENER);
      display.stage.addEventListener(Event.ACTIVATE,this.onActivate);
      display.stage.addEventListener(Event.DEACTIVATE,this.onDeactivate);
      battleEventDispatcher.addBattleEventListener(TankAddedToBattleEvent,this);
      battleEventDispatcher.addBattleEventListener(TankRemovedFromBattleEvent,this);
      battleEventDispatcher.addBattleEventListener(BattleFinishEvent,this);
      battleEventDispatcher.addBattleEventListener(TankUnloadedEvent,this);
      battleEventDispatcher.addBattleEventListener(TankDeadEvent,this);
      battleEventDispatcher.addBattleEventListener(ReloadActivateEvent,this);
      battleEventDispatcher.addBattleEventListener(ReloadDeactivateEvent,this);
      battleEventDispatcher.addBattleEventListener(PauseActivationEvent,this);
      battleEventDispatcher.addBattleEventListener(PauseDeactivationEvent,this);
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local2:GameActionEnum = keysBindingService.getBindingAction(param1.keyCode);
      if(local2 == GameActionEnum.SUICIDE || param1.keyCode == Keyboard.BACKSLASH && param1.ctrlKey) {
        this.requestSuicide();
      }
    }

    private function onActivate(param1:Event) : void {
      this._suicideIndicator.visible = true;
    }

    private function onDeactivate(param1:Event) : void {
      this._suicideIndicator.visible = false;
    }

    private function requestSuicide() : void {
      if(this.canRequest()) {
        this.showIndicator();
        this._requested = true;
        Model.object = this._user;
        this._server.suicideCommand();
        Model.popObject();
      }
    }

    private function showIndicator() : void {
      this._idleTimeoutEndTime = getTimer() + this.SUICIDE_DELAY;
      this._suicideIndicator.show(this.SUICIDE_DELAY / 1000);
      battleService.getBattleRunner().addLogicUnit(this);
      battleEventDispatcher.dispatchEvent(new SuicideActivationEvent());
    }

    private function canRequest() : Boolean {
      var local1:ITankModel = ITankModel(this._user.adapt(ITankModel));
      var local2:Tank = local1.getTank();
      return Boolean(battleService.isBattleActive()) && !this._requested && !this._pauseEnable && !this._rearmorEnable && !battleInputLockService.isInputLocked() && this._tankInBattle && local2.state == ClientTankState.ACTIVE && !local2.stunned;
    }

    public function runLogic(param1:int, param2:int) : void {
      this._suicideIndicator.seconds = Math.max((this._idleTimeoutEndTime - param1) / 1000,0);
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is TankAddedToBattleEvent) {
        this.onTankAddedToBattle(TankAddedToBattleEvent(param1));
      } else if(param1 is TankRemovedFromBattleEvent) {
        this.onTankRemovedFromBattle(TankRemovedFromBattleEvent(param1));
      } else if(param1 is BattleFinishEvent) {
        this.hideIndicator();
      } else if(param1 is TankUnloadedEvent) {
        this.onTankUnload(TankUnloadedEvent(param1));
      } else if(param1 is TankDeadEvent) {
        this.onTankDead(TankDeadEvent(param1));
      } else if(param1 is ReloadActivateEvent) {
        this._rearmorEnable = true;
      } else if(param1 is ReloadDeactivateEvent) {
        this._rearmorEnable = false;
      } else if(param1 is PauseActivationEvent) {
        this._pauseEnable = true;
      } else if(param1 is PauseDeactivationEvent) {
        this._pauseEnable = false;
      }
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      var local2:Tank = param1.tank;
      if(local2.getUser() == this._user) {
        this._requested = false;
        this._tankInBattle = true;
      }
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      var local2:Tank = param1.tank;
      if(local2.getUser() == this._user) {
        this._tankInBattle = false;
      }
    }

    private function onTankUnload(param1:TankUnloadedEvent) : void {
      if(this._user == param1.tank.getUser()) {
        this.hideIndicator();
      }
    }

    private function hideIndicator() : void {
      battleService.getBattleRunner().removeLogicUnit(this);
      this._suicideIndicator.hide();
      battleEventDispatcher.dispatchEvent(new SuicideDeactivationEvent());
    }

    private function onTankDead(param1:TankDeadEvent) : void {
      if(this._user == param1.victim) {
        this.hideIndicator();
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      display.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
      display.stage.removeEventListener(Event.DEACTIVATE,this.onDeactivate);
      battleEventDispatcher.removeBattleEventListener(TankAddedToBattleEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankRemovedFromBattleEvent,this);
      battleEventDispatcher.removeBattleEventListener(BattleFinishEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankUnloadedEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankDeadEvent,this);
      battleEventDispatcher.removeBattleEventListener(ReloadActivateEvent,this);
      battleEventDispatcher.removeBattleEventListener(ReloadDeactivateEvent,this);
      battleEventDispatcher.removeBattleEventListener(PauseActivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(PauseDeactivationEvent,this);
      this._suicideIndicator.destroy();
      this._suicideIndicator = null;
      this._user = null;
      this._server = null;
    }
  }
}
