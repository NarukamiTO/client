package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.laser {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.weapon.laser.LaserPointerCC;

  public class CodecLaserPointerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_fadeInTimeMs:ICodec;
    private var codec_laserPointerBlueColor:ICodec;
    private var codec_laserPointerRedColor:ICodec;
    private var codec_locallyVisible:ICodec;

    public function CodecLaserPointerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_fadeInTimeMs = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_laserPointerBlueColor = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_laserPointerRedColor = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_locallyVisible = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LaserPointerCC = new LaserPointerCC();
      local2.fadeInTimeMs = this.codec_fadeInTimeMs.decode(param1) as int;
      local2.laserPointerBlueColor = this.codec_laserPointerBlueColor.decode(param1) as String;
      local2.laserPointerRedColor = this.codec_laserPointerRedColor.decode(param1) as String;
      local2.locallyVisible = this.codec_locallyVisible.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LaserPointerCC = LaserPointerCC(param2);
      this.codec_fadeInTimeMs.encode(param1,local3.fadeInTimeMs);
      this.codec_laserPointerBlueColor.encode(param1,local3.laserPointerBlueColor);
      this.codec_laserPointerRedColor.encode(param1,local3.laserPointerRedColor);
      this.codec_locallyVisible.encode(param1,local3.locallyVisible);
    }
  }
}
