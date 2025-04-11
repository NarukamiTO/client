package projects.tanks.clients.fp10.libraries.tanksservices.service.clan {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.client.clans.notifier.ClanNotifierData;

  public class UserClanInfo {
    public var userId:Long;
    public var isInClan:Boolean;
    public var clanId:Long;
    public var clanName:String;
    public var clanTag:String;
    public var clanActions:Vector.<ClanAction>;
    public var clanUserIncoming:Vector.<Long>;
    public var clanUserOutgoing:Vector.<Long>;
    public var minRankForJoinClan:int;

    public function UserClanInfo(param1:ClanNotifierData) {
      super();
      this.userId = param1.userId;
      this.isInClan = param1.clanMember;
      this.clanId = param1.clanId;
      this.clanName = param1.clanName;
      this.clanTag = param1.clanTag;
      this.clanActions = param1.clanAction;
      this.clanUserIncoming = param1.clanIncoming;
      this.clanUserOutgoing = param1.clanOutgoing;
      this.minRankForJoinClan = param1.minRankForJoinClan;
    }
  }
}
