package alternativa.tanks.gui.garagelist {
  import alternativa.tanks.gui.TimerKitCouldBeBoughtContext;
  import alternativa.tanks.gui.category.CategoryButtonsList;
  import alternativa.tanks.gui.category.CategoryButtonsListEvent;
  import alternativa.tanks.model.item.itemforpartners.ItemEnabledForPartner;
  import alternativa.tanks.model.item.kit.GarageKit;
  import alternativa.tanks.model.item.present.UserPresent;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
  import alternativa.tanks.service.notificationcategories.NotificationGarageCategoriesEvent;
  import alternativa.tanks.types.MultiGameObjectDictionary;
  import controls.timer.CountDownTimer;
  import flash.events.Event;
  import flash.utils.clearTimeout;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.garage.models.item.container.lootbox.ILootBoxModelBase;
  import projects.tanks.client.garage.models.item.kit.KitItem;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class GarageListController {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var premiumService:PremiumService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var notificationGarageCategoriesService:INotificationGarageCategoriesService;

    [Inject]
    public static var garageService:GarageService;

    private static const DEFAULT_CATEGORY_TO_SHOW:ItemViewCategoryEnum = ItemViewCategoryEnum.WEAPON;
    private static const LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY:String = "LAST_SHOWED_GARAGE_CATEGORY";
    private static const UPDATE_VISIBILITY_DISCOUNT_INDICATORS_DELAY:int = 1000;

    private var _garageList:GarageList;
    private var _categoryButtons:CategoryButtonsList;
    private var _itemsInDepot:Vector.<IGameObject>;
    private var _itemsInStore:Vector.<IGameObject>;
    private var _itemsInStoreFromServer:Vector.<IGameObject>;
    private var _currentShowingCategory:ItemViewCategoryEnum;
    private var _kitsByItem:MultiGameObjectDictionary;
    private var _updateVisibilityDiscountIndicatorsTimeoutId:uint;

    public function GarageListController(param1:GarageList, param2:CategoryButtonsList) {
      super();
      this._garageList = param1;
      this._categoryButtons = param2;
      this.init();
    }

    private function init() : void {
      this._itemsInDepot = new Vector.<IGameObject>();
      this._itemsInStore = new Vector.<IGameObject>();
      userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onRankChange);
      notificationGarageCategoriesService.addEventListener(NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE,this.onChangeNotificationGarageCategory);
      this._categoryButtons.addEventListener(CategoryButtonsListEvent.CATEGORY_SELECTED,this.onCategoryButtonsSelected);
      premiumService.addEventListener(Event.CHANGE,this.onSelfPremiumChanged);
      this.updateVisibilityNotificationIconOnCategories();
    }

    private function onRankChange(param1:UserPropertiesServiceEvent) : void {
      this.updateStore();
      this.showCategory(this._currentShowingCategory);
    }

    private function onCategoryButtonsSelected(param1:CategoryButtonsListEvent) : void {
      if(this._currentShowingCategory != param1.getCategory()) {
        this.showCategory(param1.getCategory());
      }
    }

    private function onSelfPremiumChanged(param1:Event) : void {
      var local3:IGameObject = null;
      var local2:int = this._garageList.itemsCount() - 1;
      while(local2 >= 0) {
        local3 = this._garageList.getItemAt(local2);
        if(Boolean(itemService.isPremiumItem(local3)) && this.isItemInStore(local3)) {
          this._garageList.updateShowLockPremium(local3,!premiumService.hasPremium());
        }
        local2--;
      }
      this._garageList.sort();
      this.selectAndScrollToItemInCategory(this._garageList.selectedItem);
    }

    private function onChangeNotificationGarageCategory(param1:NotificationGarageCategoriesEvent) : void {
      this.updateVisibilityNotificationIconOnCategories();
    }

    private function updateVisibilityNotificationIconOnCategories() : void {
      var local4:ItemViewCategoryEnum = null;
      var local1:Vector.<ItemViewCategoryEnum> = ItemViewCategoryEnum.values;
      var local2:int = int(local1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = local1[local3];
        if(notificationGarageCategoriesService.isNeedShowNewItemNotification(local4)) {
          if(this._currentShowingCategory == local4) {
            notificationGarageCategoriesService.categoryShowed(local4);
          } else {
            this._categoryButtons.hideDiscountIndicator(local4);
            this._categoryButtons.showNewItemIndicator(local4);
          }
        }
        local3++;
      }
    }

    public function initDepot(param1:Vector.<IGameObject>) : void {
      var local2:IGameObject = null;
      for each(local2 in param1) {
        itemService.addItem(local2);
      }
      for each(local2 in param1) {
        if(!this.needExcludeFromDepot(local2)) {
          this._itemsInDepot.push(local2);
        }
      }
    }

    private function needExcludeFromDepot(param1:IGameObject) : Boolean {
      var local2:ItemCategoryEnum = itemService.getCategory(param1);
      if(local2 == ItemCategoryEnum.INVENTORY || local2 == ItemCategoryEnum.CONTAINER) {
        return true;
      }
      var local3:ItemViewCategoryEnum = itemService.getViewCategory(param1);
      if(local3 == ItemViewCategoryEnum.INVISIBLE) {
        return true;
      }
      if(Boolean(itemService.isModificationItem(param1)) && param1 != itemService.getMaxUserModificationItem(param1)) {
        return true;
      }
      return false;
    }

    public function initStore(param1:Vector.<IGameObject>) : void {
      this._itemsInStoreFromServer = param1;
      this.updateStore();
    }

    private function updateStore() : void {
      this._itemsInStore = new Vector.<IGameObject>();
      this.addBuyableItemToStore();
      this.excludeNotBuyableModificationItemFromStore();
      this.updateKitsFromStore();
    }

    private function updateKitsFromStore() : void {
      var local3:IGameObject = null;
      var local4:Vector.<KitItem> = null;
      var local5:KitItem = null;
      this._kitsByItem = new MultiGameObjectDictionary();
      var local1:int = int(this._itemsInStore.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this._itemsInStore[local2];
        if(itemService.isKit(local3)) {
          local4 = GarageKit(local3.adapt(GarageKit)).getItems();
          for each(local5 in local4) {
            this._kitsByItem.put(local5.item,local3);
          }
        }
        local2++;
      }
    }

    public function updateKitsContainsItem(param1:IGameObject) : void {
      var local4:IGameObject = null;
      if(this._kitsByItem == null) {
        return;
      }
      var local2:Vector.<IGameObject> = this._kitsByItem.getValues(param1);
      var local3:int = local2.length - 1;
      while(local3 >= 0) {
        local4 = local2[local3];
        if(!itemService.canBuy(local4)) {
          this.removeSingleItemFromStore(local4);
        } else {
          this._garageList.updateCost(local4,itemService.getPrice(local4));
        }
        local3--;
      }
    }

    private function addBuyableItemToStore() : void {
      var local3:IGameObject = null;
      var local1:int = int(this._itemsInStoreFromServer.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this._itemsInStoreFromServer[local2];
        if(Boolean(itemService.canBuy(local3)) && this.availableInPartner(local3)) {
          this._itemsInStore.push(local3);
        }
        local2++;
      }
    }

    private function availableInPartner(param1:IGameObject) : Boolean {
      if(!param1.hasModel(ItemEnabledForPartner)) {
        return true;
      }
      return ItemEnabledForPartner(param1.adapt(ItemEnabledForPartner)).isAvailable();
    }

    private function excludeNotBuyableModificationItemFromStore() : void {
      var local4:IGameObject = null;
      var local5:IGameObject = null;
      var local6:IGameObject = null;
      var local1:Vector.<IGameObject> = new Vector.<IGameObject>();
      var local2:int = int(this._itemsInStore.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this._itemsInStore[local3];
        if(itemService.isModificationItem(local4)) {
          if(itemService.isPremiumItem(local4)) {
            local1.push(local4);
          } else {
            local5 = itemService.getMaxUserModificationItem(local4);
            if(local5 == null && itemService.getModificationIndex(local4) == 0) {
              local6 = itemService.getMaxAvailableModification(local4);
              if(local6 == null) {
                local1.push(local4);
              } else {
                local1.push(local6);
              }
            }
          }
        } else {
          local1.push(local4);
        }
        local3++;
      }
      this._itemsInStore = local1;
    }

    public function showCategory(param1:ItemViewCategoryEnum, param2:IGameObject = null) : void {
      var local7:ItemViewCategoryEnum = null;
      var local8:IGameObject = null;
      var local9:IGameObject = null;
      var local10:int = 0;
      if(!this._categoryButtons.getCategoryButtonVisibility(param1)) {
        local7 = this._categoryButtons.findVisibleCategory();
        this.showCategory(local7);
        return;
      }
      this._currentShowingCategory = param1;
      this._categoryButtons.select(param1);
      var local3:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInDepot,param1);
      var local4:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInStore,param1);
      this._garageList.clearList();
      var local5:int = int(local3.length);
      var local6:int = 0;
      while(local6 < local5) {
        this._garageList.addItem(this.createData(local3[local6],true));
        local6++;
      }
      local5 = int(local4.length);
      local6 = 0;
      while(local6 < local5) {
        this._garageList.addItem(this.createData(local4[local6],false));
        local6++;
      }
      this._garageList.sort();
      storageService.getStorage().data[LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY] = param1.value;
      if(this._garageList.itemsCount() > 0) {
        local8 = this._garageList.getItemAt(0);
        if(param2 == null) {
          local9 = this.getMountedItemInCategory(local3);
          if(local9 == null) {
            this.selectAndScrollToItemInCategory(local8);
          } else {
            this._garageList.scrollTo(local8);
            this._garageList.select(local9);
          }
        } else {
          local10 = this._garageList.indexById(param2);
          if(local10 == -1) {
            this.selectAndScrollToItemInCategory(local8);
          } else {
            this.selectAndScrollToItemInCategory(param2);
          }
        }
      }
      this.resetNotificationCategory(param1);
      this.updateVisibilityDiscountIndicators();
    }

    private function getMountedItemInCategory(param1:Vector.<IGameObject>) : IGameObject {
      var local2:IGameObject = null;
      var local5:IGameObject = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        if(itemService.isMounted(local5)) {
          local2 = local5;
          break;
        }
        local4++;
      }
      return local2;
    }

    private function resetNotificationCategory(param1:ItemViewCategoryEnum) : void {
      this._categoryButtons.hideNewItemIndicator(param1);
      notificationGarageCategoriesService.categoryShowed(param1);
    }

    private function selectAndScrollToItemInCategory(param1:IGameObject) : void {
      this._garageList.unselect();
      this._garageList.select(param1);
      this._garageList.scrollTo(param1);
    }

    private function createData(param1:IGameObject, param2:Boolean) : GarageListRendererData {
      var local3:GarageListRendererData = new GarageListRendererData();
      local3.id = param1;
      local3.name = itemService.getName(param1);
      local3.type = itemService.getCategory(param1);
      local3.mod = itemService.getModificationIndex(param1);
      local3.crystalPrice = itemService.getPrice(param1);
      if(param2) {
        local3.rank = -1;
        local3.showLockPremium = false;
        local3.discount = this.getDiscountForDepotItem(param1);
      } else {
        local3.rank = this.determineShowingRankIndex(param1);
        local3.showLockPremium = Boolean(itemService.isPremiumItem(param1)) && !premiumService.hasPremium();
        local3.discount = itemService.getDiscount(param1);
      }
      local3.installed = itemService.isMounted(param1);
      local3.garageElement = param2;
      local3.count = itemService.getCount(param1);
      local3.preview = itemService.getPreviewResource(param1);
      local3.sort = itemService.getPosition(param1);
      local3.timerDiscount = this.getEndDiscountTimer(param1,param2);
      if(itemService.isGivenPresent(param1)) {
        local3.appearanceTime = UserPresent(param1.adapt(UserPresent)).getDate().time;
      } else if(param1.hasModel(ILootBoxModelBase)) {
        local3.appearanceTime = 1;
      } else {
        local3.appearanceTime = 0;
      }
      return local3;
    }

    private function getDiscountForDepotItem(param1:IGameObject) : int {
      var local3:IGameObject = null;
      var local2:int = 0;
      if(itemService.isCountable(param1)) {
        local2 = int(itemService.getDiscount(param1));
      } else if(Boolean(itemService.isModificationItem(param1)) && Boolean(itemService.hasNextModification(param1))) {
        local3 = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
        local2 = int(itemService.getDiscount(local3));
      }
      return local2;
    }

    private function determineShowingRankIndex(param1:IGameObject) : int {
      var local2:int = int(itemService.getMinRankIndex(param1));
      var local3:int = int(itemService.getMaxRankIndex(param1));
      var local4:int = int(userPropertiesService.rank);
      if(local4 < local2) {
        return local2;
      }
      if(local4 > local3) {
        return local3;
      }
      return 0;
    }

    private function getEndDiscountTimer(param1:IGameObject, param2:Boolean) : CountDownTimer {
      if(itemService.isKit(param1)) {
        return this.getEndDiscountTimerForKit(param1);
      }
      var local3:IGameObject = param1;
      if(Boolean(itemService.isModificationItem(param1)) && param2) {
        if(!itemService.hasNextModification(param1)) {
          return null;
        }
        local3 = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
      }
      return itemService.getEndDiscountTimer(local3);
    }

    private function getEndDiscountTimerForKit(param1:IGameObject) : CountDownTimer {
      var local2:CountDownTimer = null;
      var local6:TimerKitCouldBeBoughtContext = null;
      var local3:Vector.<TimerKitCouldBeBoughtContext> = garageService.getView().getTimersKitCouldBeBoughtContext();
      var local4:int = int(local3.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = local3[local5];
        if(local6.item == param1) {
          local2 = local6.timer;
          break;
        }
        local5++;
      }
      return local2;
    }

    public function getItemsByCategory(param1:Vector.<IGameObject>, param2:ItemViewCategoryEnum) : Vector.<IGameObject> {
      var local6:IGameObject = null;
      var local3:Vector.<IGameObject> = new Vector.<IGameObject>();
      var local4:int = int(param1.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = param1[local5];
        if(itemService.getViewCategory(local6) == param2) {
          local3.push(local6);
        }
        local5++;
      }
      return local3;
    }

    public function destroy() : void {
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onRankChange);
      notificationGarageCategoriesService.removeEventListener(NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE,this.onChangeNotificationGarageCategory);
      this._categoryButtons.removeEventListener(CategoryButtonsListEvent.CATEGORY_SELECTED,this.onCategoryButtonsSelected);
      premiumService.removeEventListener(Event.CHANGE,this.onSelfPremiumChanged);
      clearTimeout(this._updateVisibilityDiscountIndicatorsTimeoutId);
      removeDisplayObject(this._garageList);
      removeDisplayObject(this._categoryButtons);
      this._garageList.destroy();
      this._categoryButtons.destroy();
      this._garageList = null;
      this._categoryButtons = null;
      this._itemsInDepot = null;
      this._itemsInStore = null;
    }

    public function isItemInDepot(param1:IGameObject) : Boolean {
      if(this._itemsInDepot == null) {
        return false;
      }
      return this._itemsInDepot.indexOf(param1) != -1;
    }

    public function isItemInStore(param1:IGameObject) : Boolean {
      if(this._itemsInStore == null) {
        return false;
      }
      return this._itemsInStore.indexOf(param1) != -1;
    }

    public function addItemToDepot(param1:IGameObject) : void {
      if(this.isItemInDepot(param1)) {
        return;
      }
      itemService.addItem(param1);
      if(!this.needExcludeFromDepot(param1)) {
        this._itemsInDepot.push(param1);
      }
      this.updateVisibilityDiscountIndicatorsWithDelay();
      if(this._currentShowingCategory == itemService.getViewCategory(param1)) {
        this._garageList.addItem(this.createData(param1,true));
        this._garageList.sort();
        this.selectAndScrollToItemInCategory(param1);
      }
    }

    public function removeItemFromDepot(param1:IGameObject) : void {
      var local2:int = int(this._itemsInDepot.indexOf(param1));
      if(local2 != -1) {
        itemService.removeItem(param1);
        this._itemsInDepot.splice(local2,1);
      }
      if(this._garageList.indexById(param1) != -1) {
        this._garageList.deleteItem(param1);
      }
      this.updateSelection();
    }

    public function addItemToStore(param1:IGameObject) : void {
      if(this.isItemInStore(param1) || !itemService.canBuy(param1)) {
        return;
      }
      this._itemsInStore.push(param1);
      if(this._currentShowingCategory == itemService.getViewCategory(param1)) {
        this._garageList.addItem(this.createData(param1,false));
        this._garageList.sort();
        this.selectAndScrollToItemInCategory(param1);
      }
    }

    public function removeSingleItemFromStore(param1:IGameObject) : void {
      var local3:Vector.<KitItem> = null;
      var local4:KitItem = null;
      var local2:int = int(this._itemsInStore.indexOf(param1));
      if(local2 != -1) {
        this._itemsInStore.splice(local2,1);
      }
      if(this._garageList.indexById(param1) != -1) {
        this._garageList.deleteItem(param1);
      }
      if(itemService.isKit(param1)) {
        local3 = GarageKit(param1.adapt(GarageKit)).getItems();
        for each(local4 in local3) {
          this._kitsByItem.remove(local4.item,param1);
        }
      }
    }

    public function removeItemFromStore(param1:IGameObject) : void {
      if(itemService.isGrouped(param1)) {
        this.removeGroupedItemsFromStore(param1);
      } else {
        this.removeSingleItemFromStore(param1);
      }
      this.updateSelection();
    }

    private function removeGroupedItemsFromStore(param1:IGameObject) : void {
      var local4:IGameObject = null;
      var local2:int = int(itemService.getGroup(param1));
      var local3:int = this._itemsInStore.length - 1;
      while(local3 >= 0) {
        local4 = this._itemsInStore[local3];
        if(Boolean(itemService.isGrouped(local4)) && itemService.getGroup(local4) == local2) {
          this.removeSingleItemFromStore(local4);
        }
        local3--;
      }
    }

    public function get itemsInDepot() : Vector.<IGameObject> {
      return this._itemsInDepot;
    }

    public function showDefaultCategory() : void {
      this.showCategory(this.getCategoryFromShared());
    }

    private function getCategoryFromShared() : ItemViewCategoryEnum {
      var local1:int = 0;
      if(storageService.getStorage().data.hasOwnProperty(LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY)) {
        local1 = int(storageService.getStorage().data[LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY]);
        if(local1 < 0 || local1 >= ItemViewCategoryEnum.values.length) {
          return DEFAULT_CATEGORY_TO_SHOW;
        }
        return ItemViewCategoryEnum.values[local1];
      }
      return DEFAULT_CATEGORY_TO_SHOW;
    }

    public function showItemInCategory(param1:IGameObject) : void {
      var local3:IGameObject = null;
      var local2:IGameObject = param1;
      if(itemService.isModificationItem(param1)) {
        local3 = itemService.getMaxUserModificationItem(param1);
        if(local3 != null) {
          local2 = local3;
        } else {
          local2 = itemService.getMaxAvailableModification(param1);
        }
      }
      this.showCategory(itemService.getViewCategory(local2),local2);
    }

    public function updateSelection() : void {
      if(this._garageList.selectedItem == null && this._garageList.itemsCount() > 0) {
        this.selectAndScrollToItemInCategory(this._garageList.getItemAt(0));
      }
    }

    public function updateDiscount(param1:IGameObject) : void {
      var local2:IGameObject = null;
      this.updateKitsContainsItem(param1);
      this.updateVisibilityDiscountIndicatorsWithDelay();
      if(this.isItemInStore(param1)) {
        this._garageList.updateDiscountAndCost(param1,itemService.getDiscount(param1),itemService.getEndDiscountTimer(param1),itemService.getPrice(param1));
        return;
      }
      if(itemService.isModificationItem(param1)) {
        local2 = itemService.getMaxUserModificationItem(param1);
        if(local2 != null && itemService.getMaxAvailableOrNextNotAvailableModification(local2) == param1) {
          this._garageList.updateDiscountWithTimer(local2,itemService.getDiscount(param1),itemService.getEndDiscountTimer(param1));
        }
        return;
      }
      if(itemService.isCountable(param1)) {
        this._garageList.updateDiscountAndCost(param1,itemService.getDiscount(param1),itemService.getEndDiscountTimer(param1),itemService.getPrice(param1));
      }
    }

    private function updateVisibilityDiscountIndicatorsWithDelay() : void {
      clearTimeout(this._updateVisibilityDiscountIndicatorsTimeoutId);
      this._updateVisibilityDiscountIndicatorsTimeoutId = setTimeout(this.updateVisibilityDiscountIndicators,UPDATE_VISIBILITY_DISCOUNT_INDICATORS_DELAY);
    }

    private function updateVisibilityDiscountIndicators() : void {
      var local4:ItemViewCategoryEnum = null;
      var local5:Boolean = false;
      var local1:Vector.<ItemViewCategoryEnum> = ItemViewCategoryEnum.values;
      var local2:int = int(local1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = local1[local3];
        if(local4 != ItemViewCategoryEnum.INVISIBLE) {
          local5 = false;
          if(local4 != ItemViewCategoryEnum.KIT && !notificationGarageCategoriesService.isNeedShowNewItemNotification(local4)) {
            if(this.hasAvailableTemporaryDiscounts(local4)) {
              local5 = true;
            }
          }
          if(local5) {
            this._categoryButtons.showDiscountIndicator(local4);
          } else {
            this._categoryButtons.hideDiscountIndicator(local4);
          }
        }
        local3++;
      }
    }

    private function hasAvailableTemporaryDiscounts(param1:ItemViewCategoryEnum) : Boolean {
      var local3:int = 0;
      var local4:int = 0;
      var local6:IGameObject = null;
      var local7:IGameObject = null;
      var local2:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInDepot,param1);
      local4 = int(local2.length);
      local3 = 0;
      while(local3 < local4) {
        local6 = local2[local3];
        if(this.isAvailableTemporaryDiscount(local6,true)) {
          return true;
        }
        local3++;
      }
      var local5:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInStore,param1);
      local4 = int(local5.length);
      local3 = 0;
      while(local3 < local4) {
        local7 = local5[local3];
        if(this.isAvailableTemporaryDiscount(local7,false)) {
          return true;
        }
        local3++;
      }
      return false;
    }

    private function isAvailableTemporaryDiscount(param1:IGameObject, param2:Boolean) : Boolean {
      var local3:Boolean = false;
      var local4:CountDownTimer = null;
      if(param2) {
        if(this.getDiscountForDepotItem(param1) > 0) {
          local4 = this.getEndDiscountTimer(param1,param2);
        }
      } else if(userPropertiesService.rank >= itemService.getMinRankIndex(param1)) {
        local4 = itemService.getEndDiscountTimer(param1);
      }
      if(local4 != null) {
        local3 = local4.getEndTime() > getTimer();
      }
      return local3;
    }

    public function getCurrentCategoryItemsCount() : int {
      return this._garageList.itemsCount();
    }
  }
}
