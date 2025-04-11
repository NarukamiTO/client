package projects.tanks.client.battleservice.model.statistics {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class StatisticsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:StatisticsModelServer;

    private var client:IStatisticsModelBase = IStatisticsModelBase(this);
    private var modelId:Long = Long.getLong(485575169,-17734339);
    private var _fundChangeId:Long = Long.getLong(2027633487,-2104416877);
    private var _fundChange_fundCodec:ICodec;
    private var _onRankChangedId:Long = Long.getLong(794588440,-1349024015);
    private var _onRankChanged_userIdCodec:ICodec;
    private var _onRankChanged_newRankCodec:ICodec;
    private var _onRankChanged_forceUpRankForNewbiesCodec:ICodec;
    private var _resetBattleNameId:Long = Long.getLong(1688328639,-1477155462);
    private var _roundFinishId:Long = Long.getLong(1570125867,640719657);
    private var _roundFinish_showResultTableCodec:ICodec;
    private var _roundFinish_rewardCodec:ICodec;
    private var _roundFinish_timeToRestartCodec:ICodec;
    private var _roundStartId:Long = Long.getLong(2027560760,1768125684);
    private var _roundStart_timeLimitInSecCodec:ICodec;
    private var _roundStart_valuableRoundCodec:ICodec;
    private var _roundStopId:Long = Long.getLong(1312331174,-81511448);
    private var _setBattleNameId:Long = Long.getLong(1481208751,-1671478579);
    private var _setBattleName_nameCodec:ICodec;
    private var _statusProbablyCheaterChangedId:Long = Long.getLong(844922966,157499169);
    private var _statusProbablyCheaterChanged_userIdCodec:ICodec;
    private var _statusProbablyCheaterChanged_suspiciousCodec:ICodec;

    public function StatisticsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new StatisticsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(StatisticsModelCC,false)));
      this._fundChange_fundCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._onRankChanged_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._onRankChanged_newRankCodec = this._protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._onRankChanged_forceUpRankForNewbiesCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._roundFinish_showResultTableCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._roundFinish_rewardCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserReward,false),false,1));
      this._roundFinish_timeToRestartCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._roundStart_timeLimitInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._roundStart_valuableRoundCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._setBattleName_nameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._statusProbablyCheaterChanged_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._statusProbablyCheaterChanged_suspiciousCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : StatisticsModelCC {
      return StatisticsModelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._fundChangeId:
          this.client.fundChange(int(this._fundChange_fundCodec.decode(param2)));
          break;
        case this._onRankChangedId:
          this.client.onRankChanged(Long(this._onRankChanged_userIdCodec.decode(param2)),int(this._onRankChanged_newRankCodec.decode(param2)),Boolean(this._onRankChanged_forceUpRankForNewbiesCodec.decode(param2)));
          break;
        case this._resetBattleNameId:
          this.client.resetBattleName();
          break;
        case this._roundFinishId:
          this.client.roundFinish(Boolean(this._roundFinish_showResultTableCodec.decode(param2)),this._roundFinish_rewardCodec.decode(param2) as Vector.<UserReward>,int(this._roundFinish_timeToRestartCodec.decode(param2)));
          break;
        case this._roundStartId:
          this.client.roundStart(int(this._roundStart_timeLimitInSecCodec.decode(param2)),Boolean(this._roundStart_valuableRoundCodec.decode(param2)));
          break;
        case this._roundStopId:
          this.client.roundStop();
          break;
        case this._setBattleNameId:
          this.client.setBattleName(String(this._setBattleName_nameCodec.decode(param2)));
          break;
        case this._statusProbablyCheaterChangedId:
          this.client.statusProbablyCheaterChanged(Long(this._statusProbablyCheaterChanged_userIdCodec.decode(param2)),Boolean(this._statusProbablyCheaterChanged_suspiciousCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
