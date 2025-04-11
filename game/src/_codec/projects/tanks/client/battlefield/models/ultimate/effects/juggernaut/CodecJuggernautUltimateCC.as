package _codec.projects.tanks.client.battlefield.models.ultimate.effects.juggernaut {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.juggernaut.JuggernautUltimateCC;

  public class CodecJuggernautUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_activateSound:ICodec;
    private var codec_negativeColorTransform:ICodec;
    private var codec_positiveColorTransform:ICodec;
    private var codec_sparkImage:ICodec;

    public function CodecJuggernautUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_activateSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_negativeColorTransform = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_positiveColorTransform = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_sparkImage = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:JuggernautUltimateCC = new JuggernautUltimateCC();
      local2.activateSound = this.codec_activateSound.decode(param1) as SoundResource;
      local2.negativeColorTransform = this.codec_negativeColorTransform.decode(param1) as String;
      local2.positiveColorTransform = this.codec_positiveColorTransform.decode(param1) as String;
      local2.sparkImage = this.codec_sparkImage.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:JuggernautUltimateCC = JuggernautUltimateCC(param2);
      this.codec_activateSound.encode(param1,local3.activateSound);
      this.codec_negativeColorTransform.encode(param1,local3.negativeColorTransform);
      this.codec_positiveColorTransform.encode(param1,local3.positiveColorTransform);
      this.codec_sparkImage.encode(param1,local3.sparkImage);
    }
  }
}
