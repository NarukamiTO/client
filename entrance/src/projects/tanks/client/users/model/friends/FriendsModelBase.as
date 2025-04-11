package projects.tanks.client.users.model.friends {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class FriendsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FriendsModelServer;

    private var client:IFriendsModelBase = IFriendsModelBase(this);
    private var modelId:Long = Long.getLong(1693173045,628784534);
    private var _acceptSuccessId:Long = Long.getLong(608205693,1898592764);
    private var _acceptSuccess_userIdCodec:ICodec;
    private var _acceptedLimitExceededId:Long = Long.getLong(370363039,338480872);
    private var _acceptedLimitExceeded_uidCodec:ICodec;
    private var _alreadyInAcceptedFriendsId:Long = Long.getLong(311681954,1684738000);
    private var _alreadyInAcceptedFriends_uidCodec:ICodec;
    private var _alreadyInIncomingFriendsId:Long = Long.getLong(348947857,-1693710961);
    private var _alreadyInIncomingFriends_uidCodec:ICodec;
    private var _alreadyInIncomingFriends_userIdCodec:ICodec;
    private var _alreadyInOutgoingFriendsId:Long = Long.getLong(444676649,1880663147);
    private var _alreadyInOutgoingFriends_uidCodec:ICodec;
    private var _incomingLimitExceededId:Long = Long.getLong(910302409,-1168735433);
    private var _yourAcceptedLimitExceededId:Long = Long.getLong(766260615,-36774901);

    public function FriendsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FriendsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(FriendsCC,false)));
      this._acceptSuccess_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._acceptedLimitExceeded_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInAcceptedFriends_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInIncomingFriends_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInIncomingFriends_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._alreadyInOutgoingFriends_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : FriendsCC {
      return FriendsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._acceptSuccessId:
          this.client.acceptSuccess(Long(this._acceptSuccess_userIdCodec.decode(param2)));
          break;
        case this._acceptedLimitExceededId:
          this.client.acceptedLimitExceeded(String(this._acceptedLimitExceeded_uidCodec.decode(param2)));
          break;
        case this._alreadyInAcceptedFriendsId:
          this.client.alreadyInAcceptedFriends(String(this._alreadyInAcceptedFriends_uidCodec.decode(param2)));
          break;
        case this._alreadyInIncomingFriendsId:
          this.client.alreadyInIncomingFriends(String(this._alreadyInIncomingFriends_uidCodec.decode(param2)),Long(this._alreadyInIncomingFriends_userIdCodec.decode(param2)));
          break;
        case this._alreadyInOutgoingFriendsId:
          this.client.alreadyInOutgoingFriends(String(this._alreadyInOutgoingFriends_uidCodec.decode(param2)));
          break;
        case this._incomingLimitExceededId:
          this.client.incomingLimitExceeded();
          break;
        case this._yourAcceptedLimitExceededId:
          this.client.yourAcceptedLimitExceeded();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
