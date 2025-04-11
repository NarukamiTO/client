package projects.tanks.client.battleservice.model.statistics {
  import alternativa.types.Long;

  public class UserStat {
    private var _deaths:int;
    private var _kills:int;
    private var _score:int;
    private var _user:Long;

    public function UserStat(param1:int = 0, param2:int = 0, param3:int = 0, param4:Long = null) {
      super();
      this._deaths = param1;
      this._kills = param2;
      this._score = param3;
      this._user = param4;
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

    public function get score() : int {
      return this._score;
    }

    public function set score(param1:int) : void {
      this._score = param1;
    }

    public function get user() : Long {
      return this._user;
    }

    public function set user(param1:Long) : void {
      this._user = param1;
    }

    public function toString() : String {
      var local1:String = "UserStat [";
      local1 += "deaths = " + this.deaths + " ";
      local1 += "kills = " + this.kills + " ";
      local1 += "score = " + this.score + " ";
      local1 += "user = " + this.user + " ";
      return local1 + "]";
    }
  }
}
