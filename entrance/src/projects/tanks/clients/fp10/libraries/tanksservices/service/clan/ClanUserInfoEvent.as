package projects.tanks.clients.fp10.libraries.tanksservices.service.clan {
  import flash.events.Event;

  public class ClanUserInfoEvent extends Event {
    public static const UPDATE_GIVE_BONUSES_CLAN:String = "ClanUserInfoEvent.UPDATE_GIVE_BONUSES_CLAN";
    public static const ON_JOIN_CLAN:String = "ClanUserInfoEvent.ON_JOIN_CLAN";
    public static const ON_LEAVE_CLAN:String = "ClanUserInfoEvent.ON_LEAVE_CLAN";

    public function ClanUserInfoEvent(param1:String) {
      super(param1,true);
    }
  }
}
