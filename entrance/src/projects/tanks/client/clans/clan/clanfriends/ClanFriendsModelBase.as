package projects.tanks.client.clans.clan.clanfriends {
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

  public class ClanFriendsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanFriendsModelServer;

    private var client:IClanFriendsModelBase = IClanFriendsModelBase(this);
    private var modelId:Long = Long.getLong(1889621503,1893984398);
    private var _onUserAddId:Long = Long.getLong(2135860306,-1585042188);
    private var _onUserAdd_idCodec:ICodec;
    private var _onUserRemoveId:Long = Long.getLong(526095397,633372847);
    private var _onUserRemove_idCodec:ICodec;
    private var _userJoinClanId:Long = Long.getLong(489547868,-896284526);
    private var _userJoinClan_usersIdCodec:ICodec;

    public function ClanFriendsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanFriendsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanFriendsCC,false)));
      this._onUserAdd_idCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._onUserRemove_idCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._userJoinClan_usersIdCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
    }

    protected function getInitParam() : ClanFriendsCC {
      return ClanFriendsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._onUserAddId:
          this.client.onUserAdd(Long(this._onUserAdd_idCodec.decode(param2)));
          break;
        case this._onUserRemoveId:
          this.client.onUserRemove(Long(this._onUserRemove_idCodec.decode(param2)));
          break;
        case this._userJoinClanId:
          this.client.userJoinClan(this._userJoinClan_usersIdCodec.decode(param2) as Vector.<Long>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
