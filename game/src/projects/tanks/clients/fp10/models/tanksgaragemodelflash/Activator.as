package projects.tanks.clients.fp10.models.tanksgaragemodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.dump.IDumpService;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.gui.GarageWindow;
  import alternativa.tanks.gui.ItemInfoPanel;
  import alternativa.tanks.gui.PresentInfoPanel;
  import alternativa.tanks.gui.TimerItemWillBeEnabledContext;
  import alternativa.tanks.gui.buttons.GarageButton;
  import alternativa.tanks.gui.confirm.ConfirmAlert;
  import alternativa.tanks.gui.confirm.DeviceRentConfirmAlert;
  import alternativa.tanks.gui.device.DeviceController;
  import alternativa.tanks.gui.device.DevicePanel;
  import alternativa.tanks.gui.device.DevicesWindow;
  import alternativa.tanks.gui.device.ItemInfoDevicesPanel;
  import alternativa.tanks.gui.garagelist.GarageListController;
  import alternativa.tanks.gui.item.actionpanel.SingleActionPanel;
  import alternativa.tanks.gui.item.actionpanel.SingleActionWithCheckBoxPanel;
  import alternativa.tanks.gui.present.give.PresentPrepareWindow;
  import alternativa.tanks.gui.skins.ItemSkinsWindow;
  import alternativa.tanks.gui.skins.ShotSkinDescription;
  import alternativa.tanks.gui.skins.ShotSkinsWindow;
  import alternativa.tanks.gui.skins.SkinDescription;
  import alternativa.tanks.gui.tables.KitInfoTable;
  import alternativa.tanks.gui.tables.KitItemInfoRow;
  import alternativa.tanks.gui.tankpreview.EventTankPreview;
  import alternativa.tanks.gui.tankpreview.TankPreviewHoliday;
  import alternativa.tanks.gui.tankpreview.TankPreviewWindow;
  import alternativa.tanks.gui.upgrade.SelectUpgradeWindow;
  import alternativa.tanks.gui.upgrade.UpgradeButton;
  import alternativa.tanks.gui.upgrade.UpgradeColors;
  import alternativa.tanks.gui.upgrade.UpgradeInfoForm;
  import alternativa.tanks.gui.upgrade.UpgradeProgressForm;
  import alternativa.tanks.gui.upgrade.UpgradeWindowBase;
  import alternativa.tanks.help.FirstMoneyHelper;
  import alternativa.tanks.help.SwitchingItemCategoriesHelper;
  import alternativa.tanks.help.TanksPartHelper;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.garage.Garage;
  import alternativa.tanks.model.garage.GarageAdapt;
  import alternativa.tanks.model.garage.GarageEvents;
  import alternativa.tanks.model.garage.GarageModel;
  import alternativa.tanks.model.garage.GaragePurchaseConfirmation;
  import alternativa.tanks.model.garage.GaragePurchaseConfirmationAdapt;
  import alternativa.tanks.model.garage.GaragePurchaseConfirmationEvents;
  import alternativa.tanks.model.garage.Tank3DViewer;
  import alternativa.tanks.model.garage.passtoshop.PassToShopModel;
  import alternativa.tanks.model.garage.passtoshop.PassToShopService;
  import alternativa.tanks.model.garage.passtoshop.PassToShopServiceAdapt;
  import alternativa.tanks.model.garage.passtoshop.PassToShopServiceEvents;
  import alternativa.tanks.model.garage.premium.PremiumInDepotModel;
  import alternativa.tanks.model.garage.present.PresentGiven;
  import alternativa.tanks.model.garage.present.PresentGivenAdapt;
  import alternativa.tanks.model.garage.present.PresentGivenEvents;
  import alternativa.tanks.model.garage.present.PresentGivenModel;
  import alternativa.tanks.model.garage.present.PresentProfileModel;
  import alternativa.tanks.model.garage.present.PresentPurchase;
  import alternativa.tanks.model.garage.present.PresentPurchaseAdapt;
  import alternativa.tanks.model.garage.present.PresentPurchaseEvents;
  import alternativa.tanks.model.garage.present.PresentPurchaseModel;
  import alternativa.tanks.model.garage.preview.GaragePreviewModel;
  import alternativa.tanks.model.garage.temperature.TemperatureConfig;
  import alternativa.tanks.model.garage.temperature.TemperatureModel;
  import alternativa.tanks.model.garage.upgrade.FlushUpgrades;
  import alternativa.tanks.model.garage.upgrade.FlushUpgradesAdapt;
  import alternativa.tanks.model.garage.upgrade.FlushUpgradesEvents;
  import alternativa.tanks.model.garage.upgrade.UpgradeGarageItem;
  import alternativa.tanks.model.garage.upgrade.UpgradeGarageItemAdapt;
  import alternativa.tanks.model.garage.upgrade.UpgradeGarageItemEvents;
  import alternativa.tanks.model.garage.upgrade.UpgradeGarageItemModel;
  import alternativa.tanks.model.item.availabledevices.AvailableDevices;
  import alternativa.tanks.model.item.availabledevices.AvailableDevicesAdapt;
  import alternativa.tanks.model.item.availabledevices.AvailableDevicesEvents;
  import alternativa.tanks.model.item.availabledevices.AvailableDevicesModel;
  import alternativa.tanks.model.item.buyable.BuyableModel;
  import alternativa.tanks.model.item.buyable.IBuyable;
  import alternativa.tanks.model.item.buyable.IBuyableAdapt;
  import alternativa.tanks.model.item.buyable.IBuyableEvents;
  import alternativa.tanks.model.item.category.IItemCategory;
  import alternativa.tanks.model.item.category.IItemCategoryAdapt;
  import alternativa.tanks.model.item.category.IItemCategoryEvents;
  import alternativa.tanks.model.item.category.IItemViewCategory;
  import alternativa.tanks.model.item.category.IItemViewCategoryAdapt;
  import alternativa.tanks.model.item.category.IItemViewCategoryEvents;
  import alternativa.tanks.model.item.category.ItemCategoryModel;
  import alternativa.tanks.model.item.category.ItemViewCategoryModel;
  import alternativa.tanks.model.item.container.gui.ContainerPanel;
  import alternativa.tanks.model.item.container.gui.opening.ContainerOpenDialog;
  import alternativa.tanks.model.item.container.lootboxes.LootBoxModel;
  import alternativa.tanks.model.item.container.resource.ContainerResource;
  import alternativa.tanks.model.item.container.resource.ContainerResourceAdapt;
  import alternativa.tanks.model.item.container.resource.ContainerResourceEvents;
  import alternativa.tanks.model.item.container.resource.ContainerResourceModel;
  import alternativa.tanks.model.item.container.weeklycontainer.WeeklyContainerModel;
  import alternativa.tanks.model.item.countable.CountableItemModel;
  import alternativa.tanks.model.item.countable.ICountableItem;
  import alternativa.tanks.model.item.countable.ICountableItemAdapt;
  import alternativa.tanks.model.item.countable.ICountableItemEvents;
  import alternativa.tanks.model.item.delaymountcategory.DelayMountCategoryModel;
  import alternativa.tanks.model.item.device.ItemDevicesGarage;
  import alternativa.tanks.model.item.device.ItemDevicesGarageAdapt;
  import alternativa.tanks.model.item.device.ItemDevicesGarageEvents;
  import alternativa.tanks.model.item.device.ItemDevicesGarageModel;
  import alternativa.tanks.model.item.discount.DiscountCollectorModel;
  import alternativa.tanks.model.item.discount.DiscountEndTimer;
  import alternativa.tanks.model.item.discount.DiscountEndTimerAdapt;
  import alternativa.tanks.model.item.discount.DiscountEndTimerEvents;
  import alternativa.tanks.model.item.discount.DiscountForUpgradeModel;
  import alternativa.tanks.model.item.discount.DiscountModel;
  import alternativa.tanks.model.item.discount.ICollectDiscount;
  import alternativa.tanks.model.item.discount.ICollectDiscountAdapt;
  import alternativa.tanks.model.item.discount.ICollectDiscountEvents;
  import alternativa.tanks.model.item.discount.IDiscount;
  import alternativa.tanks.model.item.discount.IDiscountAdapt;
  import alternativa.tanks.model.item.discount.IDiscountEvents;
  import alternativa.tanks.model.item.discount.proabonement.ProAbonementRankDiscount;
  import alternativa.tanks.model.item.discount.proabonement.ProAbonementRankDiscountAdapt;
  import alternativa.tanks.model.item.discount.proabonement.ProAbonementRankDiscountEvents;
  import alternativa.tanks.model.item.discount.proabonement.ProAbonementRankDiscountModel;
  import alternativa.tanks.model.item.drone.DroneModel;
  import alternativa.tanks.model.item.drone.DronePanel;
  import alternativa.tanks.model.item.drone.HasBatteriesNotifyModel;
  import alternativa.tanks.model.item.droppablegold.DroppableGoldItemModel;
  import alternativa.tanks.model.item.fitting.ItemFitting;
  import alternativa.tanks.model.item.fitting.ItemFittingAdapt;
  import alternativa.tanks.model.item.fitting.ItemFittingEvents;
  import alternativa.tanks.model.item.fitting.ItemFittingModel;
  import alternativa.tanks.model.item.grouped.GroupedItemModel;
  import alternativa.tanks.model.item.grouped.IGroupedItem;
  import alternativa.tanks.model.item.grouped.IGroupedItemAdapt;
  import alternativa.tanks.model.item.grouped.IGroupedItemEvents;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import alternativa.tanks.model.item.info.ItemActionPanelAdapt;
  import alternativa.tanks.model.item.info.ItemActionPanelEvents;
  import alternativa.tanks.model.item.item.IItem;
  import alternativa.tanks.model.item.item.IItemAdapt;
  import alternativa.tanks.model.item.item.IItemEvents;
  import alternativa.tanks.model.item.item.ItemModel;
  import alternativa.tanks.model.item.itemforpartners.ItemEnabledForPartner;
  import alternativa.tanks.model.item.itemforpartners.ItemEnabledForPartnerAdapt;
  import alternativa.tanks.model.item.itemforpartners.ItemEnabledForPartnerEvents;
  import alternativa.tanks.model.item.itemforpartners.ItemEnabledForPartnerModel;
  import alternativa.tanks.model.item.itempersonaldiscount.ItemPersonalDiscountModel;
  import alternativa.tanks.model.item.kit.GarageKit;
  import alternativa.tanks.model.item.kit.GarageKitAdapt;
  import alternativa.tanks.model.item.kit.GarageKitEvents;
  import alternativa.tanks.model.item.kit.GarageKitModel;
  import alternativa.tanks.model.item.modification.IModification;
  import alternativa.tanks.model.item.modification.IModificationAdapt;
  import alternativa.tanks.model.item.modification.IModificationEvents;
  import alternativa.tanks.model.item.modification.ModificationModel;
  import alternativa.tanks.model.item.premium.PremiumItem;
  import alternativa.tanks.model.item.premium.PremiumItemAdapt;
  import alternativa.tanks.model.item.premium.PremiumItemEvents;
  import alternativa.tanks.model.item.premium.PremiumItemModel;
  import alternativa.tanks.model.item.present.PresentImage;
  import alternativa.tanks.model.item.present.PresentImageAdapt;
  import alternativa.tanks.model.item.present.PresentImageEvents;
  import alternativa.tanks.model.item.present.PresentItemModel;
  import alternativa.tanks.model.item.present.UserPresent;
  import alternativa.tanks.model.item.present.UserPresentAdapt;
  import alternativa.tanks.model.item.present.UserPresentEvents;
  import alternativa.tanks.model.item.properties.ItemProperties;
  import alternativa.tanks.model.item.properties.ItemPropertiesAdapt;
  import alternativa.tanks.model.item.properties.ItemPropertiesEvents;
  import alternativa.tanks.model.item.properties.ItemPropertiesModel;
  import alternativa.tanks.model.item.rarity.ItemRarityModel;
  import alternativa.tanks.model.item.relativeproperties.RelativePropertiesModel;
  import alternativa.tanks.model.item.rename.RenameForm;
  import alternativa.tanks.model.item.rename.RenameModel;
  import alternativa.tanks.model.item.resistance.MountedResistances;
  import alternativa.tanks.model.item.resistance.MountedResistancesAdapt;
  import alternativa.tanks.model.item.resistance.MountedResistancesEvents;
  import alternativa.tanks.model.item.resistance.MountedResistancesModel;
  import alternativa.tanks.model.item.resistance.ResistanceModuleModel;
  import alternativa.tanks.model.item.resistance.view.MountedResistancesPanel;
  import alternativa.tanks.model.item.resistance.view.ResistanceButton;
  import alternativa.tanks.model.item.resistance.view.ResistancePanel;
  import alternativa.tanks.model.item.shopabonement.ShopAbonement;
  import alternativa.tanks.model.item.shopabonement.ShopAbonementAdapt;
  import alternativa.tanks.model.item.shopabonement.ShopAbonementEvents;
  import alternativa.tanks.model.item.shopabonement.ShopAbonementModel;
  import alternativa.tanks.model.item.skins.AvailableShotSkins;
  import alternativa.tanks.model.item.skins.AvailableShotSkinsAdapt;
  import alternativa.tanks.model.item.skins.AvailableShotSkinsEvents;
  import alternativa.tanks.model.item.skins.AvailableShotSkinsModel;
  import alternativa.tanks.model.item.skins.AvailableSkins;
  import alternativa.tanks.model.item.skins.AvailableSkinsAdapt;
  import alternativa.tanks.model.item.skins.AvailableSkinsEvents;
  import alternativa.tanks.model.item.skins.AvailableSkinsItemModel;
  import alternativa.tanks.model.item.skins.MountShotSkin;
  import alternativa.tanks.model.item.skins.MountShotSkinAdapt;
  import alternativa.tanks.model.item.skins.MountShotSkinEvents;
  import alternativa.tanks.model.item.skins.MountShotSkinModel;
  import alternativa.tanks.model.item.skins.MountSkin;
  import alternativa.tanks.model.item.skins.MountSkinAdapt;
  import alternativa.tanks.model.item.skins.MountSkinEvents;
  import alternativa.tanks.model.item.skins.MountSkinItemModel;
  import alternativa.tanks.model.item.temporary.ITemporaryItem;
  import alternativa.tanks.model.item.temporary.ITemporaryItemAdapt;
  import alternativa.tanks.model.item.temporary.ITemporaryItemEvents;
  import alternativa.tanks.model.item.temporary.TemporaryItemModel;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.model.item.upgradable.UpgradableItemAdapt;
  import alternativa.tanks.model.item.upgradable.UpgradableItemEvents;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import alternativa.tanks.model.item.upgradable.UpgradeParamsModel;
  import alternativa.tanks.model.item.upgradable.VideoAdsItemUpgradeModel;
  import alternativa.tanks.model.item.upgradable.calculators.CriticalChanceCalculator;
  import alternativa.tanks.model.item3d.Item3DModel;
  import alternativa.tanks.model.item3d.Object3DSModel;
  import alternativa.tanks.model.mobilelootbox.MobileLootBoxDeliveryModel;
  import alternativa.tanks.model.mobilelootbox.MobileLootBoxModel;
  import alternativa.tanks.model.mobilelootbox.VideoAdsMobileLootBoxModel;
  import alternativa.tanks.model.useremailandpassword.PasswordService;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.battery.BatteriesService;
  import alternativa.tanks.service.delaymountcategory.DelayMountCategoryServiceImpl;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.device.DeviceServiceImpl;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item.ItemServiceImpl;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsServiceImpl;
  import alternativa.tanks.service.itempropertyparams.aggregationmodes.InvertUpgradeAggregationMode;
  import alternativa.tanks.service.itempropertyparams.aggregationmodes.RangeUpgradeAggregationMode;
  import alternativa.tanks.service.itempropertyparams.aggregationmodes.SumUpgradeAggregationMode;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
  import alternativa.tanks.service.resistance.ResistanceService;
  import alternativa.tanks.service.resistance.ResistanceServiceImpl;
  import alternativa.tanks.service.temporaryitem.ITemporaryItemService;
  import alternativa.tanks.service.temporaryitem.TemporaryItemService;
  import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyService;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import alternativa.tanks.tracker.ITrackerService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegisterAdapt:ModelRegistry;
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(IAlertService,function(param1:Object):void {
        GarageWindow.alertService = IAlertService(param1);
      },function():IAlertService {
        return GarageWindow.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        GarageWindow.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return GarageWindow.battleInfoService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        GarageWindow.itemService = ItemService(param1);
      },function():ItemService {
        return GarageWindow.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        GarageWindow.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return GarageWindow.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GarageWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GarageWindow.localeService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        GarageWindow.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return GarageWindow.paymentDisplayService;
      });
      osgi.injectService(ITank3DViewer,function(param1:Object):void {
        GarageWindow.tank3DViewer = ITank3DViewer(param1);
      },function():ITank3DViewer {
        return GarageWindow.tank3DViewer;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        GarageWindow.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return GarageWindow.trackerService;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        GarageWindow.userGarageActionsService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return GarageWindow.userGarageActionsService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ItemInfoPanel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ItemInfoPanel.battleInfoService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        ItemInfoPanel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return ItemInfoPanel.delayMountCategoryService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        ItemInfoPanel.deviceService = DeviceService(param1);
      },function():DeviceService {
        return ItemInfoPanel.deviceService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        ItemInfoPanel.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return ItemInfoPanel.dialogService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ItemInfoPanel.itemService = ItemService(param1);
      },function():ItemService {
        return ItemInfoPanel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ItemInfoPanel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ItemInfoPanel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ItemInfoPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ItemInfoPanel.localeService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        ItemInfoPanel.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return ItemInfoPanel.moneyService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        ItemInfoPanel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return ItemInfoPanel.paymentDisplayService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        ItemInfoPanel.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return ItemInfoPanel.propertyService;
      });
      osgi.injectService(ITank3DViewer,function(param1:Object):void {
        ItemInfoPanel.tank3dView = ITank3DViewer(param1);
      },function():ITank3DViewer {
        return ItemInfoPanel.tank3dView;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        ItemInfoPanel.userGarageActionsService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return ItemInfoPanel.userGarageActionsService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ItemInfoPanel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ItemInfoPanel.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PresentInfoPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PresentInfoPanel.localeService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        TimerItemWillBeEnabledContext.itemService = ItemService(param1);
      },function():ItemService {
        return TimerItemWillBeEnabledContext.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GarageButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GarageButton.localeService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        GarageButton.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return GarageButton.moneyService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        GarageButton.premiumService = PremiumService(param1);
      },function():PremiumService {
        return GarageButton.premiumService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ConfirmAlert.itemService = ItemService(param1);
      },function():ItemService {
        return ConfirmAlert.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ConfirmAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ConfirmAlert.localeService;
      });
      osgi.injectService(ITimeUnitService,function(param1:Object):void {
        DeviceRentConfirmAlert.timeUnitService = ITimeUnitService(param1);
      },function():ITimeUnitService {
        return DeviceRentConfirmAlert.timeUnitService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        DeviceController.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return DeviceController.delayMountCategoryService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        DeviceController.deviceService = DeviceService(param1);
      },function():DeviceService {
        return DeviceController.deviceService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DeviceController.itemService = ItemService(param1);
      },function():ItemService {
        return DeviceController.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DeviceController.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DeviceController.lobbyLayoutService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        DeviceController.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return DeviceController.moneyService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        DeviceController.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return DeviceController.paymentDisplayService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        DevicePanel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return DevicePanel.delayMountCategoryService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        DevicePanel.deviceService = DeviceService(param1);
      },function():DeviceService {
        return DevicePanel.deviceService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DevicePanel.itemService = ItemService(param1);
      },function():ItemService {
        return DevicePanel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DevicePanel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DevicePanel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DevicePanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DevicePanel.localeService;
      });
      osgi.injectService(ITemporaryItemService,function(param1:Object):void {
        DevicePanel.temporaryItemService = ITemporaryItemService(param1);
      },function():ITemporaryItemService {
        return DevicePanel.temporaryItemService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        DevicesWindow.deviceService = DeviceService(param1);
      },function():DeviceService {
        return DevicesWindow.deviceService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        DevicesWindow.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return DevicesWindow.dialogService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DevicesWindow.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DevicesWindow.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DevicesWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DevicesWindow.localeService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        DevicesWindow.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return DevicesWindow.moneyService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        DevicesWindow.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return DevicesWindow.propertyService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ItemInfoDevicesPanel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ItemInfoDevicesPanel.battleInfoService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        ItemInfoDevicesPanel.blurService = IBlurService(param1);
      },function():IBlurService {
        return ItemInfoDevicesPanel.blurService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        ItemInfoDevicesPanel.deviceService = DeviceService(param1);
      },function():DeviceService {
        return ItemInfoDevicesPanel.deviceService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ItemInfoDevicesPanel.itemService = ItemService(param1);
      },function():ItemService {
        return ItemInfoDevicesPanel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ItemInfoDevicesPanel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ItemInfoDevicesPanel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ItemInfoDevicesPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ItemInfoDevicesPanel.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        ItemInfoDevicesPanel.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return ItemInfoDevicesPanel.modalLoaderService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        GarageListController.garageService = GarageService(param1);
      },function():GarageService {
        return GarageListController.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        GarageListController.itemService = ItemService(param1);
      },function():ItemService {
        return GarageListController.itemService;
      });
      osgi.injectService(INotificationGarageCategoriesService,function(param1:Object):void {
        GarageListController.notificationGarageCategoriesService = INotificationGarageCategoriesService(param1);
      },function():INotificationGarageCategoriesService {
        return GarageListController.notificationGarageCategoriesService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        GarageListController.premiumService = PremiumService(param1);
      },function():PremiumService {
        return GarageListController.premiumService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        GarageListController.storageService = IStorageService(param1);
      },function():IStorageService {
        return GarageListController.storageService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        GarageListController.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return GarageListController.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SingleActionPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SingleActionPanel.localeService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        SingleActionWithCheckBoxPanel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return SingleActionWithCheckBoxPanel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PresentPrepareWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PresentPrepareWindow.localeService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        ItemSkinsWindow.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return ItemSkinsWindow.dialogService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ItemSkinsWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ItemSkinsWindow.localeService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        ShotSkinDescription.garageService = GarageService(param1);
      },function():GarageService {
        return ShotSkinDescription.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ShotSkinDescription.itemService = ItemService(param1);
      },function():ItemService {
        return ShotSkinDescription.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ShotSkinDescription.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ShotSkinDescription.localeService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        ShotSkinsWindow.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return ShotSkinsWindow.dialogService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ShotSkinsWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ShotSkinsWindow.localeService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        SkinDescription.garageService = GarageService(param1);
      },function():GarageService {
        return SkinDescription.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        SkinDescription.itemService = ItemService(param1);
      },function():ItemService {
        return SkinDescription.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SkinDescription.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SkinDescription.localeService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        KitInfoTable.itemService = ItemService(param1);
      },function():ItemService {
        return KitInfoTable.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        KitInfoTable.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return KitInfoTable.localeService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        KitItemInfoRow.itemService = ItemService(param1);
      },function():ItemService {
        return KitItemInfoRow.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        KitItemInfoRow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return KitItemInfoRow.localeService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        EventTankPreview.garageService = GarageService(param1);
      },function():GarageService {
        return EventTankPreview.garageService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        EventTankPreview.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return EventTankPreview.lobbyLayoutService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        TankPreviewHoliday.garageService = GarageService(param1);
      },function():GarageService {
        return TankPreviewHoliday.garageService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        TankPreviewHoliday.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return TankPreviewHoliday.lobbyLayoutService;
      });
      osgi.injectService(BatteriesService,function(param1:Object):void {
        TankPreviewWindow.batteryService = BatteriesService(param1);
      },function():BatteriesService {
        return TankPreviewWindow.batteryService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        TankPreviewWindow.garageService = GarageService(param1);
      },function():GarageService {
        return TankPreviewWindow.garageService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        TankPreviewWindow.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return TankPreviewWindow.lobbyLayoutService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        SelectUpgradeWindow.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return SelectUpgradeWindow.lobbyLayoutService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        SelectUpgradeWindow.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return SelectUpgradeWindow.moneyService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        SelectUpgradeWindow.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return SelectUpgradeWindow.propertyService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        UpgradeButton.itemService = ItemService(param1);
      },function():ItemService {
        return UpgradeButton.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UpgradeButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UpgradeButton.localeService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        UpgradeColors.itemService = ItemService(param1);
      },function():ItemService {
        return UpgradeColors.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UpgradeInfoForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UpgradeInfoForm.localeService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        UpgradeInfoForm.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return UpgradeInfoForm.propertyService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UpgradeProgressForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UpgradeProgressForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UpgradeWindowBase.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UpgradeWindowBase.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FirstMoneyHelper.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FirstMoneyHelper.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SwitchingItemCategoriesHelper.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SwitchingItemCategoriesHelper.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TanksPartHelper.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TanksPartHelper.localeService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        GarageModel.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return GarageModel.achievementService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        GarageModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return GarageModel.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        GarageModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return GarageModel.battleInfoService;
      });
      osgi.injectService(CommandService,function(param1:Object):void {
        GarageModel.commandService = CommandService(param1);
      },function():CommandService {
        return GarageModel.commandService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        GarageModel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return GarageModel.delayMountCategoryService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        GarageModel.deviceService = DeviceService(param1);
      },function():DeviceService {
        return GarageModel.deviceService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        GarageModel.display = IDisplay(param1);
      },function():IDisplay {
        return GarageModel.display;
      });
      osgi.injectService(IDumpService,function(param1:Object):void {
        GarageModel.dumpService = IDumpService(param1);
      },function():IDumpService {
        return GarageModel.dumpService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        GarageModel.garageService = GarageService(param1);
      },function():GarageService {
        return GarageModel.garageService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        GarageModel.helpService = IHelpService(param1);
      },function():IHelpService {
        return GarageModel.helpService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        GarageModel.itemService = ItemService(param1);
      },function():ItemService {
        return GarageModel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        GarageModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return GarageModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GarageModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GarageModel.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        GarageModel.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return GarageModel.modalLoaderService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        GarageModel.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return GarageModel.moneyService;
      });
      osgi.injectService(ResistanceService,function(param1:Object):void {
        GarageModel.resistanceService = ResistanceService(param1);
      },function():ResistanceService {
        return GarageModel.resistanceService;
      });
      osgi.injectService(ITank3DViewer,function(param1:Object):void {
        GarageModel.tank3DViewer = ITank3DViewer(param1);
      },function():ITank3DViewer {
        return GarageModel.tank3DViewer;
      });
      osgi.injectService(ITemporaryItemNotifyService,function(param1:Object):void {
        GarageModel.temporaryItemNotifyService = ITemporaryItemNotifyService(param1);
      },function():ITemporaryItemNotifyService {
        return GarageModel.temporaryItemNotifyService;
      });
      osgi.injectService(ITemporaryItemService,function(param1:Object):void {
        GarageModel.temporaryItemService = ITemporaryItemService(param1);
      },function():ITemporaryItemService {
        return GarageModel.temporaryItemService;
      });
      osgi.injectService(UpgradingItemsService,function(param1:Object):void {
        GarageModel.upgradingItemsService = UpgradingItemsService(param1);
      },function():UpgradingItemsService {
        return GarageModel.upgradingItemsService;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        GarageModel.userGarageActionsService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return GarageModel.userGarageActionsService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        Tank3DViewer.itemService = ItemService(param1);
      },function():ItemService {
        return Tank3DViewer.itemService;
      });
      osgi.injectService(PassToShopService,function(param1:Object):void {
        PremiumInDepotModel.passToShop = PassToShopService(param1);
      },function():PassToShopService {
        return PremiumInDepotModel.passToShop;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        PremiumInDepotModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return PremiumInDepotModel.paymentDisplayService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        PresentProfileModel.garageService = GarageService(param1);
      },function():GarageService {
        return PresentProfileModel.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        PresentPurchaseModel.itemService = ItemService(param1);
      },function():ItemService {
        return PresentPurchaseModel.itemService;
      });
      osgi.injectService(TemperatureConfig,function(param1:Object):void {
        TemperatureModel.config = TemperatureConfig(param1);
      },function():TemperatureConfig {
        return TemperatureModel.config;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        UpgradeGarageItemModel.clientLog = IClientLog(param1);
      },function():IClientLog {
        return UpgradeGarageItemModel.clientLog;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        UpgradeGarageItemModel.garageService = GarageService(param1);
      },function():GarageService {
        return UpgradeGarageItemModel.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        UpgradeGarageItemModel.itemService = ItemService(param1);
      },function():ItemService {
        return UpgradeGarageItemModel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        UpgradeGarageItemModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return UpgradeGarageItemModel.lobbyLayoutService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        UpgradeGarageItemModel.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return UpgradeGarageItemModel.moneyService;
      });
      osgi.injectService(UpgradingItemsService,function(param1:Object):void {
        UpgradeGarageItemModel.upgradingItemsService = UpgradingItemsService(param1);
      },function():UpgradingItemsService {
        return UpgradeGarageItemModel.upgradingItemsService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        AvailableDevicesModel.deviceService = DeviceService(param1);
      },function():DeviceService {
        return AvailableDevicesModel.deviceService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ContainerPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ContainerPanel.localeService;
      });
      osgi.injectService(PassToShopService,function(param1:Object):void {
        ContainerPanel.passToShop = PassToShopService(param1);
      },function():PassToShopService {
        return ContainerPanel.passToShop;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        ContainerOpenDialog.loaderService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return ContainerOpenDialog.loaderService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ContainerOpenDialog.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ContainerOpenDialog.localeService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        LootBoxModel.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return LootBoxModel.dialogService;
      });
      osgi.injectService(PassToShopService,function(param1:Object):void {
        LootBoxModel.passToShop = PassToShopService(param1);
      },function():PassToShopService {
        return LootBoxModel.passToShop;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        LootBoxModel.paymentService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return LootBoxModel.paymentService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        WeeklyContainerModel.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return WeeklyContainerModel.dialogService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        DelayMountCategoryModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return DelayMountCategoryModel.battleInfoService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        DelayMountCategoryModel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return DelayMountCategoryModel.delayMountCategoryService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DelayMountCategoryModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DelayMountCategoryModel.lobbyLayoutService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        DelayMountCategoryModel.logService = LogService(param1);
      },function():LogService {
        return DelayMountCategoryModel.logService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ItemDevicesGarageModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ItemDevicesGarageModel.battleInfoService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        ItemDevicesGarageModel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return ItemDevicesGarageModel.delayMountCategoryService;
      });
      osgi.injectService(DeviceService,function(param1:Object):void {
        ItemDevicesGarageModel.deviceService = DeviceService(param1);
      },function():DeviceService {
        return ItemDevicesGarageModel.deviceService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ItemDevicesGarageModel.itemService = ItemService(param1);
      },function():ItemService {
        return ItemDevicesGarageModel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ItemDevicesGarageModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ItemDevicesGarageModel.lobbyLayoutService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DiscountForUpgradeModel.itemService = ItemService(param1);
      },function():ItemService {
        return DiscountForUpgradeModel.itemService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        DiscountModel.garageService = GarageService(param1);
      },function():GarageService {
        return DiscountModel.garageService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ProAbonementRankDiscountModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ProAbonementRankDiscountModel.userPropertiesService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        DronePanel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return DronePanel.battleInfoService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        DronePanel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return DronePanel.delayMountCategoryService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DronePanel.itemService = ItemService(param1);
      },function():ItemService {
        return DronePanel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DronePanel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DronePanel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DronePanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DronePanel.localeService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        DronePanel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return DronePanel.trackerService;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        DronePanel.userGarageActionsService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return DronePanel.userGarageActionsService;
      });
      osgi.injectService(BatteriesService,function(param1:Object):void {
        HasBatteriesNotifyModel.batteryService = BatteriesService(param1);
      },function():BatteriesService {
        return HasBatteriesNotifyModel.batteryService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DroppableGoldItemModel.itemService = ItemService(param1);
      },function():ItemService {
        return DroppableGoldItemModel.itemService;
      });
      osgi.injectService(PassToShopService,function(param1:Object):void {
        DroppableGoldItemModel.passToShop = PassToShopService(param1);
      },function():PassToShopService {
        return DroppableGoldItemModel.passToShop;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        DroppableGoldItemModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return DroppableGoldItemModel.paymentDisplayService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        DroppableGoldItemModel.userProperties = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return DroppableGoldItemModel.userProperties;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        ItemEnabledForPartnerModel.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return ItemEnabledForPartnerModel.partnerService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        GarageKitModel.itemService = ItemService(param1);
      },function():ItemService {
        return GarageKitModel.itemService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        GarageKitModel.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return GarageKitModel.userPropertyService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        ItemPropertiesModel.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return ItemPropertiesModel.propertyService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RenameForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RenameForm.localeService;
      });
      osgi.injectService(PasswordService,function(param1:Object):void {
        RenameForm.passwordService = PasswordService(param1);
      },function():PasswordService {
        return RenameForm.passwordService;
      });
      osgi.injectService(UidCheckService,function(param1:Object):void {
        RenameForm.uidCheckService = UidCheckService(param1);
      },function():UidCheckService {
        return RenameForm.uidCheckService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        RenameForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return RenameForm.validateService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        RenameModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return RenameModel.alertService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        RenameModel.garageService = GarageService(param1);
      },function():GarageService {
        return RenameModel.garageService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RenameModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RenameModel.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        RenameModel.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return RenameModel.partnerService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        RenameModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return RenameModel.storageService;
      });
      osgi.injectService(ResistanceService,function(param1:Object):void {
        MountedResistancesModel.resistanceService = ResistanceService(param1);
      },function():ResistanceService {
        return MountedResistancesModel.resistanceService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ResistanceModuleModel.itemService = ItemService(param1);
      },function():ItemService {
        return ResistanceModuleModel.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MountedResistancesPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MountedResistancesPanel.localeService;
      });
      osgi.injectService(ResistanceService,function(param1:Object):void {
        MountedResistancesPanel.resistanceService = ResistanceService(param1);
      },function():ResistanceService {
        return MountedResistancesPanel.resistanceService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ResistanceButton.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ResistanceButton.battleInfoService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        ResistanceButton.garageService = GarageService(param1);
      },function():GarageService {
        return ResistanceButton.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ResistanceButton.itemService = ItemService(param1);
      },function():ItemService {
        return ResistanceButton.itemService;
      });
      osgi.injectService(ResistanceService,function(param1:Object):void {
        ResistanceButton.resistanceService = ResistanceService(param1);
      },function():ResistanceService {
        return ResistanceButton.resistanceService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ResistancePanel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ResistancePanel.battleInfoService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        ResistancePanel.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return ResistancePanel.delayMountCategoryService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        ResistancePanel.garageService = GarageService(param1);
      },function():GarageService {
        return ResistancePanel.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ResistancePanel.itemService = ItemService(param1);
      },function():ItemService {
        return ResistancePanel.itemService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ResistancePanel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ResistancePanel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ResistancePanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ResistancePanel.localeService;
      });
      osgi.injectService(ResistanceService,function(param1:Object):void {
        ResistancePanel.resistancesService = ResistanceService(param1);
      },function():ResistanceService {
        return ResistancePanel.resistancesService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        ResistancePanel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return ResistancePanel.trackerService;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        ResistancePanel.userGarageActionsService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return ResistancePanel.userGarageActionsService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ResistancePanel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ResistancePanel.userPropertiesService;
      });
      osgi.injectService(ITemporaryItemNotifyService,function(param1:Object):void {
        TemporaryItemModel.temporaryItemNotifyService = ITemporaryItemNotifyService(param1);
      },function():ITemporaryItemNotifyService {
        return TemporaryItemModel.temporaryItemNotifyService;
      });
      osgi.injectService(ITemporaryItemService,function(param1:Object):void {
        TemporaryItemModel.temporaryItemService = ITemporaryItemService(param1);
      },function():ITemporaryItemService {
        return TemporaryItemModel.temporaryItemService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        UpgradableItemParams.itemService = ItemService(param1);
      },function():ItemService {
        return UpgradableItemParams.itemService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        UpgradableItemParams.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return UpgradableItemParams.propertyService;
      });
      osgi.injectService(UpgradingItemsService,function(param1:Object):void {
        UpgradableItemParams.upgradingItemService = UpgradingItemsService(param1);
      },function():UpgradingItemsService {
        return UpgradableItemParams.upgradingItemService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        UpgradableItemPropertyValue.propertyParamsService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return UpgradableItemPropertyValue.propertyParamsService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        UpgradeParamsModel.itemService = ItemService(param1);
      },function():ItemService {
        return UpgradeParamsModel.itemService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        CriticalChanceCalculator.propertyParamsService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return CriticalChanceCalculator.propertyParamsService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        Item3DModel.itemService = ItemService(param1);
      },function():ItemService {
        return Item3DModel.itemService;
      });
      osgi.injectService(ITank3DViewer,function(param1:Object):void {
        Item3DModel.tank3DViewer = ITank3DViewer(param1);
      },function():ITank3DViewer {
        return Item3DModel.tank3DViewer;
      });
      osgi.injectService(ResourceRegistry,function(param1:Object):void {
        Object3DSModel.resourceRegistry = ResourceRegistry(param1);
      },function():ResourceRegistry {
        return Object3DSModel.resourceRegistry;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DelayMountCategoryServiceImpl.itemService = ItemService(param1);
      },function():ItemService {
        return DelayMountCategoryServiceImpl.itemService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        DelayMountCategoryServiceImpl.logService = LogService(param1);
      },function():LogService {
        return DelayMountCategoryServiceImpl.logService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        DeviceServiceImpl.itemService = ItemService(param1);
      },function():ItemService {
        return DeviceServiceImpl.itemService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        ItemServiceImpl.clientLog = IClientLog(param1);
      },function():IClientLog {
        return ItemServiceImpl.clientLog;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        ItemServiceImpl.garageService = GarageService(param1);
      },function():GarageService {
        return ItemServiceImpl.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ItemServiceImpl.itemService = ItemService(param1);
      },function():ItemService {
        return ItemServiceImpl.itemService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ItemServiceImpl.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ItemServiceImpl.localeService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        ItemServiceImpl.propertyService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return ItemServiceImpl.propertyService;
      });
      osgi.injectService(ResistanceService,function(param1:Object):void {
        ItemServiceImpl.resistancesService = ResistanceService(param1);
      },function():ResistanceService {
        return ItemServiceImpl.resistancesService;
      });
      osgi.injectService(UpgradingItemsService,function(param1:Object):void {
        ItemServiceImpl.upgradingItemsService = UpgradingItemsService(param1);
      },function():UpgradingItemsService {
        return ItemServiceImpl.upgradingItemsService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ItemServiceImpl.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ItemServiceImpl.userPropertyService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ItemPropertyParamsServiceImpl.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ItemPropertyParamsServiceImpl.localeService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        ItemPropertyParamsServiceImpl.logger = IClientLog(param1);
      },function():IClientLog {
        return ItemPropertyParamsServiceImpl.logger;
      });
      osgi.injectService(TemperatureConfig,function(param1:Object):void {
        ItemPropertyParamsServiceImpl.temperatureConfig = TemperatureConfig(param1);
      },function():TemperatureConfig {
        return ItemPropertyParamsServiceImpl.temperatureConfig;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        InvertUpgradeAggregationMode.propertyParamsService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return InvertUpgradeAggregationMode.propertyParamsService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        RangeUpgradeAggregationMode.propertyParamsService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return RangeUpgradeAggregationMode.propertyParamsService;
      });
      osgi.injectService(ItemPropertyParamsService,function(param1:Object):void {
        SumUpgradeAggregationMode.propertyParamsService = ItemPropertyParamsService(param1);
      },function():ItemPropertyParamsService {
        return SumUpgradeAggregationMode.propertyParamsService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ResistanceServiceImpl.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ResistanceServiceImpl.battleInfoService;
      });
      osgi.injectService(IDelayMountCategoryService,function(param1:Object):void {
        ResistanceServiceImpl.delayMountCategoryService = IDelayMountCategoryService(param1);
      },function():IDelayMountCategoryService {
        return ResistanceServiceImpl.delayMountCategoryService;
      });
      osgi.injectService(GarageService,function(param1:Object):void {
        ResistanceServiceImpl.garageService = GarageService(param1);
      },function():GarageService {
        return ResistanceServiceImpl.garageService;
      });
      osgi.injectService(ItemService,function(param1:Object):void {
        ResistanceServiceImpl.itemService = ItemService(param1);
      },function():ItemService {
        return ResistanceServiceImpl.itemService;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        ResistanceServiceImpl.userGarageActionsService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return ResistanceServiceImpl.userGarageActionsService;
      });
      osgi.injectService(ITemporaryItemNotifyService,function(param1:Object):void {
        TemporaryItemService.temporaryItemNotifyService = ITemporaryItemNotifyService(param1);
      },function():ITemporaryItemNotifyService {
        return TemporaryItemService.temporaryItemNotifyService;
      });
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(Garage,GarageAdapt);
      modelRegisterAdapt.registerEvents(Garage,GarageEvents);
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new GarageModel());
      modelRegisterAdapt.registerAdapt(GaragePurchaseConfirmation,GaragePurchaseConfirmationAdapt);
      modelRegisterAdapt.registerEvents(GaragePurchaseConfirmation,GaragePurchaseConfirmationEvents);
      modelRegister.add(new PassToShopModel());
      modelRegisterAdapt.registerAdapt(PassToShopService,PassToShopServiceAdapt);
      modelRegisterAdapt.registerEvents(PassToShopService,PassToShopServiceEvents);
      modelRegister.add(new PremiumInDepotModel());
      modelRegisterAdapt.registerAdapt(PresentGiven,PresentGivenAdapt);
      modelRegisterAdapt.registerEvents(PresentGiven,PresentGivenEvents);
      modelRegister.add(new PresentGivenModel());
      modelRegister.add(new PresentProfileModel());
      modelRegisterAdapt.registerAdapt(PresentPurchase,PresentPurchaseAdapt);
      modelRegisterAdapt.registerEvents(PresentPurchase,PresentPurchaseEvents);
      modelRegister.add(new PresentPurchaseModel());
      modelRegister.add(new GaragePreviewModel());
      modelRegister.add(new TemperatureModel());
      modelRegisterAdapt.registerAdapt(FlushUpgrades,FlushUpgradesAdapt);
      modelRegisterAdapt.registerEvents(FlushUpgrades,FlushUpgradesEvents);
      modelRegisterAdapt.registerAdapt(UpgradeGarageItem,UpgradeGarageItemAdapt);
      modelRegisterAdapt.registerEvents(UpgradeGarageItem,UpgradeGarageItemEvents);
      modelRegister.add(new UpgradeGarageItemModel());
      modelRegisterAdapt.registerAdapt(AvailableDevices,AvailableDevicesAdapt);
      modelRegisterAdapt.registerEvents(AvailableDevices,AvailableDevicesEvents);
      modelRegister.add(new AvailableDevicesModel());
      modelRegister.add(new BuyableModel());
      modelRegisterAdapt.registerAdapt(IBuyable,IBuyableAdapt);
      modelRegisterAdapt.registerEvents(IBuyable,IBuyableEvents);
      modelRegisterAdapt.registerAdapt(IItemCategory,IItemCategoryAdapt);
      modelRegisterAdapt.registerEvents(IItemCategory,IItemCategoryEvents);
      modelRegisterAdapt.registerAdapt(IItemViewCategory,IItemViewCategoryAdapt);
      modelRegisterAdapt.registerEvents(IItemViewCategory,IItemViewCategoryEvents);
      modelRegister.add(new ItemCategoryModel());
      modelRegister.add(new ItemViewCategoryModel());
      modelRegister.add(new LootBoxModel());
      modelRegisterAdapt.registerAdapt(ContainerResource,ContainerResourceAdapt);
      modelRegisterAdapt.registerEvents(ContainerResource,ContainerResourceEvents);
      modelRegister.add(new ContainerResourceModel());
      modelRegister.add(new WeeklyContainerModel());
      modelRegister.add(new CountableItemModel());
      modelRegisterAdapt.registerAdapt(ICountableItem,ICountableItemAdapt);
      modelRegisterAdapt.registerEvents(ICountableItem,ICountableItemEvents);
      modelRegister.add(new DelayMountCategoryModel());
      modelRegisterAdapt.registerAdapt(ItemDevicesGarage,ItemDevicesGarageAdapt);
      modelRegisterAdapt.registerEvents(ItemDevicesGarage,ItemDevicesGarageEvents);
      modelRegister.add(new ItemDevicesGarageModel());
      modelRegister.add(new DiscountCollectorModel());
      modelRegisterAdapt.registerAdapt(DiscountEndTimer,DiscountEndTimerAdapt);
      modelRegisterAdapt.registerEvents(DiscountEndTimer,DiscountEndTimerEvents);
      modelRegister.add(new DiscountForUpgradeModel());
      modelRegister.add(new DiscountModel());
      modelRegisterAdapt.registerAdapt(ICollectDiscount,ICollectDiscountAdapt);
      modelRegisterAdapt.registerEvents(ICollectDiscount,ICollectDiscountEvents);
      modelRegisterAdapt.registerAdapt(IDiscount,IDiscountAdapt);
      modelRegisterAdapt.registerEvents(IDiscount,IDiscountEvents);
      modelRegisterAdapt.registerAdapt(ProAbonementRankDiscount,ProAbonementRankDiscountAdapt);
      modelRegisterAdapt.registerEvents(ProAbonementRankDiscount,ProAbonementRankDiscountEvents);
      modelRegister.add(new ProAbonementRankDiscountModel());
      modelRegister.add(new DroneModel());
      modelRegister.add(new HasBatteriesNotifyModel());
      modelRegister.add(new DroppableGoldItemModel());
      modelRegisterAdapt.registerAdapt(ItemFitting,ItemFittingAdapt);
      modelRegisterAdapt.registerEvents(ItemFitting,ItemFittingEvents);
      modelRegister.add(new ItemFittingModel());
      modelRegister.add(new GroupedItemModel());
      modelRegisterAdapt.registerAdapt(IGroupedItem,IGroupedItemAdapt);
      modelRegisterAdapt.registerEvents(IGroupedItem,IGroupedItemEvents);
      modelRegisterAdapt.registerAdapt(ItemActionPanel,ItemActionPanelAdapt);
      modelRegisterAdapt.registerEvents(ItemActionPanel,ItemActionPanelEvents);
      modelRegisterAdapt.registerAdapt(IItem,IItemAdapt);
      modelRegisterAdapt.registerEvents(IItem,IItemEvents);
      modelRegister.add(new ItemModel());
      modelRegisterAdapt.registerAdapt(ItemEnabledForPartner,ItemEnabledForPartnerAdapt);
      modelRegisterAdapt.registerEvents(ItemEnabledForPartner,ItemEnabledForPartnerEvents);
      modelRegister.add(new ItemEnabledForPartnerModel());
      modelRegister.add(new ItemPersonalDiscountModel());
      modelRegisterAdapt.registerAdapt(GarageKit,GarageKitAdapt);
      modelRegisterAdapt.registerEvents(GarageKit,GarageKitEvents);
      modelRegister.add(new GarageKitModel());
      modelRegisterAdapt.registerAdapt(IModification,IModificationAdapt);
      modelRegisterAdapt.registerEvents(IModification,IModificationEvents);
      modelRegister.add(new ModificationModel());
      modelRegisterAdapt.registerAdapt(PremiumItem,PremiumItemAdapt);
      modelRegisterAdapt.registerEvents(PremiumItem,PremiumItemEvents);
      modelRegister.add(new PremiumItemModel());
      modelRegisterAdapt.registerAdapt(PresentImage,PresentImageAdapt);
      modelRegisterAdapt.registerEvents(PresentImage,PresentImageEvents);
      modelRegister.add(new PresentItemModel());
      modelRegisterAdapt.registerAdapt(UserPresent,UserPresentAdapt);
      modelRegisterAdapt.registerEvents(UserPresent,UserPresentEvents);
      modelRegisterAdapt.registerAdapt(ItemProperties,ItemPropertiesAdapt);
      modelRegisterAdapt.registerEvents(ItemProperties,ItemPropertiesEvents);
      modelRegister.add(new ItemPropertiesModel());
      modelRegister.add(new ItemRarityModel());
      modelRegister.add(new RelativePropertiesModel());
      modelRegister.add(new RenameModel());
      modelRegisterAdapt.registerAdapt(MountedResistances,MountedResistancesAdapt);
      modelRegisterAdapt.registerEvents(MountedResistances,MountedResistancesEvents);
      modelRegister.add(new MountedResistancesModel());
      modelRegister.add(new ResistanceModuleModel());
      modelRegisterAdapt.registerAdapt(ShopAbonement,ShopAbonementAdapt);
      modelRegisterAdapt.registerEvents(ShopAbonement,ShopAbonementEvents);
      modelRegister.add(new ShopAbonementModel());
      modelRegisterAdapt.registerAdapt(AvailableShotSkins,AvailableShotSkinsAdapt);
      modelRegisterAdapt.registerEvents(AvailableShotSkins,AvailableShotSkinsEvents);
      modelRegister.add(new AvailableShotSkinsModel());
      modelRegisterAdapt.registerAdapt(AvailableSkins,AvailableSkinsAdapt);
      modelRegisterAdapt.registerEvents(AvailableSkins,AvailableSkinsEvents);
      modelRegister.add(new AvailableSkinsItemModel());
      modelRegisterAdapt.registerAdapt(MountShotSkin,MountShotSkinAdapt);
      modelRegisterAdapt.registerEvents(MountShotSkin,MountShotSkinEvents);
      modelRegister.add(new MountShotSkinModel());
      modelRegisterAdapt.registerAdapt(MountSkin,MountSkinAdapt);
      modelRegisterAdapt.registerEvents(MountSkin,MountSkinEvents);
      modelRegister.add(new MountSkinItemModel());
      modelRegisterAdapt.registerAdapt(ITemporaryItem,ITemporaryItemAdapt);
      modelRegisterAdapt.registerEvents(ITemporaryItem,ITemporaryItemEvents);
      modelRegister.add(new TemporaryItemModel());
      modelRegisterAdapt.registerAdapt(UpgradableItem,UpgradableItemAdapt);
      modelRegisterAdapt.registerEvents(UpgradableItem,UpgradableItemEvents);
      modelRegister.add(new UpgradeParamsModel());
      modelRegister.add(new VideoAdsItemUpgradeModel());
      modelRegister.add(new Item3DModel());
      modelRegister.add(new Object3DSModel());
      modelRegister.add(new MobileLootBoxDeliveryModel());
      modelRegister.add(new MobileLootBoxModel());
      modelRegister.add(new VideoAdsMobileLootBoxModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
