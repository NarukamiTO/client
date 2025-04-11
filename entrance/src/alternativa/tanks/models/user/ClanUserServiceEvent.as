package alternativa.tanks.models.user {
  import flash.events.Event;

  public class ClanUserServiceEvent extends Event {
    public static const HIDE_CLAN_WINDOW:String = "ClanUserServiceEvent.HIDE_CLAN_WINDOW";

    public function ClanUserServiceEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
