package alternativa.tanks.model.personaldiscount {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.personaldiscount.PersonalDiscountAlert;
  import forms.events.PartsListEvent;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.client.panel.model.personaldiscount.IPersonalDiscountModelBase;
  import projects.tanks.client.panel.model.personaldiscount.PersonalDiscountModelBase;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class PersonalDiscountModel extends PersonalDiscountModelBase implements IPersonalDiscountModelBase {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private static const USER_NAME_PATTERN:String = "$USERNAME$";
    private static const ITEM_NAME_PATTERN:String = "$ITEM-NAME$";

    public static const DISCOUNT_TIMER_PATTERN:String = "$DISCOUNT_TIMER$";

    private static const DISCOUNT_PATTERN:String = "$DISCOUNT$";

    public function PersonalDiscountModel() {
      super();
    }

    public function showPersonalDiscount(param1:GarageItemInfo, param2:int, param3:int, param4:int) : void {
      var local5:String = localeService.getText(TanksLocale.TEXT_MESSAGE_ALERT_PERSONAL_DISCOUNT);
      var local6:String = local5.replace(USER_NAME_PATTERN,userPropertiesService.userName).replace(ITEM_NAME_PATTERN,param1.name).replace(DISCOUNT_PATTERN,param2);
      var local7:PersonalDiscountAlert = new PersonalDiscountAlert(param1,localeService.getText(TanksLocale.TEXT_HEADER_DISCOUNT),param2,param3,param4,local6);
      if(lobbyLayoutService.isSwitchInProgress()) {
        lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
      } else {
        local7.enqueueDialog();
      }
      local7.partsList.addEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,getFunctionWrapper(this.onItemSelect));
      putData(PersonalDiscountAlert,local7);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      var local2:PersonalDiscountAlert = PersonalDiscountAlert(getData(PersonalDiscountAlert));
      local2.enqueueDialog();
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
    }

    private function onItemSelect(param1:PartsListEvent) : void {
      var local2:PersonalDiscountAlert = PersonalDiscountAlert(getData(PersonalDiscountAlert));
      server.select(local2.partsList.selectedItem);
      local2.partsList.removeEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,getFunctionWrapper(this.onItemSelect));
      local2.close();
    }
  }
}
