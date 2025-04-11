package projects.tanks.client.clans.user {
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

  public class ClanUserModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanUserModelServer;

    private var client:IClanUserModelBase = IClanUserModelBase(this);
    private var modelId:Long = Long.getLong(259670316,1522052296);
    private var _alreadyInAcceptedId:Long = Long.getLong(57363867,1237781863);
    private var _alreadyInAccepted_nameCodec:ICodec;
    private var _alreadyInClanId:Long = Long.getLong(618126442,-725356522);
    private var _alreadyInClanOutgoingId:Long = Long.getLong(1671975780,-1329402274);
    private var _alreadyInClanOutgoing_nameCodec:ICodec;
    private var _alreadyInClanOutgoing_lightClanCodec:ICodec;
    private var _alreadyInIncomingId:Long = Long.getLong(57363920,-817863194);
    private var _alreadyInIncoming_nameCodec:ICodec;
    private var _alreadyInIncoming_clanCodec:ICodec;
    private var _alreadyInOutgoingId:Long = Long.getLong(57363960,-848977620);
    private var _alreadyInOutgoing_nameCodec:ICodec;
    private var _clanBlockedId:Long = Long.getLong(325235064,-2121980921);
    private var _clanExistId:Long = Long.getLong(1693514433,32146500);
    private var _clanIncomingRequestDisabledId:Long = Long.getLong(944293305,-1852342578);
    private var _clanNotExistId:Long = Long.getLong(1492352330,720837769);
    private var _creatorLeaveOfClanIfEmptyClanId:Long = Long.getLong(1273341198,-1482111631);
    private var _joinClanId:Long = Long.getLong(193176875,2068732989);
    private var _leftClanId:Long = Long.getLong(193176886,893937818);
    private var _leftClan_restrictionTimeInSecCodec:ICodec;
    private var _removeClanBonusesId:Long = Long.getLong(1136230800,538530230);
    private var _showAlertFullClanId:Long = Long.getLong(2062667168,-2002974215);
    private var _updateStatusBonusesClanId:Long = Long.getLong(1570177194,1280257195);
    private var _updateStatusBonusesClan_canGiveBonusesClanCodec:ICodec;
    private var _userLowRankId:Long = Long.getLong(321756128,1414681448);

    public function ClanUserModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanUserModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanUserCC,false)));
      this._alreadyInAccepted_nameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInClanOutgoing_nameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInClanOutgoing_lightClanCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._alreadyInIncoming_nameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._alreadyInIncoming_clanCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._alreadyInOutgoing_nameCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._leftClan_restrictionTimeInSecCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateStatusBonusesClan_canGiveBonusesClanCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : ClanUserCC {
      return ClanUserCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._alreadyInAcceptedId:
          this.client.alreadyInAccepted(String(this._alreadyInAccepted_nameCodec.decode(param2)));
          break;
        case this._alreadyInClanId:
          this.client.alreadyInClan();
          break;
        case this._alreadyInClanOutgoingId:
          this.client.alreadyInClanOutgoing(String(this._alreadyInClanOutgoing_nameCodec.decode(param2)),IGameObject(this._alreadyInClanOutgoing_lightClanCodec.decode(param2)));
          break;
        case this._alreadyInIncomingId:
          this.client.alreadyInIncoming(String(this._alreadyInIncoming_nameCodec.decode(param2)),IGameObject(this._alreadyInIncoming_clanCodec.decode(param2)));
          break;
        case this._alreadyInOutgoingId:
          this.client.alreadyInOutgoing(String(this._alreadyInOutgoing_nameCodec.decode(param2)));
          break;
        case this._clanBlockedId:
          this.client.clanBlocked();
          break;
        case this._clanExistId:
          this.client.clanExist();
          break;
        case this._clanIncomingRequestDisabledId:
          this.client.clanIncomingRequestDisabled();
          break;
        case this._clanNotExistId:
          this.client.clanNotExist();
          break;
        case this._creatorLeaveOfClanIfEmptyClanId:
          this.client.creatorLeaveOfClanIfEmptyClan();
          break;
        case this._joinClanId:
          this.client.joinClan();
          break;
        case this._leftClanId:
          this.client.leftClan(int(this._leftClan_restrictionTimeInSecCodec.decode(param2)));
          break;
        case this._removeClanBonusesId:
          this.client.removeClanBonuses();
          break;
        case this._showAlertFullClanId:
          this.client.showAlertFullClan();
          break;
        case this._updateStatusBonusesClanId:
          this.client.updateStatusBonusesClan(Boolean(this._updateStatusBonusesClan_canGiveBonusesClanCodec.decode(param2)));
          break;
        case this._userLowRankId:
          this.client.userLowRank();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
