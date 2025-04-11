package alternativa.tanks.models.service {
  import flash.events.Event;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class ClanInfoUpdateEvent extends Event {
    public static const UPDATE:String = "ClanInfoUpdateEvent.UPDATE";

    public var clanName:String = "";
    public var clanTag:String = "";
    public var clanDescription:String = "";
    public var clanFlag:ClanFlag;
    public var clanRequestsEnabled:Boolean = true;
    public var clanMinRank:int = 0;

    public function ClanInfoUpdateEvent() {
      super(UPDATE,true,false);
    }
  }
}
