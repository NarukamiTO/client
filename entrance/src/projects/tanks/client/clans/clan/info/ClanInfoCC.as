package projects.tanks.client.clans.clan.info {
  import alternativa.types.Long;

  public class ClanInfoCC {
    private var _blocked:Boolean;
    private var _createTime:Long;
    private var _creatorId:Long;
    private var _description:String;
    private var _flagId:Long;
    private var _incomingRequestEnabled:Boolean;
    private var _maxCharactersDescription:int;
    private var _maxMembers:int;
    private var _minRankForAddClan:int;
    private var _name:String;
    private var _reasonForBlocking:String;
    private var _self:Boolean;
    private var _tag:String;
    private var _timeBlocking:Long;
    private var _users:Vector.<Long>;

    public function ClanInfoCC(param1:Boolean = false, param2:Long = null, param3:Long = null, param4:String = null, param5:Long = null, param6:Boolean = false, param7:int = 0, param8:int = 0, param9:int = 0, param10:String = null, param11:String = null, param12:Boolean = false, param13:String = null, param14:Long = null, param15:Vector.<Long> = null) {
      super();
      this._blocked = param1;
      this._createTime = param2;
      this._creatorId = param3;
      this._description = param4;
      this._flagId = param5;
      this._incomingRequestEnabled = param6;
      this._maxCharactersDescription = param7;
      this._maxMembers = param8;
      this._minRankForAddClan = param9;
      this._name = param10;
      this._reasonForBlocking = param11;
      this._self = param12;
      this._tag = param13;
      this._timeBlocking = param14;
      this._users = param15;
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

    public function get maxCharactersDescription() : int {
      return this._maxCharactersDescription;
    }

    public function set maxCharactersDescription(param1:int) : void {
      this._maxCharactersDescription = param1;
    }

    public function get maxMembers() : int {
      return this._maxMembers;
    }

    public function set maxMembers(param1:int) : void {
      this._maxMembers = param1;
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

    public function get self() : Boolean {
      return this._self;
    }

    public function set self(param1:Boolean) : void {
      this._self = param1;
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

    public function get users() : Vector.<Long> {
      return this._users;
    }

    public function set users(param1:Vector.<Long>) : void {
      this._users = param1;
    }

    public function toString() : String {
      var local1:String = "ClanInfoCC [";
      local1 += "blocked = " + this.blocked + " ";
      local1 += "createTime = " + this.createTime + " ";
      local1 += "creatorId = " + this.creatorId + " ";
      local1 += "description = " + this.description + " ";
      local1 += "flagId = " + this.flagId + " ";
      local1 += "incomingRequestEnabled = " + this.incomingRequestEnabled + " ";
      local1 += "maxCharactersDescription = " + this.maxCharactersDescription + " ";
      local1 += "maxMembers = " + this.maxMembers + " ";
      local1 += "minRankForAddClan = " + this.minRankForAddClan + " ";
      local1 += "name = " + this.name + " ";
      local1 += "reasonForBlocking = " + this.reasonForBlocking + " ";
      local1 += "self = " + this.self + " ";
      local1 += "tag = " + this.tag + " ";
      local1 += "timeBlocking = " + this.timeBlocking + " ";
      local1 += "users = " + this.users + " ";
      return local1 + "]";
    }
  }
}
