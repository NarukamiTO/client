package _codec.projects.tanks.client.battlefield.models.teamlight {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightColorParams;

  public class CodecTeamLightColorParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_color:ICodec;
    private var codec_intensity:ICodec;

    public function CodecTeamLightColorParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_color = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_intensity = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TeamLightColorParams = new TeamLightColorParams();
      local2.color = this.codec_color.decode(param1) as String;
      local2.intensity = this.codec_intensity.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TeamLightColorParams = TeamLightColorParams(param2);
      this.codec_color.encode(param1,local3.color);
      this.codec_intensity.encode(param1,local3.intensity);
    }
  }
}
