package alternativa.tanks.models.battle.gui.statistics {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class ClientUserInfo {
    private var _userId:Long;
    private var _uid:String;
    private var _rank:int;
    private var _loaded:Boolean;
    private var _suspicious:Boolean;
    private var _teamType:BattleTeam;
    private var _chatModeratorLevel:ChatModeratorLevel;
    private var _hasPremium:Boolean;

    public function ClientUserInfo(param1:Long, param2:String, param3:int, param4:Boolean, param5:Boolean, param6:BattleTeam, param7:ChatModeratorLevel, param8:Boolean) {
      super();
      this._userId = param1;
      this._uid = param2;
      this._rank = param3;
      this._loaded = param4;
      this._suspicious = param5;
      this._teamType = param6;
      this._chatModeratorLevel = param7;
      this._hasPremium = param8;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    public function get loaded() : Boolean {
      return this._loaded;
    }

    public function set loaded(param1:Boolean) : void {
      this._loaded = param1;
    }

    public function get suspicious() : Boolean {
      return this._suspicious;
    }

    public function set suspicious(param1:Boolean) : void {
      this._suspicious = param1;
    }

    public function get teamType() : BattleTeam {
      return this._teamType;
    }

    public function set teamType(param1:BattleTeam) : void {
      this._teamType = param1;
    }

    public function get chatModeratorLevel() : ChatModeratorLevel {
      return this._chatModeratorLevel;
    }

    public function set chatModeratorLevel(param1:ChatModeratorLevel) : void {
      this._chatModeratorLevel = param1;
    }

    public function getShortUserInfo() : ShortUserInfo {
      var local1:ShortUserInfo = new ShortUserInfo();
      local1.userId = this._userId;
      local1.uid = this._uid;
      local1.rank = this._rank;
      local1.suspicious = this._suspicious;
      local1.teamType = this._teamType;
      local1.chatModeratorLevel = this._chatModeratorLevel;
      local1.hasPremium = this._hasPremium;
      return local1;
    }
  }
}
