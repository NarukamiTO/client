package projects.tanks.client.clans.clan.clanmembersdata {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public class UserData {
    private var _dateInClanInSec:int;
    private var _deaths:int;
    private var _kills:int;
    private var _lastVisitTime:Long;
    private var _permission:ClanPermission;
    private var _score:int;
    private var _userId:Long;

    public function UserData(param1:int = 0, param2:int = 0, param3:int = 0, param4:Long = null, param5:ClanPermission = null, param6:int = 0, param7:Long = null) {
      super();
      this._dateInClanInSec = param1;
      this._deaths = param2;
      this._kills = param3;
      this._lastVisitTime = param4;
      this._permission = param5;
      this._score = param6;
      this._userId = param7;
    }

    public function get dateInClanInSec() : int {
      return this._dateInClanInSec;
    }

    public function set dateInClanInSec(param1:int) : void {
      this._dateInClanInSec = param1;
    }

    public function get deaths() : int {
      return this._deaths;
    }

    public function set deaths(param1:int) : void {
      this._deaths = param1;
    }

    public function get kills() : int {
      return this._kills;
    }

    public function set kills(param1:int) : void {
      this._kills = param1;
    }

    public function get lastVisitTime() : Long {
      return this._lastVisitTime;
    }

    public function set lastVisitTime(param1:Long) : void {
      this._lastVisitTime = param1;
    }

    public function get permission() : ClanPermission {
      return this._permission;
    }

    public function set permission(param1:ClanPermission) : void {
      this._permission = param1;
    }

    public function get score() : int {
      return this._score;
    }

    public function set score(param1:int) : void {
      this._score = param1;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function toString() : String {
      var local1:String = "UserData [";
      local1 += "dateInClanInSec = " + this.dateInClanInSec + " ";
      local1 += "deaths = " + this.deaths + " ";
      local1 += "kills = " + this.kills + " ";
      local1 += "lastVisitTime = " + this.lastVisitTime + " ";
      local1 += "permission = " + this.permission + " ";
      local1 += "score = " + this.score + " ";
      local1 += "userId = " + this.userId + " ";
      return local1 + "]";
    }
  }
}
