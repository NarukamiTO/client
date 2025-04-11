package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.InventorySlotReadyToUseEvent;
  import alternativa.tanks.models.battle.gui.inventory.cooldown.CooldownIndicator;
  import alternativa.tanks.models.battle.gui.inventory.cooldown.InventoryCooldownItem;
  import alternativa.tanks.models.battle.gui.inventory.readytouse.LightPillarEffect;
  import alternativa.tanks.models.battle.gui.inventory.splash.SplashColor;
  import alternativa.tanks.models.battle.gui.inventory.splash.SplashController;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import controls.Label;
  import flash.display.Bitmap;
  import flash.display.BlendMode;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.filters.GlowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.utils.clearInterval;
  import flash.utils.setTimeout;
  import forms.ColorConstants;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  public class InventoryPanelSlot {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var inventorySoundService:InventorySoundService;

    private static const FONT_SIZE:int = 10;

    public static const QUANTITY_COLOR_WHITE:uint = ColorConstants.WHITE;
    public static const QUANTITY_COLOR_GRAY:uint = 11711154;
    public static const GLOW_FILTER:GlowFilter = new GlowFilter(0,0.8,4,4,3);

    private var _cooldownItem:InventoryCooldownItem;
    private var _inventoryItem:InventoryItem;
    private var _canvas:DisplayObjectContainer;
    private var _quantityLabel:Label;
    private var _slotNumberLabel:Label;
    private var _lockIcon:Bitmap;
    private var _inventoryIcon:InventoryIcons;
    private var _slotNumber:int;
    private var _lockBits:int;
    private var _splashController:SplashController;
    private var lightPillarEffect:LightPillarEffect = new LightPillarEffect();

    public var activeAfterDeath:Boolean;

    private var flashTimer:uint;

    public function InventoryPanelSlot(param1:int) {
      super();
      this._slotNumber = param1;
      this.init();
    }

    private function init() : void {
      this._canvas = new Sprite();
      this._canvas.addChild(this.lightPillarEffect);
      var local1:Sprite = new Sprite();
      this._canvas.addChild(local1);
      if(GPUCapabilities.gpuEnabled) {
        local1.blendMode = BlendMode.ADD;
      }
      this._inventoryIcon = new InventoryIcons(this._slotNumber);
      var local2:Bitmap = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.BORDER));
      var local3:Bitmap = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.BGD));
      this._lockIcon = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.LOCK_OVERLAY));
      this._slotNumberLabel = new Label();
      this._slotNumberLabel.size = FONT_SIZE;
      this._slotNumberLabel.text = this._slotNumber.toString();
      this._slotNumberLabel.x = this._inventoryIcon.width - this._slotNumberLabel.width - 2;
      this._slotNumberLabel.y = this._inventoryIcon.height - this._slotNumberLabel.height;
      var local4:CooldownIndicator = new CooldownIndicator(HudInventoryIcon.getIcon(HudInventoryIcon.COOLDOWN_OVERLAY));
      var local5:CooldownIndicator = new CooldownIndicator(HudInventoryIcon.getBgdIcon(this._slotNumber));
      this._quantityLabel = new Label();
      this._quantityLabel.width = this._inventoryIcon.width;
      this._quantityLabel.autoSize = TextFieldAutoSize.CENTER;
      this._quantityLabel.filters = [GLOW_FILTER];
      local1.addChild(local3);
      local1.addChild(local2);
      local1.addChild(local4);
      local1.addChild(local5);
      local1.addChild(this._inventoryIcon);
      local1.addChild(this._slotNumberLabel);
      local1.addChild(this._lockIcon);
      this._canvas.addChild(this._quantityLabel);
      this._splashController = new SplashController(local1);
      this._cooldownItem = new InventoryCooldownItem(this._slotNumber,local5,local4,this._splashController,this._inventoryIcon,this.finishEffectAndCooldown,this.onStartCooldown);
      this.setLockMask(InventoryLock.PLAYER_INACTIVE,true);
    }

    public function setLockMask(param1:int, param2:Boolean) : void {
      if(param2) {
        this._lockBits |= param1;
      } else {
        this.tryIndicateActivationWithSplash(param1);
        this._lockBits &= ~param1;
      }
      if(param1 == InventoryLock.PLAYER_INACTIVE) {
        if(param2) {
          if(this._slotNumber != InventoryItemType.BATTERY) {
            this._inventoryIcon.state = InventoryIcons.NEUTRAL_STATE;
            this._splashController.stopFlash();
            this._cooldownItem.destroy();
          }
        } else {
          this.startFlash(this.finishShowStateSplash);
        }
      }
      if(param2) {
        this._splashController.stopFlash();
      }
      this.updateVisibleSlotNumberAndQuantityLabels();
      this.updateVisibleLockIcon();
    }

    private function tryIndicateActivationWithSplash(param1:int) : void {
      if(this._slotNumber == InventoryItemType.FIRST_AID || this._slotNumber == InventoryItemType.MINE || this._slotNumber == InventoryItemType.GOLD) {
        if(this.isLocked() && !this._cooldownItem.isActive() && this.getInventoryCount() > 0 && param1 == InventoryLock.FORCED) {
          this._splashController.startFlash(SplashColor.getColor(this._slotNumber));
        }
      }
    }

    private function updateVisibleSlotNumberAndQuantityLabels() : void {
      this.updateVisibleSlotNumberLabel();
      this.updateVisibleQuantityLabel();
    }

    private function updateVisibleSlotNumberLabel() : void {
      if(this._inventoryItem == null) {
        this._slotNumberLabel.visible = false;
      }
      if(this.isLocked() || this._slotNumber == InventoryItemType.BATTERY) {
        this._slotNumberLabel.visible = false;
      } else if(this._cooldownItem.isActive()) {
        this._slotNumberLabel.visible = false;
      } else {
        this._slotNumberLabel.visible = this.getInventoryCount() > 0;
      }
    }

    private function updateVisibleQuantityLabel() : void {
      if(this._cooldownItem.isActive()) {
        if(!this._cooldownItem.isEffectActive() && this._cooldownItem.isCooldownActive()) {
          this._quantityLabel.color = QUANTITY_COLOR_GRAY;
        }
      } else if(this.isLocked() || this.needLock()) {
        this._quantityLabel.color = QUANTITY_COLOR_GRAY;
      } else {
        this._quantityLabel.color = QUANTITY_COLOR_WHITE;
      }
      this._quantityLabel.visible = !this.needLock();
    }

    private function updateVisibleLockIcon() : void {
      if(this.isLocked()) {
        this._splashController.stopFlash();
        this._lockIcon.visible = true;
      } else {
        this._lockIcon.visible = this.needLock();
        if(!this._cooldownItem.isActive()) {
          this._inventoryIcon.state = InventoryIcons.NEUTRAL_STATE;
        }
      }
    }

    private function needLock() : Boolean {
      return this.getInventoryCount() <= 0;
    }

    public function ready() : * {
      this._cooldownItem.destroy();
      this._inventoryIcon.state = InventoryIcons.NEUTRAL_STATE;
      if(!this.isLocked()) {
        this.startFlash(this.finishShowStateSplash);
        this.flashTimer = setTimeout(this.startFlash,350);
        battleEventDispatcher.dispatchEvent(new InventorySlotReadyToUseEvent(this._slotNumber));
        this.updateVisibleSlotNumberAndQuantityLabels();
      }
      this.updateVisibleLockIcon();
    }

    private function finishEffectAndCooldown() : void {
      if(this.cooldownItem.isCooldownActive()) {
        this._inventoryIcon.state = InventoryIcons.COOLDOWN_STATE;
      } else {
        this._inventoryIcon.state = InventoryIcons.NEUTRAL_STATE;
        if(this._slotNumber == InventoryItemType.BATTERY) {
          this.setLockMask(InventoryLock.PLAYER_INACTIVE,false);
        }
      }
    }

    private function startFlash(param1:Function = null) : void {
      this.clearFlashTimer();
      this._splashController.startFlash(SplashColor.getColor(this._slotNumber),param1);
    }

    private function onStartCooldown() : void {
      this._quantityLabel.visible = true;
      this._quantityLabel.color = QUANTITY_COLOR_GRAY;
      this._inventoryIcon.state = InventoryIcons.COOLDOWN_STATE;
    }

    private function finishShowStateSplash() : void {
      this.updateVisibleSlotNumberAndQuantityLabels();
    }

    public function isLocked() : Boolean {
      return this._lockBits != 0;
    }

    public function getCanvas() : DisplayObject {
      return this._canvas;
    }

    public function get inventoryItem() : InventoryItem {
      return this._inventoryItem;
    }

    public function set inventoryItem(param1:InventoryItem) : void {
      if(this._inventoryItem == param1) {
        return;
      }
      this._inventoryItem = param1;
    }

    public function get cooldownItem() : InventoryCooldownItem {
      return this._cooldownItem;
    }

    public function update(param1:int) : void {
      this._cooldownItem.update(param1);
      this._splashController.update(param1);
      this.lightPillarEffect.update(param1);
    }

    public function getInventoryCount() : int {
      if(this._inventoryItem != null) {
        return this._inventoryItem.count;
      }
      return 0;
    }

    public function updateCounter() : void {
      this.updateVisibleSlotNumberAndQuantityLabels();
      this.updateVisibleLockIcon();
      this._quantityLabel.text = this.getInventoryCount().toString();
      this._quantityLabel.y = -this._quantityLabel.height - 2;
    }

    public function destroy() : void {
      this.clearFlashTimer();
      this._cooldownItem = null;
      this._inventoryItem = null;
    }

    public function setQuantityLabel(param1:String) : * {
      this._quantityLabel.text = param1;
      this._quantityLabel.y = -this._quantityLabel.height - 2;
    }

    private function clearFlashTimer() : void {
      if(this.flashTimer != 0) {
        clearInterval(this.flashTimer);
        this.flashTimer = 0;
      }
    }

    public function changeEffectTime(param1:int, param2:Boolean) : void {
      this._cooldownItem.changeEffectTime(param1,param2);
      this.updateVisibleSlotNumberAndQuantityLabels();
      this.updateVisibleLockIcon();
    }

    public function startInfiniteEffect(param1:Boolean) : void {
      this._cooldownItem.activateInfinite();
    }

    public function activateCooldown(param1:int) : void {
      this._cooldownItem.activateCooldown(param1);
      this.updateVisibleSlotNumberAndQuantityLabels();
      this.updateVisibleLockIcon();
    }

    public function activateDependedCooldown(param1:int) : void {
      if(this.getInventoryCount() > 0) {
        this._cooldownItem.activateDependedCooldown(param1);
        this.updateVisibleSlotNumberAndQuantityLabels();
        this.updateVisibleLockIcon();
      }
    }

    public function stopEffect() : void {
      this._cooldownItem.stopEffect();
    }

    public function getSlotNumber() : int {
      return this._slotNumber;
    }

    public function startReadyIndicator() : void {
      inventorySoundService.playReadySound(this._slotNumber);
      this.lightPillarEffect.init(HudInventoryIcon.getIndicatorColor(this._slotNumber));
      this.lightPillarEffect.y = -this.lightPillarEffect.height + this._inventoryIcon.width - 2;
      this.lightPillarEffect.start();
    }

    public function setCooldownDuration(param1:int) : void {
      this._cooldownItem.setCooldownDuration(param1);
    }
  }
}
