package _codec.projects.tanks.client.battlefield.models.teamlight {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightColorParams;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightParams;
  import projects.tanks.client.battleservice.BattleMode;

  public class CodecTeamLightParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_attenuationBegin:ICodec;
    private var codec_attenuationEnd:ICodec;
    private var codec_battleMode:ICodec;
    private var codec_blueTeam:ICodec;
    private var codec_neutralTeam:ICodec;
    private var codec_redTeam:ICodec;

    public function CodecTeamLightParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_attenuationBegin = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_attenuationEnd = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_battleMode = param1.getCodec(new EnumCodecInfo(BattleMode,false));
      this.codec_blueTeam = param1.getCodec(new TypeCodecInfo(TeamLightColorParams,false));
      this.codec_neutralTeam = param1.getCodec(new TypeCodecInfo(TeamLightColorParams,false));
      this.codec_redTeam = param1.getCodec(new TypeCodecInfo(TeamLightColorParams,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TeamLightParams = new TeamLightParams();
      local2.attenuationBegin = this.codec_attenuationBegin.decode(param1) as Number;
      local2.attenuationEnd = this.codec_attenuationEnd.decode(param1) as Number;
      local2.battleMode = this.codec_battleMode.decode(param1) as BattleMode;
      local2.blueTeam = this.codec_blueTeam.decode(param1) as TeamLightColorParams;
      local2.neutralTeam = this.codec_neutralTeam.decode(param1) as TeamLightColorParams;
      local2.redTeam = this.codec_redTeam.decode(param1) as TeamLightColorParams;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TeamLightParams = TeamLightParams(param2);
      this.codec_attenuationBegin.encode(param1,local3.attenuationBegin);
      this.codec_attenuationEnd.encode(param1,local3.attenuationEnd);
      this.codec_battleMode.encode(param1,local3.battleMode);
      this.codec_blueTeam.encode(param1,local3.blueTeam);
      this.codec_neutralTeam.encode(param1,local3.neutralTeam);
      this.codec_redTeam.encode(param1,local3.redTeam);
    }
  }
}
