package projects.tanks.client.battlefield.models.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.HitTraceData;
  import projects.tanks.client.battleservice.BattleRoundParameters;

  public class BattlefieldModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattlefieldModelServer;

    private var client:IBattlefieldModelBase = IBattlefieldModelBase(this);
    private var modelId:Long = Long.getLong(1723277227,1936126557);
    private var _battleFinishId:Long = Long.getLong(1285984840,1983429603);
    private var _battleRestartId:Long = Long.getLong(1210824392,-987670337);
    private var _battleStartId:Long = Long.getLong(180030714,353397522);
    private var _battleStart_paramsCodec:ICodec;
    private var _traceHitId:Long = Long.getLong(711773257,1091256454);
    private var _traceHit_hitTraceDataCodec:ICodec;

    public function BattlefieldModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattlefieldModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattlefieldCC,false)));
      this._battleStart_paramsCodec = this._protocol.getCodec(new TypeCodecInfo(BattleRoundParameters,false));
      this._traceHit_hitTraceDataCodec = this._protocol.getCodec(new TypeCodecInfo(HitTraceData,false));
    }

    protected function getInitParam() : BattlefieldCC {
      return BattlefieldCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._battleFinishId:
          this.client.battleFinish();
          break;
        case this._battleRestartId:
          this.client.battleRestart();
          break;
        case this._battleStartId:
          this.client.battleStart(BattleRoundParameters(this._battleStart_paramsCodec.decode(param2)));
          break;
        case this._traceHitId:
          this.client.traceHit(HitTraceData(this._traceHit_hitTraceDataCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
