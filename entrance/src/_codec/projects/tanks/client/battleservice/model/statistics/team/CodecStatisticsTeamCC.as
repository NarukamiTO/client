package _codec.projects.tanks.client.battleservice.model.statistics.team {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamCC;

  public class CodecStatisticsTeamCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_blueScore:ICodec;
    private var codec_redScore:ICodec;
    private var codec_usersInfoBlue:ICodec;
    private var codec_usersInfoRed:ICodec;

    public function CodecStatisticsTeamCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_blueScore = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_redScore = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_usersInfoBlue = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserInfo,false),false,1));
      this.codec_usersInfoRed = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserInfo,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:StatisticsTeamCC = new StatisticsTeamCC();
      local2.blueScore = this.codec_blueScore.decode(param1) as int;
      local2.redScore = this.codec_redScore.decode(param1) as int;
      local2.usersInfoBlue = this.codec_usersInfoBlue.decode(param1) as Vector.<UserInfo>;
      local2.usersInfoRed = this.codec_usersInfoRed.decode(param1) as Vector.<UserInfo>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:StatisticsTeamCC = StatisticsTeamCC(param2);
      this.codec_blueScore.encode(param1,local3.blueScore);
      this.codec_redScore.encode(param1,local3.redScore);
      this.codec_usersInfoBlue.encode(param1,local3.usersInfoBlue);
      this.codec_usersInfoRed.encode(param1,local3.usersInfoRed);
    }
  }
}
