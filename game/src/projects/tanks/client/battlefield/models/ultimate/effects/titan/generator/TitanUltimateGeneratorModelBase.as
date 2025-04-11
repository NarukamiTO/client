package projects.tanks.client.battlefield.models.ultimate.effects.titan.generator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class TitanUltimateGeneratorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TitanUltimateGeneratorModelServer;

    private var client:ITitanUltimateGeneratorModelBase = ITitanUltimateGeneratorModelBase(this);
    private var modelId:Long = Long.getLong(2034655677,183456205);
    private var _coverTankId:Long = Long.getLong(758928504,-1627221703);
    private var _coverTank_tankIdCodec:ICodec;
    private var _uncoverTankId:Long = Long.getLong(810722220,-1805959360);
    private var _uncoverTank_tankIdCodec:ICodec;
    private var _uncoverTank_isStillCoveredCodec:ICodec;

    public function TitanUltimateGeneratorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TitanUltimateGeneratorModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TitanUltimateGeneratorCC,false)));
      this._coverTank_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._uncoverTank_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._uncoverTank_isStillCoveredCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : TitanUltimateGeneratorCC {
      return TitanUltimateGeneratorCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._coverTankId:
          this.client.coverTank(Long(this._coverTank_tankIdCodec.decode(param2)));
          break;
        case this._uncoverTankId:
          this.client.uncoverTank(Long(this._uncoverTank_tankIdCodec.decode(param2)),Boolean(this._uncoverTank_isStillCoveredCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
