package alternativa.tanks.models.tank.turnover {
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.event.LocalTankLoadListener;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
  import alternativa.tanks.models.tank.support.TurnOverIndicatorSupport;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.turnover.ITankTurnOverModelBase;
  import projects.tanks.client.battlefield.models.user.turnover.TankTurnOverModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class TankTurnOverModel extends TankTurnOverModelBase implements ITankTurnOverModelBase, LocalTankLoadListener, BattleEventListener, LocalTankUnloadListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private const CHECK_DELAY:int = 100;
    private const SHOW_DELAY:int = 4000;
    private const RANK_THRESHOLD:int = 5;

    private var localUser:IGameObject;
    private var timer:Timer;
    private var lastTurnedTime:int;
    private var wasTurnedOver:Boolean;
    private var isInsideBattle:Boolean;
    private var indicatorSupport:TurnOverIndicatorSupport;

    public function TankTurnOverModel() {
      super();
    }

    public function localTankLoaded(param1:Boolean) : void {
      this.localUser = object;
      this.timer = new Timer(this.CHECK_DELAY);
      this.indicatorSupport = new TurnOverIndicatorSupport();
      putData(TurnOverIndicatorSupport,this.indicatorSupport);
      this.addEventHandlers();
      this.timer.start();
    }

    private function checkTurnOverHandler(param1:TimerEvent) : void {
      if(this.isTurnedOver()) {
        if(!this.wasTurnedOver) {
          this.lastTurnedTime = getTimer();
          this.wasTurnedOver = true;
        }
      } else {
        this.wasTurnedOver = false;
      }
      if(this.shouldShowIndicator()) {
        this.indicatorSupport.shouldShow();
      } else {
        this.indicatorSupport.hide();
      }
    }

    private function isTurnedOver() : Boolean {
      var local1:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
      var local2:Tank = local1.getTank();
      return BattleUtils.isTurnedOver(local2.getBody());
    }

    private function shouldShowIndicator() : Boolean {
      return this.isInsideBattle && this.wasTurnedOver && this.timeSinceTurned() > this.SHOW_DELAY && userPropertiesService.rank <= this.RANK_THRESHOLD;
    }

    private function timeSinceTurned() : int {
      return getTimer() - this.lastTurnedTime;
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is BattleFinishEvent) {
        this.resetTurnOverState(false);
      } else if(param1 is TankDeadEvent) {
        if(this.localUser == TankDeadEvent(param1).victim) {
          this.resetTurnOverState(false);
        }
      } else if(param1 is TankAddedToBattleEvent) {
        if(this.localUser == TankAddedToBattleEvent(param1).tank.getUser()) {
          this.resetTurnOverState(true);
        }
      } else if(param1 is TankRemovedFromBattleEvent) {
        if(this.localUser == TankRemovedFromBattleEvent(param1).tank.getUser()) {
          this.resetTurnOverState(false);
        }
      }
    }

    private function resetTurnOverState(param1:Boolean) : void {
      this.isInsideBattle = param1;
      this.wasTurnedOver = false;
      this.lastTurnedTime = 0;
      this.indicatorSupport.hide();
    }

    private function addEventHandlers() : void {
      this.timer.addEventListener(TimerEvent.TIMER,this.checkTurnOverHandler);
      battleEventDispatcher.addBattleEventListener(BattleFinishEvent,this);
      battleEventDispatcher.addBattleEventListener(TankDeadEvent,this);
      battleEventDispatcher.addBattleEventListener(TankAddedToBattleEvent,this);
      battleEventDispatcher.addBattleEventListener(TankRemovedFromBattleEvent,this);
    }

    private function removeEventHandlers() : void {
      this.timer.removeEventListener(TimerEvent.TIMER,this.checkTurnOverHandler);
      battleEventDispatcher.removeBattleEventListener(BattleFinishEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankDeadEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankAddedToBattleEvent,this);
      battleEventDispatcher.removeBattleEventListener(TankRemovedFromBattleEvent,this);
    }

    public function localTankUnloaded(param1:Boolean) : void {
      this.timer.stop();
      this.removeEventHandlers();
      this.timer = null;
      this.lastTurnedTime = 0;
      this.wasTurnedOver = false;
      this.isInsideBattle = false;
      this.indicatorSupport = null;
    }
  }
}
