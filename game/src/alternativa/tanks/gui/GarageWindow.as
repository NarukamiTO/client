package alternativa.tanks.gui {
  import alternativa.engine3d.objects.SkyBox;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.buttons.GarageButton;
  import alternativa.tanks.gui.category.CategoryButtonsList;
  import alternativa.tanks.gui.garagelist.GarageList;
  import alternativa.tanks.gui.garagelist.GarageListController;
  import alternativa.tanks.gui.tankpreview.EventTankPreview;
  import alternativa.tanks.gui.tankpreview.TankPreviewWindow;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import alternativa.tanks.model.item.shopabonement.ShopAbonement;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import alternativa.tanks.tracker.ITrackerService;
  import base.DiscreteSprite;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import controls.buttons.ButtonStates;
  import controls.timer.CountDownTimer;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.utils.getTimer;
  import forms.events.PartsListEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
  import services.alertservice.AlertAnswer;

  public class GarageWindow extends DiscreteSprite implements IGarageWindow {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var userGarageActionsService:UserGarageActionsService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var tank3DViewer:ITank3DViewer;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    private static const GA_CATEGORY:String = "garage";
    private static const windowMargin:int = 11;
    private static const itemInfoPanelWidth:int = 412;

    public var timersKitCouldBeBoughtContext:Vector.<TimerKitCouldBeBoughtContext>;
    public var itemInfoPanel:ItemInfoPanel;
    public var tankPreview:TankPreviewWindow;

    private var _windowSize:Point;
    private var _selectedItem:IGameObject;
    private var _garageListWindow:TankWindow;
    private var _garageListInner:TankWindowInner;
    private var _garageList:GarageList;
    private var _categoryButtons:CategoryButtonsList;
    private var _garageListController:GarageListController;

    public function GarageWindow(param1:Boolean) {
      super();
      this.timersKitCouldBeBoughtContext = new Vector.<TimerKitCouldBeBoughtContext>();
      this.itemInfoPanel = new ItemInfoPanel(param1,itemInfoPanelWidth);
      addChild(this.itemInfoPanel);
      this._garageListWindow = new TankWindow();
      addChild(this._garageListWindow);
      this._garageListInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this._garageListInner.showBlink = true;
      addChild(this._garageListInner);
      this._garageList = new GarageList();
      addChild(this._garageList);
      this._categoryButtons = new CategoryButtonsList();
      addChild(this._categoryButtons);
      this._garageListController = new GarageListController(this._garageList,this._categoryButtons);
      this.updateNavigationLock();
      this.setEvents();
    }

    public function initTankPreviewWindow(param1:Tanks3DSResource, param2:SkyBox) : void {
      this.tankPreview = param1.id.low == 500360050 ? new TankPreviewWindow() : new EventTankPreview();
      this.tankPreview.init(param1,param2);
      addChild(this.tankPreview);
      tank3DViewer.setView(this.tankPreview);
      if(this._windowSize != null) {
        this.tankPreview.resize(this._windowSize.x - itemInfoPanelWidth,this._windowSize.y - this._garageListWindow.height);
      }
    }

    private function onGarageItemDoubleClick(param1:PartsListEvent) : void {
      this.onSelectGarageListItem(param1);
      if(this._selectedItem.hasModel(ItemActionPanel)) {
        ItemActionPanel(this._selectedItem.adapt(ItemActionPanel)).handleDoubleClickOnItemPreview();
        return;
      }
      if(this._selectedItem.hasModel(ShopAbonement)) {
        paymentDisplayService.openPaymentAt(ShopAbonement(this._selectedItem.adapt(ShopAbonement)).getShopCategory());
      } else if(Boolean(this.itemInfoPanel.equipButton.visible) && this.itemInfoPanel.equipButton.getState() == ButtonStates.UP) {
        this.equip();
      } else if(this.itemInfoPanel.upgradeButton.visible && this.itemInfoPanel.upgradeButton.getState() == ButtonStates.UP) {
        this.itemInfoPanel.upgradeSelectedItem();
      } else if(Boolean(this.itemInfoPanel.buyButton.visible) && this.itemInfoPanel.buyButton.getState() == ButtonStates.UP) {
        this.onButtonBuyClickInternal();
      } else if(Boolean(this.itemInfoPanel.deletePresentButton.visible) && this.itemInfoPanel.deletePresentButton.getState() == ButtonStates.UP) {
        this.deletePresentInternal();
      }
    }

    private function setEvents() : void {
      this._garageList.addEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,this.onSelectGarageListItem);
      this._garageList.addEventListener(PartsListEvent.ITEM_DOUBLE_CLICK,this.onGarageItemDoubleClick);
      this.itemInfoPanel.buyButton.addEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
      this.itemInfoPanel.equipButton.addEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
      this.itemInfoPanel.deletePresentButton.addEventListener(MouseEvent.CLICK,this.onButtonDeletePresentClick);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.updateNavigationLock);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.updateNavigationLock);
      battleInfoService.addEventListener(BattleInfoServiceEvent.BATTLE_START,this.onBattleStart);
    }

    private function onBattleStart(param1:BattleInfoServiceEvent) : void {
      if(this._selectedItem != null) {
        this.itemInfoPanel.updateEquipButton();
      }
    }

    private function deletePresentInternal() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_PRESENT_WILL_BE_REMOVED_ALERT),Vector.<String>([AlertAnswer.OK,AlertAnswer.CANCEL]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onAlertAnswer);
    }

    private function onButtonDeletePresentClick(param1:MouseEvent) : void {
      this.deletePresentInternal();
    }

    private function onAlertAnswer(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onAlertAnswer);
      if(param1.typeButton == AlertAnswer.OK) {
        dispatchEvent(new GarageWindowEvent(GarageWindowEvent.DELETE_PRESENT,this._selectedItem));
        this.removeItemFromDepot(this._selectedItem);
        if(this._garageListController.getCurrentCategoryItemsCount() > 0) {
          this.updateSelection();
        } else {
          this._categoryButtons.setCategoryButtonVisibility(ItemViewCategoryEnum.GIVEN_PRESENTS,false);
          this.showDefaultCategory();
        }
      }
    }

    private function onSelectGarageListItem(param1:PartsListEvent) : void {
      this._selectedItem = this._garageList.selectedItem;
      var local2:Boolean = this._garageListController.isItemInDepot(this._selectedItem);
      this.showItemInfo(this._selectedItem,!local2);
      if(local2) {
        dispatchEvent(new GarageWindowEvent(GarageWindowEvent.WAREHOUSE_ITEM_SELECTED,this._selectedItem));
      } else {
        dispatchEvent(new GarageWindowEvent(GarageWindowEvent.STORE_ITEM_SELECTED,this._selectedItem));
      }
      userGarageActionsService.selectItem(this._selectedItem);
    }

    private function onButtonBuyClickInternal() : void {
      var local1:IGameObject = null;
      if(Boolean(itemService.isModificationItem(this._selectedItem)) && this.isItemInDepot(this._selectedItem)) {
        local1 = itemService.getMaxAvailableModification(this._selectedItem);
        userGarageActionsService.buyItemModification(local1);
        trackerService.trackEvent(GA_CATEGORY,GarageWindowEvent.UPGRADE_ITEM,itemService.getName(this._selectedItem));
      } else {
        local1 = this._selectedItem;
        userGarageActionsService.buyItem(local1);
        trackerService.trackEvent(GA_CATEGORY,GarageWindowEvent.BUY_ITEM,itemService.getName(this._selectedItem));
      }
      dispatchEvent(new GarageWindowEvent(GarageWindowEvent.BUY_ITEM,local1));
    }

    private function onButtonBuyClick(param1:MouseEvent) : void {
      this.onButtonBuyClickInternal();
    }

    private function equip() : void {
      trackerService.trackEvent(GA_CATEGORY,GarageWindowEvent.SETUP_ITEM,itemService.getName(this._selectedItem));
      dispatchEvent(new GarageWindowEvent(GarageWindowEvent.SETUP_ITEM,this._selectedItem));
    }

    private function onButtonEquipClick(param1:MouseEvent) : void {
      this.equip();
    }

    private function removeEvents() : void {
      this._garageList.removeEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,this.onSelectGarageListItem);
      this.itemInfoPanel.buyButton.removeEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
      this.itemInfoPanel.equipButton.removeEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
      this.itemInfoPanel.deletePresentButton.removeEventListener(MouseEvent.CLICK,this.onButtonDeletePresentClick);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.updateNavigationLock);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.updateNavigationLock);
      battleInfoService.removeEventListener(BattleInfoServiceEvent.BATTLE_START,this.onBattleStart);
      this.removeTimerListeners();
    }

    private function removeTimerListeners() : void {
      var local1:TimerKitCouldBeBoughtContext = null;
      for each(local1 in this.timersKitCouldBeBoughtContext) {
        local1.removeListener();
      }
    }

    private function updateNavigationLock(param1:LobbyLayoutServiceEvent = null) : void {
      var local2:GarageButton = this.itemInfoPanel.buyButton;
      if(lobbyLayoutService.isSwitchInProgress()) {
        local2.mouseEnabled = false;
        local2.mouseChildren = false;
      } else {
        local2.mouseEnabled = local2.enabled;
        local2.mouseChildren = local2.enabled;
      }
    }

    public function destroy() : void {
      this.removeEvents();
      if(this.tankPreview != null) {
        removeDisplayObject(this.tankPreview);
        this.tankPreview.destroy();
        this.tankPreview = null;
      }
      this.itemInfoPanel.destroy();
      this.itemInfoPanel = null;
      removeDisplayObject(this._garageListWindow);
      this._garageListWindow = null;
      removeDisplayObject(this._garageListInner);
      this._garageListInner = null;
      this._garageListController.destroy();
      this._garageListController = null;
      this._garageList = null;
      this._categoryButtons = null;
      this._selectedItem = null;
    }

    public function resize(param1:int, param2:int) : void {
      this._windowSize = new Point(param1,param2);
      this._garageListWindow.width = param1;
      this._garageListWindow.height = 205;
      this._garageListWindow.x = 0;
      this._garageListWindow.y = param2 - this._garageListWindow.height;
      this._garageListInner.width = param1 - windowMargin * 2;
      this._garageListInner.height = 169 - windowMargin * 2;
      this._garageListInner.x = windowMargin;
      this._garageListInner.y = this._garageListWindow.y + windowMargin;
      this._garageList.width = this._garageListWindow.width - windowMargin * 2 - 8;
      this._garageList.height = 169 - windowMargin * 2 + 1;
      this._garageList.x = windowMargin + 4;
      this._garageList.y = this._garageListWindow.y + windowMargin + 4;
      this._categoryButtons.width = param1 - windowMargin * 2 - 8;
      this._categoryButtons.x = windowMargin;
      this._categoryButtons.y = this._garageList.y + this._garageList.height;
      if(this.tankPreview != null) {
        this.tankPreview.resize(param1 - itemInfoPanelWidth,param2 - this._garageListWindow.height);
      }
      this.itemInfoPanel.resize(itemInfoPanelWidth,param2 - this._garageListWindow.height);
      this.itemInfoPanel.x = param1 - itemInfoPanelWidth;
    }

    public function isItemInStore(param1:IGameObject) : Boolean {
      return this._garageListController.isItemInStore(param1);
    }

    public function isItemInDepot(param1:IGameObject) : Boolean {
      return this._garageListController.isItemInDepot(param1);
    }

    public function addItemToDepot(param1:IGameObject) : void {
      this._garageListController.addItemToDepot(param1);
    }

    public function addItemToStore(param1:IGameObject) : void {
      this._garageListController.addItemToStore(param1);
    }

    public function updateKitsContainsItem(param1:IGameObject) : void {
      this._garageListController.updateKitsContainsItem(param1);
    }

    public function removeItemFromDepot(param1:IGameObject) : void {
      this._garageListController.removeItemFromDepot(param1);
    }

    public function removeItemFromStore(param1:IGameObject) : void {
      this._garageListController.removeItemFromStore(param1);
    }

    public function get itemsOnDepot() : Vector.<IGameObject> {
      return this._garageListController.itemsInDepot;
    }

    public function unmountItem(param1:IGameObject) : void {
      this._garageList.unmount(param1);
    }

    public function mountItem(param1:IGameObject) : void {
      this._garageList.mount(param1);
    }

    public function showItemInfo(param1:IGameObject, param2:Boolean) : void {
      this.itemInfoPanel.showItemInfo(param1,param2);
      this.itemInfoPanel.resize(itemInfoPanelWidth,this._windowSize.y - this._garageListWindow.height);
    }

    public function removeAllModifications(param1:IGameObject) : void {
      var local3:IGameObject = null;
      var local2:Vector.<IGameObject> = itemService.getModifications(param1);
      for each(local3 in local2) {
        if(this.isItemInDepot(local3)) {
          this.removeItemFromDepot(local3);
        }
        if(this.isItemInStore(local3)) {
          this.removeItemFromStore(local3);
        }
      }
    }

    public function updateCount(param1:IGameObject) : void {
      this._garageList.updateCount(param1,itemService.getCount(param1));
    }

    public function updateDiscount(param1:IGameObject) : void {
      if(this._selectedItem == param1) {
        this.showItemInfo(this._selectedItem,this.isItemInStore(this._selectedItem));
      }
      this._garageListController.updateDiscount(param1);
    }

    public function getSelectedItem() : IGameObject {
      return this._selectedItem;
    }

    public function getItemInfoPanel() : ItemInfoPanel {
      return this.itemInfoPanel;
    }

    public function initDepot(param1:Vector.<IGameObject>) : void {
      this._garageListController.initDepot(param1);
    }

    public function initStore(param1:Vector.<IGameObject>) : void {
      this.checkIfTimersKitCouldBeBoughtContext(param1);
      this._garageListController.initStore(param1);
    }

    private function checkIfTimersKitCouldBeBoughtContext(param1:Vector.<IGameObject>) : void {
      var local4:IGameObject = null;
      var local5:int = 0;
      var local6:int = 0;
      var local7:uint = 0;
      var local8:CountDownTimer = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        if(Boolean(itemService.isKit(local4)) && Boolean(itemService.canBuy(local4)) && Boolean(itemService.isEnabledItem(local4))) {
          local5 = int(itemService.getTimeLeftInSeconds(local4));
          local6 = 2592000;
          if(!itemService.isTimelessItem(local4) && local5 > 0 && local5 <= local6) {
            local7 = uint(local5 * 1000);
            local8 = new CountDownTimer();
            local8.start(local7 + getTimer());
            this.timersKitCouldBeBoughtContext.push(new TimerKitCouldBeBoughtContext(local4,local8,this));
          }
        }
        local3++;
      }
    }

    public function itemFullUpgraded(param1:IGameObject) : void {
      var local2:IGameObject = null;
      if(itemService.isModificationItem(this._selectedItem)) {
        local2 = itemService.getNextModification(param1);
        if(local2 != null) {
          this.updateDiscount(local2);
        }
      }
    }

    public function showDefaultCategory() : void {
      this._garageListController.showDefaultCategory();
    }

    public function showCategory(param1:ItemViewCategoryEnum) : void {
      this._garageListController.showCategory(param1);
    }

    public function showItemInCategory(param1:IGameObject) : void {
      this._garageListController.showItemInCategory(param1);
    }

    public function updateSelection() : void {
      this._garageListController.updateSelection();
    }

    public function getTimersKitCouldBeBoughtContext() : Vector.<TimerKitCouldBeBoughtContext> {
      return this.timersKitCouldBeBoughtContext;
    }

    public function setCategoryButtonVisibility(param1:ItemViewCategoryEnum, param2:Boolean) : void {
      this._categoryButtons.setCategoryButtonVisibility(param1,param2);
    }
  }
}
