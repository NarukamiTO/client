package projects.tanks.client.users.model.friends.acceptednotificator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.users.model.friends.container.UserContainerCC;

  public class FriendsAcceptedNotificatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FriendsAcceptedNotificatorModelServer;

    private var client:IFriendsAcceptedNotificatorModelBase = IFriendsAcceptedNotificatorModelBase(this);
    private var modelId:Long = Long.getLong(100897389,708983546);
    private var _onAddingId:Long = Long.getLong(203629091,-1595335121);
    private var _onAdding_userIdCodec:ICodec;
    private var _onRemovedId:Long = Long.getLong(2017534548,29039506);
    private var _onRemoved_userIdCodec:ICodec;

    public function FriendsAcceptedNotificatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FriendsAcceptedNotificatorModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UserContainerCC,false)));
      this._onAdding_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._onRemoved_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : UserContainerCC {
      return UserContainerCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._onAddingId:
          this.client.onAdding(Long(this._onAdding_userIdCodec.decode(param2)));
          break;
        case this._onRemovedId:
          this.client.onRemoved(Long(this._onRemoved_userIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
