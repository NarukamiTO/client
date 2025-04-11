package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.invite {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MatchmakingGroupInviteModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MatchmakingGroupInviteModelServer;

    private var client:IMatchmakingGroupInviteModelBase = IMatchmakingGroupInviteModelBase(this);
    private var modelId:Long = Long.getLong(1554280211,1562501796);
    private var _acceptedId:Long = Long.getLong(1122035593,599020768);
    private var _accepted_userCodec:ICodec;
    private var _rejectInvitationToGroupDisabledId:Long = Long.getLong(490134730,1080398833);
    private var _rejectInvitationToGroupDisabled_userCodec:ICodec;
    private var _rejectUserAlreadyInGroupId:Long = Long.getLong(473112343,1371826939);
    private var _rejectUserAlreadyInGroup_userCodec:ICodec;
    private var _rejectUserOfflineId:Long = Long.getLong(374808837,1597389024);
    private var _rejectUserOffline_userCodec:ICodec;
    private var _rejectedId:Long = Long.getLong(1122035483,-939007991);
    private var _rejected_userCodec:ICodec;
    private var _sendInviteId:Long = Long.getLong(239302436,-1286419946);
    private var _sendInvite_leaderCodec:ICodec;

    public function MatchmakingGroupInviteModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MatchmakingGroupInviteModelServer(IModel(this));
      this._accepted_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectInvitationToGroupDisabled_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectUserAlreadyInGroup_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejectUserOffline_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._rejected_userCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._sendInvite_leaderCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._acceptedId:
          this.client.accepted(Long(this._accepted_userCodec.decode(param2)));
          break;
        case this._rejectInvitationToGroupDisabledId:
          this.client.rejectInvitationToGroupDisabled(Long(this._rejectInvitationToGroupDisabled_userCodec.decode(param2)));
          break;
        case this._rejectUserAlreadyInGroupId:
          this.client.rejectUserAlreadyInGroup(Long(this._rejectUserAlreadyInGroup_userCodec.decode(param2)));
          break;
        case this._rejectUserOfflineId:
          this.client.rejectUserOffline(Long(this._rejectUserOffline_userCodec.decode(param2)));
          break;
        case this._rejectedId:
          this.client.rejected(Long(this._rejected_userCodec.decode(param2)));
          break;
        case this._sendInviteId:
          this.client.sendInvite(Long(this._sendInvite_leaderCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
