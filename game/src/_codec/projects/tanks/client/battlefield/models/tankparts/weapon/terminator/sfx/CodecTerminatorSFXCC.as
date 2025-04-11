package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx.TerminatorSFXCC;

  public class CodecTerminatorSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_closedSound:ICodec;
    private var codec_openedSound:ICodec;
    private var codec_servoSound:ICodec;

    public function CodecTerminatorSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_closedSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_openedSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_servoSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TerminatorSFXCC = new TerminatorSFXCC();
      local2.closedSound = this.codec_closedSound.decode(param1) as SoundResource;
      local2.openedSound = this.codec_openedSound.decode(param1) as SoundResource;
      local2.servoSound = this.codec_servoSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TerminatorSFXCC = TerminatorSFXCC(param2);
      this.codec_closedSound.encode(param1,local3.closedSound);
      this.codec_openedSound.encode(param1,local3.openedSound);
      this.codec_servoSound.encode(param1,local3.servoSound);
    }
  }
}
