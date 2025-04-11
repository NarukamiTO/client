package alternativa.tanks.service.clan {
  import flash.events.Event;

  public class ClanPanelAvailabilityButtonEvent extends Event {
    public static const UPDATE_AVAILABILITY_CLAN_BUTTON:String = "ClanPanelNotificationEvent.UPDATE_AVAILABILITY_CLAN_BUTTON";

    private var _visibleClanButton:Boolean;

    public function ClanPanelAvailabilityButtonEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false) {
      this._visibleClanButton = param2;
      super(param1,param3,param4);
    }

    public function get visibleClanButton() : Boolean {
      return this._visibleClanButton;
    }

    public function set visibleClanButton(param1:Boolean) : void {
      this._visibleClanButton = param1;
    }
  }
}
