package projects.tanks.client.chat.models.clanchat.clanchat {
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

  public class ClanChatModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanChatModelServer;

    private var client:IClanChatModelBase = IClanChatModelBase(this);
    private var modelId:Long = Long.getLong(207484105,-2003218757);
    private var _receiveMessageId:Long = Long.getLong(1427006127,1489654476);
    private var _receiveMessage_messageCodec:ICodec;
    private var _showMessagesHistoryId:Long = Long.getLong(485375957,-1291947355);
    private var _showMessagesHistory_chatMessagesCodec:ICodec;

    public function ClanChatModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanChatModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanChatCC,false)));
      this._receiveMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(ChatMessage,false));
      this._showMessagesHistory_chatMessagesCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ChatMessage,false),false,1));
    }

    protected function getInitParam() : ClanChatCC {
      return ClanChatCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receiveMessageId:
          this.client.receiveMessage(ChatMessage(this._receiveMessage_messageCodec.decode(param2)));
          break;
        case this._showMessagesHistoryId:
          this.client.showMessagesHistory(this._showMessagesHistory_chatMessagesCodec.decode(param2) as Vector.<ChatMessage>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
