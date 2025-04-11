package projects.tanks.client.battleservice.model.statistics.team {
  import projects.tanks.client.battleservice.model.statistics.UserInfo;

  public class StatisticsTeamCC {
    private var _blueScore:int;
    private var _redScore:int;
    private var _usersInfoBlue:Vector.<UserInfo>;
    private var _usersInfoRed:Vector.<UserInfo>;

    public function StatisticsTeamCC(param1:int = 0, param2:int = 0, param3:Vector.<UserInfo> = null, param4:Vector.<UserInfo> = null) {
      super();
      this._blueScore = param1;
      this._redScore = param2;
      this._usersInfoBlue = param3;
      this._usersInfoRed = param4;
    }

    public function get blueScore() : int {
      return this._blueScore;
    }

    public function set blueScore(param1:int) : void {
      this._blueScore = param1;
    }

    public function get redScore() : int {
      return this._redScore;
    }

    public function set redScore(param1:int) : void {
      this._redScore = param1;
    }

    public function get usersInfoBlue() : Vector.<UserInfo> {
      return this._usersInfoBlue;
    }

    public function set usersInfoBlue(param1:Vector.<UserInfo>) : void {
      this._usersInfoBlue = param1;
    }

    public function get usersInfoRed() : Vector.<UserInfo> {
      return this._usersInfoRed;
    }

    public function set usersInfoRed(param1:Vector.<UserInfo>) : void {
      this._usersInfoRed = param1;
    }

    public function toString() : String {
      var local1:String = "StatisticsTeamCC [";
      local1 += "blueScore = " + this.blueScore + " ";
      local1 += "redScore = " + this.redScore + " ";
      local1 += "usersInfoBlue = " + this.usersInfoBlue + " ";
      local1 += "usersInfoRed = " + this.usersInfoRed + " ";
      return local1 + "]";
    }
  }
}
