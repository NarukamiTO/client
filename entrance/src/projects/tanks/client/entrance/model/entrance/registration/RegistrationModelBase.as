package projects.tanks.client.entrance.model.entrance.registration {
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

  public class RegistrationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RegistrationModelServer;

    private var client:IRegistrationModelBase = IRegistrationModelBase(this);
    private var modelId:Long = Long.getLong(576129845,453074872);
    private var _anchorRegistrationId:Long = Long.getLong(1757127483,1517315861);
    private var _enteredUidIsBusyId:Long = Long.getLong(290381668,-2011787495);
    private var _enteredUidIsBusy_advisedUidsCodec:ICodec;
    private var _enteredUidIsFreeId:Long = Long.getLong(290381668,-2011671668);
    private var _enteredUidIsIncorrectId:Long = Long.getLong(1011786258,-588410501);
    private var _passwordIsIncorrectId:Long = Long.getLong(177292069,531145411);
    private var _registrationFailedId:Long = Long.getLong(663922876,-71252787);

    public function RegistrationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RegistrationModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(RegistrationModelCC,false)));
      this._enteredUidIsBusy_advisedUidsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
    }

    protected function getInitParam() : RegistrationModelCC {
      return RegistrationModelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._anchorRegistrationId:
          this.client.anchorRegistration();
          break;
        case this._enteredUidIsBusyId:
          this.client.enteredUidIsBusy(this._enteredUidIsBusy_advisedUidsCodec.decode(param2) as Vector.<String>);
          break;
        case this._enteredUidIsFreeId:
          this.client.enteredUidIsFree();
          break;
        case this._enteredUidIsIncorrectId:
          this.client.enteredUidIsIncorrect();
          break;
        case this._passwordIsIncorrectId:
          this.client.passwordIsIncorrect();
          break;
        case this._registrationFailedId:
          this.client.registrationFailed();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
