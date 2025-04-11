package alternativa.tanks.models.service {
  import flash.events.Event;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class ClanServiceUpdateEvent extends Event {
    public static const UPDATE:String = "CreateClanServiceEvent.UPDATE";

    public var description:String;
    public var flag:ClanFlag;
    public var rankIndex:int;
    public var incomingRequestsEnabled:Boolean;

    public function ClanServiceUpdateEvent(param1:String, param2:String, param3:int, param4:ClanFlag, param5:Boolean, param6:Boolean = false, param7:Boolean = false) {
      this.description = param2;
      this.flag = param4;
      this.rankIndex = param3;
      this.incomingRequestsEnabled = param5;
      super(param1,param6,param7);
    }
  }
}
