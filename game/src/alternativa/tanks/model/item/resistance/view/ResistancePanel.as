package alternativa.tanks.model.item.resistance.view {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.GarageWindowEvent;
  import alternativa.tanks.gui.ItemInfoPanel;
  import alternativa.tanks.gui.buttons.GarageButton;
  import alternativa.tanks.gui.buttons.TimerButton;
  import alternativa.tanks.gui.buttons.TimerButtonEvent;
  import alternativa.tanks.gui.upgrade.SelectUpgradeWindow;
  import alternativa.tanks.gui.upgrade.UpgradeButton;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.resistance.ResistanceService;
  import alternativa.tanks.tracker.ITrackerService;
  import controls.timer.CountDownTimer;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class ResistancePanel implements AutoClosable {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var garageService:GarageService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var userGarageActionsService:UserGarageActionsService;

    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var resistancesService:ResistanceService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private const BUTTON_WIDTH:Number = 120;
    private const MARGIN:Number = 11;
    private const SPACE:Number = 15;

    private var selectWindow:SelectUpgradeWindow;
    private var buyButton:GarageButton = new GarageButton();
    private var upgradeButton:UpgradeButton = new UpgradeButton();
    private var equipButton:TimerButton = new TimerButton();
    private var item:IGameObject;
    private var garageWindowDispatcher:IEventDispatcher;

    public function ResistancePanel() {
      super();
      this.buyButton.width = this.BUTTON_WIDTH;
      this.upgradeButton.width = this.BUTTON_WIDTH;
      this.equipButton.width = this.BUTTON_WIDTH;
      this.buyButton.x = this.MARGIN;
      this.upgradeButton.x = this.buyButton.x + this.BUTTON_WIDTH + this.SPACE;
      this.equipButton.x = this.upgradeButton.x + this.BUTTON_WIDTH + this.SPACE;
      this.buyButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT));
      this.buyButton.addEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
      this.upgradeButton.addEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
      this.equipButton.addEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
    }

    private function updateButtonsVisibility() : void {
      this.buyButton.visible = Boolean(itemService.canBuy(this.item)) || Boolean(itemService.hasNextModification(this.item));
      this.upgradeButton.visible = !itemService.canBuy(this.item) && Boolean(itemService.isModificationItem(this.item));
      this.equipButton.visible = (!resistancesService.getView().isFull() || resistancesService.isMounted(this.item)) && !itemService.canBuy(this.item);
    }

    public function onDoubleClick() : * {
      if(garageService.getView().isItemInDepot(this.item)) {
        if(resistancesService.isMounted(this.item)) {
          this.onButtonUpgradeClickInternal();
        } else {
          this.onButtonEquipClickInternal();
        }
      } else {
        this.onButtonBuyClickInternal();
      }
    }

    private function updateBuyButton(param1:IGameObject) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:IGameObject = null;
      var local6:int = 0;
      var local2:* = itemService.canBuy(param1);
      if(this.buyButton.visible) {
        local3 = ItemInfoPanel.getRequiredRank(itemService.getMinRankIndex(param1),itemService.getMaxRankIndex(param1));
        if(!local2) {
          local5 = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
          local4 = int(itemService.getPrice(local5));
          local6 = int(itemService.getMinRankIndex(local5));
          local3 = userPropertiesService.rank >= local6 ? local6 : int(-local6);
        } else {
          local4 = int(itemService.getPrice(param1));
        }
        this.updateBuyButtonText(param1,local2);
        this.buyButton.setInfo(local4,1,local3,itemService.isPremiumItem(param1));
      }
    }

    private function updateBuyButtonText(param1:IGameObject, param2:Boolean) : void {
      var local4:IGameObject = null;
      var local3:String = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT);
      if(itemService.isModificationItem(param1)) {
        if(param2) {
          local4 = itemService.getMaxAvailableModification(param1);
          if(local4 == null) {
            local4 = param1;
          }
        } else {
          local4 = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
        }
        this.buyButton.setText(local3 + " M" + itemService.getModificationIndex(local4));
      } else {
        this.buyButton.setText(local3);
      }
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher, param3:IGameObject) : void {
      this.item = param3;
      if(Boolean(itemService.canBuy(param3)) || !resistancesService.canBeMount(param3)) {
        resistancesService.setOnlyUnmountMode();
      } else {
        this.setActive();
      }
      this.garageWindowDispatcher = param2;
      param1.addChild(this.buyButton);
      param1.addChild(this.equipButton);
      param1.addChild(this.upgradeButton);
      this.updateButtons();
    }

    private function onButtonBuyClickInternal() : void {
      var local1:IGameObject = !!garageService.getView().isItemInDepot(this.item) ? itemService.getMaxAvailableModification(this.item) : this.item;
      garageService.getView().dispatchEvent(new GarageWindowEvent(GarageWindowEvent.BUY_ITEM,local1));
    }

    private function onButtonBuyClick(param1:MouseEvent) : void {
      this.onButtonBuyClickInternal();
    }

    private function onButtonUpgradeClickInternal() : void {
      garageService.getView().getItemInfoPanel().upgradeSelectedItem();
    }

    private function onButtonUpgradeClick(param1:MouseEvent) : void {
      this.onButtonUpgradeClickInternal();
    }

    private function onButtonEquipClickInternal() : void {
      if(this.isItemMounted()) {
        resistancesService.unmount(this.item);
      } else {
        resistancesService.mountIntoFreeSlot(this.item);
      }
      this.updateButtonsLabels();
    }

    private function onButtonEquipClick(param1:MouseEvent) : void {
      this.onButtonEquipClickInternal();
    }

    private function isItemMounted() : Boolean {
      return resistancesService.isMounted(this.item);
    }

    private function updateButtons() : void {
      this.updateButtonsVisibility();
      this.updateButtonsLabels();
      this.updateEquipButton();
    }

    private function updateEquipButton() : void {
      if(!itemService.hasItem(this.item)) {
        this.equipButton.enabled = false;
        this.equipButton.hideTime();
        return;
      }
      this.controlTimerEquipButton();
    }

    private function updateButtonsLabels() : void {
      this.updateBuyButton(this.item);
      var local1:UpgradableItem = UpgradableItem(this.item.adapt(UpgradableItem));
      if(local1.isUpgrading()) {
        this.upgradeButton.setUpgradingButton(local1.getCountDownTimer(),local1.hasSpeedUpDiscount());
      } else if(itemService.isFullUpgraded(this.item)) {
        this.upgradeButton.setUpgradedButton();
      } else {
        this.upgradeButton.setUpgradeButton(local1.hasUpgradeDiscount());
      }
      this.equipButton.label = this.isItemMounted() ? localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_UNEQUIP_TEXT) : localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
    }

    private function controlTimerEquipButton() : void {
      var local1:CountDownTimer = null;
      if(lobbyLayoutService.inBattle()) {
        if(battleInfoService.reArmorEnabled) {
          local1 = delayMountCategoryService.getDownTimer(this.item);
          if(local1.getRemainingSeconds() > 0) {
            this.equipButton.startTimer(local1);
            this.equipButton.addEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
            resistancesService.getView().disable();
          } else {
            this.setActive();
          }
        } else {
          this.equipButton.hideTime();
          this.equipButton.enabled = false;
          resistancesService.getView().disable();
        }
      } else {
        this.setActive();
      }
    }

    private function setActive() : void {
      this.equipButton.hideTime();
      this.equipButton.enabled = true;
      resistancesService.getView().enable();
    }

    private function onCompletedTimer(param1:TimerButtonEvent) : void {
      this.equipButton.enabled = true;
      this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      resistancesService.getView().enable();
    }

    public function close() : void {
      this.buyButton.removeEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
      this.upgradeButton.removeEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
      this.equipButton.removeEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
      this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      this.equipButton.hideTime();
      if(this.selectWindow != null) {
        this.selectWindow.destroy();
        this.selectWindow = null;
      }
    }
  }
}
