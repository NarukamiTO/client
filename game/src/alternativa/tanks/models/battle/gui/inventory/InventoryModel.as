package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.EffectActivatedEvent;
  import alternativa.tanks.battle.events.EffectStoppedEvent;
  import alternativa.tanks.battle.events.InventorySlotReadyToUseEvent;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.battle.events.LocalTankKilledEvent;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battlegui.BattleGUIServiceEvent;
  import alternativa.tanks.services.battleinput.BattleInputLockEvent;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import controls.InventoryIcon;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.battle.gui.inventory.IInventoryModelBase;
  import projects.tanks.client.battlefield.models.battle.gui.inventory.InventoryModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class InventoryModel extends InventoryModelBase implements IInventoryModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, IInventoryPanel, IInventoryModel, GameActionListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var tankUsersRegistry:TankUsersRegistry;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var inventorySoundService:InventorySoundService;

    [Inject]
    public static var modelRegistry:ModelRegistry;

    public static const PANEL_OFFSET_Y:int = 50;
    public static const GAP_BETWEEN_ITEM:int = 10;

    private var container:DisplayObjectContainer;
    private var inventorySlots:Dictionary;
    private var slotIndexByGameAction:Dictionary = new Dictionary();
    private var battleEventSupport:BattleEventSupport;
    private var iconWithGapSize:int;

    public function InventoryModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivationEvent);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.onLocalTankKilled);
      this.battleEventSupport.addEventHandler(EffectActivatedEvent,this.onEffectActivatedEvent);
      this.battleEventSupport.addEventHandler(EffectStoppedEvent,this.onEffectStoppedEvent);
      this.battleEventSupport.addEventHandler(InventorySlotReadyToUseEvent,this.onInventorySlotReadyToUseEvent);
    }

    private function onEffectActivatedEvent(param1:EffectActivatedEvent) : void {
      var local2:ITankModel = null;
      var local3:InventoryPanelSlot = null;
      if(!this.isSpecialEffect(param1.effectId)) {
        local2 = ITankModel(tankUsersRegistry.getUser(param1.userId).adapt(ITankModel));
        if(local2.isLocal()) {
          local3 = this.inventorySlots[param1.effectId];
          local3.activeAfterDeath = param1.activeAfterDeath;
        }
      }
    }

    private function isSpecialEffect(param1:int) : Boolean {
      return param1 <= 0;
    }

    private function onEffectStoppedEvent(param1:EffectStoppedEvent) : void {
      var local2:InventoryPanelSlot = null;
      if(!this.isSpecialEffect(param1.effectId)) {
        if(ITankModel(tankUsersRegistry.getUser(param1.userId).adapt(ITankModel)).isLocal()) {
          local2 = this.inventorySlots[param1.effectId];
          if(local2.activeAfterDeath) {
            local2.activeAfterDeath = false;
          }
        }
      }
    }

    private function onBattleFinish(param1:BattleFinishEvent) : void {
      this.lockItems(InventoryLock.PLAYER_INACTIVE,true);
      this.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
    }

    private function onLocalTankKilled(param1:Object) : void {
      this.lockItemsAfterDeath();
    }

    public function lockItemsAfterDeath() : void {
      var local1:InventoryPanelSlot = null;
      for each(local1 in this.inventorySlots) {
        if(!local1.activeAfterDeath) {
          local1.setLockMask(InventoryLock.PLAYER_INACTIVE,true);
        }
      }
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.container = new Sprite();
      this.container.visible = false;
      battleGuiService.resetPositionXInventory();
      battleGuiService.getGuiContainer().addChild(this.container);
      this.battleEventSupport.activateHandlers();
      this.bindKeys();
    }

    public function objectLoadedPost() : void {
      this.initSlots();
      OSGi.getInstance().registerService(IInventoryPanel,this);
    }

    private function initSlots() : void {
      if(this.isDisableInventoryInBattle()) {
        return;
      }
      this.iconWithGapSize = GAP_BETWEEN_ITEM + new InventoryIcon(InventoryIcon.EMPTY).width;
      this.inventorySlots = new Dictionary();
      if(!battleInfoService.withoutSupplies || !battleInfoService.withoutBonuses) {
        this.createSlot(InventoryItemType.FIRST_AID);
        this.createSlot(InventoryItemType.ARMOR);
        this.createSlot(InventoryItemType.DAMAGE);
        this.createSlot(InventoryItemType.NITRO);
        this.createSlot(InventoryItemType.MINE);
        this.createSlot(InventoryItemType.GOLD);
        this.inventorySlots[InventoryItemType.GOLD].getCanvas().visible = false;
      }
      this.createSlot(InventoryItemType.BATTERY);
      this.onResize();
      this.container.visible = true;
      battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      display.stage.addEventListener(Event.RESIZE,this.onResize,false,-1);
      battleGuiService.addEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onChangePositionDefaultLayout);
      display.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function isDisableInventoryInBattle() : Boolean {
      return Boolean(battleInfoService.withoutSupplies) && Boolean(battleInfoService.withoutBonuses) && Boolean(battleInfoService.withoutDrones) || Boolean(battleInfoService.isSpectatorMode());
    }

    private function createSlot(param1:int) : void {
      var local2:* = new InventoryPanelSlot(param1);
      this.inventorySlots[param1] = local2;
      this.container.addChild(local2.getCanvas());
    }

    private function onChangePositionDefaultLayout(param1:BattleGUIServiceEvent) : void {
      this.onResize();
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:* = undefined;
      OSGi.getInstance().unregisterService(IInventoryPanel);
      if(this.inventorySlots != null) {
        battleGuiService.removeEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onChangePositionDefaultLayout);
        display.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
        display.stage.removeEventListener(Event.RESIZE,this.onResize);
        battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
        battleInputService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
        for(local1 in this.inventorySlots) {
          this.clearSlot(int(local1));
        }
        battleInputService.removeGameActionListener(this);
        this.inventorySlots = null;
      }
      battleGuiService.getGuiContainer().removeChild(this.container);
      this.container = null;
      this.battleEventSupport.deactivateHandlers();
    }

    public function assignItemToSlot(param1:InventoryItem, param2:int) : void {
      if(this.getActiveSlotsCount() == 0) {
        battleInputService.addGameActionListener(this);
      }
      var local3:InventoryPanelSlot = this.inventorySlots[param2];
      local3.inventoryItem = param1;
      this.updateSlotCounter(local3);
    }

    public function itemUpdateCount(param1:InventoryItem) : void {
      var local2:InventoryPanelSlot = null;
      for each(local2 in this.inventorySlots) {
        if(local2.inventoryItem == param1) {
          this.updateSlotCounter(local2);
        }
      }
    }

    private function updateSlotCounter(param1:InventoryPanelSlot) : void {
      var local2:Boolean = false;
      param1.updateCounter();
      if(param1.getSlotNumber() == InventoryItemType.GOLD) {
        local2 = param1.getInventoryCount() > 0;
        if(param1.getCanvas().visible == local2) {
          return;
        }
        param1.getCanvas().visible = local2;
        this.onResize();
      }
    }

    public function lockItem(param1:int, param2:int, param3:Boolean) : void {
      var local4:InventoryPanelSlot = null;
      var local5:InventoryItem = null;
      for each(local4 in this.inventorySlots) {
        local5 = local4.inventoryItem;
        if(local5 != null && local5.getId() == param1) {
          local4.setLockMask(param2,param3);
        }
      }
    }

    public function lockItems(param1:int, param2:Boolean) : void {
      var local3:InventoryPanelSlot = null;
      for each(local3 in this.inventorySlots) {
        local3.setLockMask(param1,param2);
      }
    }

    public function lockItemsByMask(param1:Vector.<int>, param2:int, param3:Boolean) : void {
      var local4:InventoryPanelSlot = null;
      var local5:InventoryItem = null;
      for each(local4 in this.inventorySlots) {
        local5 = local4.inventoryItem;
        if(local5 != null && param1.indexOf(local5.getId()) != -1) {
          local4.setLockMask(param2,param3);
        }
      }
    }

    private function onResize(param1:Event = null) : void {
      var local2:int = this.getPanelWidth();
      var local3:int = display.stage.stageWidth - local2 >> 1;
      var local4:int = local3 + local2 + GAP_BETWEEN_ITEM;
      var local5:int = int(battleGuiService.getPositionXDefaultLayout());
      if(local4 > local5) {
        local3 = local5 - local2 - GAP_BETWEEN_ITEM;
      }
      this.container.x = local3;
      this.container.y = display.stage.stageHeight - PANEL_OFFSET_Y;
      battleGuiService.setPositionXInventory(local3);
    }

    private function getPanelWidth() : int {
      var local2:InventoryPanelSlot = null;
      var local1:int = 0;
      for each(local2 in this.inventorySlots) {
        local2.getCanvas().x = local1 * this.iconWithGapSize;
        if(local2.getCanvas().visible) {
          local1++;
        }
      }
      return local1 * this.iconWithGapSize - GAP_BETWEEN_ITEM;
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(!param2) {
        return;
      }
      var local3:* = this.slotIndexByGameAction[param1];
      if(local3 == null) {
        return;
      }
      var local4:InventoryPanelSlot = this.inventorySlots[int(local3)];
      if(local4.isLocked()) {
        if(local4.getSlotNumber() == InventoryItemType.FIRST_AID) {
          inventorySoundService.playNotReadySound();
        }
      } else if(local4.inventoryItem != null && local4.inventoryItem.count > 0 && local4.cooldownItem.canActivate()) {
        local4.inventoryItem.requestActivation();
      } else {
        inventorySoundService.playNotReadySound();
      }
    }

    private function getActiveSlotsCount() : int {
      var local2:InventoryPanelSlot = null;
      var local1:int = 0;
      for each(local2 in this.inventorySlots) {
        if(local2.inventoryItem != null) {
          local1++;
        }
      }
      return local1;
    }

    private function clearSlot(param1:int) : void {
      var local2:InventoryPanelSlot = this.inventorySlots[param1];
      local2.destroy();
    }

    private function onEnterFrame(param1:Event) : void {
      var local3:InventoryPanelSlot = null;
      var local2:int = getTimer();
      for each(local3 in this.inventorySlots) {
        local3.update(local2);
      }
    }

    private function bindKeys() : void {
      this.slotIndexByGameAction[GameActionEnum.USE_FIRS_AID] = InventoryItemType.FIRST_AID;
      this.slotIndexByGameAction[GameActionEnum.USE_DOUBLE_ARMOR] = InventoryItemType.ARMOR;
      this.slotIndexByGameAction[GameActionEnum.USE_DOUBLE_DAMAGE] = InventoryItemType.DAMAGE;
      this.slotIndexByGameAction[GameActionEnum.USE_NITRO] = InventoryItemType.NITRO;
      this.slotIndexByGameAction[GameActionEnum.USE_MINE] = InventoryItemType.MINE;
      this.slotIndexByGameAction[GameActionEnum.DROP_GOLD_BOX] = InventoryItemType.GOLD;
    }

    private function onInputLocked(param1:BattleInputLockEvent) : void {
      this.lockItems(InventoryLock.GUI,true);
    }

    private function onInputUnlocked(param1:BattleInputLockEvent) : void {
      this.lockItems(InventoryLock.GUI,false);
    }

    private function onLocalTankActivationEvent(param1:Object) : void {
      var local2:InventoryPanelSlot = null;
      for each(local2 in this.inventorySlots) {
        if(!local2.activeAfterDeath) {
          local2.setLockMask(InventoryLock.PLAYER_INACTIVE,false);
        }
      }
    }

    public function changeEffectTime(param1:int, param2:int, param3:Boolean, param4:Boolean) : void {
      var local5:InventoryPanelSlot = this.inventorySlots[param1];
      if(!this.isSpecialEffect(param1)) {
        if(param4) {
          local5.startInfiniteEffect(param3);
        } else {
          local5.changeEffectTime(param2,param3);
        }
      }
    }

    public function activateCooldown(param1:int, param2:int) : void {
      var local3:InventoryPanelSlot = null;
      if(!this.isSpecialEffect(param1)) {
        local3 = this.inventorySlots[param1];
        local3.activateCooldown(param2);
      }
    }

    public function activateDependedCooldown(param1:int, param2:int) : void {
      var local3:InventoryPanelSlot = null;
      if(!this.isSpecialEffect(param1)) {
        local3 = this.inventorySlots[param1];
        local3.activateDependedCooldown(param2);
      }
    }

    public function showInventory() : void {
      if(this.container != null && this.container.numChildren > 0) {
        this.onResize();
        this.container.visible = true;
      }
    }

    public function stopEffect(param1:int) : void {
      var local2:InventoryPanelSlot = null;
      if(!this.isSpecialEffect(param1)) {
        local2 = this.inventorySlots[param1];
        local2.stopEffect();
      }
    }

    private function onInventorySlotReadyToUseEvent(param1:InventorySlotReadyToUseEvent) : void {
      var local2:InventoryPanelSlot = this.inventorySlots[param1.slotIndex];
      local2.startReadyIndicator();
    }

    public function setCooldownDuration(param1:int, param2:int) : void {
      InventoryPanelSlot(this.inventorySlots[param1]).setCooldownDuration(param2);
    }

    public function setVisible(param1:int, param2:Boolean, param3:Boolean) : void {
      if(this.inventorySlots != null) {
        InventoryPanelSlot(this.inventorySlots[param1]).getCanvas().visible = param2;
        this.onResize();
      }
    }

    public function setEffectInfinite(param1:int, param2:Boolean) : void {
      var local3:InventoryPanelSlot = this.inventorySlots[param1];
      if(local3 != null) {
        this.changeEffectTime(param1,getTimer(),true,param2);
      }
    }

    public function ready(param1:int) : void {
      InventoryPanelSlot(this.inventorySlots[param1]).ready();
    }
  }
}
