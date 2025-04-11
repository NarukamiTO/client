package alternativa.tanks.models.tank.ultimate {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.EffectActivatedEvent;
  import alternativa.tanks.battle.events.EffectStoppedEvent;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.battle.events.LocalTankKilledEvent;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
  import alternativa.tanks.models.battle.gui.ultimate.UltimateIndicator;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.tank.AddToBattleListener;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.event.LocalTankLoadListener;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import flash.events.TimerEvent;
  import flash.geom.ColorTransform;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.common.IUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.common.UltimateModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class UltimateModel extends UltimateModelBase implements IUltimateModelBase, IUltimateModel, LocalTankLoadListener, LocalTankUnloadListener, ObjectLoadPostListener, UltimateStunListener, ObjectUnloadListener, AddToBattleListener, GameActionListener {
    [Inject]
    public static var inventorySoundService:InventorySoundService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private static const CHARGE_TIME_PERIOD_MILLIS:int = 100;
    private static const FULL_CHARGE:int = 100;

    private var battleEventSupport:BattleEventSupport;
    private var chargeTimer:Timer;
    private var chargePercentPerSecond:Number;
    private var chargeInPercent:Number = 0;
    private var localTankSpawned:Boolean;
    private var ultimateBlocked:Boolean = true;
    private var indicator:UltimateIndicator;
    private var activeUltimates:Dictionary = new Dictionary();

    public function UltimateModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivationEvent);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.onLocalTankKilled);
      this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestarted);
    }

    public static function parseColorTransform(param1:String) : ColorTransform {
      if(param1 == null || param1.length != 6) {
        return null;
      }
      var local2:Number = parseInt(param1.substr(0,2),16) / 255;
      var local3:Number = parseInt(param1.substr(2,2),16) / 255;
      var local4:Number = parseInt(param1.substr(4,2),16) / 255;
      return new ColorTransform(local2,local3,local4);
    }

    public function updateCharge(param1:int) : void {
      if(!battleInfoService.isSpectatorMode() && Boolean(localTankInfoService.isLocalTankLoaded()) && object == localTankInfoService.getLocalTankObject()) {
        this.setCharge(param1);
      }
    }

    private function onLocalTankActivationEvent(param1:Object) : void {
      this.markInventoryIndicatorDisabled(false);
      if(this.charged()) {
        this.indicator.onCharged();
      }
    }

    private function onBattleFinish(param1:BattleFinishEvent) : void {
      this.reset();
      this.markInventoryIndicatorDisabled(true);
    }

    private function onLocalTankKilled(param1:Object) : void {
      this.markInventoryIndicatorDisabled(true);
    }

    private function onBattleRestarted(param1:Object) : void {
      this.activeUltimates = new Dictionary();
      this.reset();
      this.localTankSpawned = true;
    }

    private function markInventoryIndicatorDisabled(param1:Boolean) : void {
      this.ultimateBlocked = param1;
      if(!battleInfoService.isSpectatorMode()) {
        this.indicator.markDisabled(param1);
      }
    }

    private function addChargeTimer() : void {
      this.chargeTimer = new Timer(CHARGE_TIME_PERIOD_MILLIS);
      this.chargeTimer.addEventListener(TimerEvent.TIMER,getFunctionWrapper(this.onChargeTick));
      this.chargeTimer.start();
    }

    public function ultimateUsed() : void {
      if(object == localTankInfoService.getLocalTankObjectOrNull()) {
        this.setCharge(0);
      }
      this.hideTitleIcon();
    }

    private function onChargeTick(param1:TimerEvent) : void {
      if(Boolean(battleService.isBattleActive()) && this.localTankSpawned) {
        this.addCharge(this.chargePercentPerSecond / 10);
      }
    }

    private function removeChargeTimer() : void {
      this.chargeTimer.stop();
      this.chargeTimer.removeEventListener(TimerEvent.TIMER,getFunctionWrapper(this.onChargeTick));
      this.chargeTimer = null;
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      var action:GameActionEnum = param1;
      var isActive:Boolean = param2;
      if(action == GameActionEnum.ULTIMATE && isActive && Boolean(localTankInfoService.isLocalTankLoaded())) {
        object = localTankInfoService.getLocalTankObject();
        try {
          if(this.canActivate()) {
            server.activateUltimate();
          } else {
            inventorySoundService.playNotReadySound();
          }
        }
        finally {
          Model.popObject();
        }
      }
    }

    private function canActivate() : Boolean {
      return !this.ultimateBlocked && this.charged() && this.isInActiveState();
    }

    private function isInActiveState() : Boolean {
      return ITankModel(object.adapt(ITankModel)).getTank().state == ClientTankState.ACTIVE;
    }

    private function charged() : Boolean {
      return this.chargeInPercent >= FULL_CHARGE;
    }

    public function reset() : void {
      this.localTankSpawned = false;
      this.setCharge(0);
    }

    public function resetCharge() : void {
      this.hideTitleIcon();
    }

    public function addCharge(param1:Number) : void {
      if(this.charged()) {
        return;
      }
      var local2:Number = this.chargeInPercent + param1;
      if(local2 > 99) {
        local2 = 99;
      }
      this.setCharge(local2);
    }

    public function showUltimateCharged() : void {
      this.activeUltimates[object] = true;
      if(!battleInfoService.isSpectatorMode() && object == localTankInfoService.getLocalTankObject()) {
        this.setCharge(FULL_CHARGE);
        if(this.isInActiveState()) {
          this.indicator.onCharged();
        }
      }
      this.showTitleIcon();
    }

    public function objectLoadedPost() : void {
      if(getInitParam().enabled && getInitParam().charged) {
        this.activeUltimates[object] = true;
        this.showTitleIcon();
      }
    }

    private function setCharge(param1:Number) : void {
      if(Boolean(localTankInfoService.isLocalTankLoaded()) && object == localTankInfoService.getLocalTankObject() && this.indicator != null) {
        this.chargeInPercent = param1;
        this.indicator.updateCharge(param1);
      }
    }

    public function objectUnloaded() : void {
      delete this.activeUltimates[object];
    }

    public function localTankLoaded(param1:Boolean) : void {
      if(getInitParam().enabled && !param1) {
        this.localTankSpawned = true;
        this.chargePercentPerSecond = getInitParam().chargePercentPerSecond;
        this.addChargeTimer();
        battleInputService.addGameActionListener(this);
      }
    }

    public function initIndicator() : void {
      if(Boolean(localTankInfoService.isLocalTankLoaded()) && object == localTankInfoService.getLocalTankObject()) {
        if(this.indicator != null) {
          this.indicator.destroy();
        }
        this.indicator = new UltimateIndicator(this.getUltimateIndex());
        this.setCharge(0);
        this.battleEventSupport.activateHandlers();
      }
    }

    private function getUltimateIndex() : int {
      var local1:IGameObject = ITankModel(object.adapt(ITankModel)).getTankSet().hull;
      return HullCommon(local1.adapt(HullCommon)).getUltimateIconIndex();
    }

    public function localTankUnloaded(param1:Boolean) : void {
      if(getInitParam().enabled && !param1) {
        battleInputService.removeGameActionListener(this);
        this.removeChargeTimer();
        this.battleEventSupport.deactivateHandlers();
        this.indicator.destroy();
        this.indicator = null;
      }
    }

    public function updateChargeAndRate(param1:int, param2:Number) : void {
      this.chargePercentPerSecond = param2;
      this.setCharge(param1);
    }

    public function onAddToBattle() : void {
      if(getInitParam().enabled) {
        if(Boolean(this.activeUltimates[object])) {
          this.showTitleIcon();
        }
      }
    }

    private function showTitleIcon() : void {
      battleEventDispatcher.dispatchEvent(new EffectActivatedEvent(object.id,InventoryItemType.ULTIMATE,int.MAX_VALUE));
    }

    private function hideTitleIcon() : void {
      delete this.activeUltimates[object];
      battleEventDispatcher.dispatchEvent(new EffectStoppedEvent(object.id,InventoryItemType.ULTIMATE));
    }

    public function isUltimateEnabled() : Boolean {
      return getInitParam().enabled;
    }

    public function ultimateRejected() : void {
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        this.markInventoryIndicatorDisabled(true);
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        this.markInventoryIndicatorDisabled(false);
      }
    }

    public function effectDeactivated() : void {
      if(this.indicator != null) {
        this.indicator.effectDeactivated();
      }
    }

    public function effectActivatedOrMerged(param1:int) : void {
      if(this.indicator != null) {
        this.indicator.effectActivatedOrMerged(param1);
      }
    }
  }
}
