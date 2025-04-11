package projects.tanks.client.battleservice.model.statistics.team {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public class StatisticsTeamModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:StatisticsTeamModelServer;

    private var client:IStatisticsTeamModelBase = IStatisticsTeamModelBase(this);
    private var modelId:Long = Long.getLong(183455729,-2099733819);
    private var _changeTeamScoreId:Long = Long.getLong(1367071399,-1702461867);
    private var _changeTeamScore_teamCodec:ICodec;
    private var _changeTeamScore_scoreCodec:ICodec;
    private var _changeUserStatId:Long = Long.getLong(1479921566,-1347191967);
    private var _changeUserStat_usersStatCodec:ICodec;
    private var _changeUserStat_teamCodec:ICodec;
    private var _refreshUsersStatId:Long = Long.getLong(1581597391,-963196943);
    private var _refreshUsersStat_userStatCodec:ICodec;
    private var _refreshUsersStat_teamCodec:ICodec;
    private var _swapTeamId:Long = Long.getLong(1345957775,1774893408);
    private var _swapTeam_redUsersCodec:ICodec;
    private var _swapTeam_blueUsersCodec:ICodec;
    private var _userConnectId:Long = Long.getLong(386945968,-373481329);
    private var _userConnect_userIdCodec:ICodec;
    private var _userConnect_usersInfoCodec:ICodec;
    private var _userConnect_teamCodec:ICodec;
    private var _userDisconnectId:Long = Long.getLong(184857581,1110813993);
    private var _userDisconnect_userIdCodec:ICodec;

    public function StatisticsTeamModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new StatisticsTeamModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(StatisticsTeamCC,false)));
      this._changeTeamScore_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._changeTeamScore_scoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._changeUserStat_usersStatCodec = this._protocol.getCodec(new TypeCodecInfo(UserStat,false));
      this._changeUserStat_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._refreshUsersStat_userStatCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserStat,false),false,1));
      this._refreshUsersStat_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._swapTeam_redUsersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserStat,false),false,1));
      this._swapTeam_blueUsersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserStat,false),false,1));
      this._userConnect_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._userConnect_usersInfoCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserInfo,false),false,1));
      this._userConnect_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._userDisconnect_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : StatisticsTeamCC {
      return StatisticsTeamCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeTeamScoreId:
          this.client.changeTeamScore(BattleTeam(this._changeTeamScore_teamCodec.decode(param2)),int(this._changeTeamScore_scoreCodec.decode(param2)));
          break;
        case this._changeUserStatId:
          this.client.changeUserStat(UserStat(this._changeUserStat_usersStatCodec.decode(param2)),BattleTeam(this._changeUserStat_teamCodec.decode(param2)));
          break;
        case this._refreshUsersStatId:
          this.client.refreshUsersStat(this._refreshUsersStat_userStatCodec.decode(param2) as Vector.<UserStat>,BattleTeam(this._refreshUsersStat_teamCodec.decode(param2)));
          break;
        case this._swapTeamId:
          this.client.swapTeam(this._swapTeam_redUsersCodec.decode(param2) as Vector.<UserStat>,this._swapTeam_blueUsersCodec.decode(param2) as Vector.<UserStat>);
          break;
        case this._userConnectId:
          this.client.userConnect(Long(this._userConnect_userIdCodec.decode(param2)),this._userConnect_usersInfoCodec.decode(param2) as Vector.<UserInfo>,BattleTeam(this._userConnect_teamCodec.decode(param2)));
          break;
        case this._userDisconnectId:
          this.client.userDisconnect(Long(this._userDisconnect_userIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
