package _codec.projects.tanks.client.chat.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
  import projects.tanks.client.chat.types.BattleChatLink;
  import projects.tanks.client.chat.types.ChatMessage;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.chat.types.UserStatus;

  public class CodecChatMessage implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_addressMode:ICodec;
    private var codec_battleLinks:ICodec;
    private var codec_channel:ICodec;
    private var codec_links:ICodec;
    private var codec_messageType:ICodec;
    private var codec_sourceUser:ICodec;
    private var codec_targetUser:ICodec;
    private var codec_text:ICodec;
    private var codec_timePassedInSec:ICodec;

    public function CodecChatMessage() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_addressMode = param1.getCodec(new EnumCodecInfo(ChatAddressMode,false));
      this.codec_battleLinks = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleChatLink,false),false,1));
      this.codec_channel = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_links = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),true,1));
      this.codec_messageType = param1.getCodec(new EnumCodecInfo(MessageType,false));
      this.codec_sourceUser = param1.getCodec(new TypeCodecInfo(UserStatus,true));
      this.codec_targetUser = param1.getCodec(new TypeCodecInfo(UserStatus,true));
      this.codec_text = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_timePassedInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChatMessage = new ChatMessage();
      local2.addressMode = this.codec_addressMode.decode(param1) as ChatAddressMode;
      local2.battleLinks = this.codec_battleLinks.decode(param1) as Vector.<BattleChatLink>;
      local2.channel = this.codec_channel.decode(param1) as String;
      local2.links = this.codec_links.decode(param1) as Vector.<String>;
      local2.messageType = this.codec_messageType.decode(param1) as MessageType;
      local2.sourceUser = this.codec_sourceUser.decode(param1) as UserStatus;
      local2.targetUser = this.codec_targetUser.decode(param1) as UserStatus;
      local2.text = this.codec_text.decode(param1) as String;
      local2.timePassedInSec = this.codec_timePassedInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ChatMessage = ChatMessage(param2);
      this.codec_addressMode.encode(param1,local3.addressMode);
      this.codec_battleLinks.encode(param1,local3.battleLinks);
      this.codec_channel.encode(param1,local3.channel);
      this.codec_links.encode(param1,local3.links);
      this.codec_messageType.encode(param1,local3.messageType);
      this.codec_sourceUser.encode(param1,local3.sourceUser);
      this.codec_targetUser.encode(param1,local3.targetUser);
      this.codec_text.encode(param1,local3.text);
      this.codec_timePassedInSec.encode(param1,local3.timePassedInSec);
    }
  }
}
