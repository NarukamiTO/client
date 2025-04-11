package alternativa.tanks.models.battle.gui.drone {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.TankActivationEvent;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
  import alternativa.tanks.models.battle.gui.inventory.InventoryItem;
  import alternativa.tanks.models.drones.Drone;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.TankSet;
  import alternativa.tanks.models.tank.configuration.TankConfiguration;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.sfx.drone.DroneSFX;
  import alternativa.tanks.sfx.drone.DroneSFXData;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.drone.DroneIndicatorCC;
  import projects.tanks.client.battlefield.models.drone.DroneIndicatorModelBase;
  import projects.tanks.client.battlefield.models.drone.IDroneIndicatorModelBase;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;
  import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;

  [ModelInfo]
  public class DroneIndicatorModel extends DroneIndicatorModelBase implements IDroneIndicatorModelBase, IDroneModel, TankEntityCreationListener, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var inventoryPanel:IInventoryPanel;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var settingsChangedService:UserSettingsChangedService;

    private var localTank:Tank;
    private var droneIndicatorItem:InventoryItem;
    private var battleEventSupport:BattleEventSupport;
    private var drones:Dictionary = new Dictionary();

    public function DroneIndicatorModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankActivationEvent,this.onTankActivation);
      this.battleEventSupport.addEventHandler(TankDeadEvent,this.onTankDeactivation);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoad);
      this.battleEventSupport.activateHandlers();
    }

    public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var local4:DroneIndicatorCC = this.getSavedState();
      if(local4 == null) {
        putData(DroneIndicatorCC,getInitParam());
      }
      this.initDrones(param1,param2,param3);
      this.getSavedState().timeToReloadMs = 0;
      if(param2) {
        this.localTank = param1;
        this.updateBatteryIndicator();
      }
    }

    private function updateBatteryIndicator() : void {
      inventoryPanel.setVisible(InventoryItemType.BATTERY,this.hasDrone(),false);
    }

    public function initDrones(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var local4:DroneIndicatorCC = null;
      var local5:IInventoryModel = null;
      if(this.hasDrone()) {
        local4 = DroneIndicatorCC(getData(DroneIndicatorCC));
        if(param2) {
          this.droneIndicatorItem = new InventoryItem(null,InventoryItemType.BATTERY,local4.batteryAmount,null);
          inventoryPanel.assignItemToSlot(this.droneIndicatorItem,InventoryItemType.BATTERY);
          if(local4.timeToReloadMs != 0) {
            inventoryPanel.activateCooldown(InventoryItemType.BATTERY,local4.timeToReloadMs);
          }
          local5 = IInventoryModel(battleService.getBattle().adapt(IInventoryModel));
          local5.lockItem(InventoryItemType.BATTERY,InventoryLock.FORCED,!local4.droneReady);
        }
        this.initDrone(param1,param2);
        this.setCooldownState(param1,local4.timeToReloadMs);
        this.setDroneState(param1,local4.droneReady);
        if(!param2) {
          this.onTankActiveStateChanged(param1,param3 == TankLogicState.ACTIVE);
        }
      }
    }

    public function ready() : void {
      this.setDroneReadiness(true);
    }

    public function notReady() : void {
      this.setDroneReadiness(false);
    }

    public function reload(param1:int) : void {
      var local2:Tank = object.adapt(ITankModel).getTank();
      this.cooldown(local2,param1);
      if(local2 == this.localTank) {
        inventoryPanel.activateCooldown(InventoryItemType.BATTERY,param1);
      }
    }

    public function setDroneReadiness(param1:Boolean) : void {
      var local3:IInventoryModel = null;
      var local2:Tank = object.adapt(ITankModel).getTank();
      this.setDroneState(local2,param1);
      this.getSavedState().droneReady = param1;
      if(local2 == this.localTank) {
        inventoryPanel.setVisible(InventoryItemType.BATTERY,this.hasDrone(),false);
        local3 = IInventoryModel(battleService.getBattle().adapt(IInventoryModel));
        local3.lockItem(InventoryItemType.BATTERY,InventoryLock.FORCED,!param1);
      }
    }

    public function setBatteriesAmount(param1:int) : void {
      this.droneIndicatorItem.count = param1;
      this.getSavedState().batteryAmount = param1;
      inventoryPanel.itemUpdateCount(this.droneIndicatorItem);
    }

    private function initDrone(param1:Tank, param2:Boolean) : void {
      var local3:TankConfiguration = TankConfiguration(param1.user.adapt(TankConfiguration));
      var local4:TankSet = ITankModel(object.adapt(ITankModel)).getTankSet();
      var local5:Tanks3DSResource = IObject3DS(local4.drone.adapt(IObject3DS)).getResource3DS();
      var local6:DroneSFXData = DroneSFX(local4.drone.adapt(DroneSFX)).getSfxData();
      var local7:IColoring = IColoring(local3.getColoringObject().adapt(IColoring));
      this.drones[param1] = new Drone(param1,param2,battleService,local5,settingsService,textureMaterialRegistry,local7,local6);
    }

    private function cooldown(param1:Tank, param2:int) : void {
      var local3:Drone = this.drones[param1];
      if(local3 != null) {
        local3.cooldown(param2);
      }
    }

    private function setDroneState(param1:Tank, param2:Boolean) : void {
      var local3:Drone = this.drones[param1];
      if(local3 != null) {
        local3.setState(param2);
      }
    }

    private function setCooldownState(param1:Tank, param2:int) : void {
      var local3:Drone = this.drones[param1];
      if(local3 != null) {
        local3.setInitialCooldownState(param2);
      }
    }

    private function hasDrone() : Boolean {
      return ITankModel(object.adapt(ITankModel)).getTankSet().drone != null;
    }

    private function onTankActivation(param1:TankActivationEvent) : void {
      this.onTankActiveStateChanged(param1.tank,true);
    }

    private function onTankDeactivation(param1:TankDeadEvent) : void {
      this.onTankActiveStateChanged(ITankModel(param1.victim.adapt(ITankModel)).getTank(),false);
    }

    private function onBattleFinish(param1:BattleFinishEvent) : void {
      var local2:Drone = null;
      for each(local2 in this.drones) {
        local2.onTankActiveStateChanged(false);
      }
    }

    private function onTankActiveStateChanged(param1:Tank, param2:Boolean) : void {
      var local3:Drone = this.drones[param1];
      if(local3 != null) {
        local3.onTankActiveStateChanged(param2);
      }
    }

    private function onSettingsChanged(param1:UserSettingsChangedEvent) : void {
      var local2:Drone = null;
      for each(local2 in this.drones) {
        local2.updateGameSettings();
      }
    }

    public function objectLoaded() : void {
      settingsChangedService.addEventListener(UserSettingsChangedEvent.TYPE,this.onSettingsChanged);
    }

    public function objectUnloaded() : void {
      settingsChangedService.removeEventListener(UserSettingsChangedEvent.TYPE,this.onSettingsChanged);
      this.destroy();
    }

    private function destroy() : void {
      var local1:Tank = ITankModel(object.adapt(ITankModel)).getTank();
      this.destroyDroneForTank(local1);
    }

    private function destroyDroneForTank(param1:Tank) : void {
      var local2:Drone = this.drones[param1];
      if(local2 != null) {
        if(Boolean(local2.getCurrentRenderer())) {
          local2.getCurrentRenderer().stop();
        }
        local2.destroy();
      }
      delete this.drones[param1];
    }

    private function getSavedState() : DroneIndicatorCC {
      return DroneIndicatorCC(getData(DroneIndicatorCC));
    }

    private function onTankLoad(param1:TankLoadedEvent) : void {
      if(param1.isLocal) {
        this.localTank = param1.tank;
        this.updateBatteryIndicator();
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete global[this.destroyDroneForTank(param1.tank)];
    }

    public function canOverheal() : Boolean {
      return getInitParam().canOverheal;
    }
  }
}
