package projects.tanks.client.panel.model.battleinvite {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class BattleInviteModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleInviteModelServer;

    private var client:IBattleInviteModelBase = IBattleInviteModelBase(this);
    private var modelId:Long = Long.getLong(1766933086,508742652);
    private var _acceptedId:Long = Long.getLong(1068297728,1829837704);
    private var _accepted_userCodec:ICodec;
    private var _notifyId:Long = Long.getLong(398876573,1490756518);
    private var _notify_userCodec:ICodec;
    private var _notify_dataCodec:ICodec;
    private var _rejectedId:Long = Long.getLong(1068297619,291808945);
    private var _rejected_userCodec:ICodec;
    private var _rejectedBattleNotFoundId:Long = Long.getLong(1139457794,1130394742);
    private var _rejectedBattleNotFound_userCodec:ICodec;
    private var _rejectedInvitationToBattleDisabledId:Long = Long.getLong(1206670376,-1986947351);
    private var _rejectedInvitationToBattleDisabled_userCodec:ICodec;
    private var _rejectedPanelNotLoadedId:Long = Long.getLong(911140643,1907726781);
    private var _rejectedPanelNotLoaded_userCodec:ICodec;
    private var _rejectedUserAlreadyInBattleId:Long = Long.getLong(1422836744,-825710181);
    private var _rejectedUserAlreadyInBattle_userCodec:ICodec;
    private var _rejectedUserInMatchBattleId:Long = Long.getLong(193670407,-969155806);
    private var _rejectedUserInMatchBattle_userCodec:ICodec;
    private var _rejectedUserOfflineId:Long = Long.getLong(335218654,-1980586295);
    private var _rejectedUserOffline_userCodec:ICodec;

    public function BattleInviteModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleInviteModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleInviteCC,false)));
      this._accepted_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._notify_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._notify_dataCodec = this._protocol.getCodec(new TypeCodecInfo(BattleInviteMessage,false));
      this._rejected_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectedBattleNotFound_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectedInvitationToBattleDisabled_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectedPanelNotLoaded_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectedUserAlreadyInBattle_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectedUserInMatchBattle_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectedUserOffline_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : BattleInviteCC {
      return BattleInviteCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._acceptedId:
          this.client.accepted(Long(this._accepted_userCodec.decode(param2)));
          break;
        case this._notifyId:
          this.client.notify(Long(this._notify_userCodec.decode(param2)),BattleInviteMessage(this._notify_dataCodec.decode(param2)));
          break;
        case this._rejectedId:
          this.client.rejected(Long(this._rejected_userCodec.decode(param2)));
          break;
        case this._rejectedBattleNotFoundId:
          this.client.rejectedBattleNotFound(Long(this._rejectedBattleNotFound_userCodec.decode(param2)));
          break;
        case this._rejectedInvitationToBattleDisabledId:
          this.client.rejectedInvitationToBattleDisabled(Long(this._rejectedInvitationToBattleDisabled_userCodec.decode(param2)));
          break;
        case this._rejectedPanelNotLoadedId:
          this.client.rejectedPanelNotLoaded(Long(this._rejectedPanelNotLoaded_userCodec.decode(param2)));
          break;
        case this._rejectedUserAlreadyInBattleId:
          this.client.rejectedUserAlreadyInBattle(Long(this._rejectedUserAlreadyInBattle_userCodec.decode(param2)));
          break;
        case this._rejectedUserInMatchBattleId:
          this.client.rejectedUserInMatchBattle(Long(this._rejectedUserInMatchBattle_userCodec.decode(param2)));
          break;
        case this._rejectedUserOfflineId:
          this.client.rejectedUserOffline(Long(this._rejectedUserOffline_userCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
