package _codec.projects.tanks.client.battleservice.model.statistics {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class CodecUserInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chatModeratorLevel:ICodec;
    private var codec_deaths:ICodec;
    private var codec_hasPremium:ICodec;
    private var codec_kills:ICodec;
    private var codec_rank:ICodec;
    private var codec_score:ICodec;
    private var codec_uid:ICodec;
    private var codec_user:ICodec;

    public function CodecUserInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chatModeratorLevel = param1.getCodec(new EnumCodecInfo(ChatModeratorLevel,false));
      this.codec_deaths = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_hasPremium = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_kills = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_rank = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_score = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_uid = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_user = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserInfo = new UserInfo();
      local2.chatModeratorLevel = this.codec_chatModeratorLevel.decode(param1) as ChatModeratorLevel;
      local2.deaths = this.codec_deaths.decode(param1) as int;
      local2.hasPremium = this.codec_hasPremium.decode(param1) as Boolean;
      local2.kills = this.codec_kills.decode(param1) as int;
      local2.rank = this.codec_rank.decode(param1) as int;
      local2.score = this.codec_score.decode(param1) as int;
      local2.uid = this.codec_uid.decode(param1) as String;
      local2.user = this.codec_user.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserInfo = UserInfo(param2);
      this.codec_chatModeratorLevel.encode(param1,local3.chatModeratorLevel);
      this.codec_deaths.encode(param1,local3.deaths);
      this.codec_hasPremium.encode(param1,local3.hasPremium);
      this.codec_kills.encode(param1,local3.kills);
      this.codec_rank.encode(param1,local3.rank);
      this.codec_score.encode(param1,local3.score);
      this.codec_uid.encode(param1,local3.uid);
      this.codec_user.encode(param1,local3.user);
    }
  }
}
