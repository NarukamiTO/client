package _codec.projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.FacilitySphericalZoneCC;

  public class CodecFacilitySphericalZoneCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_centerOffsetZ:ICodec;
    private var codec_radius:ICodec;

    public function CodecFacilitySphericalZoneCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_centerOffsetZ = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_radius = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FacilitySphericalZoneCC = new FacilitySphericalZoneCC();
      local2.centerOffsetZ = this.codec_centerOffsetZ.decode(param1) as Number;
      local2.radius = this.codec_radius.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FacilitySphericalZoneCC = FacilitySphericalZoneCC(param2);
      this.codec_centerOffsetZ.encode(param1,local3.centerOffsetZ);
      this.codec_radius.encode(param1,local3.radius);
    }
  }
}
