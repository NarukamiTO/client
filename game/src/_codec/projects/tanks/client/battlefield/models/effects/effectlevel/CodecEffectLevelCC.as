package _codec.projects.tanks.client.battlefield.models.effects.effectlevel {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.effects.effectlevel.EffectLevelCC;

  public class CodecEffectLevelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_effectLevel:ICodec;

    public function CodecEffectLevelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_effectLevel = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EffectLevelCC = new EffectLevelCC();
      local2.effectLevel = this.codec_effectLevel.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EffectLevelCC = EffectLevelCC(param2);
      this.codec_effectLevel.encode(param1,local3.effectLevel);
    }
  }
}
