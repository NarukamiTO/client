package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotCC;

  public class CodecShotgunShotCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_magazineReloadTime:ICodec;
    private var codec_magazineSize:ICodec;

    public function CodecShotgunShotCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_magazineReloadTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_magazineSize = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShotgunShotCC = new ShotgunShotCC();
      local2.magazineReloadTime = this.codec_magazineReloadTime.decode(param1) as int;
      local2.magazineSize = this.codec_magazineSize.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShotgunShotCC = ShotgunShotCC(param2);
      this.codec_magazineReloadTime.encode(param1,local3.magazineReloadTime);
      this.codec_magazineSize.encode(param1,local3.magazineSize);
    }
  }
}
