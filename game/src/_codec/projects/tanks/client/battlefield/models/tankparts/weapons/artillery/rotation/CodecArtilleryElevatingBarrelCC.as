package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.ArtilleryElevatingBarrelCC;

  public class CodecArtilleryElevatingBarrelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_control:ICodec;
    private var codec_elevation:ICodec;

    public function CodecArtilleryElevatingBarrelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_control = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_elevation = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ArtilleryElevatingBarrelCC = new ArtilleryElevatingBarrelCC();
      local2.control = this.codec_control.decode(param1) as int;
      local2.elevation = this.codec_elevation.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ArtilleryElevatingBarrelCC = ArtilleryElevatingBarrelCC(param2);
      this.codec_control.encode(param1,local3.control);
      this.codec_elevation.encode(param1,local3.elevation);
    }
  }
}
