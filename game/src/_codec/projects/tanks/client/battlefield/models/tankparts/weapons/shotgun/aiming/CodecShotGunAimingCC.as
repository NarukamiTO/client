package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;

  public class CodecShotGunAimingCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_coneHorizontalAngle:ICodec;
    private var codec_coneVerticalAngle:ICodec;
    private var codec_pelletCount:ICodec;

    public function CodecShotGunAimingCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_coneHorizontalAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_coneVerticalAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_pelletCount = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShotGunAimingCC = new ShotGunAimingCC();
      local2.coneHorizontalAngle = this.codec_coneHorizontalAngle.decode(param1) as Number;
      local2.coneVerticalAngle = this.codec_coneVerticalAngle.decode(param1) as Number;
      local2.pelletCount = this.codec_pelletCount.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShotGunAimingCC = ShotGunAimingCC(param2);
      this.codec_coneHorizontalAngle.encode(param1,local3.coneHorizontalAngle);
      this.codec_coneVerticalAngle.encode(param1,local3.coneVerticalAngle);
      this.codec_pelletCount.encode(param1,local3.pelletCount);
    }
  }
}
