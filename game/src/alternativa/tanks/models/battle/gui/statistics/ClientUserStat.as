package alternativa.tanks.models.battle.gui.statistics {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public class ClientUserStat {
    private var _clientUserInfo:ClientUserInfo;
    private var _deaths:int;
    private var _kills:int;
    private var _score:int;
    private var _reward:int;
    private var _stars:int;
    private var _hasPremium:Boolean;

    public function ClientUserStat() {
      super();
    }

    public function initUserStat(param1:UserStat, param2:ClientUserInfo) : void {
      this._clientUserInfo = param2;
      this._deaths = param1.deaths;
      this._kills = param1.kills;
      this._score = param1.score;
    }

    public function updateUserStat(param1:UserStat) : void {
      this._deaths = param1.deaths;
      this._kills = param1.kills;
      this._score = param1.score;
    }

    public function initUserInfo(param1:UserInfo, param2:ClientUserInfo) : void {
      this._clientUserInfo = param2;
      this._deaths = param1.deaths;
      this._kills = param1.kills;
      this._score = param1.score;
    }

    public function get userId() : Long {
      return this._clientUserInfo.userId;
    }

    public function get uid() : String {
      return this._clientUserInfo.uid;
    }

    public function get rank() : int {
      return this._clientUserInfo.rank;
    }

    public function get suspicious() : Boolean {
      return this._clientUserInfo.suspicious;
    }

    public function get loaded() : Boolean {
      return this._clientUserInfo.loaded;
    }

    public function get teamType() : BattleTeam {
      return this._clientUserInfo.teamType;
    }

    public function get deaths() : int {
      return this._deaths;
    }

    public function get kills() : int {
      return this._kills;
    }

    public function get score() : int {
      return this._score;
    }

    public function get reward() : int {
      return this._reward;
    }

    public function set teamType(param1:BattleTeam) : void {
      this._clientUserInfo.teamType = param1;
    }

    public function set suspicious(param1:Boolean) : void {
      this._clientUserInfo.suspicious = param1;
    }

    public function set loaded(param1:Boolean) : void {
      this._clientUserInfo.loaded = param1;
    }

    public function set rank(param1:int) : void {
      this._clientUserInfo.rank = param1;
    }

    public function set reward(param1:int) : void {
      this._reward = param1;
    }

    public function get stars() : int {
      return this._stars;
    }

    public function set stars(param1:int) : void {
      this._stars = param1;
    }

    public function get hasPremium() : Boolean {
      return this._hasPremium;
    }

    public function set hasPremium(param1:Boolean) : void {
      this._hasPremium = param1;
    }
  }
}
