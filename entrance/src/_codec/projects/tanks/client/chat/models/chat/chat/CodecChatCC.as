package _codec.projects.tanks.client.chat.models.chat.chat {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.chat.models.chat.chat.ChatCC;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class CodecChatCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_admin:ICodec;
    private var codec_antifloodEnabled:ICodec;
    private var codec_bufferSize:ICodec;
    private var codec_channels:ICodec;
    private var codec_chatEnabled:ICodec;
    private var codec_chatModeratorLevel:ICodec;
    private var codec_linksWhiteList:ICodec;
    private var codec_minChar:ICodec;
    private var codec_minWord:ICodec;
    private var codec_privateMessagesEnabled:ICodec;
    private var codec_selfName:ICodec;
    private var codec_showLinks:ICodec;
    private var codec_typingSpeedAntifloodEnabled:ICodec;

    public function CodecChatCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_admin = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_antifloodEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_bufferSize = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_channels = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
      this.codec_chatEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_chatModeratorLevel = param1.getCodec(new EnumCodecInfo(ChatModeratorLevel,false));
      this.codec_linksWhiteList = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
      this.codec_minChar = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_minWord = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_privateMessagesEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_selfName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_showLinks = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_typingSpeedAntifloodEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChatCC = new ChatCC();
      local2.admin = this.codec_admin.decode(param1) as Boolean;
      local2.antifloodEnabled = this.codec_antifloodEnabled.decode(param1) as Boolean;
      local2.bufferSize = this.codec_bufferSize.decode(param1) as int;
      local2.channels = this.codec_channels.decode(param1) as Vector.<String>;
      local2.chatEnabled = this.codec_chatEnabled.decode(param1) as Boolean;
      local2.chatModeratorLevel = this.codec_chatModeratorLevel.decode(param1) as ChatModeratorLevel;
      local2.linksWhiteList = this.codec_linksWhiteList.decode(param1) as Vector.<String>;
      local2.minChar = this.codec_minChar.decode(param1) as int;
      local2.minWord = this.codec_minWord.decode(param1) as int;
      local2.privateMessagesEnabled = this.codec_privateMessagesEnabled.decode(param1) as Boolean;
      local2.selfName = this.codec_selfName.decode(param1) as String;
      local2.showLinks = this.codec_showLinks.decode(param1) as Boolean;
      local2.typingSpeedAntifloodEnabled = this.codec_typingSpeedAntifloodEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ChatCC = ChatCC(param2);
      this.codec_admin.encode(param1,local3.admin);
      this.codec_antifloodEnabled.encode(param1,local3.antifloodEnabled);
      this.codec_bufferSize.encode(param1,local3.bufferSize);
      this.codec_channels.encode(param1,local3.channels);
      this.codec_chatEnabled.encode(param1,local3.chatEnabled);
      this.codec_chatModeratorLevel.encode(param1,local3.chatModeratorLevel);
      this.codec_linksWhiteList.encode(param1,local3.linksWhiteList);
      this.codec_minChar.encode(param1,local3.minChar);
      this.codec_minWord.encode(param1,local3.minWord);
      this.codec_privateMessagesEnabled.encode(param1,local3.privateMessagesEnabled);
      this.codec_selfName.encode(param1,local3.selfName);
      this.codec_showLinks.encode(param1,local3.showLinks);
      this.codec_typingSpeedAntifloodEnabled.encode(param1,local3.typingSpeedAntifloodEnabled);
    }
  }
}
