package projects.tanks.client.clans.panel.foreignclan {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;

  public class ForeignClanData {
    private var _blocked:Boolean;
    private var _createTime:Long;
    private var _creatorId:Long;
    private var _description:String;
    private var _flagId:Long;
    private var _incomingRequestEnabled:Boolean;
    private var _maxMembers:int;
    private var _memberClan:Boolean;
    private var _minRankForAddClan:int;
    private var _name:String;
    private var _reasonForBlocking:String;
    private var _requestInIncoming:Boolean;
    private var _requestInOutgoing:Boolean;
    private var _tag:String;
    private var _timeBlocking:Long;
    private var _users:Vector.<UserData>;

    public function ForeignClanData(param1:Boolean = false, param2:Long = null, param3:Long = null, param4:String = null, param5:Long = null, param6:Boolean = false, param7:int = 0, param8:Boolean = false, param9:int = 0, param10:String = null, param11:String = null, param12:Boolean = false, param13:Boolean = false, param14:String = null, param15:Long = null, param16:Vector.<UserData> = null) {
      super();
      this._blocked = param1;
      this._createTime = param2;
      this._creatorId = param3;
      this._description = param4;
      this._flagId = param5;
      this._incomingRequestEnabled = param6;
      this._maxMembers = param7;
      this._memberClan = param8;
      this._minRankForAddClan = param9;
      this._name = param10;
      this._reasonForBlocking = param11;
      this._requestInIncoming = param12;
      this._requestInOutgoing = param13;
      this._tag = param14;
      this._timeBlocking = param15;
      this._users = param16;
    }

    public function get blocked() : Boolean {
      return this._blocked;
    }

    public function set blocked(param1:Boolean) : void {
      this._blocked = param1;
    }

    public function get createTime() : Long {
      return this._createTime;
    }

    public function set createTime(param1:Long) : void {
      this._createTime = param1;
    }

    public function get creatorId() : Long {
      return this._creatorId;
    }

    public function set creatorId(param1:Long) : void {
      this._creatorId = param1;
    }

    public function get description() : String {
      return this._description;
    }

    public function set description(param1:String) : void {
      this._description = param1;
    }

    public function get flagId() : Long {
      return this._flagId;
    }

    public function set flagId(param1:Long) : void {
      this._flagId = param1;
    }

    public function get incomingRequestEnabled() : Boolean {
      return this._incomingRequestEnabled;
    }

    public function set incomingRequestEnabled(param1:Boolean) : void {
      this._incomingRequestEnabled = param1;
    }

    public function get maxMembers() : int {
      return this._maxMembers;
    }

    public function set maxMembers(param1:int) : void {
      this._maxMembers = param1;
    }

    public function get memberClan() : Boolean {
      return this._memberClan;
    }

    public function set memberClan(param1:Boolean) : void {
      this._memberClan = param1;
    }

    public function get minRankForAddClan() : int {
      return this._minRankForAddClan;
    }

    public function set minRankForAddClan(param1:int) : void {
      this._minRankForAddClan = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get reasonForBlocking() : String {
      return this._reasonForBlocking;
    }

    public function set reasonForBlocking(param1:String) : void {
      this._reasonForBlocking = param1;
    }

    public function get requestInIncoming() : Boolean {
      return this._requestInIncoming;
    }

    public function set requestInIncoming(param1:Boolean) : void {
      this._requestInIncoming = param1;
    }

    public function get requestInOutgoing() : Boolean {
      return this._requestInOutgoing;
    }

    public function set requestInOutgoing(param1:Boolean) : void {
      this._requestInOutgoing = param1;
    }

    public function get tag() : String {
      return this._tag;
    }

    public function set tag(param1:String) : void {
      this._tag = param1;
    }

    public function get timeBlocking() : Long {
      return this._timeBlocking;
    }

    public function set timeBlocking(param1:Long) : void {
      this._timeBlocking = param1;
    }

    public function get users() : Vector.<UserData> {
      return this._users;
    }

    public function set users(param1:Vector.<UserData>) : void {
      this._users = param1;
    }

    public function toString() : String {
      var local1:String = "ForeignClanData [";
      local1 += "blocked = " + this.blocked + " ";
      local1 += "createTime = " + this.createTime + " ";
      local1 += "creatorId = " + this.creatorId + " ";
      local1 += "description = " + this.description + " ";
      local1 += "flagId = " + this.flagId + " ";
      local1 += "incomingRequestEnabled = " + this.incomingRequestEnabled + " ";
      local1 += "maxMembers = " + this.maxMembers + " ";
      local1 += "memberClan = " + this.memberClan + " ";
      local1 += "minRankForAddClan = " + this.minRankForAddClan + " ";
      local1 += "name = " + this.name + " ";
      local1 += "reasonForBlocking = " + this.reasonForBlocking + " ";
      local1 += "requestInIncoming = " + this.requestInIncoming + " ";
      local1 += "requestInOutgoing = " + this.requestInOutgoing + " ";
      local1 += "tag = " + this.tag + " ";
      local1 += "timeBlocking = " + this.timeBlocking + " ";
      local1 += "users = " + this.users + " ";
      return local1 + "]";
    }
  }
}
