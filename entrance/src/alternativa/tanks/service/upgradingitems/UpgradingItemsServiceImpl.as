package alternativa.tanks.service.upgradingitems {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.alerts.UpgradedItemsAlert;
  import alternativa.tanks.model.garage.upgradingitems.UpgradingItem;
  import alternativa.types.Long;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteAfter;
  import flash.events.Event;
  import flash.utils.getTimer;
  import forms.events.PartsListEvent;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.clients.flash.commons.models.runtime.DataOwner;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class UpgradingItemsServiceImpl implements UpgradingItemsService, CountDownTimerOnCompleteAfter, OnConnectionClosedServiceListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var upgradingItems:Vector.<ItemInfo> = new Vector.<ItemInfo>();
    private var alert:UpgradedItemsAlert;
    private var callback:UpgradingItem;
    private var showUpgradeNotifications:Boolean = false;

    public function UpgradingItemsServiceImpl() {
      super();
    }

    public function init(param1:Vector.<GarageItemInfo>, param2:UpgradingItem) : void {
      var local5:CountDownTimer = null;
      this.callback = param2;
      var local3:int = getTimer();
      var local4:int = 0;
      while(local4 < param1.length) {
        local5 = new CountDownTimer();
        local5.start(local3 + param1[local4].remaingTimeInMS);
        this.add(param1[local4],local5);
        local4++;
      }
    }

    public function add(param1:GarageItemInfo, param2:CountDownTimer) : void {
      var local3:ItemInfo = new ItemInfo(param1,param2);
      this.addListener(param2);
      this.upgradingItems.push(local3);
      this.upgradingItems.sort(this.compare);
      if(this.upgradingItems.length == 1) {
        lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
        lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
        this.startShowUpgradeNotifications();
      }
    }

    public function remove(param1:IGameObject) : void {
      var local2:int = this.upgradingItemsIndexOf(param1);
      if(local2 != -1) {
        this.removeByIndex(local2);
      }
    }

    private function removeByIndex(param1:int) : void {
      this.removeListener(this.upgradingItems[param1].timer);
      this.upgradingItems.splice(param1,1);
    }

    private function checkItems() : void {
      var local2:ItemInfo = null;
      if(this.alert != null) {
        return;
      }
      var local1:Vector.<ItemInfo> = new Vector.<ItemInfo>();
      while(this.upgradingItems.length > 0 && this.upgradingItems[this.upgradingItems.length - 1].timer.getRemainingSeconds() <= 0) {
        local2 = this.upgradingItems.pop();
        this.removeListener(local2.timer);
        local1.push(local2);
      }
      this.showUpgradedItems(local1);
      if(this.upgradingItems.length == 0) {
        this.stopShowUpgradeNotifications();
      }
    }

    private function showUpgradedItems(param1:Vector.<ItemInfo>) : void {
      this.show(param1,TanksLocale.TEXT_HEADER_CONGRATULATION,localeService.getText(TanksLocale.TEXT_GARAGE_UPGRADE_COMPLETE_TEXT));
    }

    public function getCountDownTimer(param1:IGameObject) : CountDownTimer {
      var local2:int = this.upgradingItemsIndexOf(param1);
      if(local2 != -1) {
        return this.upgradingItems[local2].timer;
      }
      return null;
    }

    public function onMount(param1:IGameObject, param2:IGameObject) : void {
      var local3:int = this.upgradingItemsIndexOf(param1);
      var local4:int = this.upgradingItemsIndexOf(param2);
      if(local3 != -1) {
        this.upgradingItems[local3].info.mounted = false;
      }
      if(local4 != -1) {
        this.upgradingItems[local4].info.mounted = true;
      }
    }

    private function show(param1:Vector.<ItemInfo>, param2:String, param3:String) : void {
      if(param1.length > 0) {
        this.alert = new UpgradedItemsAlert(param1,param2,param3);
        this.alert.addEventListener(Event.CANCEL,this.onClose);
        this.alert.addEventListener(PartsListEvent.ITEM_CLICK,this.onItemSelect);
      }
    }

    private function onItemSelect(param1:PartsListEvent) : void {
      this.callback.select(this.alert.partsList.selectedItem);
      this.closeAlert();
    }

    private function onClose(param1:Event) : void {
      this.closeAlert();
    }

    private function closeAlert() : void {
      this.alert.removeEventListener(Event.CANCEL,this.onClose);
      this.alert.removeEventListener(PartsListEvent.ITEM_CLICK,this.onItemSelect);
      this.alert = null;
      this.checkItems();
    }

    private function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      this.stopShowUpgradeNotifications();
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state != LayoutState.BATTLE) {
        this.startShowUpgradeNotifications();
        this.checkItems();
      }
    }

    private function startShowUpgradeNotifications() : void {
      if(!this.showUpgradeNotifications) {
        if(lobbyLayoutService.getCurrentState() != LayoutState.BATTLE) {
          this.showUpgradeNotifications = true;
        }
      }
    }

    private function stopShowUpgradeNotifications() : void {
      if(this.showUpgradeNotifications) {
        this.showUpgradeNotifications = false;
        if(this.upgradingItems.length == 0) {
          lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
          lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
        }
      }
    }

    public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void {
      var local3:int = this.indexOfByTimer(param1);
      this.callback.itemUpgraded(this.upgradingItems[local3].info.item);
      if(this.showUpgradeNotifications) {
        if(param2) {
          this.removeByIndex(local3);
        } else {
          this.checkItems();
        }
      }
    }

    public function reset() : void {
      var local1:ItemInfo = null;
      for each(local1 in this.upgradingItems) {
        local1.timer.destroy();
      }
      this.upgradingItems.length = 0;
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      this.reset();
    }

    private function compare(param1:ItemInfo, param2:ItemInfo) : Number {
      return param2.timer.getEndTime() - param1.timer.getEndTime();
    }

    private function upgradingItemsIndexOf(param1:IGameObject) : int {
      var local4:ItemInfo = null;
      var local2:Long = DataOwner(param1.adapt(DataOwner)).getDataOwnerId();
      var local3:int = 0;
      while(local3 < this.upgradingItems.length) {
        local4 = this.upgradingItems[local3];
        if(this.equalsLong(local4.ownerId,local2)) {
          return local3;
        }
        local3++;
      }
      return -1;
    }

    private function indexOfByTimer(param1:CountDownTimer) : int {
      var local3:ItemInfo = null;
      var local2:int = 0;
      while(local2 < this.upgradingItems.length) {
        local3 = this.upgradingItems[local2];
        if(local3.timer == param1) {
          return local2;
        }
        local2++;
      }
      return -1;
    }

    private function addListener(param1:CountDownTimer) : void {
      param1.addListener(CountDownTimerOnCompleteAfter,this);
    }

    private function removeListener(param1:CountDownTimer) : void {
      param1.removeListener(CountDownTimerOnCompleteAfter,this);
    }

    public function informServerAboutUpgradedItem(param1:IGameObject) : void {
      this.callback.itemUpgraded(param1);
    }

    public function equalsLong(param1:Long, param2:Long) : Boolean {
      return param1.high == param2.high && param1.low == param2.low;
    }
  }
}
