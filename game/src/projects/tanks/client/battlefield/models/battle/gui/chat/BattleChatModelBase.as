package projects.tanks.client.battlefield.models.battle.gui.chat {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleChatModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleChatModelServer;

    private var client:IBattleChatModelBase = IBattleChatModelBase(this);
    private var modelId:Long = Long.getLong(1254001332,-1596966842);
    private var _addMessageId:Long = Long.getLong(1268063749,-1740285311);
    private var _addMessage_userIdCodec:ICodec;
    private var _addMessage_messageCodec:ICodec;
    private var _addMessage_typeCodec:ICodec;
    private var _addSpectatorTeamMessageId:Long = Long.getLong(1310559631,-90978751);
    private var _addSpectatorTeamMessage_uidCodec:ICodec;
    private var _addSpectatorTeamMessage_messageCodec:ICodec;
    private var _addSystemMessageId:Long = Long.getLong(211790396,868140590);
    private var _addSystemMessage_messageCodec:ICodec;
    private var _addTeamMessageId:Long = Long.getLong(540625227,-85921692);
    private var _addTeamMessage_userIdCodec:ICodec;
    private var _addTeamMessage_messageCodec:ICodec;
    private var _addTeamMessage_typeCodec:ICodec;
    private var _updateTeamHeaderId:Long = Long.getLong(159380621,1692473102);
    private var _updateTeamHeader_headerCodec:ICodec;

    public function BattleChatModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleChatModelServer(IModel(this));
      this._addMessage_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._addMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._addMessage_typeCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._addSpectatorTeamMessage_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._addSpectatorTeamMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._addSystemMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._addTeamMessage_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._addTeamMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._addTeamMessage_typeCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._updateTeamHeader_headerCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addMessageId:
          this.client.addMessage(Long(this._addMessage_userIdCodec.decode(param2)),String(this._addMessage_messageCodec.decode(param2)),BattleTeam(this._addMessage_typeCodec.decode(param2)));
          break;
        case this._addSpectatorTeamMessageId:
          this.client.addSpectatorTeamMessage(String(this._addSpectatorTeamMessage_uidCodec.decode(param2)),String(this._addSpectatorTeamMessage_messageCodec.decode(param2)));
          break;
        case this._addSystemMessageId:
          this.client.addSystemMessage(String(this._addSystemMessage_messageCodec.decode(param2)));
          break;
        case this._addTeamMessageId:
          this.client.addTeamMessage(Long(this._addTeamMessage_userIdCodec.decode(param2)),String(this._addTeamMessage_messageCodec.decode(param2)),BattleTeam(this._addTeamMessage_typeCodec.decode(param2)));
          break;
        case this._updateTeamHeaderId:
          this.client.updateTeamHeader(String(this._updateTeamHeader_headerCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
