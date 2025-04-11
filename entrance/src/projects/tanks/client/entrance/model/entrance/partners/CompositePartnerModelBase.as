package projects.tanks.client.entrance.model.entrance.partners {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;

  public class CompositePartnerModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:CompositePartnerModelServer;

    private var client:ICompositePartnerModelBase = ICompositePartnerModelBase(this);
    private var modelId:Long = Long.getLong(119483168,-902850894);
    private var _linkAlreadyExistsId:Long = Long.getLong(1311759417,-1469962579);
    private var _loginFailedId:Long = Long.getLong(1900698747,429778913);
    private var _setPartnerObjectId:Long = Long.getLong(1922813084,1169013396);
    private var _setPartnerObject_partnerObjectCodec:ICodec;
    private var _showTutorialId:Long = Long.getLong(1248008117,296674690);
    private var _startPartnerRegistrationId:Long = Long.getLong(547591075,572045158);
    private var _wrongPasswordId:Long = Long.getLong(826220945,-1410348991);

    public function CompositePartnerModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new CompositePartnerModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(CompositePartnerCC,false)));
      this._setPartnerObject_partnerObjectCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    protected function getInitParam() : CompositePartnerCC {
      return CompositePartnerCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._linkAlreadyExistsId:
          this.client.linkAlreadyExists();
          break;
        case this._loginFailedId:
          this.client.loginFailed();
          break;
        case this._setPartnerObjectId:
          this.client.setPartnerObject(IGameObject(this._setPartnerObject_partnerObjectCodec.decode(param2)));
          break;
        case this._showTutorialId:
          this.client.showTutorial();
          break;
        case this._startPartnerRegistrationId:
          this.client.startPartnerRegistration();
          break;
        case this._wrongPasswordId:
          this.client.wrongPassword();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
