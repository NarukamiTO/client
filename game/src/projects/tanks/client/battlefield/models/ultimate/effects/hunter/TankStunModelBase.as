package projects.tanks.client.battlefield.models.ultimate.effects.hunter {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class TankStunModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankStunModelServer;

    private var client:ITankStunModelBase = ITankStunModelBase(this);
    private var modelId:Long = Long.getLong(1689684337,1941542906);
    private var _calmId:Long = Long.getLong(2139145234,802852526);
    private var _calm_stunDurationMsCodec:ICodec;
    private var _stunId:Long = Long.getLong(2139145234,803347721);

    public function TankStunModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankStunModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TankStunCC,false)));
      this._calm_stunDurationMsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : TankStunCC {
      return TankStunCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._calmId:
          this.client.calm(int(this._calm_stunDurationMsCodec.decode(param2)));
          break;
        case this._stunId:
          this.client.stun();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
