package projects.tanks.client.entrance.model.entrance.invite {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class InviteEntranceModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:InviteEntranceModelServer;

    private var client:IInviteEntranceModelBase = IInviteEntranceModelBase(this);
    private var modelId:Long = Long.getLong(2122883443,1406559758);
    private var _inviteAlreadyActivatedId:Long = Long.getLong(726287787,1758911497);
    private var _inviteAlreadyActivated_uidCodec:ICodec;
    private var _inviteFreeId:Long = Long.getLong(1017441927,966581788);
    private var _inviteNotFoundId:Long = Long.getLong(1810857751,-34129889);

    public function InviteEntranceModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new InviteEntranceModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(InviteEntranceCC,false)));
      this._inviteAlreadyActivated_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : InviteEntranceCC {
      return InviteEntranceCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._inviteAlreadyActivatedId:
          this.client.inviteAlreadyActivated(String(this._inviteAlreadyActivated_uidCodec.decode(param2)));
          break;
        case this._inviteFreeId:
          this.client.inviteFree();
          break;
        case this._inviteNotFoundId:
          this.client.inviteNotFound();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
