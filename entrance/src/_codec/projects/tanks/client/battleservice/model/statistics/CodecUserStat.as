package _codec.projects.tanks.client.battleservice.model.statistics {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public class CodecUserStat implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_deaths:ICodec;
    private var codec_kills:ICodec;
    private var codec_score:ICodec;
    private var codec_user:ICodec;

    public function CodecUserStat() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_deaths = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_kills = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_score = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_user = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserStat = new UserStat();
      local2.deaths = this.codec_deaths.decode(param1) as int;
      local2.kills = this.codec_kills.decode(param1) as int;
      local2.score = this.codec_score.decode(param1) as int;
      local2.user = this.codec_user.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserStat = UserStat(param2);
      this.codec_deaths.encode(param1,local3.deaths);
      this.codec_kills.encode(param1,local3.kills);
      this.codec_score.encode(param1,local3.score);
      this.codec_user.encode(param1,local3.user);
    }
  }
}
