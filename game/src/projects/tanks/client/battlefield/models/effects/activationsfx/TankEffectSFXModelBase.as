package projects.tanks.client.battlefield.models.effects.activationsfx {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class TankEffectSFXModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankEffectSFXModelServer;

    private var client:ITankEffectSFXModelBase = ITankEffectSFXModelBase(this);
    private var modelId:Long = Long.getLong(1495845146,-1290667120);
    private var _effectActivatedId:Long = Long.getLong(9900043,143735205);
    private var _effectActivated_effectTagCodec:ICodec;

    public function TankEffectSFXModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankEffectSFXModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(TankEffectSFXCC,false)));
      this._effectActivated_effectTagCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : TankEffectSFXCC {
      return TankEffectSFXCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._effectActivatedId:
          this.client.effectActivated(int(this._effectActivated_effectTagCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
