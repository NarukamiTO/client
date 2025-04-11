package projects.tanks.client.battleselect.model.matchmaking.group.notify {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class MatchmakingGroupNotifyModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MatchmakingGroupNotifyModelServer;

    private var client:IMatchmakingGroupNotifyModelBase = IMatchmakingGroupNotifyModelBase(this);
    private var modelId:Long = Long.getLong(24345264,-1141305498);
    private var _addUserId:Long = Long.getLong(457644934,1356384143);
    private var _addUser_userDataCodec:ICodec;
    private var _removeUserId:Long = Long.getLong(1473935785,1650079766);
    private var _removeUser_userIdCodec:ICodec;
    private var _userMountedItemId:Long = Long.getLong(796961862,-1942684603);
    private var _userMountedItem_userDataCodec:ICodec;
    private var _userNotReadyId:Long = Long.getLong(907288320,709901878);
    private var _userNotReady_userIdCodec:ICodec;
    private var _userReadyId:Long = Long.getLong(1710113617,1839810627);
    private var _userReady_userIdCodec:ICodec;

    public function MatchmakingGroupNotifyModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MatchmakingGroupNotifyModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(MatchmakingGroupCC,false)));
      this._addUser_userDataCodec = this._protocol.getCodec(new TypeCodecInfo(MatchmakingUserData,false));
      this._removeUser_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._userMountedItem_userDataCodec = this._protocol.getCodec(new TypeCodecInfo(MountItemsUserData,false));
      this._userNotReady_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._userReady_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : MatchmakingGroupCC {
      return MatchmakingGroupCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addUserId:
          this.client.addUser(MatchmakingUserData(this._addUser_userDataCodec.decode(param2)));
          break;
        case this._removeUserId:
          this.client.removeUser(Long(this._removeUser_userIdCodec.decode(param2)));
          break;
        case this._userMountedItemId:
          this.client.userMountedItem(MountItemsUserData(this._userMountedItem_userDataCodec.decode(param2)));
          break;
        case this._userNotReadyId:
          this.client.userNotReady(Long(this._userNotReady_userIdCodec.decode(param2)));
          break;
        case this._userReadyId:
          this.client.userReady(Long(this._userReady_userIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
