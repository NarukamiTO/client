package alternativa.tanks.models.battle.gui.ultimate {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.models.battle.gui.inventory.HudInventoryIcon;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
  import alternativa.tanks.models.battle.gui.inventory.InventoryIcons;
  import alternativa.tanks.models.battle.gui.inventory.InventoryModel;
  import alternativa.tanks.models.battle.gui.inventory.InventoryPanelSlot;
  import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
  import alternativa.tanks.models.battle.gui.inventory.UltimateIcon;
  import alternativa.tanks.models.battle.gui.inventory.cooldown.CooldownIndicator;
  import alternativa.tanks.models.battle.gui.inventory.cooldown.InventoryCooldownItem;
  import alternativa.tanks.models.battle.gui.inventory.readytouse.LightPillarEffect;
  import alternativa.tanks.models.battle.gui.inventory.splash.SplashColor;
  import alternativa.tanks.models.battle.gui.inventory.splash.SplashController;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battlegui.BattleGUIServiceEvent;
  import alternativa.tanks.services.battlegui.InventoryChangePositionEvent;
  import alternativa.tanks.services.battleinput.BattleInputLockEvent;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.utils.removeDisplayObject;
  import controls.Label;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.text.TextFieldAutoSize;
  import flash.utils.clearInterval;
  import flash.utils.clearTimeout;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import forms.ColorConstants;

  public class UltimateIndicator {
    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var inventoryPanel:IInventoryPanel;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var inventorySoundService:InventorySoundService;

    private static const KEY_ICON_OFFSET_X:int = -6;
    private static const KEY_ICON_OFFSET_Y:int = -20;
    private static const ICON_SIZE:int = 78;

    private var cooldownItem:InventoryCooldownItem;
    private var splashController:SplashController;
    private var cooldownIndicator:CooldownIndicator = new CooldownIndicator(HudInventoryIcon.getIcon(HudInventoryIcon.OVERDRIVE_COOLDOWN_OVERLAY));
    private var inventoryIcon:InventoryIcons;
    private var baseContainer:Sprite = new Sprite();
    private var percentLabel:Label = new Label();
    private var keyLabel:Label = new Label();
    private var lockIcon:Bitmap;
    private var disabled:Boolean = true;
    private var charged:Boolean;
    private var lightPillarEffect:LightPillarEffect = new LightPillarEffect();
    private var resizeTimer:uint;
    private var flashTimer:uint;

    public function UltimateIndicator(param1:int) {
      super();
      this.lightPillarEffect.scaleX = 2;
      this.baseContainer.addChild(this.lightPillarEffect);
      var local2:Sprite = new Sprite();
      this.baseContainer.addChild(local2);
      var local3:Bitmap = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.OVERDRIVE_BG));
      local2.addChild(local3);
      var local4:CooldownIndicator = new CooldownIndicator(HudInventoryIcon.getBgdIcon(InventoryItemType.ULTIMATE));
      this.inventoryIcon = new UltimateIcon(param1);
      local2.addChild(this.inventoryIcon);
      local2.addChild(this.cooldownIndicator);
      this.keyLabel.text = "Shift";
      this.keyLabel.x = ICON_SIZE - this.keyLabel.width + KEY_ICON_OFFSET_X;
      this.keyLabel.y = ICON_SIZE + KEY_ICON_OFFSET_Y;
      this.keyLabel.visible = false;
      local2.addChild(this.keyLabel);
      this.percentLabel.y = -19;
      this.percentLabel.color = InventoryPanelSlot.QUANTITY_COLOR_WHITE;
      this.percentLabel.autoSize = TextFieldAutoSize.CENTER;
      this.percentLabel.filters = [InventoryPanelSlot.GLOW_FILTER];
      local2.addChild(this.percentLabel);
      this.setPercentText(0);
      this.lockIcon = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.OVERDRIVE_COOLDOWN_OVERLAY));
      this.lockIcon.visible = true;
      local2.addChild(this.lockIcon);
      local2.addChild(local4);
      this.splashController = new SplashController(local2);
      this.cooldownItem = new InventoryCooldownItem(InventoryItemType.ULTIMATE,local4,this.cooldownIndicator,this.splashController,this.inventoryIcon,this.finishEffectAndCooldown,this.startCooldownCallback,false);
      this.onResize();
      local2.visible = true;
      battleGuiService.getGuiContainer().addChild(this.baseContainer);
      display.stage.addEventListener(Event.RESIZE,this.onResize,false,int.MIN_VALUE);
      display.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      battleGuiService.addEventListener(InventoryChangePositionEvent.ON_CHANGE_POSITION,this.onResize);
    }

    private function startCooldownCallback() : void {
    }

    public function markDisabled(param1:Boolean) : void {
      this.disabled = param1;
      this.updateState();
    }

    private function onInputLocked(param1:BattleInputLockEvent) : void {
      this.markDisabled(true);
    }

    private function onInputUnlocked(param1:BattleInputLockEvent) : void {
      this.markDisabled(false);
    }

    private function updateState() : void {
      this.disableVisual(this.disabled || !this.charged);
    }

    private function disableVisual(param1:Boolean) : void {
      this.keyLabel.visible = !param1;
      this.lockIcon.visible = param1;
      this.percentLabel.color = param1 ? InventoryPanelSlot.QUANTITY_COLOR_GRAY : InventoryPanelSlot.QUANTITY_COLOR_WHITE;
    }

    public function updateCharge(param1:int) : void {
      this.charged = param1 >= 100;
      this.setPercentText(param1);
      this.cooldownIndicator.setProgress(param1 / 100,1);
      this.updateState();
    }

    private function setPercentText(param1:int) : void {
      this.percentLabel.text = param1.toString() + " %";
      this.percentLabel.x = ICON_SIZE - this.percentLabel.width >> 1;
    }

    public function onCharged() : void {
      this.keyLabel.visible = true;
      this.inventoryIcon.state = InventoryIcons.NEUTRAL_STATE;
      this.flashIcon();
      inventorySoundService.playReadySound(InventoryItemType.ULTIMATE);
      this.lightPillarEffect.init(ColorConstants.WHITE);
      this.lightPillarEffect.y = -this.lightPillarEffect.height + ICON_SIZE - 2;
      this.lightPillarEffect.start();
      this.flashTimer = setTimeout(this.flashIcon,350);
    }

    private function flashIcon() : void {
      this.clearFlashTimer();
      this.splashController.startFlash(SplashColor.WHITE);
    }

    private function onResize(param1:Event = null) : void {
      if(this.resizeTimer == 0) {
        this.resizeTimer = setTimeout(this.doResize,0);
        battleGuiService.dispatchEvent(new BattleGUIServiceEvent(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT));
      }
    }

    private function doResize() : void {
      this.baseContainer.x = 10;
      this.baseContainer.y = display.stage.stageHeight - InventoryModel.PANEL_OFFSET_Y - 40;
      this.clearResizeTimer();
    }

    public function destroy() : void {
      battleGuiService.removeEventListener(InventoryChangePositionEvent.ON_CHANGE_POSITION,this.onResize);
      battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      removeDisplayObject(this.baseContainer);
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
      display.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      this.percentLabel = null;
      this.baseContainer = null;
      this.lockIcon = null;
      this.clearFlashTimer();
      this.clearResizeTimer();
    }

    public function activate() : void {
      this.keyLabel.visible = false;
      this.cooldownItem.activateCooldown(1);
    }

    private function finishEffectAndCooldown() : void {
      this.inventoryIcon.state = InventoryIcons.COOLDOWN_STATE;
    }

    private function onEnterFrame(param1:Event) : void {
      var local2:int = getTimer();
      this.splashController.update(local2);
      this.cooldownItem.update(local2);
      this.lightPillarEffect.update(local2);
    }

    private function clearFlashTimer() : void {
      if(this.flashTimer != 0) {
        clearInterval(this.flashTimer);
        this.flashTimer = 0;
      }
    }

    private function clearResizeTimer() : void {
      if(this.resizeTimer != 0) {
        clearTimeout(this.resizeTimer);
        this.resizeTimer = 0;
      }
    }

    public function effectActivatedOrMerged(param1:int) : void {
      this.cooldownItem.changeEffectTime(param1,false);
    }

    public function effectDeactivated() : void {
      this.cooldownItem.stopEffect();
    }
  }
}
