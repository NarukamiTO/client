package projects.tanks.client.panel.model.socialnetwork {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class SocialNetworkPanelModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SocialNetworkPanelModelServer;

    private var client:ISocialNetworkPanelModelBase = ISocialNetworkPanelModelBase(this);
    private var modelId:Long = Long.getLong(439695750,646961384);
    private var _linkAlreadyExistsId:Long = Long.getLong(964446817,-340367443);
    private var _linkAlreadyExists_socialNetworkIdCodec:ICodec;
    private var _linkCreatedId:Long = Long.getLong(455315457,289812863);
    private var _linkCreated_socialNetworkIdCodec:ICodec;
    private var _unlinkSuccessId:Long = Long.getLong(2086735179,-395191971);
    private var _unlinkSuccess_socialNetworkIdCodec:ICodec;
    private var _validationFailedId:Long = Long.getLong(1997552645,-744590077);

    public function SocialNetworkPanelModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SocialNetworkPanelModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(SocialNetworkPanelCC,false)));
      this._linkAlreadyExists_socialNetworkIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._linkCreated_socialNetworkIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._unlinkSuccess_socialNetworkIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : SocialNetworkPanelCC {
      return SocialNetworkPanelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._linkAlreadyExistsId:
          this.client.linkAlreadyExists(String(this._linkAlreadyExists_socialNetworkIdCodec.decode(param2)));
          break;
        case this._linkCreatedId:
          this.client.linkCreated(String(this._linkCreated_socialNetworkIdCodec.decode(param2)));
          break;
        case this._unlinkSuccessId:
          this.client.unlinkSuccess(String(this._unlinkSuccess_socialNetworkIdCodec.decode(param2)));
          break;
        case this._validationFailedId:
          this.client.validationFailed();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
