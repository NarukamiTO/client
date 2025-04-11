package projects.tanks.client.tanksservices.model.proabonementnotifier {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ProBattleNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ProBattleNotifierModelServer;

    private var client:IProBattleNotifierModelBase = IProBattleNotifierModelBase(this);
    private var modelId:Long = Long.getLong(1634466802,-928935342);
    private var _setRemainingAbonementTimeSecId:Long = Long.getLong(1929134425,15611068);
    private var _setRemainingAbonementTimeSec_remainingTimeCodec:ICodec;

    public function ProBattleNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ProBattleNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ProAbonementNotifierCC,false)));
      this._setRemainingAbonementTimeSec_remainingTimeCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : ProAbonementNotifierCC {
      return ProAbonementNotifierCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setRemainingAbonementTimeSecId:
          this.client.setRemainingAbonementTimeSec(int(this._setRemainingAbonementTimeSec_remainingTimeCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
