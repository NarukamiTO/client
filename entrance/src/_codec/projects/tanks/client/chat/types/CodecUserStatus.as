package _codec.projects.tanks.client.chat.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.chat.types.UserStatus;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class CodecUserStatus implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chatModeratorLevel:ICodec;
    private var codec_ip:ICodec;
    private var codec_rankIndex:ICodec;
    private var codec_uid:ICodec;
    private var codec_userId:ICodec;

    public function CodecUserStatus() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chatModeratorLevel = param1.getCodec(new EnumCodecInfo(ChatModeratorLevel,false));
      this.codec_ip = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_rankIndex = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_uid = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserStatus = new UserStatus();
      local2.chatModeratorLevel = this.codec_chatModeratorLevel.decode(param1) as ChatModeratorLevel;
      local2.ip = this.codec_ip.decode(param1) as String;
      local2.rankIndex = this.codec_rankIndex.decode(param1) as int;
      local2.uid = this.codec_uid.decode(param1) as String;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserStatus = UserStatus(param2);
      this.codec_chatModeratorLevel.encode(param1,local3.chatModeratorLevel);
      this.codec_ip.encode(param1,local3.ip);
      this.codec_rankIndex.encode(param1,local3.rankIndex);
      this.codec_uid.encode(param1,local3.uid);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
