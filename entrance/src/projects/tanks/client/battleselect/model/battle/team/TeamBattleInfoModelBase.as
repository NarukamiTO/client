package projects.tanks.client.battleselect.model.battle.team {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TeamBattleInfoModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TeamBattleInfoModelServer;

    private var client:ITeamBattleInfoModelBase = ITeamBattleInfoModelBase(this);
    private var modelId:Long = Long.getLong(1548819686,-690668258);
    private var _addUserId:Long = Long.getLong(1082637975,-979180615);
    private var _addUser_userInfoCodec:ICodec;
    private var _addUser_teamCodec:ICodec;
    private var _removeUserId:Long = Long.getLong(1958615472,-14223454);
    private var _removeUser_userIdCodec:ICodec;
    private var _swapTeamsId:Long = Long.getLong(1033012780,-1733683120);
    private var _updateTeamScoreId:Long = Long.getLong(344688414,904593895);
    private var _updateTeamScore_teamCodec:ICodec;
    private var _updateTeamScore_scoreCodec:ICodec;
    private var _updateUserScoreId:Long = Long.getLong(344688125,389346965);
    private var _updateUserScore_userIdCodec:ICodec;
    private var _updateUserScore_scoreCodec:ICodec;

    public function TeamBattleInfoModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TeamBattleInfoModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TeamBattleInfoCC,false)));
      this._addUser_userInfoCodec = this._protocol.getCodec(new TypeCodecInfo(BattleInfoUser,false));
      this._addUser_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._removeUser_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._updateTeamScore_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._updateTeamScore_scoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateUserScore_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._updateUserScore_scoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : TeamBattleInfoCC {
      return TeamBattleInfoCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addUserId:
          this.client.addUser(BattleInfoUser(this._addUser_userInfoCodec.decode(param2)),BattleTeam(this._addUser_teamCodec.decode(param2)));
          break;
        case this._removeUserId:
          this.client.removeUser(Long(this._removeUser_userIdCodec.decode(param2)));
          break;
        case this._swapTeamsId:
          this.client.swapTeams();
          break;
        case this._updateTeamScoreId:
          this.client.updateTeamScore(BattleTeam(this._updateTeamScore_teamCodec.decode(param2)),int(this._updateTeamScore_scoreCodec.decode(param2)));
          break;
        case this._updateUserScoreId:
          this.client.updateUserScore(Long(this._updateUserScore_userIdCodec.decode(param2)),int(this._updateUserScore_scoreCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
