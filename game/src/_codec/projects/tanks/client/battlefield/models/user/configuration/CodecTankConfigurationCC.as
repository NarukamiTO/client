package _codec.projects.tanks.client.battlefield.models.user.configuration {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.user.configuration.TankConfigurationCC;

  public class CodecTankConfigurationCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_coloringId:ICodec;
    private var codec_droneId:ICodec;
    private var codec_hullId:ICodec;
    private var codec_weaponId:ICodec;

    public function CodecTankConfigurationCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_coloringId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_droneId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_hullId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_weaponId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankConfigurationCC = new TankConfigurationCC();
      local2.coloringId = this.codec_coloringId.decode(param1) as Long;
      local2.droneId = this.codec_droneId.decode(param1) as Long;
      local2.hullId = this.codec_hullId.decode(param1) as Long;
      local2.weaponId = this.codec_weaponId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankConfigurationCC = TankConfigurationCC(param2);
      this.codec_coloringId.encode(param1,local3.coloringId);
      this.codec_droneId.encode(param1,local3.droneId);
      this.codec_hullId.encode(param1,local3.hullId);
      this.codec_weaponId.encode(param1,local3.weaponId);
    }
  }
}
