package alternativa.tanks.model.item.drone {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.GarageWindowEvent;
  import alternativa.tanks.gui.ItemInfoPanel;
  import alternativa.tanks.gui.buttons.GarageButton;
  import alternativa.tanks.gui.buttons.TimerButton;
  import alternativa.tanks.gui.buttons.TimerButtonEvent;
  import alternativa.tanks.gui.upgrade.ItemPropertyUpgradeEvent;
  import alternativa.tanks.gui.upgrade.UpgradeButton;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.item.ItemService;
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

  public class DronePanel implements AutoClosable {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

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

    private const GA_CATEGORY:String = "garage";
    private const BUTTON_WIDTH:Number = 120;
    private const MARGIN:Number = 11;
    private const SPACE:Number = 15;

    private var buyButton:GarageButton = new GarageButton();
    private var upgradeButton:UpgradeButton = new UpgradeButton();
    private var equipButton:TimerButton = new TimerButton();
    private var item:IGameObject;
    private var garageWindowDispatcher:IEventDispatcher;

    public function DronePanel() {
      super();
      this.buyButton.width = this.BUTTON_WIDTH;
      this.upgradeButton.width = this.BUTTON_WIDTH;
      this.equipButton.width = this.BUTTON_WIDTH;
      this.buyButton.x = this.MARGIN;
      this.upgradeButton.x = this.buyButton.x + this.BUTTON_WIDTH + this.SPACE;
      this.equipButton.x = this.upgradeButton.x + this.BUTTON_WIDTH + this.SPACE;
      this.buyButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT));
      this.buyButton.addEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
      this.equipButton.addEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
      this.upgradeButton.addEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
    }

    private function onButtonUpgradeClick(param1:MouseEvent) : * {
      userGarageActionsService.upgradeItem(this.item);
      this.garageWindowDispatcher.dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED));
    }

    private function onButtonEquipClick(param1:MouseEvent) : * {
      if(itemService.isMounted(this.item)) {
        trackerService.trackEvent(this.GA_CATEGORY,GarageWindowEvent.UNMOUNT_ITEM,itemService.getName(this.item));
        this.garageWindowDispatcher.dispatchEvent(new GarageWindowEvent(GarageWindowEvent.UNMOUNT_ITEM,this.item));
      } else {
        trackerService.trackEvent(this.GA_CATEGORY,GarageWindowEvent.SETUP_ITEM,itemService.getName(this.item));
        this.garageWindowDispatcher.dispatchEvent(new GarageWindowEvent(GarageWindowEvent.SETUP_ITEM,this.item));
      }
      this.updateButtonsLabels();
      this.updateEquipButton();
    }

    public function onDoubleClick() : * {
      if(!itemService.isMounted(this.item) && Boolean(this.equipButton.enabled)) {
        this.onButtonEquipClick(null);
      }
    }

    private function onButtonBuyClick(param1:MouseEvent) : * {
      userGarageActionsService.buyItem(this.item);
      trackerService.trackEvent(this.GA_CATEGORY,GarageWindowEvent.BUY_ITEM,itemService.getName(this.item));
      this.garageWindowDispatcher.dispatchEvent(new GarageWindowEvent(GarageWindowEvent.BUY_ITEM,this.item));
    }

    public function close() : void {
      this.buyButton.removeEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
      this.equipButton.removeEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
      this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      this.equipButton.hideTime();
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher, param3:IGameObject) : * {
      this.item = param3;
      this.garageWindowDispatcher = param2;
      param1.addChild(this.buyButton);
      param1.addChild(this.equipButton);
      param1.addChild(this.upgradeButton);
      this.updateButtons();
    }

    private function updateButtons() : * {
      this.updateButtonsVisibility();
      this.updateButtonsLabels();
      this.updateEquipButton();
    }

    private function updateButtonsVisibility() : * {
      this.buyButton.visible = itemService.canBuy(this.item);
      this.upgradeButton.visible = !this.buyButton.visible;
      this.equipButton.visible = !this.buyButton.visible;
    }

    private function updateButtonsLabels() : * {
      var local1:* = ItemInfoPanel.getRequiredRank(itemService.getMinRankIndex(this.item),itemService.getMaxRankIndex(this.item));
      this.buyButton.setInfo(itemService.getPrice(this.item),1,local1,itemService.isPremiumItem(this.item));
      var local2:* = this.item.adapt(UpgradableItem);
      if(Boolean(local2.isUpgrading())) {
        this.upgradeButton.setUpgradingButton(local2.getCountDownTimer(),local2.hasSpeedUpDiscount());
      } else if(itemService.isFullUpgraded(this.item)) {
        this.upgradeButton.setUpgradedButton();
      } else {
        this.upgradeButton.setUpgradeButton(local2.hasUpgradeDiscount());
      }
      this.equipButton.label = this.itemCouldBeMounted() ? localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT) : localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_UNEQUIP_TEXT);
    }

    private function updateEquipButton() : * {
      if(Boolean(lobbyLayoutService.inBattle()) && !battleInfoService.reArmorEnabled && !itemService.isMounted(this.item)) {
        this.equipButton.enabled = false;
        return;
      }
      if(!itemService.hasItem(this.item)) {
        this.equipButton.enabled = false;
        this.equipButton.hideTime();
        return;
      }
      this.controlTimerEquipButton();
    }

    private function controlTimerEquipButton() : * {
      var local1:CountDownTimer = delayMountCategoryService.getDownTimer(this.item);
      if(Boolean(lobbyLayoutService.inBattle()) && local1.getRemainingSeconds() > 0 && !itemService.isMounted(this.item)) {
        this.equipButton.startTimer(local1);
        this.equipButton.addEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      } else {
        this.equipButton.hideTime();
        this.equipButton.enabled = true;
      }
    }

    private function onCompletedTimer(param1:TimerButtonEvent) : * {
      this.equipButton.enabled = true;
      this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
    }

    private function itemCouldBeMounted() : Boolean {
      return Boolean(itemService.hasItem(this.item)) && !itemService.isMounted(this.item);
    }
  }
}
