package projects.tanks.client.battlefield.models.tankparts.gearscore {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class BattleGearScoreModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleGearScoreModelServer;

    private var client:IBattleGearScoreModelBase = IBattleGearScoreModelBase(this);
    private var modelId:Long = Long.getLong(1135202411,-1956043623);
    private var _setGearScoreId:Long = Long.getLong(1064176503,81422397);
    private var _setGearScore_scoreCodec:ICodec;

    public function BattleGearScoreModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleGearScoreModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleGearScoreCC,false)));
      this._setGearScore_scoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : BattleGearScoreCC {
      return BattleGearScoreCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setGearScoreId:
          this.client.setGearScore(int(this._setGearScore_scoreCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
