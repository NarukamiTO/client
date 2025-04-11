package projects.tanks.client.clans.notifier {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.permissions.ClanAction;

  public class ClanNotifierData {
    private var _clanAction:Vector.<ClanAction>;
    private var _clanId:Long;
    private var _clanIncoming:Vector.<Long>;
    private var _clanMember:Boolean;
    private var _clanName:String;
    private var _clanOutgoing:Vector.<Long>;
    private var _clanTag:String;
    private var _incomingRequestEnabled:Boolean;
    private var _minRankForJoinClan:int;
    private var _restrictionTimeJoinClan:Long;
    private var _userId:Long;

    public function ClanNotifierData(param1:Vector.<ClanAction> = null, param2:Long = null, param3:Vector.<Long> = null, param4:Boolean = false, param5:String = null, param6:Vector.<Long> = null, param7:String = null, param8:Boolean = false, param9:int = 0, param10:Long = null, param11:Long = null) {
      super();
      this._clanAction = param1;
      this._clanId = param2;
      this._clanIncoming = param3;
      this._clanMember = param4;
      this._clanName = param5;
      this._clanOutgoing = param6;
      this._clanTag = param7;
      this._incomingRequestEnabled = param8;
      this._minRankForJoinClan = param9;
      this._restrictionTimeJoinClan = param10;
      this._userId = param11;
    }

    public function get clanAction() : Vector.<ClanAction> {
      return this._clanAction;
    }

    public function set clanAction(param1:Vector.<ClanAction>) : void {
      this._clanAction = param1;
    }

    public function get clanId() : Long {
      return this._clanId;
    }

    public function set clanId(param1:Long) : void {
      this._clanId = param1;
    }

    public function get clanIncoming() : Vector.<Long> {
      return this._clanIncoming;
    }

    public function set clanIncoming(param1:Vector.<Long>) : void {
      this._clanIncoming = param1;
    }

    public function get clanMember() : Boolean {
      return this._clanMember;
    }

    public function set clanMember(param1:Boolean) : void {
      this._clanMember = param1;
    }

    public function get clanName() : String {
      return this._clanName;
    }

    public function set clanName(param1:String) : void {
      this._clanName = param1;
    }

    public function get clanOutgoing() : Vector.<Long> {
      return this._clanOutgoing;
    }

    public function set clanOutgoing(param1:Vector.<Long>) : void {
      this._clanOutgoing = param1;
    }

    public function get clanTag() : String {
      return this._clanTag;
    }

    public function set clanTag(param1:String) : void {
      this._clanTag = param1;
    }

    public function get incomingRequestEnabled() : Boolean {
      return this._incomingRequestEnabled;
    }

    public function set incomingRequestEnabled(param1:Boolean) : void {
      this._incomingRequestEnabled = param1;
    }

    public function get minRankForJoinClan() : int {
      return this._minRankForJoinClan;
    }

    public function set minRankForJoinClan(param1:int) : void {
      this._minRankForJoinClan = param1;
    }

    public function get restrictionTimeJoinClan() : Long {
      return this._restrictionTimeJoinClan;
    }

    public function set restrictionTimeJoinClan(param1:Long) : void {
      this._restrictionTimeJoinClan = param1;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function toString() : String {
      var local1:String = "ClanNotifierData [";
      local1 += "clanAction = " + this.clanAction + " ";
      local1 += "clanId = " + this.clanId + " ";
      local1 += "clanIncoming = " + this.clanIncoming + " ";
      local1 += "clanMember = " + this.clanMember + " ";
      local1 += "clanName = " + this.clanName + " ";
      local1 += "clanOutgoing = " + this.clanOutgoing + " ";
      local1 += "clanTag = " + this.clanTag + " ";
      local1 += "incomingRequestEnabled = " + this.incomingRequestEnabled + " ";
      local1 += "minRankForJoinClan = " + this.minRankForJoinClan + " ";
      local1 += "restrictionTimeJoinClan = " + this.restrictionTimeJoinClan + " ";
      local1 += "userId = " + this.userId + " ";
      return local1 + "]";
    }
  }
}
