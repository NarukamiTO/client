package projects.tanks.client.battleselect.model.matchmaking.group.invitewindow {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class GroupInviteWindowModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GroupInviteWindowModelServer;

    private var client:IGroupInviteWindowModelBase = IGroupInviteWindowModelBase(this);
    private var modelId:Long = Long.getLong(443203981,347316300);
    private var _setAvailableToInviteUsersId:Long = Long.getLong(64042174,-63295164);
    private var _setAvailableToInviteUsers_friendsCodec:ICodec;
    private var _showId:Long = Long.getLong(1229034573,1475867490);
    private var _show_allowedFromFriendsCodec:ICodec;
    private var _show_allowedFromClanCodec:ICodec;

    public function GroupInviteWindowModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GroupInviteWindowModelServer(IModel(this));
      this._setAvailableToInviteUsers_friendsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(MatchMakingUserInfo,false),false,1));
      this._show_allowedFromFriendsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this._show_allowedFromClanCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setAvailableToInviteUsersId:
          this.client.setAvailableToInviteUsers(this._setAvailableToInviteUsers_friendsCodec.decode(param2) as Vector.<MatchMakingUserInfo>);
          break;
        case this._showId:
          this.client.show(this._show_allowedFromFriendsCodec.decode(param2) as Vector.<Long>,this._show_allowedFromClanCodec.decode(param2) as Vector.<Long>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
