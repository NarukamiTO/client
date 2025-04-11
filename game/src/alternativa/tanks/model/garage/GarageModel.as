package alternativa.tanks.model.garage {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.materials.TextureResourcesRegistry;
  import alternativa.engine3d.objects.SkyBox;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.dump.IDumpService;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.GarageWindow;
  import alternativa.tanks.gui.GarageWindowEvent;
  import alternativa.tanks.gui.TimerKitCouldBeBoughtContext;
  import alternativa.tanks.gui.confirm.ConfirmAlert;
  import alternativa.tanks.gui.confirm.ConfirmAlertEvent;
  import alternativa.tanks.help.FirstMoneyHelper;
  import alternativa.tanks.help.SwitchingItemCategoriesHelper;
  import alternativa.tanks.help.TanksPartHelper;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.garage.present.PresentPurchase;
  import alternativa.tanks.model.garage.upgrade.UpgradeGarageItem;
  import alternativa.tanks.model.item.kit.GarageKit;
  import alternativa.tanks.model.item.temporary.ITemporaryItem;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.tanks.service.resistance.ResistanceService;
  import alternativa.tanks.service.temporaryitem.ITemporaryItemService;
  import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyService;
  import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyServiceListener;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import alternativa.types.Long;
  import controls.timer.CountDownTimer;
  import flash.display.BlendMode;
  import flash.display.DisplayObjectContainer;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.geom.Point;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadPostListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.garage.models.garage.GarageModelBase;
  import projects.tanks.client.garage.models.garage.IGarageModelBase;
  import projects.tanks.client.garage.models.item.kit.KitItem;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import services.alertservice.AlertAnswer;
  import utils.resource.IResourceLoadingComplete;
  import utils.resource.ResourceLoadingWrapper;

  [ModelInfo]
  public class GarageModel extends GarageModelBase implements IGarageModelBase, ObjectLoadListener, Garage, ObjectUnloadPostListener, ITemporaryItemNotifyServiceListener, GaragePurchaseConfirmation, IResourceLoadingComplete {
    [Inject]
    public static var upgradingItemsService:UpgradingItemsService;

    [Inject]
    public static var dumpService:IDumpService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var temporaryItemService:ITemporaryItemService;

    [Inject]
    public static var temporaryItemNotifyService:ITemporaryItemNotifyService;

    [Inject]
    public static var tank3DViewer:ITank3DViewer;

    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    [Inject]
    public static var garageService:GarageService;

    [Inject]
    public static var commandService:CommandService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var userGarageActionsService:UserGarageActionsService;

    [Inject]
    public static var deviceService:DeviceService;

    [Inject]
    public static var resistanceService:ResistanceService;

    private static const HELPER_SWITCHING_ITEM_CATEGORIES:int = 2;
    private static const HELPER_TANK_PARTS:int = 3;
    private static const HELPER_MONEY_FIRST:int = 700;
    private static const HELPER_GROUP_KEY:String = "GarageModel";
    private static const SKYBOX_SIZE:int = 200000;
    private static const LAZY_RESOURCES_TO_LOAD:int = 2;

    private var garageWindow:GarageWindow;
    private var itemWaitingForConfirmation:IGameObject;
    private var confirmAlert:ConfirmAlert;
    private var tanksPartHelper:TanksPartHelper;
    private var switchingItemCategoriesHelper:SwitchingItemCategoriesHelper;
    private var firstMoneyHelper:FirstMoneyHelper;
    private var itemsForTrace:Vector.<IGameObject>;
    private var loadedGarageBoxResources:int;
    private var unloadedGarageBox3DS:Tanks3DSResource;
    private var unloadedGarageBoxFrontSide:TextureResource;
    private var loadedGarageBox3DS:Tanks3DSResource;
    private var loadedGarageBoxFrontSide:TextureResource;
    private var garageBox3DSId:Long;
    private var garageBoxFrontSideId:Long;

    public function GarageModel() {
      super();
    }

    public function objectLoaded() : void {
      garageService.init(getInitParam().cameraPitch,getInitParam().cameraAltitude,getInitParam().cameraDistance,getInitParam().cameraFov);
      deviceService.init();
      this.garageWindow = new GarageWindow(UpgradeGarageItem(object.adapt(UpgradeGarageItem)).isUpgradesEnabled());
      garageService.registerView(this.garageWindow);
      this.garageBox3DSId = getInitParam().garageBox.id;
      this.garageBoxFrontSideId = getInitParam().skyboxFrontSide.id;
      this.unloadedGarageBox3DS = getInitParam().garageBox;
      this.unloadedGarageBoxFrontSide = getInitParam().skyboxFrontSide;
      if(!battleInfoService.isInBattle()) {
        this.startTankPreviewWindowLoading();
      }
      if(battleInfoService.isInBattle()) {
        battleInfoService.addEventListener(BattleInfoServiceEvent.BATTLE_UNLOAD,this.onBattleUnload);
      }
      itemService.addMountableCategories(getInitParam().mountableCategories);
    }

    private function startTankPreviewWindowLoading() : void {
      this.loadedGarageBoxResources = 0;
      this.loadResourceOrMarkLoaded(this.unloadedGarageBox3DS);
      this.loadResourceOrMarkLoaded(this.unloadedGarageBoxFrontSide);
    }

    private function onBattleUnload(param1:BattleInfoServiceEvent) : void {
      this.startTankPreviewWindowLoading();
      this.alignWindow();
      this.alignHelpers();
    }

    private function loadResourceOrMarkLoaded(param1:Resource) : void {
      if(!param1.isLoaded) {
        param1.loadLazyResource(new ResourceLoadingWrapper(this));
      } else {
        this.onLoadingComplete(param1);
      }
    }

    public function objectUnloadedPost() : void {
      if(this.garageWindow != null) {
        this.unregisterDumpers();
        temporaryItemNotifyService.removeListener(this);
        this.destroyGarageWindow();
        this.unregisterHelpers();
      }
      this.itemWaitingForConfirmation = null;
      itemService.reset();
      battleInfoService.removeEventListener(BattleInfoServiceEvent.BATTLE_UNLOAD,this.onBattleUnload);
      if(!battleInfoService.isInBattle()) {
        TextureResourcesRegistry.releaseTextureResources();
      }
    }

    private function registerHelpers() : void {
      this.switchingItemCategoriesHelper = new SwitchingItemCategoriesHelper();
      this.tanksPartHelper = new TanksPartHelper();
      this.firstMoneyHelper = new FirstMoneyHelper();
      helpService.registerHelper(HELPER_GROUP_KEY,HELPER_TANK_PARTS,this.tanksPartHelper,true);
      helpService.registerHelper(HELPER_GROUP_KEY,HELPER_SWITCHING_ITEM_CATEGORIES,this.switchingItemCategoriesHelper,true);
      helpService.registerHelper(HELPER_GROUP_KEY,HELPER_MONEY_FIRST,this.firstMoneyHelper,false);
      display.stage.addEventListener(Event.RESIZE,this.alignHelpers);
      this.alignHelpers();
    }

    private function unregisterHelpers() : void {
      display.stage.removeEventListener(Event.RESIZE,this.alignHelpers);
      helpService.hideHelp();
      helpService.unregisterHelper(HELPER_GROUP_KEY,HELPER_SWITCHING_ITEM_CATEGORIES);
      helpService.unregisterHelper(HELPER_GROUP_KEY,HELPER_TANK_PARTS);
      helpService.unregisterHelper(HELPER_GROUP_KEY,HELPER_MONEY_FIRST);
      this.switchingItemCategoriesHelper = null;
      this.tanksPartHelper = null;
      this.firstMoneyHelper = null;
    }

    public function reloadGarage(param1:String, param2:int) : void {
      modalLoaderService.show();
      CountDownTimer.resetAllTimers();
      upgradingItemsService.reset();
      itemService.reset();
      moneyService.init(param2);
      alertService.showAlert(param1,Vector.<String>([AlertAnswer.OK]));
      this.destroyGarageWindow();
      this.unregisterDumpers();
      server.readyToReload();
    }

    private function initGarageWindow() : void {
      var local1:DisplayObjectContainer = display.systemLayer;
      display.mainContainer.blendMode = BlendMode.LAYER;
      local1.addChild(this.garageWindow);
      this.alignWindow();
      this.setEvents();
    }

    private function setEvents() : void {
      display.stage.addEventListener(Event.RESIZE,this.alignWindow);
      this.garageWindow.addEventListener(GarageWindowEvent.SETUP_ITEM,getFunctionWrapper(this.onSetupClick));
      this.garageWindow.addEventListener(GarageWindowEvent.UNMOUNT_ITEM,getFunctionWrapper(this.onUnmountClick));
      this.garageWindow.addEventListener(GarageWindowEvent.BUY_ITEM,getFunctionWrapper(this.onBuyClick));
    }

    private function removeEvents() : void {
      display.stage.removeEventListener(Event.RESIZE,this.alignWindow);
      this.garageWindow.removeEventListener(GarageWindowEvent.SETUP_ITEM,getFunctionWrapper(this.onSetupClick));
      this.garageWindow.removeEventListener(GarageWindowEvent.UNMOUNT_ITEM,getFunctionWrapper(this.onUnmountClick));
      this.garageWindow.removeEventListener(GarageWindowEvent.BUY_ITEM,getFunctionWrapper(this.onBuyClick));
    }

    private function destroyGarageWindow() : void {
      this.removeEvents();
      var local1:DisplayObjectContainer = display.systemLayer;
      if(local1.contains(this.garageWindow)) {
        display.mainContainer.blendMode = BlendMode.NORMAL;
        this.garageWindow.destroy();
        local1.removeChild(this.garageWindow);
      }
      tank3DViewer.resetView();
      garageService.unregisterView();
      this.garageWindow = null;
    }

    private function alignWindow(param1:Event = null) : void {
      var local2:Stage = display.stage;
      var local3:int = int(Math.max(1000,local2.stageWidth));
      if(!battleInfoService.isInBattle()) {
        this.garageWindow.x = Math.round(local3 / 3);
        this.garageWindow.y = 60;
        this.garageWindow.resize(Math.round(local3 * 2 / 3),Math.max(display.stage.stageHeight - 60,530));
      } else {
        this.garageWindow.x = 0;
        this.garageWindow.y = 60;
        this.garageWindow.resize(local3,Math.max(display.stage.stageHeight - 60,530));
      }
    }

    private function alignHelpers(param1:Event = null) : void {
      var local2:int = int(Math.max(1000,display.stage.stageWidth));
      var local3:int = int(Math.max(600,display.stage.stageHeight));
      if(!battleInfoService.isInBattle()) {
        this.tanksPartHelper.targetPoint = new Point(Math.round(local2 * (1 / 3)) + 10,local3 - 125);
        this.switchingItemCategoriesHelper.targetPoint = new Point(Math.round(local2 * (1 / 3)) + 10,local3 - 40);
      } else {
        this.tanksPartHelper.targetPoint = new Point(10000,local3 - 125);
        this.switchingItemCategoriesHelper.targetPoint = new Point(10000,local3 - 40);
      }
      this.firstMoneyHelper.targetPoint = new Point(local2 - 400,30);
      this.updateAchievementPositions();
    }

    public function initMounted(param1:Vector.<IGameObject>) : void {
      this.setOrUpdateMounted(param1);
    }

    private function setOrUpdateMounted(param1:Vector.<IGameObject>) : void {
      var local2:int = 0;
      while(local2 < param1.length) {
        this.mountItem(param1[local2]);
        local2++;
      }
    }

    public function updateMountedItems(param1:Vector.<IGameObject>) : void {
      this.setOrUpdateMounted(param1);
    }

    public function initDepot(param1:Vector.<IGameObject>) : void {
      this.checkAllItemsLoaded(param1,"depot");
      this.initGarage();
      this.garageWindow.initDepot(param1);
    }

    private function checkAllItemsLoaded(param1:Vector.<IGameObject>, param2:String) : void {
      var local3:IGameObject = null;
      for each(local3 in param1) {
        if(local3 == null) {
          throw new Error("Not all items have been loaded into the " + param2);
        }
      }
    }

    private function initGarage() : void {
      this.registerDumpers();
      this.initGarageWindow();
      this.registerHelpers();
      temporaryItemNotifyService.addListener(this);
    }

    public function initMarket(param1:Vector.<IGameObject>) : void {
      this.checkAllItemsLoaded(param1,"market");
      this.garageWindow.initStore(param1);
    }

    public function select(param1:IGameObject) : void {
      this.garageWindow.showItemInCategory(param1);
    }

    public function selectFirstItemInDepot() : void {
      this.garageWindow.showDefaultCategory();
    }

    private function onSetupClick(param1:GarageWindowEvent) : void {
      this.mountItem(param1.item);
      server.itemMounted(param1.item);
      userGarageActionsService.equipItem(param1.item);
    }

    private function onUnmountClick(param1:GarageWindowEvent) : * {
      itemService.unmountItem(param1.item);
      server.itemUnmounted(param1.item);
      userGarageActionsService.unmountItem(param1.item);
    }

    private function mountItem(param1:IGameObject) : void {
      itemService.mountItem(param1);
    }

    private function onBuyAlertConfirm(param1:ConfirmAlertEvent) : void {
      var local3:int = 0;
      userGarageActionsService.purchaseAccepted(this.itemWaitingForConfirmation);
      this.hideConfirmAlert();
      if(itemService.isKit(this.itemWaitingForConfirmation)) {
        this.buyKit();
        if(!itemService.canBuy(this.itemWaitingForConfirmation)) {
          this.removeCompleteListenerKitDiscountTimer(this.itemWaitingForConfirmation);
        }
        return;
      }
      var local2:int = param1.cost;
      moneyService.spend(local2);
      if(itemService.isPresent(this.itemWaitingForConfirmation)) {
        PresentPurchase(object.adapt(PresentPurchase)).confirmPresentPurchase(this.itemWaitingForConfirmation);
        return;
      }
      if(itemService.isCountable(this.itemWaitingForConfirmation)) {
        local3 = int(this.garageWindow.itemInfoPanel.inventoryNumStepper.value);
      } else {
        local3 = 0;
      }
      server.itemBought(this.itemWaitingForConfirmation,local3,local2);
      this.buyItem(this.itemWaitingForConfirmation,local3);
      this.garageWindow.updateKitsContainsItem(this.itemWaitingForConfirmation);
    }

    private function removeCompleteListenerKitDiscountTimer(param1:IGameObject) : void {
      var local2:TimerKitCouldBeBoughtContext = null;
      for each(local2 in this.garageWindow.timersKitCouldBeBoughtContext) {
        if(param1 == local2.item) {
          local2.removeListener();
        }
      }
    }

    private function onBuyAlertDeclined(param1:Event) : void {
      userGarageActionsService.purchaseDeclined(this.itemWaitingForConfirmation);
      this.hideConfirmAlert();
    }

    private function hideConfirmAlert() : void {
      this.confirmAlert.removeEventListener(ConfirmAlertEvent.BUY_ITEM,getFunctionWrapper(this.onBuyAlertConfirm));
      this.confirmAlert.removeEventListener(Event.CANCEL,getFunctionWrapper(this.onBuyAlertDeclined));
      this.confirmAlert = null;
    }

    private function buyKit() : void {
      var local3:KitItem = null;
      var local4:IGameObject = null;
      var local1:GarageKit = GarageKit(this.itemWaitingForConfirmation.adapt(GarageKit));
      var local2:int = int(local1.getPrice());
      if(moneyService.crystal < local2) {
        return;
      }
      moneyService.spend(local2);
      server.kitBought(this.itemWaitingForConfirmation,local2);
      for each(local3 in local1.getItems()) {
        local4 = local3.item;
        this.buyItemInKit(local4,local3.count,local3.mount);
        if(!itemService.isCountable(local4)) {
          this.garageWindow.updateKitsContainsItem(local4);
        }
      }
      this.garageWindow.showItemInCategory(this.itemWaitingForConfirmation);
    }

    private function buyItemInKit(param1:IGameObject, param2:int, param3:Boolean) : void {
      var local4:Number = NaN;
      var local5:IGameObject = null;
      if(itemService.canBuy(param1)) {
        this.buyItem(param1,param2,param3);
      } else if(param1.hasModel(ITemporaryItem)) {
        local4 = 0;
        for each(local5 in this.garageWindow.itemsOnDepot) {
          if(local5.gameClass.id == param1.gameClass.id) {
            local4 = temporaryItemService.getCurrentTimeRemainingMSec(local5) / 1000;
            temporaryItemService.stopItem(local5);
            this.garageWindow.removeItemFromDepot(local5);
          }
        }
        this.garageWindow.addItemToDepot(param1);
        ITemporaryItem(param1.adapt(ITemporaryItem)).startTiming(local4);
      }
    }

    private function forceUpgradePreviousModifications(param1:IGameObject) : void {
      var local3:IGameObject = null;
      var local4:UpgradableItem = null;
      var local2:Vector.<IGameObject> = itemService.getModifications(param1);
      for each(local3 in local2) {
        local4 = UpgradableItem(local3.adapt(UpgradableItem));
        if(local4.isUpgrading()) {
          local4.getCountDownTimer().stop();
        }
      }
    }

    private function buyItem(param1:IGameObject, param2:int, param3:Boolean = true) : void {
      var local5:int = 0;
      var local4:ItemCategoryEnum = itemService.getCategory(param1);
      if(param1.hasModel(ITemporaryItem)) {
        ITemporaryItem(param1.adapt(ITemporaryItem)).startTiming(0);
      }
      if(local4 != ItemCategoryEnum.INVENTORY) {
        if(itemService.isModificationItem(param1)) {
          this.forceUpgradePreviousModifications(param1);
          this.garageWindow.removeAllModifications(param1);
        } else {
          this.garageWindow.removeItemFromStore(param1);
        }
        this.garageWindow.addItemToDepot(param1);
      } else {
        local5 = int(itemService.getCount(param1));
        if(param2 > 0) {
          itemService.setCount(param1,local5 + param2);
          this.garageWindow.updateCount(param1);
        }
      }
      if(param3 && Boolean(itemService.isMountable(param1)) && this.haveAbilityToMount(param1)) {
        this.mountItem(param1);
        server.itemMounted(param1);
      }
      if(itemService.getCategory(param1) == ItemCategoryEnum.RESISTANCE_MODULE) {
        resistanceService.mountBought(param1);
      }
    }

    public function haveAbilityToMount(param1:IGameObject) : Boolean {
      if(!lobbyLayoutService.inBattle()) {
        return true;
      }
      if(this.isModificationMount(param1)) {
        return true;
      }
      if(!battleInfoService.reArmorEnabled) {
        return false;
      }
      if(itemService.getCategory(param1) == ItemCategoryEnum.PAINT) {
        return true;
      }
      var local2:CountDownTimer = delayMountCategoryService.getDownTimer(param1);
      return local2.getRemainingSeconds() <= 0;
    }

    private function isModificationMount(param1:IGameObject) : Boolean {
      var local3:IGameObject = null;
      if(!itemService.isModificationItem(param1)) {
        return false;
      }
      var local2:Vector.<IGameObject> = itemService.getModifications(param1);
      for each(local3 in local2) {
        if(itemService.isMounted(local3)) {
          return true;
        }
      }
      return false;
    }

    private function onBuyClick(param1:GarageWindowEvent) : void {
      this.itemWaitingForConfirmation = param1.item;
      var local2:int = this.getPrice(this.itemWaitingForConfirmation);
      if(moneyService.checkEnough(local2)) {
        if(itemService.isPresent(this.itemWaitingForConfirmation)) {
          PresentPurchase(object.adapt(PresentPurchase)).preparePresent(this.itemWaitingForConfirmation);
          return;
        }
        this.showConfirmationAlert(local2);
      } else {
        userGarageActionsService.notEnoughCrystalsForBuying(this.itemWaitingForConfirmation);
      }
    }

    public function showConfirmationAlert(param1:int) : void {
      var local2:Boolean = Boolean(itemService.isCountable(this.itemWaitingForConfirmation));
      this.confirmAlert = new ConfirmAlert(this.itemWaitingForConfirmation,param1,local2 ? int(this.garageWindow.itemInfoPanel.inventoryNumStepper.value) : -1);
      this.confirmAlert.addEventListener(ConfirmAlertEvent.BUY_ITEM,getFunctionWrapper(this.onBuyAlertConfirm));
      this.confirmAlert.addEventListener(Event.CANCEL,getFunctionWrapper(this.onBuyAlertDeclined));
    }

    private function updateAchievementPositions() : void {
      var local1:int = 0;
      if(Boolean(this.garageWindow.itemInfoPanel.buyButton.enabled) && Boolean(this.garageWindow.itemInfoPanel.buyButton.visible)) {
        local1 = this.garageWindow.x + this.garageWindow.itemInfoPanel.x;
        achievementService.setGarageBuyButtonTargetPoint(new Point(this.garageWindow.itemInfoPanel.buyButton.x + local1,this.garageWindow.itemInfoPanel.buyButton.y + 75));
      } else {
        achievementService.setGarageBuyButtonTargetPoint(new Point(0,0));
      }
    }

    public function temporaryItemTimeIsUp(param1:IGameObject) : void {
      if(this.garageWindow != null) {
        this.garageWindow.removeItemFromDepot(param1);
        if(itemService.getPrice(param1) > 0 && Boolean(itemService.isBuyable(param1))) {
          this.garageWindow.addItemToStore(param1);
        } else {
          this.garageWindow.updateSelection();
        }
      }
    }

    private function getPrice(param1:IGameObject) : int {
      var local2:int = int(itemService.getPrice(param1));
      if(itemService.isCountable(param1)) {
        local2 *= this.garageWindow.itemInfoPanel.inventoryNumStepper.value;
      }
      return local2;
    }

    private function registerDumpers() : void {
    }

    private function traceUpgrades(param1:FormattedOutput) : void {
    }

    private function unregisterDumpers() : void {
    }

    public function updateDepotItem(param1:IGameObject, param2:int) : void {
      if(param1 == null) {
        return;
      }
      if(itemService.isCountable(param1)) {
        itemService.setCount(param1,param2);
        this.garageWindow.updateCount(param1);
      } else if(!itemService.hasItem(param1)) {
        this.garageWindow.removeItemFromStore(param1);
        this.garageWindow.addItemToDepot(param1);
      }
    }

    public function removeDepotItem(param1:IGameObject) : void {
      if(itemService.hasItem(param1)) {
        this.garageWindow.removeItemFromDepot(param1);
        this.garageWindow.addItemToStore(param1);
      }
    }

    public function updateTemporaryItem(param1:IGameObject, param2:int) : void {
      var local3:ITemporaryItem = ITemporaryItem(param1.adapt(ITemporaryItem));
      local3.setRemainingTime(param2);
    }

    public function showCategory(param1:ItemViewCategoryEnum) : void {
      this.garageWindow.showCategory(param1);
    }

    public function onLoadingComplete(param1:Resource) : void {
      ++this.loadedGarageBoxResources;
      if(this.garageBox3DSId == param1.id) {
        this.loadedGarageBox3DS = Tanks3DSResource(param1);
      } else if(this.garageBoxFrontSideId == param1.id) {
        this.loadedGarageBoxFrontSide = TextureResource(param1);
      }
      if(this.loadedGarageBoxResources == LAZY_RESOURCES_TO_LOAD) {
        this.initTankPreview();
      }
    }

    private function initTankPreview() : void {
      this.garageWindow.initTankPreviewWindow(this.loadedGarageBox3DS,new SkyBox(SKYBOX_SIZE,null,null,null,new TextureMaterial(this.loadedGarageBoxFrontSide.data),null,null));
    }

    public function unmountDrone() : void {
      tank3DViewer.setDrone(null);
    }
  }
}
