package projects.tanks.client.chat.models.chat.chat {
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
  import projects.tanks.client.chat.types.ChatMessage;

  public class ChatModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ChatModelServer;

    private var client:IChatModelBase = IChatModelBase(this);
    private var modelId:Long = Long.getLong(1413646454,-1397687631);
    private var _cleanUsersMessagesId:Long = Long.getLong(798714808,-1771953585);
    private var _cleanUsersMessages_uidCodec:ICodec;
    private var _showMessagesId:Long = Long.getLong(978360780,-904735215);
    private var _showMessages_messagesCodec:ICodec;
    private var _updateTypingSpeedAntifloodParamsId:Long = Long.getLong(613975441,130861697);
    private var _updateTypingSpeedAntifloodParams_symbolCostCodec:ICodec;
    private var _updateTypingSpeedAntifloodParams_enterCostCodec:ICodec;

    public function ChatModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ChatModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ChatCC,false)));
      this._cleanUsersMessages_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showMessages_messagesCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ChatMessage,false),false,1));
      this._updateTypingSpeedAntifloodParams_symbolCostCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateTypingSpeedAntifloodParams_enterCostCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : ChatCC {
      return ChatCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._cleanUsersMessagesId:
          this.client.cleanUsersMessages(String(this._cleanUsersMessages_uidCodec.decode(param2)));
          break;
        case this._showMessagesId:
          this.client.showMessages(this._showMessages_messagesCodec.decode(param2) as Vector.<ChatMessage>);
          break;
        case this._updateTypingSpeedAntifloodParamsId:
          this.client.updateTypingSpeedAntifloodParams(int(this._updateTypingSpeedAntifloodParams_symbolCostCodec.decode(param2)),int(this._updateTypingSpeedAntifloodParams_enterCostCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
