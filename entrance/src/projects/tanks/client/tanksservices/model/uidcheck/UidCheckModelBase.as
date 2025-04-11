package projects.tanks.client.tanksservices.model.uidcheck {
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
  import platform.client.models.commons.types.ValidationStatus;

  public class UidCheckModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UidCheckModelServer;

    private var client:IUidCheckModelBase = IUidCheckModelBase(this);
    private var modelId:Long = Long.getLong(1543089237,611543143);
    private var _validateResultId:Long = Long.getLong(317069682,-1647554367);
    private var _validateResult_statusCodec:ICodec;

    public function UidCheckModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UidCheckModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UidCheckCC,false)));
      this._validateResult_statusCodec = this._protocol.getCodec(new EnumCodecInfo(ValidationStatus,false));
    }

    protected function getInitParam() : UidCheckCC {
      return UidCheckCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._validateResultId:
          this.client.validateResult(ValidationStatus(this._validateResult_statusCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
