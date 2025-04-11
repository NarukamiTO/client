package _codec.projects.tanks.client.battlefield.models.teamlight {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightCC;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightParams;

  public class CodecTeamLightCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_lightModes:ICodec;

    public function CodecTeamLightCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_lightModes = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TeamLightParams,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TeamLightCC = new TeamLightCC();
      local2.lightModes = this.codec_lightModes.decode(param1) as Vector.<TeamLightParams>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TeamLightCC = TeamLightCC(param2);
      this.codec_lightModes.encode(param1,local3.lightModes);
    }
  }
}
