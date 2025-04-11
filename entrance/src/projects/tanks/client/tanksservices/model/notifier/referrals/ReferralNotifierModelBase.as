package projects.tanks.client.tanksservices.model.notifier.referrals {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ReferralNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ReferralNotifierModelServer;

    private var client:IReferralNotifierModelBase = IReferralNotifierModelBase(this);
    private var modelId:Long = Long.getLong(1904649067,-739596764);
    private var _setIsReferralId:Long = Long.getLong(474883635,-1307823504);
    private var _setIsReferral_usersCodec:ICodec;

    public function ReferralNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ReferralNotifierModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ReferralNotifierData,false)));
      this._setIsReferral_usersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ReferralNotifierData,false),false,1));
    }

    protected function getInitParam() : ReferralNotifierData {
      return ReferralNotifierData(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setIsReferralId:
          this.client.setIsReferral(this._setIsReferral_usersCodec.decode(param2) as Vector.<ReferralNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
