package projects.tanks.client.battleselect.model.battle.team {
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class TeamBattleInfoCC {
    private var _scoreBlue:int;
    private var _scoreRed:int;
    private var _usersBlue:Vector.<BattleInfoUser>;
    private var _usersRed:Vector.<BattleInfoUser>;

    public function TeamBattleInfoCC(param1:int = 0, param2:int = 0, param3:Vector.<BattleInfoUser> = null, param4:Vector.<BattleInfoUser> = null) {
      super();
      this._scoreBlue = param1;
      this._scoreRed = param2;
      this._usersBlue = param3;
      this._usersRed = param4;
    }

    public function get scoreBlue() : int {
      return this._scoreBlue;
    }

    public function set scoreBlue(param1:int) : void {
      this._scoreBlue = param1;
    }

    public function get scoreRed() : int {
      return this._scoreRed;
    }

    public function set scoreRed(param1:int) : void {
      this._scoreRed = param1;
    }

    public function get usersBlue() : Vector.<BattleInfoUser> {
      return this._usersBlue;
    }

    public function set usersBlue(param1:Vector.<BattleInfoUser>) : void {
      this._usersBlue = param1;
    }

    public function get usersRed() : Vector.<BattleInfoUser> {
      return this._usersRed;
    }

    public function set usersRed(param1:Vector.<BattleInfoUser>) : void {
      this._usersRed = param1;
    }

    public function toString() : String {
      var local1:String = "TeamBattleInfoCC [";
      local1 += "scoreBlue = " + this.scoreBlue + " ";
      local1 += "scoreRed = " + this.scoreRed + " ";
      local1 += "usersBlue = " + this.usersBlue + " ";
      local1 += "usersRed = " + this.usersRed + " ";
      return local1 + "]";
    }
  }
}
