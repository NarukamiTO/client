package projects.tanks.client.clans.clan {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ClanModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanModelServer;

    private var client:IClanModelBase = IClanModelBase(this);
    private var modelId:Long = Long.getLong(454139398,-2069165154);
    private var _alreadyInAcceptedId:Long = Long.getLong(1925555464,-742779729);
    private var _alreadyInAccepted_uidCodec:ICodec;
    private var _alreadyInClanId:Long = Long.getLong(680200609,-1147294464);
    private var _alreadyInClan_uidCodec:ICodec;
    private var _alreadyInClanIncomingId:Long = Long.getLong(1659309065,-71192762);
    private var _alreadyInClanIncoming_uidCodec:ICodec;
    private var _alreadyInClanIncoming_userIdCodec:ICodec;
    private var _alreadyInClanOutgoingId:Long = Long.getLong(1659309105,-102307188);
    private var _alreadyInClanOutgoing_uidCodec:ICodec;
    private var _alreadyInUserOutgoingId:Long = Long.getLong(1767156062,-1193480447);
    private var _alreadyInUserOutgoing_uidCodec:ICodec;
    private var _alreadyInUserOutgoing_idCodec:ICodec;
    private var _maxMembersId:Long = Long.getLong(615510449,-291351864);
    private var _userExistId:Long = Long.getLong(1820972193,-1147714599);
    private var _userLowRankId:Long = Long.getLong(1902588706,-1770274302);
    private var _userNotExistId:Long = Long.getLong(1149292226,-49512386);

    public function ClanModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanModelServer(IModel(this));
      this._alreadyInAccepted_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInClan_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInClanIncoming_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInClanIncoming_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._alreadyInClanOutgoing_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInUserOutgoing_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInUserOutgoing_idCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._alreadyInAcceptedId:
          this.client.alreadyInAccepted(String(this._alreadyInAccepted_uidCodec.decode(param2)));
          break;
        case this._alreadyInClanId:
          this.client.alreadyInClan(String(this._alreadyInClan_uidCodec.decode(param2)));
          break;
        case this._alreadyInClanIncomingId:
          this.client.alreadyInClanIncoming(String(this._alreadyInClanIncoming_uidCodec.decode(param2)),Long(this._alreadyInClanIncoming_userIdCodec.decode(param2)));
          break;
        case this._alreadyInClanOutgoingId:
          this.client.alreadyInClanOutgoing(String(this._alreadyInClanOutgoing_uidCodec.decode(param2)));
          break;
        case this._alreadyInUserOutgoingId:
          this.client.alreadyInUserOutgoing(String(this._alreadyInUserOutgoing_uidCodec.decode(param2)),Long(this._alreadyInUserOutgoing_idCodec.decode(param2)));
          break;
        case this._maxMembersId:
          this.client.maxMembers();
          break;
        case this._userExistId:
          this.client.userExist();
          break;
        case this._userLowRankId:
          this.client.userLowRank();
          break;
        case this._userNotExistId:
          this.client.userNotExist();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
