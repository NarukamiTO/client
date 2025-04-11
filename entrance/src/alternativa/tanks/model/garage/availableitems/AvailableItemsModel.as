package alternativa.tanks.model.garage.availableitems {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.AvailableItemsAlert;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
  import flash.events.Event;
  import forms.events.PartsListEvent;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.client.panel.model.garage.availableitems.AvailableItemsModelBase;
  import projects.tanks.client.panel.model.garage.availableitems.IAvailableItemsModelBase;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class AvailableItemsModel extends AvailableItemsModelBase implements IAvailableItemsModelBase {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var notificationGarageCategoriesService:INotificationGarageCategoriesService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    public static const CHANNEL:String = "available";

    public function AvailableItemsModel() {
      super();
    }

    public function showAvailableItems(param1:Vector.<GarageItemInfo>) : void {
      if(lobbyLayoutService.getCurrentState() == LayoutState.GARAGE) {
        this.showAlert(param1);
      } else {
        clearData(Vector);
        putData(Vector,param1);
        if(lobbyLayoutService.inBattle()) {
          putData(Boolean,true);
        }
        lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
      }
      notificationGarageCategoriesService.notifyAboutAvailableItems(param1);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      var local2:Boolean = false;
      var local3:Vector.<GarageItemInfo> = null;
      if(param1.state == LayoutState.BATTLE) {
        putData(Boolean,true);
      } else {
        local2 = Boolean(getData(Boolean));
        if(local2) {
          clearData(Boolean);
          if(getData(Vector) != null) {
            local3 = Vector.<GarageItemInfo>(getData(Vector));
            this.showAlert(local3);
          }
        }
      }
    }

    private function showAlert(param1:Vector.<GarageItemInfo>) : void {
      var local2:AvailableItemsAlert = AvailableItemsAlert(getData(AvailableItemsAlert));
      if(local2 != null) {
        this.destroyAlert();
      }
      var local3:AvailableItemsAlert = new AvailableItemsAlert(param1,TanksLocale.TEXT_HEADER_CONGRATULATION,TanksLocale.TEXT_GARAGE_NEW_ITEMS_ALERT);
      local3.addEventListener(Event.CANCEL,getFunctionWrapper(this.onClickCloseButton));
      local3.addEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,getFunctionWrapper(this.onItemSelect));
      putData(AvailableItemsAlert,local3);
    }

    private function onItemSelect(param1:PartsListEvent) : void {
      var local2:AvailableItemsAlert = AvailableItemsAlert(getData(AvailableItemsAlert));
      modalLoaderService.show();
      server.select(local2.partsList.selectedItem);
      this.destroyAlert();
    }

    private function onClickCloseButton(param1:Event) : void {
      this.destroyAlert();
    }

    private function destroyAlert() : void {
      if(lobbyLayoutService.hasEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH)) {
        lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
      }
      var local1:AvailableItemsAlert = AvailableItemsAlert(getData(AvailableItemsAlert));
      local1.removeEventListener(Event.CANCEL,getFunctionWrapper(this.onClickCloseButton));
      local1.removeEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,getFunctionWrapper(this.onItemSelect));
      clearData(Vector);
      clearData(AvailableItemsAlert);
    }
  }
}
