package _codec.projects.tanks.client.battlefield.models.tankparts.engine {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.tankparts.engine.EngineCC;

  public class CodecEngineCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_engineIdleSound:ICodec;
    private var codec_engineMovingSound:ICodec;
    private var codec_engineStartMovingSound:ICodec;
    private var codec_engineStartSound:ICodec;
    private var codec_engineStopMovingSound:ICodec;

    public function CodecEngineCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_engineIdleSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_engineMovingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_engineStartMovingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_engineStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_engineStopMovingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EngineCC = new EngineCC();
      local2.engineIdleSound = this.codec_engineIdleSound.decode(param1) as SoundResource;
      local2.engineMovingSound = this.codec_engineMovingSound.decode(param1) as SoundResource;
      local2.engineStartMovingSound = this.codec_engineStartMovingSound.decode(param1) as SoundResource;
      local2.engineStartSound = this.codec_engineStartSound.decode(param1) as SoundResource;
      local2.engineStopMovingSound = this.codec_engineStopMovingSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EngineCC = EngineCC(param2);
      this.codec_engineIdleSound.encode(param1,local3.engineIdleSound);
      this.codec_engineMovingSound.encode(param1,local3.engineMovingSound);
      this.codec_engineStartMovingSound.encode(param1,local3.engineStartMovingSound);
      this.codec_engineStartSound.encode(param1,local3.engineStartSound);
      this.codec_engineStopMovingSound.encode(param1,local3.engineStopMovingSound);
    }
  }
}
