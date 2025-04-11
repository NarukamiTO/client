package projects.tanks.client.panel.model.profile.userproperties {
  import alternativa.types.Long;
  import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;

  public class UserPropertiesCC {
    private var _canUseGroup:Boolean;
    private var _crystals:int;
    private var _crystalsRating:int;
    private var _daysFromLastVisit:int;
    private var _daysFromRegistration:int;
    private var _gearScore:int;
    private var _goldsTakenRating:int;
    private var _hasSpectatorPermissions:Boolean;
    private var _id:Long;
    private var _rank:int;
    private var _rankBounds:RankBounds;
    private var _registrationTimestamp:int;
    private var _score:int;
    private var _scoreRating:int;
    private var _uid:String;
    private var _userProfileUrl:String;
    private var _userRating:int;

    public function UserPropertiesCC(param1:Boolean = false, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0, param8:Boolean = false, param9:Long = null, param10:int = 0, param11:RankBounds = null, param12:int = 0, param13:int = 0, param14:int = 0, param15:String = null, param16:String = null, param17:int = 0) {
      super();
      this._canUseGroup = param1;
      this._crystals = param2;
      this._crystalsRating = param3;
      this._daysFromLastVisit = param4;
      this._daysFromRegistration = param5;
      this._gearScore = param6;
      this._goldsTakenRating = param7;
      this._hasSpectatorPermissions = param8;
      this._id = param9;
      this._rank = param10;
      this._rankBounds = param11;
      this._registrationTimestamp = param12;
      this._score = param13;
      this._scoreRating = param14;
      this._uid = param15;
      this._userProfileUrl = param16;
      this._userRating = param17;
    }

    public function get canUseGroup() : Boolean {
      return this._canUseGroup;
    }

    public function set canUseGroup(param1:Boolean) : void {
      this._canUseGroup = param1;
    }

    public function get crystals() : int {
      return this._crystals;
    }

    public function set crystals(param1:int) : void {
      this._crystals = param1;
    }

    public function get crystalsRating() : int {
      return this._crystalsRating;
    }

    public function set crystalsRating(param1:int) : void {
      this._crystalsRating = param1;
    }

    public function get daysFromLastVisit() : int {
      return this._daysFromLastVisit;
    }

    public function set daysFromLastVisit(param1:int) : void {
      this._daysFromLastVisit = param1;
    }

    public function get daysFromRegistration() : int {
      return this._daysFromRegistration;
    }

    public function set daysFromRegistration(param1:int) : void {
      this._daysFromRegistration = param1;
    }

    public function get gearScore() : int {
      return this._gearScore;
    }

    public function set gearScore(param1:int) : void {
      this._gearScore = param1;
    }

    public function get goldsTakenRating() : int {
      return this._goldsTakenRating;
    }

    public function set goldsTakenRating(param1:int) : void {
      this._goldsTakenRating = param1;
    }

    public function get hasSpectatorPermissions() : Boolean {
      return this._hasSpectatorPermissions;
    }

    public function set hasSpectatorPermissions(param1:Boolean) : void {
      this._hasSpectatorPermissions = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    public function get rankBounds() : RankBounds {
      return this._rankBounds;
    }

    public function set rankBounds(param1:RankBounds) : void {
      this._rankBounds = param1;
    }

    public function get registrationTimestamp() : int {
      return this._registrationTimestamp;
    }

    public function set registrationTimestamp(param1:int) : void {
      this._registrationTimestamp = param1;
    }

    public function get score() : int {
      return this._score;
    }

    public function set score(param1:int) : void {
      this._score = param1;
    }

    public function get scoreRating() : int {
      return this._scoreRating;
    }

    public function set scoreRating(param1:int) : void {
      this._scoreRating = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    public function get userProfileUrl() : String {
      return this._userProfileUrl;
    }

    public function set userProfileUrl(param1:String) : void {
      this._userProfileUrl = param1;
    }

    public function get userRating() : int {
      return this._userRating;
    }

    public function set userRating(param1:int) : void {
      this._userRating = param1;
    }

    public function toString() : String {
      var local1:String = "UserPropertiesCC [";
      local1 += "canUseGroup = " + this.canUseGroup + " ";
      local1 += "crystals = " + this.crystals + " ";
      local1 += "crystalsRating = " + this.crystalsRating + " ";
      local1 += "daysFromLastVisit = " + this.daysFromLastVisit + " ";
      local1 += "daysFromRegistration = " + this.daysFromRegistration + " ";
      local1 += "gearScore = " + this.gearScore + " ";
      local1 += "goldsTakenRating = " + this.goldsTakenRating + " ";
      local1 += "hasSpectatorPermissions = " + this.hasSpectatorPermissions + " ";
      local1 += "id = " + this.id + " ";
      local1 += "rank = " + this.rank + " ";
      local1 += "rankBounds = " + this.rankBounds + " ";
      local1 += "registrationTimestamp = " + this.registrationTimestamp + " ";
      local1 += "score = " + this.score + " ";
      local1 += "scoreRating = " + this.scoreRating + " ";
      local1 += "uid = " + this.uid + " ";
      local1 += "userProfileUrl = " + this.userProfileUrl + " ";
      local1 += "userRating = " + this.userRating + " ";
      return local1 + "]";
    }
  }
}
