package alternativa.tanks.service.item {
  import alternativa.model.description.IDescription;
  import alternativa.model.timeperiod.TimePeriod;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.IGarageWindow;
  import alternativa.tanks.model.item.buyable.IBuyable;
  import alternativa.tanks.model.item.category.IItemCategory;
  import alternativa.tanks.model.item.category.IItemViewCategory;
  import alternativa.tanks.model.item.countable.ICountableItem;
  import alternativa.tanks.model.item.discount.DiscountEndTimer;
  import alternativa.tanks.model.item.discount.IDiscount;
  import alternativa.tanks.model.item.grouped.IGroupedItem;
  import alternativa.tanks.model.item.item.IItem;
  import alternativa.tanks.model.item.kit.GarageKit;
  import alternativa.tanks.model.item.modification.IModification;
  import alternativa.tanks.model.item.premium.PremiumItem;
  import alternativa.tanks.model.item.properties.ItemProperties;
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.resistance.ResistanceService;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import alternativa.types.Long;
  import controls.timer.CountDownTimer;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;

  public class ItemServiceImpl extends EventDispatcher implements ItemService {
    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var upgradingItemsService:UpgradingItemsService;

    [Inject]
    public static var garageService:GarageService;

    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var resistancesService:ResistanceService;

    private var mountedItems:Vector.<IGameObject> = new Vector.<IGameObject>();
    private var itemToModifications:Dictionary;
    private var hasItemMap:Dictionary;
    private var groupedItems:Dictionary = new Dictionary();
    private var isMountableCategoryMap:Dictionary;
    private var resistanceModuleDescription:Dictionary = new Dictionary();

    private const delayItemAppearingInSeconds:int = 5;

    public function ItemServiceImpl() {
      super();
      this.reset();
      this.resistanceModuleDescription[ItemGarageProperty.FIREBIRD_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_FIREBIRD;
      this.resistanceModuleDescription[ItemGarageProperty.FREEZE_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_FREEZE;
      this.resistanceModuleDescription[ItemGarageProperty.ISIS_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_ISIDA;
      this.resistanceModuleDescription[ItemGarageProperty.RAILGUN_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_RAILGUN;
      this.resistanceModuleDescription[ItemGarageProperty.RICOCHET_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_RICOCHET;
      this.resistanceModuleDescription[ItemGarageProperty.SHAFT_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_SHAFT;
      this.resistanceModuleDescription[ItemGarageProperty.SMOKY_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_SMOKY;
      this.resistanceModuleDescription[ItemGarageProperty.THUNDER_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_THUNDER;
      this.resistanceModuleDescription[ItemGarageProperty.TWINS_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_TWINS;
      this.resistanceModuleDescription[ItemGarageProperty.MINE_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_MINE;
      this.resistanceModuleDescription[ItemGarageProperty.SHOTGUN_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_SHOTGUN;
      this.resistanceModuleDescription[ItemGarageProperty.MACHINE_GUN_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_MACHINE_GUN;
      this.resistanceModuleDescription[ItemGarageProperty.ROCKET_LAUNCHER_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_ROCKET_LAUNCHER;
      this.resistanceModuleDescription[ItemGarageProperty.ARTILLERY_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_ARTILLERY;
      this.resistanceModuleDescription[ItemGarageProperty.GAUSS_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_GAUSS;
    }

    public function getPreviewResource(param1:IGameObject) : ImageResource {
      return IItem(param1.adapt(IItem)).getPreviewResource();
    }

    public function getCategory(param1:IGameObject) : ItemCategoryEnum {
      return IItemCategory(param1.adapt(IItemCategory)).getCategory();
    }

    public function getViewCategory(param1:IGameObject) : ItemViewCategoryEnum {
      return IItemViewCategory(param1.adapt(IItemViewCategory)).getViewCategory();
    }

    public function getName(param1:IGameObject) : String {
      var local2:String = IDescription(param1.adapt(IDescription)).getName();
      if(itemService.isModificationItem(param1)) {
        local2 += (localeService.language == LocaleServiceLangValues.CN ? "" : " ") + "M" + itemService.getModificationIndex(param1);
      }
      return local2;
    }

    public function getDescription(param1:IGameObject) : String {
      var local3:Vector.<ItemPropertyValue> = null;
      var local4:String = null;
      var local5:UpgradableItemPropertyValue = null;
      var local2:String = "";
      if(this.getCategory(param1) == ItemCategoryEnum.RESISTANCE_MODULE) {
        local3 = this.getProperties(param1);
        if(local3.length > 0) {
          local2 = localeService.getText(TanksLocale.TEXT_GARAGE_RESISTANCE_DESCRIPTION_PREFIX) + "\n";
          if(local3.length == 1 && local3[0].getProperty() == ItemGarageProperty.ALL_RESISTANCE) {
            for each(local4 in this.resistanceModuleDescription) {
              local2 += localeService.getText(local4) + "\n";
            }
          } else {
            for each(local5 in local3) {
              local2 += localeService.getText(this.resistanceModuleDescription[local5.getProperty()]) + "\n";
            }
          }
          local2 += "\n";
        }
      }
      return local2 + IDescription(param1.adapt(IDescription)).getDescription();
    }

    public function getModificationIndex(param1:IGameObject) : int {
      if(this.isModificationItem(param1)) {
        return IModification(param1.adapt(IModification)).getModificationIndex();
      }
      return -1;
    }

    public function getModifications(param1:IGameObject) : Vector.<IGameObject> {
      this.createItem2ModificationsIfNeed(param1.space.objects);
      return this.itemToModifications[param1];
    }

    private function createItem2ModificationsIfNeed(param1:Vector.<IGameObject>) : void {
      var items:Vector.<IGameObject> = null;
      var gameObject:IGameObject = null;
      var comparator:Function = null;
      var i:int = 0;
      var j:int = 0;
      var modifications:Vector.<IGameObject> = null;
      var item:IGameObject = null;
      var objects:Vector.<IGameObject> = param1;
      if(this.itemToModifications == null) {
        this.itemToModifications = new Dictionary();
        items = new Vector.<IGameObject>();
        for each(gameObject in objects) {
          if(gameObject.hasModel(IModification)) {
            items.push(gameObject);
          }
        }
        comparator = function(param1:IGameObject, param2:IGameObject):int {
          var local3:Long = IModification(param1.adapt(IModification)).getBaseItemId();
          var local4:Long = IModification(param2.adapt(IModification)).getBaseItemId();
          return Long.comparator(local3,local4);
        };
        items.sort(comparator);
        i = 0;
        while(i < items.length) {
          j = i + 1;
          while(j < items.length && comparator(items[i],items[j]) == 0) {
            j++;
          }
          modifications = new Vector.<IGameObject>(j - i);
          while(i < j) {
            item = items[i];
            modifications[IModification(item.adapt(IModification)).getModificationIndex()] = item;
            this.itemToModifications[item] = modifications;
            i++;
          }
        }
      }
    }

    public function getModificationsCount(param1:IGameObject) : int {
      return this.getModifications(param1).length;
    }

    public function getPrice(param1:IGameObject) : int {
      if(this.isKit(param1)) {
        return GarageKit(param1.adapt(GarageKit)).getPrice();
      }
      return IBuyable(param1.adapt(IBuyable)).getPrice();
    }

    public function getDiscount(param1:IGameObject) : int {
      return IDiscount(param1.adapt(IDiscount)).getDiscountInPercent();
    }

    public function getEndDiscountTimer(param1:IGameObject) : CountDownTimer {
      if(!param1.hasModel(DiscountEndTimer)) {
        return null;
      }
      return DiscountEndTimer(param1.adapt(DiscountEndTimer)).getEndDiscountTimer();
    }

    public function getPriceWithoutDiscount(param1:IGameObject) : int {
      return IBuyable(param1.adapt(IBuyable)).getPriceWithoutDiscount();
    }

    public function isBuyable(param1:IGameObject) : Boolean {
      return Boolean(IBuyable(param1.adapt(IBuyable)).isBuyable()) && this.isEnabledItem(param1);
    }

    public function getProperties(param1:IGameObject) : Vector.<ItemPropertyValue> {
      if(param1.hasModel(ItemProperties)) {
        return ItemProperties(param1.adapt(ItemProperties)).getProperties();
      }
      return null;
    }

    public function getPropertiesForInfoWindow(param1:IGameObject) : Vector.<ItemPropertyValue> {
      if(param1.hasModel(ItemProperties)) {
        return ItemProperties(param1.adapt(ItemProperties)).getPropertiesForInfoWindow();
      }
      return null;
    }

    public function getUpgradableItemParams(param1:IGameObject) : UpgradableItemParams {
      return UpgradableItem(param1.adapt(UpgradableItem)).getUpgradableItem();
    }

    public function getCurrentValue(param1:IGameObject, param2:ItemPropertyValue) : String {
      var local3:int = 0;
      if(this.isUpgradableItem(param1)) {
        local3 = this.getUpgradableItemParams(param1).getLevel();
        return param2.getValue(local3);
      }
      return param2.getValue();
    }

    public function isUpgradableItem(param1:IGameObject) : Boolean {
      return param1.hasModel(UpgradableItem);
    }

    public function getMinRankIndex(param1:IGameObject) : int {
      return IItem(param1.adapt(IItem)).getMinRank();
    }

    public function getMaxRankIndex(param1:IGameObject) : int {
      return IItem(param1.adapt(IItem)).getMaxRank();
    }

    public function getPosition(param1:IGameObject) : int {
      return IItem(param1.adapt(IItem)).getPosition();
    }

    public function getNextModification(param1:IGameObject) : IGameObject {
      var local2:int = this.getModificationIndex(param1);
      var local3:Vector.<IGameObject> = this.getModifications(param1);
      if(local2 < local3.length - 1) {
        return local3[local2 + 1];
      }
      return null;
    }

    public function hasNextModification(param1:IGameObject) : Boolean {
      if(!itemService.isModificationItem(param1)) {
        return false;
      }
      var local2:Vector.<IGameObject> = this.getModifications(param1);
      return param1 != local2[local2.length - 1];
    }

    public function getMaxUserModificationItem(param1:IGameObject) : IGameObject {
      var local4:IGameObject = null;
      var local2:Vector.<IGameObject> = this.getModifications(param1);
      var local3:int = local2.length - 1;
      while(local3 >= 0) {
        local4 = local2[local3];
        if(this.hasItem(local4)) {
          return local4;
        }
        local3--;
      }
      return null;
    }

    public function getPreviousModification(param1:IGameObject) : IGameObject {
      var local2:int = this.getModificationIndex(param1);
      var local3:Vector.<IGameObject> = this.getModifications(param1);
      if(local2 > 0) {
        return local3[local2 - 1];
      }
      return null;
    }

    public function getCount(param1:IGameObject) : int {
      if(param1.hasModel(ICountableItem)) {
        return ICountableItem(param1.adapt(ICountableItem)).getCount();
      }
      return 0;
    }

    public function setCount(param1:IGameObject, param2:int) : void {
      if(param1.hasModel(ICountableItem)) {
        ICountableItem(param1.adapt(ICountableItem)).setCount(param2);
      }
    }

    public function isCountable(param1:IGameObject) : Boolean {
      return param1.hasModel(ICountableItem);
    }

    public function isModificationItem(param1:IGameObject) : Boolean {
      return Boolean(param1.hasModel(IModification)) && this.getModificationsCount(param1) > 1;
    }

    public function isKit(param1:IGameObject) : Boolean {
      return param1.hasModel(GarageKit);
    }

    public function isGrouped(param1:IGameObject) : Boolean {
      return Boolean(param1.hasModel(IGroupedItem)) && Boolean(IGroupedItem(param1.adapt(IGroupedItem)).isGrouped());
    }

    public function getGroup(param1:IGameObject) : int {
      return IGroupedItem(param1.adapt(IGroupedItem)).getGroup();
    }

    public function hasItem(param1:IGameObject) : Boolean {
      return param1 in this.hasItemMap;
    }

    public function reset() : void {
      this.itemToModifications = null;
      this.hasItemMap = new Dictionary();
      this.groupedItems = new Dictionary();
      this.isMountableCategoryMap = new Dictionary();
      this.mountedItems.length = 0;
    }

    public function addItem(param1:IGameObject) : void {
      if(param1 in this.hasItemMap) {
        return;
      }
      this.hasItemMap[param1] = true;
      if(this.isGrouped(param1)) {
        this.groupedItems[this.getGroup(param1)] = true;
      }
      dispatchEvent(new ItemEvents(ItemEvents.OnItemAdded,param1));
    }

    public function removeItem(param1:IGameObject) : void {
      if(this.hasItem(param1)) {
        delete this.hasItemMap[param1];
      }
    }

    public function canBuy(param1:IGameObject) : Boolean {
      if(!this.isBuyable(param1) || userPropertyService.rank > this.getMaxRankIndex(param1)) {
        return false;
      }
      if(this.isGrouped(param1)) {
        return !(this.getGroup(param1) in this.groupedItems);
      }
      if(this.isKit(param1)) {
        return GarageKit(param1.adapt(GarageKit)).canBuy();
      }
      return this.isCountable(param1) || !this.hasItem(param1);
    }

    public function addMountableCategories(param1:Vector.<ItemCategoryEnum>) : void {
      var local2:* = 0;
      while(local2 < param1.length) {
        this.isMountableCategoryMap[param1[local2]] = true;
        local2++;
      }
    }

    public function isMountable(param1:IGameObject) : Boolean {
      return this.isMountableCategoryMap[this.getCategory(param1)] == true;
    }

    public function isUpgrading(param1:IGameObject) : Boolean {
      return Boolean(param1.hasModel(UpgradableItem)) && Boolean(this.upgradableItem(param1).isUpgrading());
    }

    public function getGarageItemInfo(param1:IGameObject) : GarageItemInfo {
      var local2:GarageItemInfo = new GarageItemInfo();
      local2.category = this.getCategory(param1);
      local2.item = param1;
      local2.modificationIndex = this.getModificationIndex(param1);
      local2.mounted = this.isMounted(param1);
      local2.name = this.getName(param1);
      local2.position = this.getPosition(param1);
      local2.premiumItem = this.isPremiumItem(param1);
      local2.preview = this.getPreviewResource(param1);
      return local2;
    }

    public function mountItem(param1:IGameObject) : void {
      var local2:IGameObject = this.getMountedItemByCategory(this.getCategory(param1));
      if(local2 == param1) {
        return;
      }
      var local3:IGarageWindow = garageService.getView();
      if(local2 != null) {
        upgradingItemsService.onMount(local2,param1);
        this.unmountItem(local2);
      }
      local3.mountItem(param1);
      this.mountedItems.push(param1);
      if(local3.getSelectedItem() == param1) {
        local3.getItemInfoPanel().onMountItem();
      }
    }

    public function unmountItem(param1:IGameObject) : * {
      garageService.getView().unmountItem(param1);
      this.mountedItems.splice(this.mountedItems.indexOf(param1),1);
    }

    public function isMounted(param1:IGameObject) : Boolean {
      if(this.getCategory(param1) == ItemCategoryEnum.RESISTANCE_MODULE) {
        return resistancesService.isMounted(param1);
      }
      return this.getMountedItemByCategory(this.getCategory(param1)) == param1;
    }

    public function getMountedItemByCategory(param1:ItemCategoryEnum) : IGameObject {
      var local3:IGameObject = null;
      var local2:int = 0;
      while(local2 < this.mountedItems.length) {
        local3 = this.mountedItems[local2];
        if(this.getCategory(local3) == param1) {
          return local3;
        }
        local2++;
      }
      return null;
    }

    private function upgradableItem(param1:IGameObject) : UpgradableItem {
      return UpgradableItem(param1.adapt(UpgradableItem));
    }

    public function isFullUpgraded(param1:IGameObject) : Boolean {
      return this.getUpgradableItemParams(param1).isFullUpgraded();
    }

    public function getTimeLeftInSeconds(param1:IGameObject) : int {
      var local2:int = int(TimePeriod(param1.adapt(TimePeriod)).getTimeLeftInSeconds());
      return local2 > this.delayItemAppearingInSeconds ? local2 - this.delayItemAppearingInSeconds : 0;
    }

    public function isTimelessItem(param1:IGameObject) : Boolean {
      return TimePeriod(param1.adapt(TimePeriod)).isTimeless();
    }

    public function getTimeToStartInSeconds(param1:IGameObject) : int {
      var local2:int = int(TimePeriod(param1.adapt(TimePeriod)).getTimeToStartInSeconds());
      return local2 > 0 ? local2 + this.delayItemAppearingInSeconds : 0;
    }

    private function isItemAlreadyAppear(param1:IGameObject) : Boolean {
      var local2:int = int(TimePeriod(param1.adapt(TimePeriod)).getModelLoadingTimeInMillis());
      return getTimer() > local2 + this.getTimeToStartInSeconds(param1) * 1000;
    }

    private function isItemAppearInDelayPeriod(param1:IGameObject) : Boolean {
      var local2:int = int(TimePeriod(param1.adapt(TimePeriod)).getTimeLeftInSeconds());
      return local2 > 0 && local2 <= this.delayItemAppearingInSeconds;
    }

    public function isEnabledItem(param1:IGameObject) : Boolean {
      var local2:Boolean = Boolean(TimePeriod(param1.adapt(TimePeriod)).isEnabled());
      return local2 && !this.isItemAppearInDelayPeriod(param1) || this.getTimeToStartInSeconds(param1) > 0 && this.isItemAlreadyAppear(param1);
    }

    public function getMaxAvailableOrNextNotAvailableModification(param1:IGameObject) : IGameObject {
      var local2:IGameObject = this.getMaxAvailableModification(param1);
      if(local2 == param1) {
        local2 = this.getNextModification(param1);
      }
      return local2;
    }

    public function getMaxAvailableModification(param1:IGameObject) : IGameObject {
      var local2:IGameObject = null;
      var local6:IGameObject = null;
      if(userPropertyService.rank < this.getMinRankIndex(param1)) {
        return param1;
      }
      var local3:Vector.<IGameObject> = this.getModifications(param1);
      var local4:int = int(local3.length);
      var local5:int = local4 - 1;
      while(local5 >= 0) {
        local6 = local3[local5];
        if(userPropertyService.rank >= this.getMinRankIndex(local6)) {
          local2 = local6;
          break;
        }
        local5--;
      }
      return local2;
    }

    public function isPremiumItem(param1:IGameObject) : Boolean {
      return PremiumItem(param1.adapt(PremiumItem)).isPremiumItem();
    }

    public function isPresent(param1:IGameObject) : Boolean {
      return this.getCategory(param1) == ItemCategoryEnum.PRESENT;
    }

    public function isGivenPresent(param1:IGameObject) : Boolean {
      return this.getCategory(param1) == ItemCategoryEnum.GIVEN_PRESENT;
    }

    public function getUserItemByClass(param1:IGameClass) : IGameObject {
      var local2:Object = null;
      var local3:IGameObject = null;
      for(local2 in this.hasItemMap) {
        local3 = IGameObject(local2);
        if(this.isModificationItem(local3) && this.getBaseClass(local3) == param1) {
          return this.getMaxUserModificationItem(local3);
        }
      }
      return null;
    }

    private function getBaseClass(param1:IGameObject) : IGameClass {
      var userObject:IGameObject = param1;
      try {
        return this.getModifications(userObject)[0].gameClass;
      }
      catch(e:Error) {
        throw new Error("id=" + userObject.id + ", message" + e.message,e.errorID);
      }
    }

    public function getMountedItemsByCategory(param1:ItemCategoryEnum) : Vector.<IGameObject> {
      var local3:* = undefined;
      var local2:* = new Vector.<IGameObject>();
      for each(local3 in this.mountedItems) {
        if(this.getCategory(local3) == param1) {
          local2.push(local3);
        }
      }
      return local2;
    }
  }
}
